using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;
using System.Web.UI.WebControls;
using static System.Net.Mime.MediaTypeNames;


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

            string getUserData = "Select Username, Email, DOB, RegistrationDate, ProfilePicture from ApplicationUser where Id = @id";

            conn.Open();

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
            reader.Close();

            txtUsername.Text = username;
            txtEmailAddress.Text = email;
            txtBirthday.Text = dob.ToString("dd/MM/yyyy");
            txtMemberSince.Text = registrationDate.ToString("dd/MM/yyyy");
            userProfilePic.ImageUrl = profilePicture;

        }

        protected void btnEditUserProfile_Click(object sender, EventArgs e)
        {
            if (btnEditUserProfile.Text == "Save Changes") {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                String updateUser = "UPDATE ApplicationUser SET Username = @username WHERE Id = @id";

                con.Open();

                SqlCommand com = new SqlCommand(updateUser, con);
                com.Parameters.AddWithValue("@username", txtUsername.Text);
                com.Parameters.AddWithValue("@id", Session["Id"].ToString());

                com.ExecuteNonQuery();

                con.Close();

                txtUsername.Enabled = false;
                btnEditUserProfile.Text = "Edit";
            }else if(btnEditUserProfile.Text == "Edit")
            {
                txtUsername.Enabled = true;
                btnEditUserProfile.Text = "Save Changes";
            }
        }

        protected void userUploadProfile_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string id = Session["Id"].ToString();
                string folderLocation = Server.MapPath("~/Image/UserProfile");
                string relfolderLocation = "~/Image/UserProfile";
                string uploadFile = "UPDATE ApplicationUser SET ProfilePicture = @ProfilePicture WHERE Id = @id";
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                if (fuProfile.HasFile)
                {
                    int fileSize = fuProfile.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuProfile.FileName);
                        string fileName = id + ext;
                        string savePath = Path.Combine(folderLocation, fileName);
                        string relPath = Path.Combine(relfolderLocation, fileName);
                        fuProfile.SaveAs(savePath);

                        con.Open();
                        SqlCommand com = new SqlCommand(uploadFile, con);
                        com.Parameters.AddWithValue("@ProfilePicture", relPath);
                        com.Parameters.AddWithValue("@id", id);
                        com.ExecuteNonQuery();
                        con.Close();
                        Server.Transfer("profile.aspx");
                        lblProfilePic.Text = "Image Uploaded";
                }
            }
        }
    }
}