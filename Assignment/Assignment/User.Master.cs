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

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["UserRegistrationConnectionString"].ConnectionString);

            conn.Open();

            string getUserData = "Select Username, Roles from UserRegistration where Id = @id";

            SqlCommand com = new SqlCommand(getUserData, conn);

            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Username = reader["Username"].ToString();
                Roles = reader["Roles"].ToString().Trim(' ');
            }

            conn.Close();

            admin.Visible = Roles.Equals("Admin", StringComparison.OrdinalIgnoreCase);

            Guest.Visible = false;
            userName.Text = Username;
            loginUser.Visible = true;

        }
    }
}