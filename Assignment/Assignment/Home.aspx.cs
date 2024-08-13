using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
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

                txtReturnDateTime.Attributes["max"] = DateTime.Now.AddMonths(4).ToString("yyyy-MM-ddTHH:mm");
  
            }
        }

        
        protected void txtDepartureDateTime_TextChanged(object sender, EventArgs e)
        {
            DateTime departureDate;
            if (DateTime.TryParse(txtDepartureDateTime.Text, out departureDate))
            {
                DateTime minReturnDate = departureDate.AddDays(1);
                txtReturnDateTime.Attributes["min"] = minReturnDate.ToString("yyyy-MM-ddTHH:mm");
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Save departure date to the session state
            Session["DepartureDate"] = Convert.ToDateTime(txtDepartureDateTime.Text);

            String insertString = "INSERT INTO TestTrip (Id,Pickup_point,Pickup_state,StartDate,Dropoff_point,Dropoff_state,EndDate) VALUES (@Id,@Pickup_point,@Pickup_state,@StartDate,@Dropoff_point,@Dropoff_state,@EndDate)";
            saveTripInfo(insertString);
            Server.Transfer("infopage.aspx");
        }

        protected void saveTripInfo(string insertString)
        {
            string bookID = "";
            bool isUnique;
            do
            {
                bookID = generateRandBookID();
                isUnique = CheckBookID(bookID);
            } while (!isUnique);

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(insertString, con);

            com.Parameters.AddWithValue("@Id", bookID);
            com.Parameters.AddWithValue("@Pickup_point", hdnDepartureLocation.Value);
            com.Parameters.AddWithValue("@Pickup_state", hdnDepartureState.Value);
            com.Parameters.AddWithValue("@StartDate", Convert.ToDateTime(txtDepartureDateTime.Text));
            com.Parameters.AddWithValue("@Dropoff_point", hdnReturnLocation.Value);
            com.Parameters.AddWithValue("@Dropoff_state", hdnReturnState.Value);
            com.Parameters.AddWithValue("@EndDate", Convert.ToDateTime(txtReturnDateTime.Text));

            com.ExecuteNonQuery();
            con.Close();
                
            
        }

        private String generateRandBookID()
        {
            Random random = new Random();
            int randomNumber = random.Next(0, 999999);
            String formattedNumber = randomNumber.ToString("D6"); //padding with 0 if needed(6-digit)
            return "BID" + formattedNumber;
        }

        private Boolean CheckBookID(String bookID)
        {
            String sql = "Select Id FROM TestTrip"; 
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(sql, con);
            
            SqlDataReader reader = com.ExecuteReader();

            while (reader.Read())
            {
                if (bookID == (string)reader["Id"])
                {
                    return false;

                }
            }
        return true;
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