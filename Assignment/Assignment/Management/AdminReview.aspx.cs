using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Management
{
    public partial class AdminReview : System.Web.UI.Page
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
                var reviewData = db.Reviews.ToList();

                lvReview.DataSource = reviewData;
                lvReview.DataBind();
            }
        }
    }
}