using System;
using System.Collections.Generic;
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
            
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            // Register JavaScript to open a new window
            string script = "window.open('RewardPoint.aspx', '_blank');";

            // Register JavaScript to redirect the current page
            script += "window.location.href = window.location.href;";

            // Execute the script
            ClientScript.RegisterStartupScript(this.GetType(), "OpenAndRedirect", script, true);

        }
    }
}