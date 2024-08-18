using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class bookingrecorddetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                // Retrieve BookingId from session
                string bookingId = Session["BookingRecordId"] as string;

                if (!string.IsNullOrEmpty(bookingId))
                {
                    // Fetch booking details from the database
                    GetBookingDetails(bookingId);
                }
            }

        }

        private void GetBookingDetails(string bookingId)
        {
            // Replace with your actual database connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = "SELECT * FROM Booking WHERE Id = @BookingId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Populate the table with the data
                        lblPlateNum.Text = reader["CarPlate"].ToString();
                        lblPickUpLocation.Text = reader["Pickup_point"].ToString();
                        lblPickUpTime.Text = Convert.ToDateTime(reader["StartDate"]).ToString("dd/MM/yyyy HH:mm:ss tt");
                        lblDropOffLocation.Text = reader["Dropoff_point"].ToString();
                        lblDropOffTime.Text = Convert.ToDateTime(reader["EndDate"]).ToString("dd-MM-yyyy HH:mm:ss tt");
                    }
                }
            }
        }

    }
}