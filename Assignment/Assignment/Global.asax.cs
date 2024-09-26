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
        protected void Application_Start(object sender, EventArgs e)
        {
            Application.Lock();
            Application["VisitorCount"] = 0;
            Application["LastVisitDate"] = DateTime.Today;
            Application.UnLock();
        }

        protected void Session_Start(object sender, EventArgs e)
        {
           Application.Lock();
            if ((DateTime)Application["LastVisitDate"] != DateTime.Today)
           {
                Application["VisitorCount"] = 0;
                Application["LastVisitDate"] = DateTime.Today;
           }

           Application["VisitorCount"] = (int)Application["VisitorCount"] + 1;

            if (Application["ActiveUsers"] == null)
            {
                Application["ActiveUsers"] = 1;
            }
            else
            {
                Application["ActiveUsers"] = (int)Application["ActiveUsers"] + 1;
            }
            Application["ActiveDate"] = DateTime.Now;
            Application.UnLock();
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
            HttpContext.Current.Cache["LastError"] = Server.GetLastError();
        }

        protected void Session_End(object sender, EventArgs e)
        {
            Application.Lock();
            Application["ActiveUsers"] = (int)Application["ActiveUsers"] - 1;
            Application["ActiveDate"] = DateTime.Now;
            Application.UnLock();
        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}