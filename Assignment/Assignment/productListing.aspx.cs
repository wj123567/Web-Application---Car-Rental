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
                txtStartTime.Attributes["min"] = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
                txtStartTime.Attributes["max"] = DateTime.Now.AddMonths(3).ToString("yyyy-MM-dd");                
                txtEndTime.Attributes["min"] = DateTime.Now.AddDays(2).ToString("yyyy-MM-dd");
                txtEndTime.Attributes["max"] = DateTime.Now.AddMonths(4).ToString("yyyy-MM-dd");

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

                    ViewState["CarData"] = ds.Tables["CarData"];    
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
                        ViewState["CarData"] = ds.Tables["CarData"];
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

            string carInfo = "SELECT C.* FROM Car C WHERE 1=1 ";

            carInfo += " AND LocationId = '" + ddlLocation.SelectedValue +"'";

            carInfo += " AND C.CarId NOT IN(SELECT B.CarId FROM Booking B WHERE (B.StartDate >= '" + txtStartTime.Text + "' AND B.StartDate <= '" + txtEndTime.Text + "') OR (B.EndDate >= '"+ txtStartTime.Text+"' AND b.EndDate <= '" + txtEndTime.Text +"')) ";

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
                ViewState["CarData"] = ds.Tables["CarData"];
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

        protected void btnA2Z_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnA2Z.Visible = false;
            btnZ2A.Visible = true;

            if(carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "CarName ASC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }

        protected void btnZ2A_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnA2Z.Visible = true;
            btnZ2A.Visible = false;

            if (carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "CarName DESC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }

        protected void ddlLocation_DataBound(object sender, EventArgs e)
        {
            ddlLocation.Items.Insert(0, new ListItem("Select Location", "0"));
        }
    }
        }