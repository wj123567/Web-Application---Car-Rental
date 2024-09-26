using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminRewardPoint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindListView();
            }

        }

        private void BindListView()
        {
            using (var db = new SystemDatabaseEntities())
            {
                var user = db.ApplicationUsers.ToList();

                RewardPointsListView.DataSource = user;
                RewardPointsListView.DataBind();
            }
        }

        protected void btnAddRewardPoints_Click(object sender, EventArgs e)
        {

        }

        protected void btnDeductRewardPoints_Click(object sender, EventArgs e)
        {

        }
    }
}