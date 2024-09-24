using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Runtime.Remoting.Contexts;

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
                    IsRedeemed = redeemedItemsToday.Contains(item.RedeemItemId)
                }).ToList();


                lvredeemitems.DataSource = redeemItems;
                lvredeemitems.DataBind();

            }
        }

        protected void btnRedeem_Click(object sender, EventArgs e)
        {

        }

        
    }
}