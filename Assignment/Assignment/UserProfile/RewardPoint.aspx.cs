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
using System.Runtime.Remoting.Metadata.W3cXsd2001;
using System.Data;

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
                    //System.Diagnostics.Debug.WriteLine("SessionId: " + Session["Id"]);
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
            //System.Diagnostics.Debug.WriteLine("SessionId.toString: " + userid);

            //string username = " ";
            //string currentPoints = " ";
            //string expiryPoints = " ";
            //string expiryDate = " ";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                string sql = "SELECT au.Username, au.RewardPoints, bk.PointsRemaining, bk.EarnDate" +
                    " FROM ApplicationUser au" +
                    " JOIN Booking bk ON au.Id = bk.UserId" +
                    " WHERE au.Id = @userId";

                using (SqlCommand cmd = new SqlCommand(sql,con))
                {
                    cmd.Parameters.AddWithValue("@userId", userid);

                    con.Open();
                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            lblUsername.Text = rd["Username"].ToString();
                            lblTotalPoints.Text = "Total Points: " + rd["RewardPoints"].ToString() + " Pts";
                        }
                    }
                }


                string sqlGetExpiryDate = "SELECT EarnDate FROM Booking WHERE UserId = @userid";

                using (SqlCommand cmd = new SqlCommand(sqlGetExpiryDate, con))
                {
                    cmd.Parameters.AddWithValue("@userid", userid);

                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            DateTime earnDate = Convert.ToDateTime(rd["EarnDate"]);
                            DateTime expiryDate = earnDate.AddYears(1);
                            lblExpiryDate.Text = expiryDate.ToString();
                        }
                        else
                        {
                            lblExpiryDate.Text = "No Points Yet ~";
                        }
                    }
                }
            }
        }

        protected void btnRedeem_Click(object sender, EventArgs e)
        {
            Response.Redirect("Redemption.aspx");
        }
    }
}