using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Assignment
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Id"] != null)
            {
                LoadUserData(Session["Id"].ToString());
            }
            
        }

        protected void LoadUserData(String id)
        {
            String Username = " ";
            String Roles = " ";
            String profilePicture = " ";

            SqlConnection conn = new SqlConnection(Global.CS);

            conn.Open();

            string getUserData = "Select Username, Roles, ProfilePicture from ApplicationUser where Id = @id";

            SqlCommand com = new SqlCommand(getUserData, conn);

            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Username = reader["Username"].ToString();
                Roles = reader["Roles"].ToString().Trim(' ');
                profilePicture = reader["ProfilePicture"].ToString();
            }

            conn.Close();

            admin.Visible = Roles.Equals("Admin", StringComparison.OrdinalIgnoreCase);

            Guest.Visible = false;
            userName.Text = Username.ToString();
            userProfilePicture.ImageUrl = profilePicture;
            loginUser.Visible = true;

        }

        protected void logoutBtn_Click(object sender, EventArgs e)
        {
            Session["Id"] = null;
            Server.Transfer("Home.aspx");
        }


        protected void hiddenBtn_Click(object sender, EventArgs e)
        {
            Session["Search"] = searchBar.Text;
            Server.Transfer("productListing.aspx");
        }
    }
}