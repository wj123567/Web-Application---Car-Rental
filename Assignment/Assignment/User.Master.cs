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
using System.Xml.Linq;

namespace Assignment
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string userId = getCookies();                

                if (userId != null)
                {
                    Session["Id"] = userId;
                    LoadUserData(userId);
                }
                else if (userId != null && Session["Id"] != null)
                {
                    LoadUserData(Session["Id"].ToString());
                }
            }            
        }

        protected string getCookies()
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            string userId = null;
            if (authCookie != null)
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt
                (authCookie.Value);
                if (ticket != null)
                {
                    userId = ticket.Name;
                }
            }

            return userId;
        }

        protected void LoadUserData(string id)
        {
            string Username = " ";
            string profilePicture = " ";
            string role = " ";
            int isBan = 0;

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);            

            string getUserData = "Select Username, ProfilePicture,Roles, IsBan from ApplicationUser where Id = @id";

            conn.Open();

            SqlCommand com = new SqlCommand(getUserData, conn);

            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.HasRows)
            {
                if (reader.Read())
                {
                    Username = reader["Username"].ToString();
                    profilePicture = reader["ProfilePicture"].ToString();
                    role = reader["Roles"].ToString();
                    isBan = (int)reader["IsBan"];
                }

                conn.Close();

                if (!Thread.CurrentPrincipal.IsInRole(role) || isBan == 1)
                {
                    Session["Id"] = null;
                    FormsAuthentication.SignOut();
                    Response.Redirect("Home.aspx");
                }

                Guest.Visible = false;
                userName.Text = Username.ToString();
                userProfilePicture.ImageUrl = profilePicture;
                loginUser.Visible = true;
            }
            else
            {
                Session["Id"] = null;
                FormsAuthentication.SignOut();
                Response.Redirect("Home.aspx");
            }
        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session["Id"] = null;
            FormsAuthentication.SignOut();
            Response.Redirect("Home.aspx");
        }
    }
}