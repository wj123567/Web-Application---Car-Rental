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
using System.Web.Security;
using System.Net.Mail;
using System.Drawing.Imaging;
using System.Drawing;


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
                    Session["Id"] = getCookies();
                    LoadUserData(Session["Id"].ToString());
                }

                if (Session["Id"] != null)
                {
                    if (Session["OTPCountdown"] != null)
                    {
                        verifyTimer.Enabled = true;                   
                    }
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

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string id = Session["Id"].ToString();
                string folderLocation = Server.MapPath("~/Image/UserProfile");
                string relfolderLocation = "~/Image/UserProfile";
                string uploadFile = "UPDATE ApplicationUser SET ProfilePicture = @ProfilePicture WHERE Id = @id";
                string fileName = "";
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                if (!string.IsNullOrEmpty(hdnProfilePicture.Value))
                {
                    // Decode the Base64 string and save it as an image file
                    string base64String = hdnProfilePicture.Value.Split(',')[1]; // Remove the data URI scheme part
                    byte[] imageBytes = Convert.FromBase64String(base64String);
                    fileName = id + ".jpg"; // Assuming JPEG format
                    string savePath = Path.Combine(folderLocation, fileName);
                    string relPath = Path.Combine(relfolderLocation, fileName);

                    File.WriteAllBytes(savePath, imageBytes); // Save the file

                    con.Open();
                    SqlCommand com = new SqlCommand(uploadFile, con);
                    com.Parameters.AddWithValue("@ProfilePicture", relPath);
                    com.Parameters.AddWithValue("@id", id);
                    com.ExecuteNonQuery();
                    con.Close();
                    Response.Redirect("profile.aspx");
                }
            }
        }

        protected void btnSendIniCode_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
            Random random = new Random();
            int otp = random.Next(100000, 999999);
            txtIniMail2.Enabled = false;

            String addOtp = "UPDATE ApplicationUser SET OtpCode = @OtpCode, OtpCreatedTime = @DateCreated WHERE Email = @Email";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            con.Open();
            string hdnmail = hdnEmail.Value;
            SqlCommand com = new SqlCommand(addOtp, con);
            com.Parameters.AddWithValue("@DateCreated", DateTime.Now);
            com.Parameters.AddWithValue("@OtpCode", otp);
            com.Parameters.AddWithValue("@Email", txtEmailAddress.Text);
            com.ExecuteNonQuery();
            con.Close();

            MailMessage mail = new MailMessage();
            mail.To.Add(hdnmail);
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

            txtIniMail.Text = txtEmailAddress.Text;
            labelValidateSend.Visible = true;
            labelValidateSend2.Visible = true;

            int countdownDuration = 60; 

                
             Session["OTPCountdown"] = countdownDuration;
             verifyTimer.Enabled = true;
            }
        }

        protected void validateVerificationCode_ServerValidate(object source, ServerValidateEventArgs args)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            String findUserOtp = "SELECT Id, OtpCode, OtpCreatedTime FROM ApplicationUser WHERE Email = @Email";
            String setCode = "UPDATE ApplicationUser SET OtpCode = NULL WHERE Email = @Email";

            con.Open();
            string email = txtIniMail.Text;
            SqlCommand com = new SqlCommand(findUserOtp, con);
            com.Parameters.AddWithValue("@Email", email);

            SqlDataReader reader = com.ExecuteReader();

            string sysOtp = " ";
            DateTime dateTime = DateTime.Now;

            if (reader.Read())
            {
                Session["validateId"] = reader["Id"].ToString();
                sysOtp = reader["OtpCode"].ToString();
                dateTime = reader.GetDateTime(reader.GetOrdinal("OtpCreatedTime"));
            }

            reader.Close();

            TimeSpan time = DateTime.Now - dateTime;

            if (args.Value == sysOtp && time < TimeSpan.FromMinutes(5))
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

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                labelValidateSend2.Visible = false;
                txtIniMail2.Enabled = true;
                verifyTimer.Enabled = false;
                btnSendIniCode2.Enabled = true;
                Session.Remove("OTPCountdown");
                ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCountdown", $"startCountdown({0});", true);                
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "modal2()", true);
            }
            else if(!Page.IsValid)
            {
                txtIniMail.Text = txtEmailAddress.Text;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "modal()", true);
            }
        }

        protected void emailExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            string checkUser = "select count(*) from ApplicationUser where Email = @email";
            SqlCommand comCheck = new SqlCommand(checkUser, con);
            comCheck.Parameters.AddWithValue("email", args.Value);
            int temp = (int)comCheck.ExecuteScalar();
            if (temp != 0)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
            con.Close();

        }

        protected void btnChangeValidMail_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string update = "UPDATE ApplicationUser SET Email = @Email WHERE Id = @Id";
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                SqlCommand com = new SqlCommand(update, con);
                con.Open();
                com.Parameters.AddWithValue("@Email",txtIniMail2.Text);
                com.Parameters.AddWithValue("@Id", Session["Id"]);
                com.ExecuteNonQuery();
                con.Close();
                verifyTimer.Enabled = false;
                Session.Remove("OTPCountdown");
                ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCountdown", $"startCountdown({0});", true);
                Response.Redirect("profile.aspx");

            }
            else if (!Page.IsValid)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "modal2()", true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            verifyTimer.Enabled = false;
            Session.Remove("OTPCountdown");
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateCountdown", $"startCountdown({0});", true);
            Response.Redirect("profile.aspx");
        }

        protected void verifyTimer_Tick(object sender, EventArgs e)
        {
            if(Session["OTPCountdown"] != null)
            {
                int remainingTime = (int)Session["OTPCountdown"];

                if (remainingTime > 0)
                {
                    remainingTime--;
                    Session["OTPCountdown"] = remainingTime;

                    btnSendIniCode.Enabled = false;
                    btnSendIniCode2.Enabled = false;

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