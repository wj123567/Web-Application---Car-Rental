using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//step1
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Util;

namespace Assignment
{
    public partial class RewardPoint : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Id"] != null)
                {
                    LoadUserData(Session["Id"].ToString());
                }
                else
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
        }

        private void LoadUserData(string userid)
        {
            string username = " ";
            string latestExpiryDate = " ";
            string latestExpiryPoint = " ";
            string currentPoints = " ";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {

            }
        }

        protected void btnRedeem_Click(object sender, EventArgs e)
        {
            Response.Redirect("Redemption.aspx");
        }
    }
}