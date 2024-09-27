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
                    GetPaymentDetails(bookingId);
                }

                //You

                using (var db = new SystemDatabaseEntities())
                {

                    var booking = db.Bookings.FirstOrDefault(b => b.Id == bookingId);

                    if (booking != null && booking.Status == "Completed")
                    {
                        var existingReview = db.Reviews.FirstOrDefault(r => r.BookingId == bookingId);

                        if (existingReview != null)
                        {
                            txtComment.Text = existingReview.ReviewText;
                            hfRating.Value = existingReview.Rating.ToString();
                            lblFeedback.Text = "You can modify your existing comment.";
                            lblFeedback.Visible = true;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "updateStarDisplay",
                        $"setRating({existingReview.Rating});", true);
                        }
                        else
                        {

                            txtComment.Attributes.Add("placeholder", "Write Your Comment Here!");
                        }
                    }
                    else
                    {
                        lblFeedback.Text = "You cannot leave a comment until your booking is completed.";
                        lblFeedback.Visible = true;
                        txtComment.Visible = false;
                        hfRating.Visible = false;
                        submit.Visible = false;
                    }
                    
                }

                
            }

        }

        private void GetBookingDetails(string bookingId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            double addonTotal = calcAddOnTotal(bookingId);
            

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = "SELECT b.*, c.*,l.LocationAddress FROM Booking b JOIN Car c ON b.CarPlate=c.CarPlate JOIN Location l ON b.Pickup_point = l.LocationName WHERE b.Id = @BookingId";
                
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Populate the table with the data
                        hlPickUp.NavigateUrl = $"https://www.google.com/maps/search/?api=1&query={reader["LocationAddress"].ToString()}";
                        hlDropOff.NavigateUrl = $"https://www.google.com/maps/search/?api=1&query={reader["LocationAddress"].ToString()}";
                        lblBookingNumber.Text = bookingId;
                        img_car.ImageUrl = reader["CarImage"].ToString();
                        lblBookingDate.Text = Convert.ToDateTime(reader["BookingDate"]).ToString("dd-MMM-yyyy hh:mm tt");
                        lblPlateNum.Text = reader["CarPlate"].ToString();
                        lblPickUpLocation.Text = reader["Pickup_point"].ToString();
                        lblPickUpTime.Text = Convert.ToDateTime(reader["StartDate"]).ToString("dd-MMM-yyyy hh:mm tt");
                        lblDropOffLocation.Text = reader["Dropoff_point"].ToString();
                        lblDropOffTime.Text = Convert.ToDateTime(reader["EndDate"]).ToString("dd-MMM-yyyy hh:mm tt");
                        txtNotes.Text = reader["Notes"].ToString();
                        string status = reader["Status"].ToString();

                        //status part(hide edit and cancel)
                        if (status.Equals("Completed") || status.Equals("Cancelled"))
                        {
                            btnEdit.Visible = false;
                            btnDelete.Visible= false;
                        }else if (status.Equals("Pending"))
                        {
                            btnDelete.Visible = false;
                        }

                        //price part
                        DateTime startDate = Convert.ToDateTime(reader["StartDate"]);
                        DateTime endDate = Convert.ToDateTime(reader["EndDate"]);
                        double carDayPrice = Convert.ToDouble(reader["CarDayPrice"]);

                        TimeSpan timeDiff = endDate - startDate;
                        double totalRental = carDayPrice * Math.Ceiling(timeDiff.TotalDays);
                        lblRental.Text = totalRental.ToString("F2"); //TotalDays returns fractional number of days, use ceiling to meet our business rule
                        lblAddOnPrice.Text= addonTotal.ToString("F2");

                        double finalAmt = totalRental + addonTotal;
                        //handle price diff due to update
                        double initialAmt = Convert.ToDouble(reader["Price"]);
                        double afterUpdateAmt = updateFinalPrice(finalAmt, bookingId) ;
                        lblInitialAmt.Text = initialAmt.ToString("F2");
                        lblAfterUpdateAmt.Text = afterUpdateAmt.ToString("F2");
                        if (reader["Discount"] != DBNull.Value)
                        {
                            lblDiscountAmt.Text = Convert.ToDouble(reader["Discount"]).ToString("F2");
                        }
                        else
                        {
                            lblDiscount.Visible = false;
                            lblDiscountAmt.Visible = false;
                        }

                        double priceDiff = afterUpdateAmt - initialAmt;
                        double absPriceDiff = Math.Abs(priceDiff);

                        if (priceDiff > 0)
                        {
                            lblPriceFinalOutcome.Text = "Post-update Additional Charges (MYR)";
                            lblPriceFinalOutcomeAmt.Text = absPriceDiff.ToString("F2");
                            hdnFinalPriceInfo.Value = "Extra";
                        }
                        else if (priceDiff == 0)
                        {
                            lblPriceFinalOutcome.Text = "No Refund / Charges";
                            lblPriceFinalOutcomeAmt.Text = "";
                            hdnFinalPriceInfo.Value = "No";
                        }
                        else
                        {
                            lblPriceFinalOutcome.Text = "Post-update Partial Refund (MYR)";
                            lblPriceFinalOutcomeAmt.Text = absPriceDiff.ToString("F2");
                            hdnFinalPriceInfo.Value = "Refund";
                        }
                      
                       
                        //status part
                        lblBookStatus.Text = status;
                        lblBookStatus.CssClass = $"badge {GetBadgeClass(status)}";

                        if (reader["RejectReason"] != DBNull.Value)
                        {
                            lblRejectUpdate.Visible = true;
                            lblRejectUpdate.Text = "Reject Cancellation Reason: "+reader["RejectReason"].ToString();
                        }
                    }
                    
                }
            }
        }

        private double updateFinalPrice(double finalAmt,string bookingId)
        {
            string sql = @"UPDATE Booking
                           SET FinalPrice =@FinalPrice
                           WHERE Id = @BookingID";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@BookingID", bookingId);
            cmd.Parameters.AddWithValue("@FinalPrice", finalAmt);
            cmd.ExecuteNonQuery();
            con.Close();
            return finalAmt;
        }

        private void GetPaymentDetails(string bookingId)
        {
            string searchPaymentSql = @"SELECT CardNumber, CardHolderName, FORMAT(ExpDate,'MMM') AS ExpMonth, YEAR(ExpDate) AS ExpYear
                                        FROM PaymentCard p JOIN Booking b
                                        ON p.Id = b.PaymentCardId
                                        WHERE b.Id = @BookingId";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(searchPaymentSql, con);
            cmd.Parameters.AddWithValue("@BookingId", bookingId);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    lblCardHolderName.Text = reader["CardHolderName"].ToString();
                    lblCardExpire.Text = reader["ExpMonth"].ToString() + "/" + reader["ExpYear"].ToString();
                    string cardNumber = reader["CardNumber"].ToString();
                    string maskedPart = new string('*', cardNumber.Length - 3);
                    string lastThreeDigits = cardNumber.Substring(cardNumber.Length - 3);
                    lblCardNumberEnd.Text = maskedPart + lastThreeDigits;
                }

            }
            else
            {
                lblCardHolderName.Text = "";
                lblCardNumberEnd.Text = "";
                lblCardExpire.Text = "";
            }
            con.Close();
        }


        private double calcAddOnTotal(string bookingId)
        {
            double addonTotal=0;
            lblAddOnDesc.Text = "";
            
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
                        double price = Convert.ToDouble(reader["Price"]);
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
                    return "bg-warning";
                case "Booked":
                    return "bg-success";
                case "Cancelled":
                    return "bg-danger";
                case "Completed":
                    return "bg-primary";
                default:
                    return "bg-default"; // Or any default class
            }
        }

        protected void lkbtnBack_Click(object sender, EventArgs e)
        {
            //go bck to all record, clear the session first
            Session["oriAddOnPrice"] = null;
            Response.Redirect("bookingrecord.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", " modal();", true);
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
           
            Response.Redirect("bookingRecordUpdate.aspx?notes=" + txtNotes.Text + "&rental=" + lblRental.Text + "&oriAddOnPrice=" + lblAddOnPrice.Text+"&pickUpDateTime="+lblPickUpTime.Text);
            hdnOriAddOnPrice.Value = "";
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


        //You
        protected void submit_Click(object sender, EventArgs e)
        {
            int rating = int.Parse(hfRating.Value);
            string comment = txtComment.Text;

            string bookingId = Session["bookingrecordID"] as string;

            using (var db = new SystemDatabaseEntities())
            {
                var existingReview = db.Reviews.FirstOrDefault(r => r.BookingId == bookingId);

                if (existingReview != null)
                {
                    // Update the existing review
                    existingReview.ReviewText = comment;
                    existingReview.Rating = rating;
                    existingReview.ReviewDate = DateTime.Now;

                    db.SaveChanges();
                }
                else
                {
                    var newReview = new Review
                    {
                        BookingId = bookingId,
                        ReviewText = comment,
                        Rating = rating,
                        ReviewDate = DateTime.Now
                    };

                    db.Reviews.Add(newReview);
                    db.SaveChanges();
                }

            }

            txtComment.Text = "";
            hfRating.Value = "";

            lblFeedback.Text = "You have submitted the review.";
            lblFeedback.Visible = true;

            submit.Enabled = false;
            Response.Redirect("bookingrecorddetail.aspx");
        }

    }
}