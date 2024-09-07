using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;

using System.Globalization;
using System.Drawing.Drawing2D;
using System.Data;

namespace Assignment
{
    public partial class bookinfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int currentStep = (int)(Session["CurrentStep"] ?? 1);
                UpdateProgressBar(currentStep);

                txtDriverBirth.Attributes["max"] = DateTime.Now.AddYears(-23).ToString("yyyy-MM-dd");
                txtDriverBirth.Attributes["min"] = DateTime.Now.AddYears(-65).ToString("yyyy-MM-dd");

                //----retrieve the sync data 
                retrieveData();
                //retrieve user info
                retrieveUserData();
                //retrieve driver info
                retrieveDriverData();
            }
        
        }

        protected void retrieveData()
        {
            string totalDayRent = Session["TotalDayRent"].ToString();
            string carName = Session["CarName"].ToString();
            string imageURL = Session["CarImg"].ToString();
            string totalPrice = Session["TotalPrice"] as string ?? "0.00";
            string totalAddOn = Session["TotalAddOn"] as string ?? "0.00";
            string carRental = Session["CarRental"].ToString();
            
            

            lblTotalDayRent.Text = totalDayRent;
            lblAddOnPrice.Text = totalAddOn;
            lblCarRental.Text = carRental;
            lblstickyCarModel.Text = carName;
            lblTotalPrice.Text = totalPrice;
            lblStickyTotalPrice.Text = "RM"+ totalPrice;
            imgSticky.ImageUrl = imageURL;
        }

        protected void retrieveUserData()
        {
            string userId = Session["Id"].ToString();
            // Define your SQL query
            string query = "SELECT * FROM Applicationuser WHERE Id = @userId";

            // Assuming you're using ADO.NET for database access
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, con);
                command.Parameters.AddWithValue("@userId", userId);

                con.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        {
                            txtName.Text = reader["Username"].ToString() ;
                            txtEmail.Text = reader["Email"].ToString();
                                               
                        };

                    }
                }

                reader.Close();
                con.Close();
            }

        }

        protected void retrieveDriverData()
        {
            string userId = Session["Id"].ToString();
            DateTime driverBDate = DateTime.Now;

            // Define your SQL query
            string query = "SELECT * FROM Driver WHERE UserId = @userId";

            // Assuming you're using ADO.NET for database access
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, con);
                command.Parameters.AddWithValue("@userId", userId);

                con.Open();
                SqlDataReader reader = command.ExecuteReader();
                
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        
                            txtDriverName.Text = reader["DriverName"].ToString();
                            driverBDate = reader.GetDateTime(reader.GetOrdinal("DriverBDate"));
                            txtDriverBirth.Text = driverBDate.ToString("yyyy-MM-dd");
                            txtDriverPhoneNum.Text = reader["DriverPno"].ToString();
                            ddlDriverGender.SelectedValue = reader["DriverGender"].ToString();
                            txtDriverLicenseNum.Text = reader["DriverLicense"].ToString();
                            txtDriverID.Text = reader["DriverId"].ToString();
                            chkDriver.Checked= true;
                            chkDriver.Enabled = false;

                    };
                       
                        
                }
                else
                {
                    chkDriver.Checked = false;
                    chkDriver.Enabled = false;
                }

                reader.Close();              
                con.Close();
            }
        }



        [WebMethod]
        public static bool SaveCapturedImage(string data)
        {
            string fileName = "Webcam " + DateTime.Now.ToString("yyyy-MM-dd hh-mm-ss");

            //Convert Base64 Encoded string to Byte Array.
            byte[] imageBytes = Convert.FromBase64String(data.Split(',')[1]);

            //Save the Byte Array as Image File.
            string filePath = HttpContext.Current.Server.MapPath(string.Format("~/Captures/{0}.jpg", fileName));
            File.WriteAllBytes(filePath, imageBytes);
            return true;
        }

        protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void TxtNote_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnRegisterDriver_Click(Object sender, EventArgs e)
        {
            Response.Redirect("UserProfile/driver.aspx");
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            int currentStep = (int)(Session["CurrentStep"] ?? 1);
            currentStep = Math.Min(currentStep + 1, 4);
            Session["CurrentStep"] = currentStep;
            UpdateProgressBar(currentStep);
            Response.Redirect("payment_pg.aspx");
           
        }

        protected void previous_btn_Click(object sender, EventArgs e)
        {
            int currentStep = (int)(Session["CurrentStep"] ?? 1);
            currentStep = Math.Max(currentStep - 1, 1);
            Session["CurrentStep"] = currentStep;
            UpdateProgressBar(currentStep);
            Response.Redirect("infopage.aspx");
        }

        private void UpdateProgressBar(int currentStep)
        {
            // Register a script to update the progress bar client-side
            string script = $"updateProgressBar({currentStep});";
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateProgressBar", script, true);
        }

    }
}