using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Redemption : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                String clientID = Label1.ClientID;
                Label1.Attributes.Add("onmouseover", $"showText('{clientID}')");
            }
        }

    }
}