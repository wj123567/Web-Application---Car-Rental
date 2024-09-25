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

                bool hasRedeemedToday = db.Redemptions
                    .Any(r => r.UserId == userId &&
                               r.RedeemItemId == redeemItemId &&
                               DbFunctions.TruncateTime(r.RedeemDate) == DbFunctions.TruncateTime(DateTime.Now));

                if (hasRedeemedToday)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You have already redeemed this item today.');", true);
                    return; // Exit if already redeemed
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