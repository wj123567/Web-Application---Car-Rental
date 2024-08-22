using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;
using System.Configuration;

namespace Assignment
{
    public partial class forgetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["forgetEmail"] != null)
                {
                    txtForgetEmail.Text = Session["forgetEmail"].ToString();
                }
                else
                {
                    Response.Redirect("SignUp.aspx");
                }
            }
        }

        protected void sendForgetCode_Click(object sender, EventArgs e)
        {
            Random random = new Random();
            int otp = random.Next(100000, 999999);

            String addOtp = "UPDATE ApplicationUser SET OtpCode = @OtpCode, OtpCreatedTime = @DateCreated WHERE Email = @Email";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);           

            con.Open();

            SqlCommand com = new SqlCommand(addOtp, con);

            com.Parameters.AddWithValue("@DateCreated",DateTime.Now);
            com.Parameters.AddWithValue("@OtpCode", otp);
            com.Parameters.AddWithValue("@Email", txtForgetEmail.Text);

            com.ExecuteNonQuery();
            con.Close();

            MailMessage mail = new MailMessage();
            mail.To.Add(Session["forgetEmail"].ToString());
            mail.From = new MailAddress("chongwj-pm23@student.tarc.edu.my");
            mail.Subject = "Forget Password Verification Code";

            string emailBody = "";

            emailBody += "<h1>From Only Car<h1>";
            emailBody += "<p>Your Verification Code is " + otp + "<p>";

            mail.Body = emailBody;
            mail.IsBodyHtml = true;

            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Host = "smtp.gmail.com";
            smtpClient.Credentials = new System.Net.NetworkCredential("chongwj-pm23@student.tarc.edu.my", "WeiJia_081104");
            smtpClient.Send(mail);

            labelForgetSend.Visible = true;
            int countdownDuration = 60;
            ViewState["OTPCountdown"] = countdownDuration;
            verifyTimer.Enabled = true;
        }

        protected void validateVerificationCode_ServerValidate(object source, ServerValidateEventArgs args)
        {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                String findUserOtp = "SELECT Id, OtpCode, OtpCreatedTime FROM ApplicationUser WHERE Email = @Email";
                String setCode = "UPDATE ApplicationUser SET OtpCode = NULL WHERE Email = @Email";

                con.Open();
                string email = txtForgetEmail.Text;
                SqlCommand com = new SqlCommand(findUserOtp, con);
                com.Parameters.AddWithValue("@Email", email);

                SqlDataReader reader = com.ExecuteReader();

                string sysOtp = " ";
                DateTime dateTime = DateTime.Now;

                if (reader.Read())
                {
                    Session["forgetId"] = reader["Id"].ToString();
                    sysOtp = reader["OtpCode"].ToString();
                    dateTime = reader.GetDateTime(reader.GetOrdinal("OtpCreatedTime"));
                }

                reader.Close();

                TimeSpan time = DateTime.Now - dateTime;

                if (txtforgetVerify.Text == sysOtp && time < TimeSpan.FromMinutes(5))
                {
                    args.IsValid = true;
                    com = new SqlCommand(setCode, con);
                    com.Parameters.AddWithValue("@Email", email);
                    com.ExecuteNonQuery();

                }
                else
                {
                    args.IsValid = false;
                }
                con.Close();


        }

        protected void verifyTimer_Tick(object sender, EventArgs e)
        {
            if (ViewState["OTPCountdown"] != null)
            {
                int remainingTime = (int)ViewState["OTPCountdown"];

                if (remainingTime > 0)
                {
                    remainingTime--;
                    ViewState["OTPCountdown"] = remainingTime;

                    sendForgetCode.Enabled = false;

                    ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCountdown", $"startCountdown({remainingTime});", true);
                }
                else
                {
                    ViewState.Remove("OTPCountdown");
                }
            }
            else
            {
                verifyTimer.Enabled = false;
            }
        }

        protected void btnForgetVerify_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Response.Redirect("resetPassword.aspx");
            }
        }
    }
}