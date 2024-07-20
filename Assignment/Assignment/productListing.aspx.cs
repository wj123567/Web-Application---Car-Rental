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

            if (Session["Search"] != null)
            {
                searchCarData();
            }
            else
            {
                retrievedAllData();
            }
        }

        protected void retrievedAllData() {
            string findCar = "SELECT * FROM Car";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                con.Open();

                using (SqlCommand com = new SqlCommand(findCar, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(com);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "CarData");

                    productRepeater.DataSource = ds.Tables["CarData"];
                    productRepeater.DataBind();
                }

                con.Close();
            }

        }
        protected void searchCarData()
        {

            string searchString = Session["Search"].ToString();
            Session["Search"] = null;

            string findCar = "SELECT * FROM Car WHERE CarName LIKE @searchString OR CType LIKE @searchString OR CarBrand LIKE @searchString";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
           
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

                
            }
        }