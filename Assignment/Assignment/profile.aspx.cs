using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
            if (Session["Id"] != null)
            {
                LoadUserData(Session["Id"].ToString());
            }
            else
            {
                Server.Transfer("Home.aspx");
            }
            }
        }

        protected void LoadUserData(String id)
        {
            String username = " ";
            String email = " ";
            DateTime dob = DateTime.Now;
            DateTime registrationDate = DateTime.Now;
            String profilePicture = " ";

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            conn.Open();

            string getUserData = "Select Username, Email, DOB, RegistrationDate, ProfilePicture from UserRegistration where Id = @id";

            SqlCommand com = new SqlCommand(getUserData, conn);

            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                username = reader["Username"].ToString();
                email = reader["Email"].ToString();
                dob = reader.GetDateTime(reader.GetOrdinal("DOB"));
                registrationDate = reader.GetDateTime(reader.GetOrdinal("RegistrationDate"));
                profilePicture = reader["ProfilePicture"].ToString();
            }

            conn.Close();

            txtUsername.Text = username;
            txtEmailAddress.Text = email;
            txtBirthday.Text = dob.ToString("dd/MM/yyyy");
            txtMemberSince.Text = registrationDate.ToString("dd/MM/yyyy");
            userProfilePic.ImageUrl = profilePicture;

        }

        protected void btnEditUserProfile_Click(object sender, EventArgs e)
        {
            if (btnEditUserProfile.Text == "Save Changes") {
                txtUsername.Enabled = false;
                btnEditUserProfile.Text = "Edit";
            }else if(btnEditUserProfile.Text == "Edit")
            {
                txtUsername.Enabled = true;
                btnEditUserProfile.Text = "Save Changes";
            }
        }
    }
}