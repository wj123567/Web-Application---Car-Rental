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
    public partial class payment_pg : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                          
                    BindCards();
                     

            }
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
                string sql = "SELECT CardNumber FROM PaymentCard WHERE UserId = @UserId";

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
            Response.Redirect("bookinfo.aspx");
        }

        protected void btnPaymentPgPay_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "validateForm();", true);

        }

        protected void modalOkBtn_Click(object sender, EventArgs e)
        {
            // Redirect to bookingrecord.aspx after the modal "OK" button is clicked
            Response.Redirect("bookingrecord.aspx");
        }



    }
}