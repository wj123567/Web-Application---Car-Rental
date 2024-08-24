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
                string bookingId = Session["bookingrecordID"] as string;

                if (!string.IsNullOrEmpty(bookingId))
                {
                    // Fetch booking details from the database
                    GetBookingDetails(bookingId);
                    
                }

                txtComment.Attributes.Add("placeholder", "Write Your Comment Here!");
            }

        }

        private void GetBookingDetails(string bookingId)
        {

            
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            decimal addonTotal = calcAddOnTotal(bookingId);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = "SELECT * FROM Booking b JOIN Car c ON b.CarPlate=c.CarPlate WHERE b.Id = @BookingId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Populate the table with the data
                        lblBookingNumber.Text = bookingId;
                        img_car.ImageUrl = reader["CarImage"].ToString();
                        lblPlateNum.Text = reader["CarPlate"].ToString();
                        lblPickUpLocation.Text = reader["Pickup_point"].ToString();
                        lblPickUpTime.Text = Convert.ToDateTime(reader["StartDate"]).ToString("dd/MM/yyyy HH:mm:ss tt");
                        lblDropOffLocation.Text = reader["Dropoff_point"].ToString();
                        lblDropOffTime.Text = Convert.ToDateTime(reader["EndDate"]).ToString("dd-MM-yyyy HH:mm:ss tt");
                        string status = reader["Status"].ToString();
                        
                        lblAddOnPrice.Text= addonTotal.ToString("F2");

                        lblBookStatus.Text = status;
                        lblBookStatus.CssClass = $"badge {GetBadgeClass(status)}";
                    }
                    
                }
            }
        }

        private decimal calcAddOnTotal(string bookingId)
        {
            decimal addonTotal=0;
            lblAddOnDesc.Text = "";
            // Replace with your actual database connection string
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = "SELECT b.Quantity,a.Price,a.Name FROM BookingAddOn b JOIN AddOn a ON b.AddOnId = a.Id WHERE b.BookingId = @BookingId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {

                        int quantity = Convert.ToInt16(reader["Quantity"]);
                        decimal price = Convert.ToDecimal(reader["Price"]);
                        addonTotal += quantity * price;
                        lblAddOnDesc.Text += "("+ reader["Name"].ToString() + "*" + reader["Quantity"].ToString()+ ")" ;

      
                    }
                    
                }
            }
            return addonTotal;
        }

        protected string GetBadgeClass(string status)
        {
            switch (status)
            {
                case "Pending":         
                    return "bg-primary";
                case "Booked":
                    return "bg-success";
                case "Cancelled":
                    return "bg-danger";
                default:
                    return "bg-default"; // Or any default class
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", " modal();", true);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            Response.Redirect("bookingRecordUpdate.aspx");
        }



        protected void modalYesBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string cancel = "UPDATE Booking SET Status = 'Pending', UpdateReason = @UpdateReason WHERE Id = @Id";
                string rejectReason = " ";
                if (ddlCancelReason.SelectedValue == "Other")
                {
                    rejectReason = txtOtherReason.Text;
                }
                else
                {
                    rejectReason = ddlCancelReason.SelectedValue;
                }
                updateCancelRequest(cancel, rejectReason);
            }
            // Retrieve BookingId from session

            
            Response.Redirect("bookingrecord.aspx");
        }
        protected void ddlCancelReason_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCancelReason.SelectedValue == "Other")
            {
                txtOtherReason.Visible = true;
                requireOtherReason.Enabled = true;
                updateReason.Update();
            }
            else
            {
                txtOtherReason.Visible = false;
                requireOtherReason.Enabled = false;
                updateReason.Update();
            }
        }
        private void updateCancelRequest(string sql, string cancel)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@Id", Session["bookingrecordID"].ToString());
            com.Parameters.AddWithValue("@UpdateReason", cancel);
            com.ExecuteNonQuery();
            con.Close();
        }
    }
}