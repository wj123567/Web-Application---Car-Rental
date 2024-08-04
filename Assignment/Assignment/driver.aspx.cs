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
                    Server.Transfer("Home.aspx");
                }
            }
        }


        protected void loadUserInfo(String id)
        {
            String selectDriver = "SELECT Id, DriverName, DriverId, Approval, RejectReason FROM Driver WHERE UserId = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@id", id);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "DriverData");
            if (ds.Tables["DriverData"].Rows.Count == 0)
            {
                lblDriverText.Text = "No Driver Available";
            }
            else
            {
                lblDriverText.Text = " ";
                DriverReapeter.DataSource = ds.Tables["DriverData"];
                DriverReapeter.DataBind();
            }
            con.Close();
        }

        protected void btnUpdateDoc_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string updateString = "UPDATE Driver SET DriverName = @DriverName, DriverId = @DriverId, DriverLicense = @DriverLicense, DriverPno = @DriverPno, DriverBdate = @DriverBdate, DriverGender = @DriverGender, IDpic = @IDpic, SelfiePic = @SelfiePic, LicenseFpic = @LicenseFpic, LicenseBpic = @LicenseBpic, Approval = @Approval, UserId = @UserId WHERE Id = @Id";

                SaveDriverInfo(updateString, Session["DriverID"].ToString(), "P");
            }
        }

        protected void btnUploadDoc_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string insertString = "INSERT into Driver (Id, DriverName, DriverId, DriverLicense, DriverPno, DriverBdate, DriverGender, IDpic, SelfiePic, LicenseFpic, LicenseBpic,Approval ,UserId ) values (@Id, @DriverName, @DriverId, @DriverLicense, @DriverPno, @DriverBdate, @DriverGender, @IDpic, @SelfiePic, @LicenseFpic, @LicenseBpic, @Approval, @UserId)";
                Guid newGUID = Guid.NewGuid();
                SaveDriverInfo(insertString, newGUID.ToString(), "P");
            }
        }
        protected void SaveDriverInfo(string uploadString, string Guid, string approval)
        {
            if (Page.IsValid)
            {
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
                    int fileSize = fuID.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuID.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverId");
                    string relfolderLocation = "~/Image/DriverId";
                        string fileName = Guid + ext;
                        savePathId = Path.Combine(folderLocation, fileName);
                        relPathId = Path.Combine(relfolderLocation, fileName);
                }                
                
                if (fuSelfie.HasFile)
                {
                    int fileSize = fuSelfie.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuSelfie.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverSelfie");
                    string relfolderLocation = "~/Image/DriverSelfie";
                        string fileName = Guid + ext;
                        savePathSelfie = Path.Combine(folderLocation, fileName);
                        relPathSelfie = Path.Combine(relfolderLocation, fileName);
                }                
                
                if (fuLicenseF.HasFile)
                {
                    int fileSize = fuLicenseF.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuLicenseF.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverLF");
                    string relfolderLocation = "~/Image/DriverLF";
                        string fileName = Guid + ext;
                        savePathLicenseF = Path.Combine(folderLocation, fileName);
                        relPathLicenseF = Path.Combine(relfolderLocation, fileName);
                }
                
                if (fuLicenseB.HasFile)
                {
                    int fileSize = fuLicenseB.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuLicenseB.FileName);
                    string folderLocation = Server.MapPath("~/Image/DriverLB");
                    string relfolderLocation = "~/Image/DriverLB";
                        string fileName = Guid + ext;
                        savePathLicenseB = Path.Combine(folderLocation, fileName);
                        relPathLicenseB = Path.Combine(relfolderLocation, fileName);
                }

                con.Open();
                SqlCommand com = new SqlCommand(uploadString, con);
                com.Parameters.AddWithValue("@Id", Guid);
                com.Parameters.AddWithValue("@DriverName", txtName.Text);
                com.Parameters.AddWithValue("@DriverId", txtDriverID.Text);
                com.Parameters.AddWithValue("@DriverLicense", txtDriverLicense.Text);
                com.Parameters.AddWithValue("@DriverPno", countryCode +" "+txtPhoneNum.Text);
                com.Parameters.AddWithValue("@DriverBdate", txtBirthdate.Text);
                com.Parameters.AddWithValue("@DriverGender", ddlGender.SelectedValue);
                com.Parameters.AddWithValue("@IDpic", relPathId);
                com.Parameters.AddWithValue("@SelfiePic", relPathSelfie);
                com.Parameters.AddWithValue("@LicenseFpic", relPathLicenseF);
                com.Parameters.AddWithValue("@LicenseBpic", relPathLicenseB);
                com.Parameters.AddWithValue("@Approval", approval);
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

        protected void DriverReapeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblApproval = (Label)e.Item.FindControl("lblApproval");
            Label lblReject = (Label)e.Item.FindControl("lblReject");
            Button btnView = (Button)e.Item.FindControl("btnView");
            Button btnEdit = (Button)e.Item.FindControl("btnEdit");
            string approvalStatus = DataBinder.Eval(e.Item.DataItem,"Approval").ToString();
            string rejectReason = DataBinder.Eval(e.Item.DataItem,"rejectReason").ToString();

            switch (approvalStatus)
            {
                case "P":
                    lblApproval.Text = "Pending";
                    lblApproval.CssClass = "badge bg-warning text-light";
                    btnView.Visible = true;
                    btnEdit.Visible = false;
                    break;
                case "A":
                    lblApproval.Text = "Approved";
                    lblApproval.CssClass = "badge bg-success text-light";
                    btnView.Visible = true;
                    btnEdit.Visible = false;
                    break;
                case "R":
                    lblApproval.Text = "Rejected";
                    lblApproval.CssClass = "badge bg-danger text-light";
                    btnView.Visible = false;
                    btnEdit.Visible = true;
                    lblReject.Text = "Reject Reason:" + rejectReason;
                    break;
                default:
                    lblApproval.Text = "Unknown";
                    break;
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            String id = btnView.CommandArgument;
            LoadAvailableDriver(id);
            HideControls(Panel1);
            btnDelete.Visible = true;
        }        

        protected void btnEdit_Click(object sender, EventArgs e)
        {           
            Button btnEdit = (Button)sender;
            String id = btnEdit.CommandArgument;
            LoadAvailableDriver(id);
            btnUploadDoc.Visible = false;
            btnUpdateDoc.Visible = true;
            btnDelete.Visible = true;
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string deleteDriver = "UPDATE Driver SET UserId = NULL WHERE Id = @id";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            con.Open();

            SqlCommand com = new SqlCommand(deleteDriver,con);

            com.Parameters.AddWithValue("@Id", Session["DriverID"].ToString());

            com.ExecuteNonQuery();

            Server.Transfer("driver.aspx");
        }


        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Server.Transfer("driver.aspx");
        }

        protected void LoadAvailableDriver(String id)
        {
            String selectDriver = "SELECT * FROM Driver WHERE Id = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Id",id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Session["DriverID"] = reader["id"].ToString();
                txtName.Text = reader["DriverName"].ToString();
                txtDriverID.Text = reader["DriverId"].ToString();
                txtDriverLicense.Text = reader["DriverLicense"].ToString();
                txtPhoneNum.Text = reader["DriverPno"].ToString();
                DateTime driverBdate = reader.GetDateTime(reader.GetOrdinal("DriverBdate"));
                txtBirthdate.Text = driverBdate.ToString("yyyy-MM-dd");
                ddlGender.SelectedValue = reader["driverGender"].ToString();
                imgID.ImageUrl = reader["IDpic"].ToString();;
                imgSelfie.ImageUrl = reader["Selfiepic"].ToString();
                imgLicenseF.ImageUrl = reader["LicenseFpic"].ToString();
                imgLicenseB.ImageUrl = reader["LicenseBpic"].ToString();
            }
            con.Close();
            reader.Close();
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
    }
}