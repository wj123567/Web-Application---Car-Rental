using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                }
                else
                {

                }
            }
        }


        protected void loadUserInfo(String id)
        {

        }
        protected void btnUploadDoc_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Guid newGUID = Guid.NewGuid();
                string savePathId = " "; 
                string relPathId = " ";                
                string savePathSelfie = " "; 
                string relPathSelfie = " ";                 
                string savePathLicenseF = " "; 
                string relPathLicenseF = " ";                 
                string savePathLicenseB = " "; 
                string relPathLicenseB = " "; 
                String uploadString = "INSERT into Driver (Id, DriverName, DriverId, DriverLicense, DriverPno, DriverBdate, DriverGender, IDpic, SelfiePic, LicenseFpic, LicenseBpic, UserId ) values (@Id, @DriverName, @DriverId, @DriverLicense, @DriverPno, @DriverBdate, @DriverGender, @IDpic, @SelfiePic, @LicenseFpic, @LicenseBpic, @UserId)";
                SqlConnection con = new SqlConnection(Global.CS);

                if (fuID.HasFile)
                {
                    int fileSize = fuID.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuID.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverId");
                    string relfolderLocation = "~/Image/DriverId";
                    if ((ext == ".jpg" || ext == ".png") && fileSize < 2100000)
                    {
                        string fileName = newGUID + ext;
                        savePathId = Path.Combine(folderLocation, fileName);
                        relPathId = Path.Combine(relfolderLocation, fileName);
                    }
                    else
                    {
                        lblIdPic.Text = "Invalid file type or file is too large";
                        return;
                    }
                }                
                
                if (fuSelfie.HasFile)
                {
                    int fileSize = fuSelfie.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuSelfie.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverSelfie");
                    string relfolderLocation = "~/Image/DriverSelfie";
                    if ((ext == ".jpg" || ext == ".png") && fileSize < 2100000)
                    {
                        string fileName = newGUID + ext;
                        savePathSelfie = Path.Combine(folderLocation, fileName);
                        relPathSelfie = Path.Combine(relfolderLocation, fileName);
                    }
                    else
                    {
                        lblSelfiePic.Text = "Invalid file type or file is too large";
                        return;
                    }
                }                
                
                if (fuLicenseF.HasFile)
                {
                    int fileSize = fuLicenseF.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuLicenseF.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverLF");
                    string relfolderLocation = "~/Image/DriverLF";
                    if ((ext == ".jpg" || ext == ".png") && fileSize < 2100000)
                    {
                        string fileName = newGUID + ext;
                        savePathLicenseF = Path.Combine(folderLocation, fileName);
                        relPathLicenseF = Path.Combine(relfolderLocation, fileName);
                    }
                    else
                    {
                        lblLicenseFpic.Text = "Invalid file type or file is too large";
                        return;
                    }
                }
                
                if (fuLicenseB.HasFile)
                {
                    int fileSize = fuLicenseB.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuLicenseB.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverLB");
                    string relfolderLocation = "~/Image/DriverLB";
                    if ((ext == ".jpg" || ext == ".png") && fileSize < 2100000)
                    {
                        string fileName = newGUID + ext;
                        savePathLicenseB = Path.Combine(folderLocation, fileName);
                        relPathLicenseB = Path.Combine(relfolderLocation, fileName);
                    }
                    else
                    {
                        lblLicenseBpic.Text = "Invalid file type or file is too large";
                        return;
                    }
                }

                con.Open();
                SqlCommand com = new SqlCommand(uploadString, con);
                com.Parameters.AddWithValue("@Id", newGUID);
                com.Parameters.AddWithValue("@DriverName", txtName.Text);
                com.Parameters.AddWithValue("@DriverId", txtDriverID.Text);
                com.Parameters.AddWithValue("@DriverLicense", txtDriverLicense.Text);
                com.Parameters.AddWithValue("@DriverPno", txtPhoneNum.Text);
                com.Parameters.AddWithValue("@DriverBdate", txtBirthdate.Text);
                com.Parameters.AddWithValue("@DriverGender", ddlGender.SelectedValue);
                com.Parameters.AddWithValue("@IDpic", relPathId);
                com.Parameters.AddWithValue("@SelfiePic", relPathSelfie);
                com.Parameters.AddWithValue("@LicenseFpic", relPathLicenseF);
                com.Parameters.AddWithValue("@LicenseBpic", relPathLicenseB);
                com.Parameters.AddWithValue("@UserId", Session["Id"].ToString());
                com.ExecuteNonQuery();

                con.Close();
                fuID.SaveAs(savePathId);
                fuSelfie.SaveAs(savePathSelfie);
                fuLicenseF.SaveAs(savePathLicenseF);
                fuLicenseB.SaveAs(savePathLicenseB);
                Server.Transfer("driver.aspx");
            }
        }
    }
}