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
            if (!Page.IsPostBack)
            {
                Exception lastError = (Exception)HttpContext.Current.Cache["LastError"];
                if (Request.QueryString["ErrorCode"] != null)
                {
                    string errorCode = Request.QueryString["ErrorCode"].ToString();
                    lblError.Text = lblError.Attributes["data-error-msg"] = errorCode;
                    if (lastError != null)
                    {
                        lblErrorMsg.Text = lastError.InnerException.Message;
                    }
                    else
                    {
                        lblErrorMsg.Text = "Oops, unexpected error occur ˙◠˙";
                    }
                }
                else
                {
                    lblError.Text = lblError.Attributes["data-error-msg"] = "˙◠˙";
                    if (lastError != null)
                    {
                        lblErrorMsg.Text = lastError.InnerException.Message;
                    }
                    else
                    {
                        lblErrorMsg.Text = "Oops, unexpected error occur ˙◠˙";
                    }
                }
            }
            
        }
    }
}