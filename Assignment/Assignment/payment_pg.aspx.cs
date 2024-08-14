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