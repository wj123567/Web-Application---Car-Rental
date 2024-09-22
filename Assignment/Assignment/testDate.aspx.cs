using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class testDate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            hdnStart.Value = DateTime.Now.AddDays(3).ToString("dd-MM-yyyy HH:mm");
            hdnEnd.Value = DateTime.Now.AddDays(5).ToString("dd-MM-yyyy HH:mm");
        }
    }
}