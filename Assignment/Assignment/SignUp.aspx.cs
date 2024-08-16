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
using System.Web.Util;
using System.Text;

namespace Assignment
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Id"] == null)
                {
                txtRegDOB.Attributes["max"] = DateTime.Now.AddYears(-18).ToString("yyyy-MM-dd");
                }
                else
                {
                    Server.Transfer("Home.aspx");
                }

            }
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

                Guid newGUID = Guid.NewGuid();
                string simplePassword = txtRegPassword.Text;

                string passwordHash = Security.hashing(simplePassword,newGUID.ToString());

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                con.Open();
                    try
                    {                       
                        string insertUser = "insert into ApplicationUser (Id, Username, Email, Password, DOB, registrationDate) values (@id,@username,@email,@password,@dob,@registrationDate)";
                        SqlCommand comInsert = new SqlCommand(insertUser, con);
                        comInsert.Parameters.AddWithValue("id", newGUID.ToString());
                        comInsert.Parameters.AddWithValue("username", txtUname.Text);
                        comInsert.Parameters.AddWithValue("email", txtRegEmail.Text);
                        comInsert.Parameters.AddWithValue("password", passwordHash);
                        comInsert.Parameters.AddWithValue("dob", txtRegDOB.Text);
                        comInsert.Parameters.AddWithValue("registrationDate", DateTime.Now);

                        comInsert.ExecuteNonQuery();

                    //// Insert welcome transaction and get its ID
                    //int transactionID = InsertWelcomeTransaction(newGUID.ToString());
                    ////System.Diagnostics.Debug.WriteLine("Transaction ID: " + transactionID);
                    ////System.Diagnostics.Debug.WriteLine("Reward points inserted for UserID: " + newGUID.ToString());

                    //// Assign reward point id and points
                    //InsertInitialRewardPoints(newGUID.ToString(), transactionID);

                    con.Close();

                        Session["validateEmail"] = txtRegEmail.Text;
                        Session["validateId"] = newGUID.ToString();
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
                Session["forgetEmail"] = txtEmail.Text;
                Response.Redirect("forgetPassword.aspx");
            }
        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                String simplePassword = txtPassword.Text;
                String id = " ";

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                con.Open();

                string hashPassword = " ";

                string getUserId = "Select Id, Password from ApplicationUser where email = @email";

                SqlCommand comKey = new SqlCommand(getUserId, con);

                comKey.Parameters.AddWithValue("@Email", txtEmail.Text);

                SqlDataReader reader = comKey.ExecuteReader();

                if (reader.Read())
                {
                    hashPassword = reader["Password"].ToString();
                    id = reader["Id"].ToString();
                }

                reader.Close();

                if (hashPassword == Security.hashing(simplePassword, id))
                {
                    string getUserData = "Select Id, EmailVerification, TwoStepVerification from ApplicationUser where email = @email";

                    SqlCommand com = new SqlCommand(getUserData, con);

                    com.Parameters.AddWithValue("@Email", txtEmail.Text);

                    reader = com.ExecuteReader();
                    string emailValidation = " ";
                    string Id = " ";
                    string twoStepValidation = "";

                    if (reader.Read())
                    {
                        Id = reader["Id"].ToString();
                        emailValidation = reader["EmailVerification"].ToString();
                        twoStepValidation = reader["TwoStepVerification"].ToString();
                        
                    }

                    if(emailValidation == "0" || twoStepValidation == "1")
                    {
                        Session["validateId"] = Id;
                        Session["validateEmail"] = txtEmail.Text;
                        Response.Redirect("validateEmail.aspx");
                    }
                    else
                    {
                        Session["Id"] = Id;
                        Response.Redirect("Home.aspx");
                    }
                    
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
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            string checkUser = "select count(*) from ApplicationUser where Email = @email";
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
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            string checkUser = "select count(*) from ApplicationUser where Email = @email";
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
        
        private int InsertWelcomeTransaction(string userId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                con.Open();

                string insertTransaction = "Insert into RewardPointTransaction(UserID, Amount, TransactionDate, Description) Values (@userid, @amount, @transactiondate, @description); Select SCOPE_IDENTITY();";

                using (SqlCommand comInsertTransaction = new SqlCommand(insertTransaction, con))
                {
                    comInsertTransaction.Parameters.AddWithValue("userid", userId);
                    comInsertTransaction.Parameters.AddWithValue("amount", 0.00);
                    comInsertTransaction.Parameters.AddWithValue("transactiondate", DateTime.Now);
                    comInsertTransaction.Parameters.AddWithValue("description", "Welcome Reward Points!");

                    return Convert.ToInt32(comInsertTransaction.ExecuteScalar());
                }
            }
        }
        private void InsertInitialRewardPoints(string userId, int transactionId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                con.Open();

                string insertRewardPoint = "Insert into RewardPoint(UserID, TransactionID, Points, EarnedDate, ExpiryDate, Status) Values (@userid, @transactionid, @points, @earndate, @expirydate, @status)";

                using (SqlCommand comInsertInitialReward = new SqlCommand(insertRewardPoint,con))
                {
                    comInsertInitialReward.Parameters.AddWithValue("userid", userId);
                    comInsertInitialReward.Parameters.AddWithValue("transactionid", transactionId);
                    comInsertInitialReward.Parameters.AddWithValue("points", 100);
                    comInsertInitialReward.Parameters.AddWithValue("earndate", DateTime.Now);
                    comInsertInitialReward.Parameters.AddWithValue("expirydate", DateTime.Now.AddYears(1));
                    comInsertInitialReward.Parameters.AddWithValue("status", "active");

                    comInsertInitialReward.ExecuteNonQuery();
                }
            }
        }

    }
}