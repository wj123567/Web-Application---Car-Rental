using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Id"] == null)
            {
                string userId = getCookies();
                if (userId != null)
                {
                    Session["Id"] = userId;
                    LoadUserData(Session["Id"].ToString());
                }
                else
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
            else
            {
                LoadUserData(Session["Id"].ToString());
            }
        }

        protected string getCookies()
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            string userId = null;
            if (authCookie != null)
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                if (ticket != null)
                {
                    userId = ticket.Name;
                }
            }

            return userId;
        }

        protected void LoadUserData(string userId)
        {
            string getUser = "SELECT Username, ProfilePicture, Roles FROM ApplicationUser WHERE Id = @Id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(getUser, con);
            com.Parameters.AddWithValue("@Id", userId);
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            if (reader.HasRows)
            {            
            if (reader.Read())
            {
                if (!Thread.CurrentPrincipal.IsInRole(reader["Roles"].ToString()))
                {
                    Session["Id"] = null;
                    FormsAuthentication.SignOut();
                    Response.Redirect("~/Home.aspx");
                }
                lblUsername.Text = reader["Username"].ToString();
                userProfilePicture.ImageUrl = reader["ProfilePicture"].ToString();
            }
            }
            else
            {
                Session["Id"] = null;
                FormsAuthentication.SignOut();
                Response.Redirect("~/Home.aspx");
            }
            con.Close();
            reader.Close();

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session["Id"] = null;
            FormsAuthentication.SignOut();
            Response.Redirect("~/Home.aspx");
        }
    }
}