using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.Security;

namespace Assignment
{
    public class Security
    {
        public static object Request { get; private set; }

        public static void LoginUser(string Id, string role, bool rememberMe)
        {
            HttpContext ctx = HttpContext.Current;
            //retriving old ticket
            HttpCookie authCookie = FormsAuthentication.GetAuthCookie(Id, rememberMe);
            //decrypt old ticket
            FormsAuthenticationTicket oldTicket = FormsAuthentication.Decrypt(authCookie.Value);
            //adding role into the new ticket
            FormsAuthenticationTicket newTicket = new FormsAuthenticationTicket(
                oldTicket.Version,
                oldTicket.Name,
                oldTicket.IssueDate,
                oldTicket.Expiration,
                oldTicket.IsPersistent,
                role
            );
            //encrypt new ticket 
            authCookie.Value = FormsAuthentication.Encrypt(newTicket);
            ctx.Response.Cookies.Add(authCookie);
            //pass the new ticket back to the client
            string redirectUrl = FormsAuthentication.GetRedirectUrl(Id, rememberMe);
            ctx.Response.Redirect(redirectUrl);
        }

        public static void ProcessRoles()
        {
            HttpContext ctx = HttpContext.Current;

            if (ctx.User != null &&
                ctx.User.Identity.IsAuthenticated &&
                ctx.User.Identity is FormsIdentity)
            {
                FormsIdentity identity = (FormsIdentity)ctx.User.Identity;
                string[] roles = identity.Ticket.UserData.Split(',');

                GenericPrincipal principal = new GenericPrincipal(identity, roles);
                ctx.User = principal;
                Thread.CurrentPrincipal = principal;
            }
        }
        public static string hashing(string password, string salt)
        {
            // Combine the password and salt
            string combinedPassword = password + salt;


            var sha256 = SHA256.Create();
                
            byte[] bytes = Encoding.UTF8.GetBytes(combinedPassword);

                
            byte[] hash = sha256.ComputeHash(bytes);

            string hashPassword = Convert.ToBase64String(hash);

            return hashPassword;
        }
    }
}