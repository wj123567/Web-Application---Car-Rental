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
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            String findUserID = "Select Id from ApplicationUser WHERE Email = @email";

            con.Open();
            SqlCommand findCom = new SqlCommand(findUserID, con);
            findCom.Parameters.AddWithValue("@email", Session["forgetEmail"].ToString());

            SqlDataReader reader = findCom.ExecuteReader();
            
            String UserID = " ";

            if (reader.Read())
            {
                UserID = reader["Id"].ToString();
                Session["forgetId"] = UserID;
            }
            reader.Close();
            con.Close();

            Random random = new Random();
            int otp = random.Next(100000,999999);

            con.Open();
            String addOtp = "insert into UserOtp (DateCreated, OtpKey, UserID) values (@DateCreated, @OtpKey, @UserID)";

            SqlCommand insertCom = new SqlCommand(addOtp, con);
            insertCom.Parameters.AddWithValue("@DateCreated",DateTime.Now);
            insertCom.Parameters.AddWithValue("@OtpKey", otp);
            insertCom.Parameters.AddWithValue("@UserID", UserID);

            insertCom.ExecuteNonQuery();
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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Timer", "startResendTimer()", true);

        }

        protected void validateVerificationCode_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (Session["forgetId"] != null)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                String findUserOtp = "SELECT TOP 1 OtpKey, DateCreated FROM UserOtp WHERE UserID = @UserID ORDER BY DateCreated DESC";

                con.Open();
                string id = Session["forgetId"].ToString();
                SqlCommand findCom = new SqlCommand(findUserOtp, con);
                findCom.Parameters.AddWithValue("@UserID", id);

                SqlDataReader reader = findCom.ExecuteReader();

                string sysOtp = " ";
                DateTime dateTime = DateTime.Now;

                if (reader.Read())
                {
                    sysOtp = reader["OtpKey"].ToString();
                    dateTime = reader.GetDateTime(reader.GetOrdinal("DateCreated"));
                }

                con.Close();

                TimeSpan time = DateTime.Now - dateTime;

                if (txtforgetVerify.Text == sysOtp && time < TimeSpan.FromMinutes(5))
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            else
            {
                args.IsValid = false;
            }


        }

        protected void btnForgetVerify_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Server.Transfer("resetPassword.aspx");
            }
        }
    }
}