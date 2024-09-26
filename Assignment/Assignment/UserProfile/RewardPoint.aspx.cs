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
                    string userId = Session["Id"]?.ToString();
                    LoadUserData(userId);
                }
                else
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
        }

        private void LoadUserData(string userId)
        {
            using (var db = new SystemDatabaseEntities())
            {
                var user = db.ApplicationUsers.FirstOrDefault(u => u.Id == userId);

                if (user != null)
                {
                    lblUsername.Text = user.Username;
                    lblTotalPoints.Text = user.RewardPoints.ToString() + " Points";

                    var oldestBooking = db.Bookings
                                        .Where(b => b.UserId == userId && b.EarnDate != null)
                                        .OrderBy(b => b.EarnDate)
                                        .FirstOrDefault();

                    if (oldestBooking != null && oldestBooking.EarnDate.HasValue)
                    {
                        DateTime expiryDate = oldestBooking.EarnDate.Value.AddYears(1);
                        lblExpiryDate.Text = expiryDate.ToString();
                    }
                    else
                    {
                        lblExpiryDate.Text = "No expiry date available";
                    }
                }
                else
                {
                    lblUsername.Text = "User not found";
                    lblTotalPoints.Text = "0";
                }
            }
        }

        protected void btnRedeem_Click(object sender, EventArgs e)
        {
            Response.Redirect("Redemption.aspx");
        }
    }
}