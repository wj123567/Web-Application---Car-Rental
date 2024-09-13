using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;
using System.Web.Services;
using System.Drawing.Imaging;
using System.Drawing;

namespace Assignment
{
    public partial class driver : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {                
                if (Session["Id"] != null)
                {
                    loadUserInfo(Session["Id"].ToString());
                    txtBirthdate.Attributes["max"] = DateTime.Now.AddYears(-23).ToString("yyyy-MM-dd");
                    txtBirthdate.Attributes["min"] = DateTime.Now.AddYears(-65).ToString("yyyy-MM-dd");
                    txtBirthdate2.Attributes["max"] = DateTime.Now.AddYears(-23).ToString("yyyy-MM-dd");
                    txtBirthdate2.Attributes["min"] = DateTime.Now.AddYears(-65).ToString("yyyy-MM-dd");
                }
                else
                {
                    Session["Id"] = getCookies();
                    loadUserInfo(Session["Id"].ToString());
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


        protected void loadUserInfo(String id)
        {
            String selectDriver = "SELECT COUNT(*) FROM Driver WHERE UserId = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@id", id);
            int temp = (int)com.ExecuteScalar();
            if (temp == 0)
            {
                btnAddNew.Visible = true;
                editPanel.Visible = false;
                btnEditDriver.Visible = false;
            }
            else
            {
                btnAddNew.Visible = false;
                editPanel.Visible = true;
                btnEditDriver.Visible = true;
                LoadAvailableDriver(id);
                HideControls(editPanel);
                }
            con.Close();
        }
        /*
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
*/
        protected void btnUpdateDoc_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string updateString = "UPDATE Driver SET DriverName = @DriverName, DriverId = @DriverId, DriverLicense = @DriverLicense, DriverPno = @DriverPno, DriverBdate = @DriverBdate, DriverGender = @DriverGender, IDpic = @IDpic, SelfiePic = @SelfiePic, LicenseFpic = @LicenseFpic, LicenseBpic = @LicenseBpic, Approval = @Approval, UserId = @UserId, DateApply = @dateApply WHERE Id = @Id";

                string id = Session["DriverID"].ToString();
                string savePathId = " "; 
                string relPathId = " ";                
                string savePathSelfie = " "; 
                string relPathSelfie = " ";                 
                string savePathLicenseF = " "; 
                string relPathLicenseF = " ";                 
                string savePathLicenseB = " "; 
                string relPathLicenseB = " "; 
                string countryCode = "+" + hdnCountryCode.Value;
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                if (fuID2.HasFile)
                {
                    string folderLocation = Server.MapPath("~/Image/DriverId");
                    string relfolderLocation = "~/Image/DriverId";
                    string fileName = id + ".jpg";
                    savePathId = Path.Combine(folderLocation, fileName);
                    relPathId = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuID2.FileContent);
                    source.Save(savePathId, ImageFormat.Jpeg);
                }

                if (fuSelfie2.HasFile)
                {
                    string folderLocation = Server.MapPath("~/Image/DriverSelfie");
                    string relfolderLocation = "~/Image/DriverSelfie";
                    string fileName = id + ".jpg";
                    savePathSelfie = Path.Combine(folderLocation, fileName);
                    relPathSelfie = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuSelfie2.FileContent);
                    source.Save(savePathSelfie, ImageFormat.Jpeg);
                }

                if (fuLicenseF2.HasFile)
                {
                    string folderLocation = Server.MapPath("~/Image/DriverLF");
                    string relfolderLocation = "~/Image/DriverLF";
                    string fileName = id + ".jpg";
                    savePathLicenseF = Path.Combine(folderLocation, fileName);
                    relPathLicenseF = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuLicenseF2.FileContent);
                    source.Save(savePathLicenseF, ImageFormat.Jpeg);
                }

                if (fuLicenseB2.HasFile)
                {
                    string folderLocation = Server.MapPath("~/Image/DriverLB");
                    string relfolderLocation = "~/Image/DriverLB";
                    string fileName = id + ".jpg";
                    savePathLicenseB = Path.Combine(folderLocation, fileName);
                    relPathLicenseB = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuLicenseB2.FileContent);
                    source.Save(savePathLicenseB, ImageFormat.Jpeg);
                }

                con.Open();
                SqlCommand com = new SqlCommand(updateString, con);
                com.Parameters.AddWithValue("@Id", id);
                com.Parameters.AddWithValue("@DriverName", txtName2.Text);
                com.Parameters.AddWithValue("@DriverId", txtDriverID2.Text);
                com.Parameters.AddWithValue("@DriverLicense", txtDriverLicense2.Text);
                com.Parameters.AddWithValue("@DriverPno", countryCode +" "+txtPhoneNum2.Text);
                com.Parameters.AddWithValue("@DriverBdate", txtBirthdate2.Text);
                com.Parameters.AddWithValue("@DriverGender", ddlGender2.SelectedValue);
                com.Parameters.AddWithValue("@IDpic", relPathId);
                com.Parameters.AddWithValue("@SelfiePic", relPathSelfie);
                com.Parameters.AddWithValue("@LicenseFpic", relPathLicenseF);
                com.Parameters.AddWithValue("@LicenseBpic", relPathLicenseB);
                com.Parameters.AddWithValue("@Approval", "P");
                com.Parameters.AddWithValue("@dateApply", DateTime.Today.ToString("yyyy-MM-dd"));
                com.Parameters.AddWithValue("@UserId", Session["Id"].ToString());
                com.ExecuteNonQuery();

                con.Close();
                Response.Redirect("driver.aspx");
            }
        }

        protected void btnUploadDoc_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string insertString = "INSERT into Driver (Id, DriverName, DriverId, DriverLicense, DriverPno, DriverBdate, DriverGender, IDpic, SelfiePic, LicenseFpic, LicenseBpic,Approval ,UserId , DateApply) values (@Id, @DriverName, @DriverId, @DriverLicense, @DriverPno, @DriverBdate, @DriverGender, @IDpic, @SelfiePic, @LicenseFpic, @LicenseBpic, @Approval, @UserId, @dateApply)";
                Guid guid = Guid.NewGuid();

                string savePathId = " ";
                string relPathId = " ";
                string savePathSelfie = " ";
                string relPathSelfie = " ";
                string savePathLicenseF = " ";
                string relPathLicenseF = " ";
                string savePathLicenseB = " ";
                string relPathLicenseB = " ";
                string countryCode = "+" + hdnCountryCode.Value;
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

                if (fuID.HasFile)
                {
                    string ext = Path.GetExtension(fuID.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverId");
                    string relfolderLocation = "~/Image/DriverId";
                    string fileName = guid + ".jpg";
                    savePathId = Path.Combine(folderLocation, fileName);
                    relPathId = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuID.FileContent);
                    source.Save(savePathId, ImageFormat.Jpeg);
                }

                if (fuSelfie.HasFile)
                {
                    string ext = Path.GetExtension(fuSelfie.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverSelfie");
                    string relfolderLocation = "~/Image/DriverSelfie";
                    string fileName = guid + ".jpg";
                    savePathSelfie = Path.Combine(folderLocation, fileName);
                    relPathSelfie = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuSelfie.FileContent);
                    source.Save(savePathSelfie, ImageFormat.Jpeg);
                }
                else if (!string.IsNullOrEmpty(hdnCapturedSelfie.Value))
                {
                    // Decode the Base64 string and save it as an image file
                    string base64String = hdnCapturedSelfie.Value.Split(',')[1]; // Remove the data URI scheme part
                    byte[] imageBytes = Convert.FromBase64String(base64String);

                    string folderLocation = Server.MapPath("~/Image/DriverSelfie");
                    string relfolderLocation = "~/Image/DriverSelfie";
                    string fileName = guid + ".jpg"; // Assuming JPEG format
                    savePathSelfie = Path.Combine(folderLocation, fileName);
                    relPathSelfie = Path.Combine(relfolderLocation, fileName);
                    // Log before saving the file
                    System.Diagnostics.Debug.WriteLine("Saving captured selfie to: " + savePathSelfie);

                    File.WriteAllBytes(savePathSelfie, imageBytes); // Save the file

                    // Log success
                    System.Diagnostics.Debug.WriteLine("Selfie saved successfully!");
                }

                if (fuLicenseF.HasFile)
                {
                    string ext = Path.GetExtension(fuLicenseF.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverLF");
                    string relfolderLocation = "~/Image/DriverLF";
                    string fileName = guid + ".jpg";
                    savePathLicenseF = Path.Combine(folderLocation, fileName);
                    relPathLicenseF = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuLicenseF.FileContent);
                    source.Save(savePathLicenseF, ImageFormat.Jpeg);
                }

                if (fuLicenseB.HasFile)
                {
                    string ext = Path.GetExtension(fuLicenseB.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverLB");
                    string relfolderLocation = "~/Image/DriverLB";
                    string fileName = guid + ".jpg";
                    savePathLicenseB = Path.Combine(folderLocation, fileName);
                    relPathLicenseB = Path.Combine(relfolderLocation, fileName);
                    Bitmap source = new Bitmap(fuLicenseB.FileContent);
                    source.Save(savePathLicenseB, ImageFormat.Jpeg);
                }

                con.Open();
                SqlCommand com = new SqlCommand(insertString, con);
                com.Parameters.AddWithValue("@Id", guid);
                com.Parameters.AddWithValue("@DriverName", txtName.Text);
                com.Parameters.AddWithValue("@DriverId", txtDriverID.Text);
                com.Parameters.AddWithValue("@DriverLicense", txtDriverLicense.Text);
                com.Parameters.AddWithValue("@DriverPno", countryCode + " " + txtPhoneNum.Text);
                com.Parameters.AddWithValue("@DriverBdate", txtBirthdate.Text);
                com.Parameters.AddWithValue("@DriverGender", ddlGender.SelectedValue);
                com.Parameters.AddWithValue("@IDpic", relPathId);
                com.Parameters.AddWithValue("@SelfiePic", relPathSelfie);
                com.Parameters.AddWithValue("@LicenseFpic", relPathLicenseF);
                com.Parameters.AddWithValue("@LicenseBpic", relPathLicenseB);
                com.Parameters.AddWithValue("@Approval", "P");
                com.Parameters.AddWithValue("@dateApply", DateTime.Today.ToString("yyyy-MM-dd"));
                com.Parameters.AddWithValue("@UserId", Session["Id"].ToString());
                com.ExecuteNonQuery();

                con.Close();
                Response.Redirect("driver.aspx");
            }
        }       
        protected void btnEdit_Click(object sender, EventArgs e)
        {
            ShowControls(editPanel);
            btnEditDriver.Visible = false;            
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string deleteDriver = "DELETE FROM Driver WHERE Id = @id";



            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            string[] path = { MapPath("~/Image/DriverId/") , MapPath("~/Image/DriverLB/") , MapPath("~/Image/DriverLF/") , MapPath("~/Image/DriverSelfie/") };
            string id = Session["DriverID"].ToString();
            for(int i = 0; i < path.Length; i++)
            {
                File.Delete(path[i] + id + ".jpg");
            }

            File.Delete(Server.MapPath(imgID2.ImageUrl));

            con.Open();

            SqlCommand com = new SqlCommand(deleteDriver,con);

            com.Parameters.AddWithValue("@Id", id);

            com.ExecuteNonQuery();

            Server.Transfer("driver.aspx");
        }

        protected void LoadAvailableDriver(String id)
        {
            String selectDriver = "SELECT * FROM Driver WHERE UserId = @uid";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@uid",id);
            string approvalStatus = "";
            string rejectReason = "";

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Session["DriverID"] = reader["id"].ToString();
                txtName2.Text = reader["DriverName"].ToString();
                txtDriverID2.Text = reader["DriverId"].ToString();
                txtDriverLicense2.Text = reader["DriverLicense"].ToString();
                txtPhoneNum2.Text = reader["DriverPno"].ToString();
                DateTime driverBdate = reader.GetDateTime(reader.GetOrdinal("DriverBdate"));
                txtBirthdate2.Text = driverBdate.ToString("yyyy-MM-dd");
                ddlGender2.SelectedValue = reader["driverGender"].ToString();
                imgID2.ImageUrl = reader["IDpic"].ToString();;
                imgSelfie2.ImageUrl = reader["Selfiepic"].ToString();
                imgLicenseF2.ImageUrl = reader["LicenseFpic"].ToString();
                imgLicenseB2.ImageUrl = reader["LicenseBpic"].ToString();
                approvalStatus = reader["Approval"].ToString();
                rejectReason = reader["RejectReason"].ToString();
            }
            con.Close();
            reader.Close();
            switch (approvalStatus)
            {
                case "P":
                    lblApproval.Text = "Pending";
                    lblApproval.CssClass = "badge bg-warning text-light";
                    break;
                case "A":
                    lblApproval.Text = "Approved";
                    lblApproval.CssClass = "badge bg-success text-light";
                    break;
                case "R":
                    lblApproval.Text = "Rejected";
                    lblApproval.CssClass = "badge bg-danger text-light";
                    lblReject.Text = "Reject Reason:" + rejectReason;
                    break;
            }
        }

        protected void HideControls(Control container)
        {
            foreach (Control c in container.Controls)
            {
                if(c is Button)
                {
                    c.Visible = false;
                }else if(c is TextBox){
                    ((TextBox)c).ReadOnly = true;
                }else if(c is DropDownList)
                {
                    ((DropDownList)c).Enabled = false;
                }
            }
        }

        protected void ShowControls(Control container)
        {
            foreach (Control c in container.Controls)
            {
                if (c is Button)
                {
                    c.Visible = true;
                }
                else if (c is TextBox)
                {
                    ((TextBox)c).ReadOnly = false;
                }
                else if (c is DropDownList)
                {
                    ((DropDownList)c).Enabled = true;
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            btnEditDriver.Visible = true;
            HideControls(editPanel);
        }
    }
}