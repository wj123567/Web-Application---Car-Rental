﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class payment_pg : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!Page.IsPostBack)
            {
                //----retrieve the sync data 
                retrieveData();
                int currentStep = (int)(Session["CurrentStep"] ?? 1);
                UpdateProgressBar(currentStep);

                BindCards();
                

            }
        }

        protected void retrieveData()
        {
            string totalDayRent = Session["TotalDayRent"].ToString();
            string totalPrice = Session["TotalPrice"] as string ?? "0.00";
            string totalAddOn = Session["TotalAddOn"] as string ?? "0.00";
            string carRental = Session["CarRental"].ToString();



            lblTotalDayRent.Text = totalDayRent;
            lblAddOnPrice.Text = totalAddOn;
            lblCarRental.Text = carRental;

            lblTotalPrice.Text = totalPrice; 
        }

        private void BindCards()
        {
            // Assuming you have a method GetAddOns() that returns a DataTable or List<AddOn>
            var addCards = GetCards();

            rptCards.DataSource = addCards;
            rptCards.DataBind();

        }

        private DataTable GetCards()
        {

            // Assuming you have a way to get the UserId, such as from Session or some other source
            string userId = "ae0a1581-21ea-4ea6-920c-80bef28a0129"; // Replace with your actual method to retrieve UserId

            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT * FROM PaymentCard WHERE UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    // Adding the parameter to the SqlCommand
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
                
            }
            
            
        }

        protected string getCardsPhoto(string cardType)
        {
            /* string sql = @"SELECT CardType from PaymentCard p JOIN ApplicationUser a ON p.UserId = a.Id 
                             JOIN Booking ON a.Id = b.UserId WHERE b.UserId = @UserId";*/
            switch (cardType)
            {
                case "Master":
                    return "Image/WZ/mastercard.png";
                case "Visa":
                    return "Image/WZ/visa.png";
                case "American Express":
                    return "Image/WZ/amex.png";
                default:
                    return "";

            }

        }
        protected string FormatCardNumber(string cardNumber)
        {
            if (string.IsNullOrEmpty(cardNumber) || cardNumber.Length < 4)
            {
                return cardNumber; // Return the card number as-is if it's too short to format
            }

            string maskedPart = new string('*', cardNumber.Length - 4);
            string lastFourDigits = cardNumber.Substring(cardNumber.Length - 4);
            return maskedPart + lastFourDigits;
        }

        protected void btnPaymentPgBack_Click(object sender, EventArgs e)
        {
            int currentStep = (int)(Session["CurrentStep"] ?? 1);
            currentStep = Math.Max(currentStep - 1, 1);
            Session["CurrentStep"] = currentStep;
            UpdateProgressBar(currentStep);
            Response.Redirect("bookinfo.aspx");
        }

        protected void btnBookingConfirm_Click(object sender, EventArgs e)
        {
            /*       Session["Pickup_point"]
           Session["Pickup_state"]
           Session["StartDate"]
           Session["Dropoff_point"]
           Session["Dropoff_state"]
           Session["EndDate"]

           Session["CarPlate"]
                Session["TotalAddOn"]
                Session["TotalPrice"]
          */
            String insertString = @"INSERT INTO Booking (Id,CarPlate,UserId,DriverId,StartDate,EndDate,Pickup_point,Dropoff_point,Status
                                ,PaymentCardId,Price,Notes) 
                                VALUES (@Id,@CarPlate,@UserId,@DriverId,@StartDate,@EndDate,@Pickup_point,@Dropoff_point,@Status
                                ,@PaymentCardId,@Price,@Notes)";

            SaveBookingInfo(insertString);
/*
            // Trigger the modal to be shown after the record is inserted
            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "$('#paymentModal').modal('show');", true);*/

            Response.Redirect("Home.aspx");
        }

        private void SaveBookingInfo(string insertString)
        {
            string bookingID = Session["BookingID"].ToString();
            string userID = Session["Id"].ToString();
            string pickupPoint = Session["Pickup_point"].ToString();
            DateTime startDateTime = DateTime.Parse(Session["StartDate"].ToString());
            DateTime endDateTime = DateTime.Parse(Session["EndDate"].ToString());
           /* string startDate = Session["StartDate"].ToString();*/
            string dropoffPoint = Session["Dropoff_point"].ToString();
           /* string endDate = Session["EndDate"].ToString();*/
            string carPlate = Session["CarPlate"].ToString();
            string totalPrice = Session["TotalPrice"].ToString();
            string cardID = hdnUsedCardId.Value;
            
            string notes = Session["Notes"].ToString();
            
            string driverStatus = CheckDriverStatus(Session["DriverId"].ToString());
            string driverID = Session["DriverId"].ToString();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(insertString, con);
            com.Parameters.AddWithValue("@Id",bookingID);
            com.Parameters.AddWithValue("@CarPlate",carPlate);
            com.Parameters.AddWithValue("@UserId",userID);
            com.Parameters.AddWithValue("@DriverId",driverID);
            com.Parameters.AddWithValue("@StartDate",startDateTime);
            com.Parameters.AddWithValue("@EndDate",endDateTime);
            com.Parameters.AddWithValue("@Pickup_point",pickupPoint);
            com.Parameters.AddWithValue("@Dropoff_point",dropoffPoint);
            com.Parameters.AddWithValue("@PaymentCardId",cardID);
            com.Parameters.AddWithValue("@Price",totalPrice);
            com.Parameters.AddWithValue("@Notes",notes);

               
                               
            if (driverStatus == "A")
            {
                com.Parameters.AddWithValue("@Status", "Booked");
            }
            else if (driverStatus == "P")
            {
                com.Parameters.AddWithValue("@Status", "Pending");
            }
            com.ExecuteNonQuery();
            con.Close();

        }

        private string CheckDriverStatus(string driverID)
        {
            String selectDriver = "SELECT * FROM Driver WHERE Id = @ID";
            string status = "";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@ID", driverID);
            SqlDataReader reader = com.ExecuteReader();

            if (reader.HasRows && reader.Read() )
            {
                
                    status = reader["Approval"].ToString();
                
                
            }

            reader.Close();
            con.Close();
            return status;

        }
        private void UpdateProgressBar(int currentStep)
        {
            // Register a script to update the progress bar client-side
            string script = $"updateProgressBar({currentStep});";
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateProgressBar", script, true);
        }

        protected void modalOkBtn_Click(object sender, EventArgs e)
        {
            // Redirect to bookingrecord.aspx after the modal "OK" button is clicked
            Response.Redirect("Home.aspx");
        }

        protected void btnExistCard_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;

            string cardId = button.CommandArgument;

            FillCardInfo(cardId);
            int currentStep = 4;
            UpdateProgressBar(currentStep);
        }

        protected void FillCardInfo(string cardId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "Select * FROM PaymentCard WHERE Id=@Id";

                SqlCommand cmd = new SqlCommand(sql, con);
                    
                // Adding the parameter to the SqlCommand
                cmd.Parameters.AddWithValue("@Id", cardId);
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                    
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        txtCardNumber.Text = reader["CardNumber"].ToString();
                        txtCardName.Text = reader["CardHolderName"].ToString();
                        hdnUsedCardId.Value = cardId;
                        
                        DateTime expDate = reader.GetDateTime(reader.GetOrdinal("ExpDate"));
                        txtExpiry.Text = expDate.ToString("yyyy-MM");
                        txtCvv.Text = reader["CVV"].ToString();
                    }
                }

                con.Close();
            }
           
        }

    }
}