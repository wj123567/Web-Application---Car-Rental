using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                    Server.Transfer("Home.aspx");
                }
            }
        }
        protected void LoadUserData(String id)
        {
            String email = " ";

            SqlConnection conn = new SqlConnection(Global.CS);

            string getUserData = "Select Email from UserRegistration where Id = @id";

            conn.Open();

            SqlCommand com = new SqlCommand(getUserData, conn);

            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                email = reader["Email"].ToString();
            }

            conn.Close();
            reader.Close();

            txtTwoFactorEmail.Text = email;

        }

        protected Boolean validPassword(String simplePassword)
        {
            byte[] key = new byte[16];
            byte[] iv = new byte[16];

            SqlConnection con = new SqlConnection(Global.CS);

            con.Open();

            Byte[] encryptPassword = new Byte[16];

            string getUserKey = "Select EncryptionKey, IVkey, Password from UserRegistration where id = @id";

            SqlCommand comKey = new SqlCommand(getUserKey, con);

            comKey.Parameters.AddWithValue("@id", Session["Id"].ToString());

            SqlDataReader reader = comKey.ExecuteReader();

            if (reader.Read())
            {
                encryptPassword = Convert.FromBase64String(reader["Password"].ToString());
                key = Convert.FromBase64String(reader["EncryptionKey"].ToString());
                iv = Convert.FromBase64String(reader["IVkey"].ToString());
            }

            reader.Close();

            if (simplePassword == Decrypt(encryptPassword, key, iv))
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

                byte[] key = new byte[16];
                byte[] iv = new byte[16];

                RandomNumberGenerator rng = RandomNumberGenerator.Create();

                rng.GetBytes(key);
                rng.GetBytes(iv);

                string simplePassword = txtNewPassword.Text;
                byte[] cipherPassword = Encrypt(simplePassword, key, iv);
                String cipherPasswordString = Convert.ToBase64String(cipherPassword);
                String keyString = Convert.ToBase64String(key);
                String ivString = Convert.ToBase64String(iv);

                SqlConnection con = new SqlConnection(Global.CS);

                string updateUser = "UPDATE UserRegistration SET Password = @Password, EncryptionKey= @encryptKey, IVkey = @IVkey WHERE Id = @id";

                try
                {
                    con.Open();
                    SqlCommand comUpdate = new SqlCommand(updateUser, con);
                    comUpdate.Parameters.AddWithValue("password", cipherPasswordString);
                    comUpdate.Parameters.AddWithValue("encryptKey", keyString);
                    comUpdate.Parameters.AddWithValue("IVkey", ivString);
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