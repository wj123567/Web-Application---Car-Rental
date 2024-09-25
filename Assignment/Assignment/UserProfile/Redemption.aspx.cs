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
                .Where(r => r.UserId == userId && r.RedeemDate == today)
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


            var userId = Session["Id"].ToString();
            var today = DateTime.Now.Date;

            using (var db = new SystemDatabaseEntities())
            {

                bool hasRedeemedToday = db.Redemptions
            .Any(r => r.UserId == userId && r.RedeemItemId == redeemItemId && r.RedeemDate == today);

                if (hasRedeemedToday)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('You have already redeemed this item today.');", true);
                }
                else
                {
                    // Proceed to redeem the item
                    Redemption redemption = new Redemption
                    {
                        UserId = userId,
                        RedeemItemId = redeemItemId,
                        RedeemDate = DateTime.Now
                    };

                    Debug.WriteLine($"UserId: {redemption.UserId}, RedeemItemId: {redemption.RedeemItemId}, RedeemDate: {redemption.RedeemDate}");

                    try
                    {
                        db.Redemptions.Add(redemption);
                        db.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        // Log the error
                        Debug.WriteLine($"Error saving redemption: {ex.Message}");
                        Debug.WriteLine(ex.StackTrace);
                        throw; // Optionally rethrow to indicate a failure
                    }



                    //db.Redemptions.Add(redemption);
                    //db.SaveChanges();

                    //ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Item redeemed successfully!');", true);

                    //LoadRedeemItem();
                }


            }
        }

        
    }
}