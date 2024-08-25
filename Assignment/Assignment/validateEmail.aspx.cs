using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class validateEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["validateEmail"] != null)
                {
                    txtVerifyEmail.Text = Session["validateEmail"].ToString();
                }
                else
                {

                    Response.Redirect("SignUp.aspx");
                }

                if (Session["OTPCountdown"] != null)
                {
                    sendNewCode.Enabled = false;
                }
            }

        }

        protected void validateVerificationCode_ServerValidate(object source, ServerValidateEventArgs args)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            String findUserOtp = "SELECT Id, OtpCode, OtpCreatedTime, Roles FROM ApplicationUser WHERE Email = @Email";
            String setCode = "UPDATE ApplicationUser SET OtpCode = NULL WHERE Email = @Email";

            con.Open();
            string email = txtVerifyEmail.Text;
            SqlCommand com = new SqlCommand(findUserOtp, con);
            com.Parameters.AddWithValue("@Email", email);

            SqlDataReader reader = com.ExecuteReader();

            string sysOtp = " ";
            DateTime dateTime = DateTime.Now;

            if (reader.Read())
            {
                Session["validateId"] = reader["Id"].ToString();
                hdnRoles.Value = reader["Roles"].ToString();
                sysOtp = reader["OtpCode"].ToString();
                dateTime = reader.GetDateTime(reader.GetOrdinal("OtpCreatedTime"));
            }

            reader.Close();

            TimeSpan time = DateTime.Now - dateTime;

            if (txtNewVerify.Text == sysOtp && time < TimeSpan.FromMinutes(5))
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

        protected void sendNewCode_Click(object sender, EventArgs e)
        {
            Random random = new Random();
            int otp = random.Next(100000, 999999);

            String addOtp = "UPDATE ApplicationUser SET OtpCode = @OtpCode, OtpCreatedTime = @DateCreated WHERE Email = @Email";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            con.Open();

            SqlCommand com = new SqlCommand(addOtp, con);

            com.Parameters.AddWithValue("@DateCreated", DateTime.Now);
            com.Parameters.AddWithValue("@OtpCode", otp);
            com.Parameters.AddWithValue("@Email", txtVerifyEmail.Text);

            com.ExecuteNonQuery();
            con.Close();

            MailMessage mail = new MailMessage();
            mail.To.Add(Session["validateEmail"].ToString());
            mail.From = new MailAddress("chongwj-pm23@student.tarc.edu.my");
            mail.Subject = "Email Verification Code";

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
            smtpClient.Credentials = new System.Net.NetworkCredential("chongwj-pm23@student.tarc.edu.my", "ChongWj@TarUmt");
            smtpClient.Send(mail);

            labelValidateSend.Visible = true;

            int countdownDuration = 60;
            Session["OTPCountdown"] = countdownDuration;
            verifyTimer.Enabled = true;
        }

        protected void btnNewVerify_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Session.Remove("OTPCountdown");
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                String updateUserValid = "UPDATE ApplicationUser SET EmailVerification = @ev WHERE Id = @id";

                try
                {
                    con.Open();
                    SqlCommand updateCom = new SqlCommand(updateUserValid, con);
                    updateCom.Parameters.AddWithValue("ev", 1);
                    updateCom.Parameters.AddWithValue("id", Session["validateId"].ToString());
                    updateCom.ExecuteNonQuery();
                    con.Close();
                    Session["validateEmail"] = null;
                    lblSucValidate.Text = "Email Successfully Validate";
                    Session["Id"] = Session["validateId"];
                    Security.LoginUser(Session["Id"].ToString(), hdnRoles.Value, true);
                    Response.AddHeader("REFRESH", "2;Home.aspx");
                }
                catch (Exception ex) 
                {
                    Response.Write("Error: " + ex.ToString());
                }

            }
        }

        protected void verifyTimer_Tick(object sender, EventArgs e)
        {
            if (Session["OTPCountdown"] != null)
            {
                int remainingTime = (int)Session["OTPCountdown"];

                if (remainingTime > 0)
                {
                    remainingTime--;
                    Session["OTPCountdown"] = remainingTime;

                    sendNewCode.Enabled = false;

                    ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCountdown", $"startCountdown({remainingTime});", true);
                }
                else
                {
                    Session.Remove("OTPCountdown");
                }
            }
            else
            {
                verifyTimer.Enabled = false;
            }
        }
    }
}