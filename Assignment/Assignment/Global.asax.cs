using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace Assignment
{
    public class Global : System.Web.HttpApplication
    {
        public const string CS = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\SystemDatabase.mdf;Integrated Security=True";
        protected void Application_Start(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {
           
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            Security.ProcessRoles();
        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}