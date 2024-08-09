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

namespace Assignment
{
    public partial class bookinfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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

        protected void btnNext_Click(object sender, EventArgs e)
        {
            String insertString = "INSERT INTO TestBook (CustomerName,Email,Address,Country,CustomerPhone,Destination,Note,DriverName,DriverGender,DriverID,DriverPhone,DriverAge,DriverRace,DriverLicense,RentalPurpose) VALUES (@CustomerName,@Email,@Address,@Country,@CustomerPhone,@Destination,@Note,@DriverName,@DriverGender,@DriverID,@DriverPhone,@DriverAge,@DriverRace,@DriverLicense,@RentalPurpose)";
            saveBookingInfo(insertString);

            Server.Transfer("payment_pg.aspx");
        }

        protected void previous_btn_Click(object sender, EventArgs e)
        {
            Server.Transfer("infopage.aspx");
        }

        protected void saveBookingInfo(string insertString)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(insertString, con);
            
            com.Parameters.AddWithValue("@CustomerName",txtName.Text);
            com.Parameters.AddWithValue("@Email", txtEmail.Text);
            com.Parameters.AddWithValue("@Address", txtAddress.Text);
            com.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
            com.Parameters.AddWithValue("@CustomerPhone", txtPhoneNum.Text);
            com.Parameters.AddWithValue("@Destination", ddlDestination.SelectedValue);
            com.Parameters.AddWithValue("@Note", txtNote.Text);
            com.Parameters.AddWithValue("@DriverName", txtDriverName.Text);
            com.Parameters.AddWithValue("@DriverGender", rblDriverGender.SelectedValue);
            com.Parameters.AddWithValue("@DriverID", txtDriverID.Text);
            com.Parameters.AddWithValue("@DriverPhone", txtDriverPhoneNum.Text);
            com.Parameters.AddWithValue("@DriverAge", ddlDriverAge.SelectedValue);
            com.Parameters.AddWithValue("@DriverRace", ddlDriverRace.SelectedValue);
            com.Parameters.AddWithValue("@DriverLicense", txtDriverLicenseNum.Text);
            com.Parameters.AddWithValue("@RentalPurpose", ddlRentalPurpose.SelectedValue);

            com.ExecuteNonQuery();
            con.Close();
        }
    }
}