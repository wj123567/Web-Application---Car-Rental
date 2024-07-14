using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class validateEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Email"] != null)
            {
                txtVerifyEmail.Text = Session["Email"].ToString();
            }
            else
            {

               Response.Redirect("SignUp.aspx");
            }

        }
    }
}