using System;
using System.Collections.Generic;
using System.Drawing.Design;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Assignment;

namespace Assignment.Management
{
    public partial class testModel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {

                // Call the method to get user data on page load
                GetUserDetails();
            }
        }

        private void GetUserDetails()
        {
            // Instantiate the Entity Framework context
            using (var context = new SystemDatabaseEntities() )
            {
                var userData = context.UserRewardPointsViews.ToList();
                lstAU.DataSource = userData;
                lstAU.DataBind();
            }
        }

    }
}