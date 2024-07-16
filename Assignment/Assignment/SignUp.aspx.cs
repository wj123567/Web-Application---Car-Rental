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

namespace Assignment
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (!IsPostBack)
            {
                txtRegDOB.Attributes["max"] = DateTime.Now.AddYears(-18).ToString("yyyy-MM-dd");
            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                byte[] key = new byte[16];
                byte[] iv = new byte[16];

                RandomNumberGenerator rng = RandomNumberGenerator.Create();

                rng.GetBytes(key);
                rng.GetBytes(iv);

                string simplePassword = txtRegPassword.Text;
                byte[] cipherPassword = Encrypt(simplePassword,key,iv);
                String cipherPasswordString = Convert.ToBase64String(cipherPassword);
                String keyString = Convert.ToBase64String(key);
                String ivString = Convert.ToBase64String(iv);

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UserRegistrationConnectionString"].ConnectionString);
                con.Open();
                    try
                    {
                        Guid newGUID = Guid.NewGuid();

                        string insertUser = "insert into UserRegistration (Id, Username, Email, Password, DOB, registrationDate, EncryptionKey, IVkey) values (@id,@username,@email,@password,@dob,@registrationDate,@encryptKey,@IVkey)";
                        SqlCommand comInsert = new SqlCommand(insertUser, con);
                        comInsert.Parameters.AddWithValue("id", newGUID.ToString());
                        comInsert.Parameters.AddWithValue("username", txtUname.Text);
                        comInsert.Parameters.AddWithValue("email", txtRegEmail.Text);
                        comInsert.Parameters.AddWithValue("password", cipherPasswordString);
                        comInsert.Parameters.AddWithValue("dob", txtRegDOB.Text);
                        comInsert.Parameters.AddWithValue("registrationDate", DateTime.Now);
                        comInsert.Parameters.AddWithValue("encryptKey", keyString);
                        comInsert.Parameters.AddWithValue("IVkey", ivString);



                    comInsert.ExecuteNonQuery();


                        con.Close();

                        Session["Email"] = txtRegEmail.Text;
                        ScriptManager.RegisterStartupScript(this, GetType(), "redirect", "window.location.href='validateEmail.aspx';", true);
                }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.ToString());
                    }
                }

        }

        protected void btnForget_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Session["Email"] = txtEmail.Text;
                Response.Redirect("forgetPassword.aspx");
            }
        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                byte[] key = new byte[16];
                byte[] iv = new byte[16];
                String simplePassword = txtPassword.Text;

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UserRegistrationConnectionString"].ConnectionString);

                con.Open();

                Byte[] encryptPassword = new Byte[16];

                string getUserKey = "Select EncryptionKey, IVkey, Password from UserRegistration where email = @email";

                SqlCommand comKey = new SqlCommand(getUserKey, con);

                comKey.Parameters.AddWithValue("@Email", txtEmail.Text);

                SqlDataReader reader = comKey.ExecuteReader();

                if (reader.Read())
                {
                    encryptPassword = Convert.FromBase64String(reader["Password"].ToString());
                    key = Convert.FromBase64String(reader["EncryptionKey"].ToString());
                    iv = Convert.FromBase64String(reader["IVkey"].ToString());
                }

                reader.Close();

                if (simplePassword == Decrypt(encryptPassword, key, iv)){
                    string getUserData = "Select Id from UserRegistration where email = @email";

                    SqlCommand com = new SqlCommand(getUserData, con);

                    com.Parameters.AddWithValue("@Email", txtEmail.Text);

                    reader = com.ExecuteReader();

                    if (reader.Read())
                    {
                        String Id = reader["Id"].ToString();
                        Session["Id"] = Id;
                    }

                    Response.Redirect("Home.aspx");
                }
                else
                {
                    labelValidUser.Text = "Password is incorrect";
                    labelValidUser.Visible = true;
                    updateLogin.Update();
                }

                con.Close();
            }
        }

        protected void emailExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UserRegistrationConnectionString"].ConnectionString);
            con.Open();
            string checkUser = "select count(*) from UserRegistration where Email = @email";
            SqlCommand comCheck = new SqlCommand(checkUser, con);
            comCheck.Parameters.AddWithValue("email", txtRegEmail.Text);
            int temp = Convert.ToInt32(comCheck.ExecuteScalar().ToString());
            if (temp != 0)
            {
                args.IsValid = false;
                updateRegEmail.Update();
            }
            else
            {
                args.IsValid = true;
            }
            con.Close();

        }

        protected void emailNotExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UserRegistrationConnectionString"].ConnectionString);
            con.Open();
            string checkUser = "select count(*) from UserRegistration where Email = @email";
            SqlCommand comCheck = new SqlCommand(checkUser, con);
            comCheck.Parameters.AddWithValue("email", txtEmail.Text);
            int temp = Convert.ToInt32(comCheck.ExecuteScalar().ToString());
            if (temp == 1)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
                updateLogin.Update();
            }
            con.Close();
        }

        protected string Decrypt(byte[] cipheredText, byte[] key, byte[] iv)
        {
            string simpleText = " ";
            Aes aes = Aes.Create();

            ICryptoTransform decryptor = aes.CreateDecryptor(key, iv);

            using (MemoryStream ms = new MemoryStream(cipheredText))
            {
                using (CryptoStream cs = new CryptoStream(ms, decryptor, CryptoStreamMode.Read))
                {

                    StreamReader reader = new StreamReader(cs);

                    simpleText = reader.ReadToEnd();
                }
            }

            return simpleText;
        }

        protected byte[] Encrypt(string simpleText, byte[] key, byte[] iv)
        {
            byte[] cipheredText;

            Aes aes = Aes.Create();

            ICryptoTransform encryptor = aes.CreateEncryptor(key, iv);

            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor, CryptoStreamMode.Write))
                {
                    using (StreamWriter writer = new StreamWriter(cs))
                    {
                        writer.Write(simpleText);
                    }
                    cipheredText = ms.ToArray();
                }
            }

            return cipheredText;
        }
    }
}