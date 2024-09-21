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
                if (Session["SelectedAddOns"] != null)
                {
                    Session["SelectedAddOns"] = "";
                }
                txtDepartureDateTime.Attributes["min"] = DateTime.Now.AddDays(1).ToString("yyyy-MM-ddTHH:mm");
                txtDepartureDateTime.Attributes["max"] = DateTime.Now.AddMonths(3).ToString("yyyy-MM-ddTHH:mm");

                txtReturnDateTime.Attributes["max"] = DateTime.Now.AddMonths(4).ToString("yyyy-MM-ddTHH:mm");
                PopulateRegionsAndPoints();

                //You - update reward points
                if (Session["Id"] != null)
                {
                    UpdateRewardPoints(Session["Id"].ToString());
                }

                if (Request.QueryString["Error"] != null)
                {
                    lblerrortext.Visible = true;
                }
                else
                {
                    lblerrortext.Visible = false;
                }
                
            }
        }

        private void PopulateRegionsAndPoints()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Query to get distinct regions (LocationState)
                string queryRegions = "SELECT DISTINCT LocationState FROM Location";
                SqlCommand cmdRegions = new SqlCommand(queryRegions, con);
                SqlDataReader readerRegions = cmdRegions.ExecuteReader();

                // Store regions in a list
                List<string> regions = new List<string>();
                while (readerRegions.Read())
                {
                    regions.Add(readerRegions["LocationState"].ToString());
                }
                readerRegions.Close();

                StringBuilder regionListHtml = new StringBuilder();
                StringBuilder popularPointsHtml = new StringBuilder();

                // Query to get locations (LocationName) for each region
                string queryLocations = "SELECT LocationName FROM Location WHERE LocationState = @state";
                SqlCommand cmdLocations = new SqlCommand(queryLocations, con);

                foreach (string region in regions)
                {
                    regionListHtml.AppendFormat("<li data-region='{0}'>{1}</li>", region.ToLower(), region);

                    cmdLocations.Parameters.Clear();
                    cmdLocations.Parameters.AddWithValue("@state", region);
                    SqlDataReader readerLocations = cmdLocations.ExecuteReader();

                    // Start the section for this region's popular points
                    popularPointsHtml.AppendFormat("<div class='popular-points' id='{0}-points'>", region.ToLower());
                    popularPointsHtml.Append("<h5>Popular Points</h5><ul>");

                    while (readerLocations.Read())
                    {
                        string locationName = readerLocations["LocationName"].ToString();
                        popularPointsHtml.AppendFormat("<li class='selectable-item'>{0}</li>", locationName);
                    }

                    popularPointsHtml.Append("</ul></div>");
                    readerLocations.Close();
                }

                // Inject the generated HTML into the placeholders
                RegionListPlaceholder.InnerHtml = regionListHtml.ToString();
                PopularPointsPlaceholder.InnerHtml = popularPointsHtml.ToString();
                con.Close();
            }
            
            // Reinitialize JavaScript event listeners
            ScriptManager.RegisterStartupScript(this, GetType(), "initializeEventListeners", "initializeEventListeners();", true);
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
            Session["BookingID"]= saveTripInfo();
            Session["Pickup_point"]  = hdnDepartureLocation.Value;
            Session["Pickup_state"]  = hdnDepartureState.Value;
            Session["StartDate"]     = txtDepartureDateTime.Text;
            Session["Dropoff_point"] = hdnReturnLocation.Value;
            Session["Dropoff_state"] = hdnReturnState.Value;
            Session["EndDate"]       = txtReturnDateTime.Text;
            


            Response.Redirect("productListing.aspx");

        }

        protected String saveTripInfo()
        {
            string bookID = "";
            bool isUnique;
            do
            {
                bookID = generateRandBookID();
                isUnique = CheckBookID(bookID);
            } while (!isUnique);

            //store bookingID
           hdnBookingId.Value = bookID;
            return hdnBookingId.Value;
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
            String sql = "Select Id FROM Booking"; 
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
            con.Close();
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

        //You - update points
        private void UpdateRewardPoints(string userId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                string sqlUpdateRewardPoints = "Update ApplicationUser Set RewardPoints = (Select ISNULL(SUM(PointsRemaining), 0) From Booking Where UserId = @userid AND PointsStatus = 'active') Where Id = @userid";

                using (SqlCommand cmd = new SqlCommand(sqlUpdateRewardPoints, con))
                {
                    cmd.Parameters.AddWithValue("userid", userId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                con.Close() ;
            }
        }
    }
}