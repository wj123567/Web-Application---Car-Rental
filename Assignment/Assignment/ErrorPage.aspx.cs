using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ErrorPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["ErrorCode"] != null)
            {
                string errorCode = Request.QueryString["ErrorCode"].ToString();
                lblError.Text = lblError.Attributes["data-error-msg"] = errorCode;
                lblErrorMsg.Text = Server.GetLastError().Message;
            }
            else
            {
                lblError.Text = lblError.Attributes["data-error-msg"] = "˙◠˙";
                lblErrorMsg.Text = Server.GetLastError().Message;
            }
            
        }
    }
}