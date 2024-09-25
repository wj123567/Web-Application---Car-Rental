using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
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

                //in accordion
                BindCards();
               
               
            }
        }

        protected void retrieveData()
        {
            string totalDayRent = Session["TotalDayRent"].ToString();
            string totalPrice = Session["TotalPrice"] as string ?? "0.00";
            string totalAddOn = Session["TotalAddOn"] as string ?? "0.00";
            string carRental = Session["CarRental"].ToString();

            string discount = Session["Discount"] as string ?? "0.00";

            lblTotalDayRent.Text = totalDayRent;
            lblDiscount.Text = discount;
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

            
            // Toggle visibility of the checkbox and label based on the presence of items in the DataTable
            if (addCards.Rows.Count > 0)
            {
                chkApplyCard.Visible = true;
                lblApplyCard.Visible = true;
            }
            else
            {
                hdnCardCheck.Value = "New"; 
                chkApplyCard.Visible = false;
                lblApplyCard.Visible = false;
            }

        }
        
        private DataTable GetCards()
        {

            // Assuming you have a way to get the UserId, such as from Session or some other source
            string userId = Session["Id"].ToString(); // Replace with your actual method to retrieve UserId

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

        protected void chkApplyCard_CheckedChanged(object sender, EventArgs e)
        {
            //toggle the accordion depending on checkbox 
            ScriptManager.RegisterStartupScript(this, GetType(), "toggleAccordionScript", "toggleAccordion();", true);
            if (chkApplyCard.Checked)
            {
                applyDefaultCard();  // Call the method to fetch and apply default card details
            }
            
        }

        private void applyDefaultCard()
        {
            string userId = Session["Id"].ToString();
            string sql = @"SELECT * FROM PaymentCard WHERE UserId = @UserId and IsDefault = 1";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@UserId", userId);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    txtCardName.Text = reader["CardHolderName"].ToString();
                    txtCardNumber.Text = reader["CardNumber"].ToString();
                    DateTime expDate = reader.GetDateTime(reader.GetOrdinal("ExpDate"));
                    txtExpiry.Text = expDate.ToString("yyyy-MM");
                    //need to use when save to booking later
                    hdnUsedCardId.Value = reader["Id"].ToString();
                }
               
            }
            else
            {
                txtCardName.Text = "000";
            }

            chkApplyCard.Checked = true;

            reader.Close();
            con.Close();
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

        protected string CheckCardDefault(string isDefault)
        {
            if(isDefault == "1")
            {         
                return "Default";
            }
            return "";
        }

        protected string GetDefaultBadge(string isDefault)
        {
            switch (isDefault)
            {
                case "1":
                    return "bg-light";
                default:
                    return "";
            }
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
         
            if (hdnCardCheck.Value == "New" || hdnCardCheck.Value == "NewAdded")
            {
                string insertCardString = @"INSERT into PaymentCard (CardNumber, CardHolderName, ExpDate, CVV, UserId, CardType, Id, IsDefault) 
                                         VALUES (@CardNumber , @CardHolderName, @ExpDate, @CVV, @UserId, @CardType, @Id, @IsDefault)";
                Guid newGUID = Guid.NewGuid();
                SaveCardInfo(insertCardString, newGUID.ToString());
            }

            String insertString = @"INSERT INTO Booking (Id,CarPlate,UserId,DriverId,StartDate,EndDate,Pickup_point,Dropoff_point,Status
                                ,PaymentCardId,Price,Notes,BookingDate,FinalPrice) 
                                VALUES (@Id,@CarPlate,@UserId,@DriverId,@StartDate,@EndDate,@Pickup_point,@Dropoff_point,@Status
                                ,@PaymentCardId,@Price,@Notes,@BookingDate,@FinalPrice)";

            SaveBookingInfo(insertString);

            string insertBookingAddOnString = @"INSERT INTO BookingAddOn (BookingId,AddOnId, Quantity)
                                                VALUES (@BookedID,@AddOnID, @Quantity)";

            Dictionary<int, int> selectedAddOns = Session["SelectedAddOns"] as Dictionary<int, int>;

            if (selectedAddOns != null || selectedAddOns.Count != 0)
            {
                SaveBookingAddOnInfo(insertBookingAddOnString, selectedAddOns);
            }



            /*
                        // Trigger the modal to be shown after the record is inserted
                        ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "$('#paymentModal').modal('show');", true);*/

            //you start
            if (Session["SelectedVoucherId"] != null && int.TryParse(Session["SelectedVoucherId"].ToString(), out int selectedVoucherId))
            {
                using (var db = new SystemDatabaseEntities())
                {
                    var sql = @"
                        UPDATE Redemption
                        SET IsActive = 0
                        WHERE RedeemItemId = @selectedVoucherId AND 
                        RedeemDate = (
                            SELECT MAX(RedeemDate)
                            FROM Redemption
                            WHERE RedeemItemId = @selectedVoucherId
                        )";

                    db.Database.ExecuteSqlCommand(sql, new SqlParameter("@selectedVoucherId", selectedVoucherId));
                }
            }
            //you end


            Response.Redirect("Home.aspx");
        }

        private void SaveBookingInfo(string insertString)
        {
            string cardID = "";
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
            string notes = Session["Notes"].ToString();
            

            if(hdnCardCheck.Value=="New" || hdnCardCheck.Value== "NewAdded")
            {
                cardID = hdnNewCardId.Value;    //new or newly added
            }
            else
            {
                cardID = hdnUsedCardId.Value;   //apply existing card
            }
           

            
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
            com.Parameters.AddWithValue("@BookingDate", DateTime.Now);
            com.Parameters.AddWithValue("@FinalPrice", totalPrice);
               
                               
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

        protected void SaveCardInfo(string uploadString, string id)
        {
            
            if (Page.IsValid)
            {
                hdnNewCardId.Value = id;
                int defaultCard = 0;

                if (hdnCardCheck.Value == "New")
                {
                    defaultCard = 1;
                }
                String cardType = hdnCardType.Value;

                DateTime expDate = DateTime.Parse(txtExpiry.Text);
                String cardNumber = txtCardNumber.Text.Replace(" ", "");

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                con.Open();
                SqlCommand com = new SqlCommand(uploadString, con);
                com.Parameters.AddWithValue("@CardNumber", cardNumber);
                com.Parameters.AddWithValue("@CardHolderName", txtCardName.Text);
                com.Parameters.AddWithValue("@ExpDate", expDate);
                com.Parameters.AddWithValue("@CVV", txtCvv.Text);
                com.Parameters.AddWithValue("@UserId", Session["Id"].ToString());
                com.Parameters.AddWithValue("@CardType", cardType);
                com.Parameters.AddWithValue("@Id", id);
                com.Parameters.AddWithValue("@IsDefault", defaultCard);
                com.ExecuteNonQuery();
               
                con.Close();
            }

        }

        private void SaveBookingAddOnInfo(string insertBookingAddOn, Dictionary<int, int> selectedAddOns)
        {
           

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(insertBookingAddOn, con);
            foreach (var addOn in selectedAddOns)
            {
                int addOnID = addOn.Key;
                int quantity = addOn.Value;
                // Set parameters for the current iteration
                com.Parameters.Clear();
                com.Parameters.AddWithValue("@BookedID", Session["BookingID"].ToString());
                com.Parameters.AddWithValue("@AddOnID",addOnID);
                com.Parameters.AddWithValue("@Quantity",quantity);
                com.ExecuteNonQuery();
            }
            con.Close ();
        }
        private void UpdateProgressBar(int currentStep)
        {
            // Register a script to update the progress bar client-side
            string script = $"updateProgressBar({currentStep});";
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateProgressBar", script, true);
        }

        protected void modalOkBtn_Click(object sender, EventArgs e)
        {
            
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
            Dictionary<int, int> selectedAddOns = Session["SelectedAddOns"] as Dictionary<int, int>;

            /*foreach (var addOn in selectedAddOns)
            {
                int addOnID = addOn.Key;
                int quantity = addOn.Value;
                lblCheckAdd.Text += addOnID + " "+ quantity+",";
            }*/

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
               
                    }
                }
                chkApplyCard.Checked = true;
                //toggle the accordion depending on checkbox 
                ScriptManager.RegisterStartupScript(this, GetType(), "toggleAccordionScript", "toggleAccordion();", true);
                con.Close();
            }
           
        }

    }
}