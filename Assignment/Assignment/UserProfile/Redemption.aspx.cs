using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Runtime.Remoting.Contexts;
using System.Diagnostics;
using System.Data.Entity.Validation;
using System.Data.Entity.Core.Objects;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.Infrastructure;
using System.Data.Entity;

namespace Assignment
{
    public partial class Redemption : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Id"] != null)
                {
                    LoadRedeemItem();
                }
                else
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
        }

        private void LoadRedeemItem()
        {
            using (var db = new SystemDatabaseEntities())
            {   
                var redeemItems = db.RedeemItems.ToList();
                var userId = Session["Id"].ToString();
                var today = DateTime.Now.Date;


                var userPoints = db.ApplicationUsers
                    .Where(a => a.Id == userId)
                    .Select(a => a.RewardPoints)
                    .FirstOrDefault();

                lblPointsBalance.Text = userPoints.ToString();

                var redeemedItemsToday = db.Redemptions
                    .Where(r => r.UserId == userId &&
                                DbFunctions.TruncateTime(r.RedeemDate) == DbFunctions.TruncateTime(DateTime.Now)) // Compare date parts only
                    .Select(r => r.RedeemItemId)
                    .ToList();

                var redeemItemList = redeemItems.Select(item => new
                {
                    item.RedeemItemId,
                    item.ItemName,
                    item.ItemDescription,
                    item.ItemPoints,
                    item.ItemImage,
                    IsRedeemed = redeemedItemsToday.Contains(item.RedeemItemId),
                    IsUnavailable = item.Status == "Unavailable"
                }).ToList();


                lvredeemitems.DataSource = redeemItemList;
                lvredeemitems.DataBind();

            }
        }

        protected void btnRedeem_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int redeemItemId = Convert.ToInt32(btn.CommandArgument);
            var userId = Session["Id"]?.ToString();

            using (var db = new SystemDatabaseEntities())
            {
                // Get user points
                var user = db.ApplicationUsers.FirstOrDefault(a => a.Id == userId);
                if (user == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('User not found.');", true);
                    return;
                }

                int? userPoints = user.RewardPoints;

                // Get item points
                var item = db.RedeemItems.FirstOrDefault(i => i.RedeemItemId == redeemItemId);
                if (item == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Item not found.');", true);
                    return;
                }

                int? itemPoints = item.ItemPoints;

                if (userPoints == null || itemPoints == null)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error: Unable to retrieve points.');", true);
                    return;
                }

                if (userPoints < itemPoints)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You do not have enough points to redeem this item.');", true);
                    return; // Exit if points are insufficient
                }
                else
                {
                    bool hasRedeemedToday = db.Redemptions
                    .Any(r => r.UserId == userId &&
                               r.RedeemItemId == redeemItemId &&
                               DbFunctions.TruncateTime(r.RedeemDate) == DbFunctions.TruncateTime(DateTime.Now));

                    if (hasRedeemedToday)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You have already redeemed this item today.');", true);
                        return; // Exit if already redeemed
                    }

                    user.RewardPoints -= itemPoints.Value;
                }

                string sql = "INSERT INTO Redemption (UserId, RedeemItemId, RedeemDate) VALUES (@UserId, @RedeemItemId, @RedeemDate)";
                var parameters = new[]
                {
                    new SqlParameter("@UserId", userId),
                    new SqlParameter("@RedeemItemId", redeemItemId),
                    new SqlParameter("@RedeemDate", DateTime.Now)
                };

                try
                {
                    // Execute the SQL command
                    db.Database.ExecuteSqlCommand(sql, parameters);

                    db.Entry(user).State = EntityState.Modified;
                    db.SaveChanges();

                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Redemption successful!');", true);
                    LoadRedeemItem();
                }
                catch (Exception ex)
                {
                    Debug.WriteLine($"Error saving redemption: {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error redeeming item.');", true);
                }

            }
        }


    }
}