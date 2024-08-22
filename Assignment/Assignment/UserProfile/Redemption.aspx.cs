using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

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
                var redeemItems = db.RedeemItems.Where(item => item.Status == "active").ToList();

                lvredeemitems.DataSource = redeemItems;
                lvredeemitems.DataBind();

            }
        }
    }
}