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

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                String Id = Session["forgetId"].ToString();

                byte[] key = new byte[16];
                byte[] iv = new byte[16];

                RandomNumberGenerator rng = RandomNumberGenerator.Create();

                rng.GetBytes(key);
                rng.GetBytes(iv);

                string simplePassword = txtRegPassword.Text;
                byte[] cipherPassword = Encrypt(simplePassword, key, iv);
                String cipherPasswordString = Convert.ToBase64String(cipherPassword);
                String keyString = Convert.ToBase64String(key);
                String ivString = Convert.ToBase64String(iv);

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

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