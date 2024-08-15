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
           
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString)) { 
            
                string sql = "SELECT CardNumber FROM PaymentCard";
                
                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        protected void btnPaymentPgBack_Click(object sender, EventArgs e)
        {
            Server.Transfer("bookinfo.aspx");

        }

        protected void btnPaymentPgPay_Click(object sender, EventArgs e)
        {
           
        }

        protected void modalCloseBtn_Click(object sender, EventArgs e)
        {
            // Redirect to bookingrecord.aspx after the modal "OK" button is clicked
            Response.Redirect("payment_pg.aspx");
        }



    }
}