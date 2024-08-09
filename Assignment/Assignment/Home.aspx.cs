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
            if (!Page.IsPostBack)
            {
                txtDepartureDateTime.Attributes["min"] = DateTime.Now.AddDays(1).ToString("yyyy-MM-ddTHH:mm");
                txtDepartureDateTime.Attributes["max"] = DateTime.Now.AddMonths(3).ToString("yyyy-MM-ddTHH:mm");
                txtReturnDateTime.Attributes["min"] = DateTime.Now.AddDays(2).ToString("yyyy-MM-ddTHH:mm");
                txtReturnDateTime.Attributes["max"] = DateTime.Now.AddMonths(4).ToString("yyyy-MM-ddTHH:mm");

            }
        }



        protected void btnSearch_Click(object sender, EventArgs e)
        {
            String insertString = "INSERT INTO TestBook (location,pickup_date,pickup_time,dropoff_date,dropoff_time) VALUES (location,pickup_date,pickup_time,dropoff_date,dropoff_time)";
            saveTripInfo(insertString);
            Server.Transfer("infopage.aspx");

        }

        protected void saveTripInfo(string insertString)
        {
           
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