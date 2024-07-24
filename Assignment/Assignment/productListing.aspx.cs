using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class productListing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
            
            if (!Page.IsPostBack)
            {
                BindBrandCbl();

                if (Session["Search"] != null)
                {
                    searchCarData();
                }
                else
                {
                    retrievedAllData();
                }
            }
        }

        protected void retrievedAllData() {
            string findCar = "SELECT * FROM Car";

            SqlConnection con = new SqlConnection(Global.CS);
            
                con.Open();

            SqlCommand com = new SqlCommand(findCar, con);
                
                    SqlDataAdapter da = new SqlDataAdapter(com);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "CarData");

                    productRepeater.DataSource = ds.Tables["CarData"];
                    productRepeater.DataBind();
                

                con.Close();

        }
        protected void searchCarData()
        {

            string searchString = Session["Search"].ToString();
            Session["Search"] = null;

            string findCar = "SELECT * FROM Car WHERE CarName LIKE @searchString OR CType LIKE @searchString OR CarBrand LIKE @searchString";

            SqlConnection con = new SqlConnection(Global.CS);
           
                con.Open();

            SqlCommand com = new SqlCommand(findCar, con);
               
                    com.Parameters.AddWithValue("@searchString", "%" + searchString + "%");

                    SqlDataAdapter da = new SqlDataAdapter(com);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "CarData");

                    if(ds.Tables["CarData"].Rows.Count == 0)
                    {
                        lblSearchFail.Text = "No search results found for " + searchString;
                    }
                    else
                    {
                        productRepeater.DataSource = ds.Tables["CarData"];
                        productRepeater.DataBind();
                    }

            con.Close();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            List<ListItem> brandSelected = new List<ListItem>();
            List<ListItem> typeSelected = new List<ListItem>();

            foreach (ListItem item in cblCarBrand.Items)
            {
                if (item.Selected)
                {
                    brandSelected.Add(item);
                }
            }

            foreach(ListItem item in cblCarType.Items)
            {
                if (item.Selected)
                {
                    typeSelected.Add(item);
                }
            }

            string carInfo = "SELECT * FROM Car WHERE 1=1 ";
            if (brandSelected.Count()>0)
            {
                for (int i = 0; i < brandSelected.Count(); i++) {
                    if(i == 0)
                    {
                        carInfo += "AND CarBrand in ('" + brandSelected.ElementAt(i) + "'";
                    }else if(i >= 1)
                    {
                        carInfo += ", '" + brandSelected.ElementAt(i) + "'";
                    }  
                }

                carInfo += ") ";
            }

            if (typeSelected.Count() > 0)
            {
                for (int i = 0; i < typeSelected.Count(); i++)
                {
                    if (i == 0)
                    {
                        carInfo += "AND CType in ('" + typeSelected.ElementAt(i) + "'";
                    }
                    else if (i >= 1)
                    {
                        carInfo += ", '" + typeSelected.ElementAt(i) + "'";
                    }
                }
                carInfo += ") ";
            }

            if(!string.IsNullOrEmpty(txtMinPrice.Text) || !string.IsNullOrEmpty(txtMaxPrice.Text))
            {

                if(!string.IsNullOrEmpty(txtMinPrice.Text))
                {
                    carInfo += "AND CarHourPrice >= " + double.Parse(txtMinPrice.Text);  
                }

                if(!string.IsNullOrEmpty(txtMaxPrice.Text))
                {
                    carInfo += "AND CarHourPrice <= " + double.Parse(txtMaxPrice.Text);
                }
            }

            if(rblAlphaOrder != null)
            {
                carInfo += "ORDER BY CarBrand, CarName " + rblAlphaOrder.SelectedValue.ToString();
            }

             SqlConnection con = new SqlConnection(Global.CS);
            con.Open();
            SqlCommand com = new SqlCommand(carInfo, con);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds,"CarData");

            if (ds.Tables["CarData"].Rows.Count == 0)
            {
                productRepeater.DataSource = ds;
                productRepeater.DataBind();
                lblSearchFail.Text = "No search results found";
            }
            else
            {
                lblSearchFail.Text = " ";
                productRepeater.DataSource = ds;
                productRepeater.DataBind();
            }
 
        }

        public void BindBrandCbl()
        {
            SqlConnection con = new SqlConnection(Global.CS);
            con.Open();
            string query = "SELECT DISTINCT CarBrand FROM Car Order By CarBrand";
            SqlCommand com = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "CarData");
            cblCarBrand.DataValueField = "CarBrand";
            cblCarBrand.DataTextField = "CarBrand";
            cblCarBrand.DataSource = ds.Tables["CarData"];
            cblCarBrand.DataBind();
        }

        protected void btnProductRent_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            String carID = button.CommandArgument.ToString();

            Session["CarID"] = carID;
        }
    }
        }