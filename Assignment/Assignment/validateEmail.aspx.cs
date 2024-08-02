using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
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
            }

        }

        protected void validateVerificationCode_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (Session["validateId"] != null)
            {
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                String findUserOtp = "SELECT TOP 1 OtpKey, DateCreated FROM UserOtp WHERE UserID = @UserID ORDER BY DateCreated DESC";

                con.Open();
                string id = Session["validateId"].ToString();
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

                if (txtNewVerify.Text == sysOtp && time < TimeSpan.FromMinutes(5))
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

        protected void sendNewCode_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            String findUserID = "Select Id from ApplicationUser WHERE Email = @email";

            con.Open();
            SqlCommand findCom = new SqlCommand(findUserID, con);
            findCom.Parameters.AddWithValue("@email", Session["validateEmail"].ToString());

            SqlDataReader reader = findCom.ExecuteReader();

            String UserID = " ";

            if (reader.Read())
            {
                UserID = reader["Id"].ToString();
                Session["validateId"] = UserID;
            }
            reader.Close();
            con.Close();

            Random random = new Random();
            int otp = random.Next(100000, 999999);

            con.Open();
            String addOtp = "insert into UserOtp (DateCreated, OtpKey, UserID) values (@DateCreated, @OtpKey, @UserID)";

            SqlCommand insertCom = new SqlCommand(addOtp, con);
            insertCom.Parameters.AddWithValue("@DateCreated", DateTime.Now);
            insertCom.Parameters.AddWithValue("@OtpKey", otp);
            insertCom.Parameters.AddWithValue("@UserID", UserID);

            insertCom.ExecuteNonQuery();
            con.Close();

            MailMessage mail = new MailMessage();
            mail.To.Add(Session["validateEmail"].ToString());
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

            labelValidateSend.Visible = true;

        }

        protected void btnNewVerify_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
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
                    Response.AddHeader("REFRESH", "2;Home.aspx");
                }
                catch (Exception ex) 
                {
                    Response.Write("Error: " + ex.ToString());
                }

            }
        }
    }
}