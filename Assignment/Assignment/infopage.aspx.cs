﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
	public partial class infopage : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            Server.Transfer("bookinfo.aspx");
        }

        protected void previous_btn_Click(object sender, EventArgs e)
        {
            Server.Transfer("Home.aspx");
        }
    }
}