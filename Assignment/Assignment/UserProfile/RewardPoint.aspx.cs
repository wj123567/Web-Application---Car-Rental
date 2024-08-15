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

            string username = " ";
            string currentPoints = " ";
            string expiryPoints = " ";
            string expiryDate = " ";

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                string sql = "SELECT au.Username, bk.PointsRemaining" +
                                " FROM Booking bk" +
                                " JOIN ApplicationUser au ON bk.UserId = au.Id" +
                                " WHERE au.Id = @userid";

                using (SqlCommand cmd = new SqlCommand(sql,con))
                {
                    cmd.Parameters.AddWithValue("userid", userid);

                    con.Open();
                    using (SqlDataReader rd = cmd.ExecuteReader())
                    {
                        if (rd.Read())
                        {
                            lblUsername.Text = rd["Username"].ToString();
                            lblTotalPoints.Text = "Total Points: " + rd["PointsRemaining"].ToString() + "Pts";
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