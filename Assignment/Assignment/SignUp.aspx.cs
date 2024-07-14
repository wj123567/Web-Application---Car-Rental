using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

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
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UserRegistrationConnectionString"].ConnectionString);
                con.Open();
                    try
                    {
                        Guid newGUID = Guid.NewGuid();

                        string insertUser = "insert into UserRegistration (Id, Username, Email, Password, DOB) values (@id,@username,@email,@password,@dob)";
                        SqlCommand comInsert = new SqlCommand(insertUser, con);
                        comInsert.Parameters.AddWithValue("id", newGUID.ToString());
                        comInsert.Parameters.AddWithValue("username", txtUname.Text);
                        comInsert.Parameters.AddWithValue("email", txtRegEmail.Text);
                        comInsert.Parameters.AddWithValue("password", txtRegPassword.Text);
                        comInsert.Parameters.AddWithValue("dob", txtRegDOB.Text);

                        comInsert.ExecuteNonQuery();


                        con.Close();

                        txtVerifyEmail.Text = txtRegEmail.Text;

                        string script = "verify();";
                        ClientScript.RegisterStartupScript(this.GetType(), "VerifyScript", script, true);
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.ToString());
                    }
                }

        }

        protected void btnForget_Click(object sender, EventArgs e)
        {

            txtForgetEmail.Text = txtEmail.Text;

            string script = "forgetPass();";
            ClientScript.RegisterStartupScript(this.GetType(), "VerifyScript", script, true);
        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["UserRegistrationConnectionString"].ConnectionString);

            con.Open();
            String checkmail = "select count(*) from UserRegistration where Email = @email";

            SqlCommand comCheck = new SqlCommand(checkmail, con);

            comCheck.Parameters.AddWithValue("email", txtEmail.Text);

            int email = Convert.ToInt32(comCheck.ExecuteScalar().ToString());

            if(email == 1)
            {
                String checkinfo = "Select count(*) from UserRegistration where Email = @email and Password = @password";

                SqlCommand comInfo = new SqlCommand(checkinfo, con);

                comInfo.Parameters.AddWithValue("email", txtEmail.Text);
                comInfo.Parameters.AddWithValue("password", txtPassword.Text);

                int info = Convert.ToInt32(comInfo.ExecuteScalar().ToString());

                if (info == 1)
                {
                    string getUserData = "Select Id from UserRegistration where email = @email";

                    SqlCommand com = new SqlCommand(getUserData, con);

                    com.Parameters.AddWithValue("@Email", txtEmail.Text);

                    SqlDataReader reader = com.ExecuteReader();

                    if(reader.Read())
                    {
                        String Id = reader["Id"].ToString();
                        Session["Id"] = Id;
                    }

                    Response.Redirect("Home.aspx");

                }
                else
                {
                    labelValidUser.Text = "Email or Password is incorrect";
                    labelValidUser.Visible = true;
                }
            }
            else
            {
                labelValidUser.Text = "Email is incorrect";
                labelValidUser.Visible = true;
            }

            con.Close();
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
            }
            else
            {
                args.IsValid = true;
            }
            con.Close();

        }
    }
}