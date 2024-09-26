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
using Assignment.Models;

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
                    LoadPointsHistory(userId);
                    BindPointsHistory();
                }
                else
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
        }

        private void BindPointsHistory()
        {
            var pointsRecords = ViewState["PointsRecords"] as List<PointsRecord>;

            if (pointsRecords != null)
            {
                lvPointsHistory.DataSource = pointsRecords;
                lvPointsHistory.DataBind();
            }
        }

        private void LoadPointsHistory(string userId)
        {
            using (var db = new SystemDatabaseEntities())
            {
                var pointsRecords = new List<PointsRecord>();

                //earned points
                var earnedPoints = db.Bookings
                                     .Where(b => b.UserId == userId
                                            && b.Status == "Completed"
                                            && b.EarnDate.HasValue)
                                     .Select(b => new PointsRecord
                                     {
                                         Date = b.EarnDate.Value,
                                         Points = (int)(b.FinalPrice / 10),
                                         IsEarned = true,
                                         RedeemDescription = null
                                     }).ToList();

                // Used points
                var usedPoints = db.Redemptions
                                   .Where(r => r.UserId == userId)
                                   .Select(r => new PointsRecord
                                   {
                                       Date = r.RedeemDate,
                                       Points = db.RedeemItems
                                                .Where(i => i.RedeemItemId == r.RedeemItemId)
                                                .Select(i => i.ItemPoints)
                                                .FirstOrDefault() ?? 0,
                                       IsEarned = false,
                                       RedeemDescription = db.RedeemItems.Where(i => i.RedeemItemId == r.RedeemItemId)
                                                                        .Select(i => i.ItemDescription)
                                                                        .FirstOrDefault()
                                   }).ToList();

                // Combine and sort records by date
                pointsRecords.AddRange(earnedPoints);
                pointsRecords.AddRange(usedPoints);
                pointsRecords = pointsRecords.OrderBy(pr => pr.Date).ToList();

                // Save to ViewState
                ViewState["PointsRecords"] = pointsRecords;
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

                    DateTime expiryDate = new DateTime(DateTime.Now.Year, 12, 31);

                    if (user.RewardPoints > 0)
                    {
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