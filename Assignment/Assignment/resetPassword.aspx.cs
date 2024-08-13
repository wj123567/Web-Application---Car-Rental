using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.IO;
using System.Threading;
using System.Text;

namespace Assignment
{
    public partial class resetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["forgetId"] == null)
                {
                    Server.Transfer("forgetPassword.aspx");
                }
            }
        }

        protected string HashPassword(string password, string salt)
        {
            // Combine the password and salt
            string combinedPassword = password + salt;

            // Choose the hash algorithm (SHA-256 or SHA-512)
            using (var sha256 = SHA256.Create())
            {
                // Convert the combined password string to a byte array
                byte[] bytes = Encoding.UTF8.GetBytes(combinedPassword);

                // Compute the hash value of the byte array
                byte[] hash = sha256.ComputeHash(bytes);

                // Convert the byte array to a hexadecimal string
                StringBuilder result = new StringBuilder();
                for (int i = 0; i < hash.Length; i++)
                {
                    result.Append(hash[i].ToString("x2"));
                }

                return result.ToString();
            }
        }

        protected Boolean PasswordCheck(String simplePassword)
        {
            string hashPassword = " ";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            con.Open();

            string getUserKey = "Select Password from ApplicationUser where id = @id";

            SqlCommand comKey = new SqlCommand(getUserKey, con);

            comKey.Parameters.AddWithValue("@id", Session["forgetId"].ToString());

            SqlDataReader reader = comKey.ExecuteReader();

            if (reader.Read())
            {
                hashPassword = reader["Password"].ToString();
            }

            reader.Close();

            if (hashPassword == HashPassword(simplePassword, Session["forgetId"].ToString()))
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void validNewPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            String simplePassword = txtRegPassword.Text;

            args.IsValid = !PasswordCheck(simplePassword);
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                String Id = Session["forgetId"].ToString();

                string simplePassword = txtRegPassword.Text;

                string hashPassword = HashPassword(simplePassword, Session["forgetId"].ToString());

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                string updateUser = "UPDATE ApplicationUser SET Password = @Password WHERE Id = @id";

                try
                {
                    con.Open();
                    SqlCommand comUpdate = new SqlCommand(updateUser, con);
                    comUpdate.Parameters.AddWithValue("@password", hashPassword);
                    comUpdate.Parameters.AddWithValue("@id", Id.ToString()); 
                    comUpdate.ExecuteNonQuery();


                    con.Close();

                    Session["forgetId"] = null;
                    lblSucReset.Text = "Password Reset Successfully";
                    Response.AddHeader("REFRESH", "2;SignUp.aspx");
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.ToString());
                }
            }

        }
        }
    }