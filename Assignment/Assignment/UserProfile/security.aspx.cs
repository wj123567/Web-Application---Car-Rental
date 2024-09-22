using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Text;
using System.Web.Security;

namespace Assignment
{
    public partial class ChangePassword : System.Web.UI.Page
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
                    Session["Id"] = getCookies();
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
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                if (ticket != null)
                {
                    userId = ticket.Name;
                }
            }

            return userId;
        }
        protected void LoadUserData(String id)
        {
            String email = " ";
            String twoStepVerification = "";

            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            string getUserData = "Select Email, TwoStepVerification from ApplicationUser where Id = @id";

            conn.Open();

            SqlCommand com = new SqlCommand(getUserData, conn);

            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                email = reader["Email"].ToString();
                twoStepVerification = reader["TwoStepVerification"].ToString();
            }

            conn.Close();
            reader.Close();

            txtTwoFactorEmail.Text = email;

            if(twoStepVerification == "1")
            {
                rblOtpSwitch.SelectedIndex = 0;
            }
            else
            {
                rblOtpSwitch.SelectedIndex = 1;
            
            }

        }

        protected Boolean validPassword(String simplePassword)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            con.Open();

            string hashPassword = " ";

            string getUserId = "Select Password from ApplicationUser where id = @id";

            SqlCommand comId = new SqlCommand(getUserId, con);

            comId.Parameters.AddWithValue("@id", Session["Id"].ToString());

            SqlDataReader reader = comId.ExecuteReader();

            if (reader.Read())
            {
                hashPassword = reader["Password"].ToString();
            }

            reader.Close();

            if (hashPassword == Security.hashing(simplePassword, Session["Id"].ToString()))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void validCurrentPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            String simplePassword = txtCurrentPass.Text;

            args.IsValid = validPassword(simplePassword);
        }

        protected void validNewPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            String simplePassword = txtNewPassword.Text;

            args.IsValid = !validPassword(simplePassword);
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                String Id = Session["Id"].ToString();

                string simplePassword = txtNewPassword.Text;

                string hashPassword = Security.hashing(simplePassword, Id);

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                string updateUser = "UPDATE ApplicationUser SET Password = @Password WHERE Id = @id";

                try
                {
                    con.Open();
                    SqlCommand comUpdate = new SqlCommand(updateUser, con);
                    comUpdate.Parameters.AddWithValue("password", hashPassword);
                    comUpdate.Parameters.AddWithValue("id", Id.ToString());
                    comUpdate.ExecuteNonQuery();


                    con.Close();
                    Response.AddHeader("REFRESH", "2;Home.aspx");
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.ToString());
                }
            }

        }
        protected void rblOtpSwitch_SelectedIndexChanged(object sender, EventArgs e)
        {
            int option = int.Parse(rblOtpSwitch.SelectedValue);
            String id = Session["Id"].ToString();

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            String upadateCom = "UPDATE ApplicationUser set TwoStepVerification = @tsv WHERE Id = @id";

            con.Open();
            SqlCommand com = new SqlCommand(upadateCom, con);
            com.Parameters.AddWithValue("@tsv", option);
            com.Parameters.AddWithValue("@id", id);
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void validDeletePassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            String simplePassword = txtDeletePassword.Text;

            if (!validPassword(simplePassword))
            {
                args.IsValid = false;
                updateDeleteAcc.Update();
            }
            else
            {
                args.IsValid = true;
            }
        }
        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                String id = Session["Id"].ToString();

                string path = MapPath("~/Image/UserProfile/");

                File.Delete(path + id + ".jpg");

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                string deleteCom = "DELETE FROM PaymentCard WHERE UserId = @id; DELETE FROM ApplicationUser WHERE Id = @id";

                con.Open();
                SqlCommand com = new SqlCommand(deleteCom, con);

                com.Parameters.AddWithValue("@id", id);

                com.ExecuteNonQuery();

                con.Close();

                Session["Id"] = null;
                Response.Redirect("~/Home.aspx");
            }
        }
    }
}