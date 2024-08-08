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
    public partial class driverManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadUserInfo();
            }
        }


        protected void loadUserInfo()
        {
            String selectDriver = "SELECT Id, DriverName, DriverId, Approval, RejectReason FROM Driver";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
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

        protected void DriverReapeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblApproval = (Label)e.Item.FindControl("lblApproval");
            Label lblReject = (Label)e.Item.FindControl("lblReject");
            Button btnView = (Button)e.Item.FindControl("btnView");
            string approvalStatus = DataBinder.Eval(e.Item.DataItem,"Approval").ToString();
            string rejectReason = DataBinder.Eval(e.Item.DataItem,"rejectReason").ToString();

            switch (approvalStatus)
            {
                case "P":
                    lblApproval.Text = "Pending";
                    lblApproval.CssClass = "badge bg-warning text-light";
                    btnView.Visible = true;
                    break;
                case "A":
                    lblApproval.Text = "Approved";
                    lblApproval.CssClass = "badge bg-success text-light";
                    btnView.Visible = true;
                    break;
                case "R":
                    lblApproval.Text = "Rejected";
                    lblApproval.CssClass = "badge bg-danger text-light";
                    btnView.Visible = false;
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
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "loadModal()", true);
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
    }
}