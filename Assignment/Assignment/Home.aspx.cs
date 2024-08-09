using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Assignment
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDownList();
                DateTime tomorrow = DateTime.Now.AddDays(1);
                txtDepartureDate.Attributes["min"] = tomorrow.ToString("yyyy-MM-dd");
                txtReturnDate.Attributes["min"] = tomorrow.ToString("yyyy-MM-dd");

            }
        }


        private void PopulateDropDownList()
        {
            ddlLocation.Items.Add(new ListItem(""));
            // Adding categories as items
            ddlLocation.Items.Add(new ListItem("Penang Island", "penang_island"));
            ddlLocation.Items.Add(new ListItem(" Batu Feringghi", "batu_feringghi"));


            ddlLocation.Items.Add(new ListItem("Penang Mainland", "penang_mainland"));
            ddlLocation.Items.Add(new ListItem("  Bukit Mertajam", "bukit_mertajam"));

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            String insertString = "INSERT INTO TestBook (location,pickup_date,pickup_time,dropoff_date,dropoff_time) VALUES (location,pickup_date,pickup_time,dropoff_date,dropoff_time)";
            saveTripInfo(insertString);
            Server.Transfer("infopg.aspx");

        }

        protected void saveTripInfo(string insertString)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(insertString, con);

            com.Parameters.AddWithValue("@location", ddlLocation.SelectedValue);
            com.Parameters.AddWithValue("@pickup_date", txtDepartureDate.Text);
            com.Parameters.AddWithValue("@pickup_time", txtDepartureTime.Text);
            com.Parameters.AddWithValue("@dropoff_date", txtReturnDate.Text);
            com.Parameters.AddWithValue("@dropoff_time", txtReturnTime.Text);
            

            com.ExecuteNonQuery();
            con.Close();
        }
        // Mark items as disabled before rendering the page
        /*protected override void Render(HtmlTextWriter writer)
        {
            foreach (ListItem item in ddlLocation.Items)
            {
                // Example: Disable items with specific values
                if (item.Value == "select_location"||item.Value == "penang_island" || item.Value == "penang_mainland")
                {
                    item.Attributes.Add("disabled", "disabled");

                }

            }


            base.Render(writer);
        }*/
    }
}