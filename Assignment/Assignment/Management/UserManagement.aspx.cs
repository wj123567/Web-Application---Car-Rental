using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class UserManagement : System.Web.UI.Page
    {

        private int PageSize = 10;
        private int PageNumber
        {
            get { return ViewState["PageNumber"] != null ? (int)ViewState["PageNumber"] : 1; }
            set { ViewState["PageNumber"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadUserInfo();
                txtAddBdate.Attributes["max"] = DateTime.Now.AddYears(-18).ToString("yyyy-MM-dd");
            }
        }

        protected void ddlBanReason_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBanReason.SelectedValue == "Other")
            {
                txtOtherReason.Visible = true;
                requireOtherReason.Enabled = true;
                banReasonUpdate.Update();
            }
            else
            {
                txtOtherReason.Visible = false;
                requireOtherReason.Enabled = false;
                banReasonUpdate.Update();
            }
        }
        protected void loadUserInfo()
        {
            
            string selectUser = "SELECT * FROM ApplicationUser ORDER BY Username OFFSET @Pagesize*(@PageNumber - 1) ROWS FETCH NEXT @Pagesize ROWS ONLY";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectUser, con);            
            com.Parameters.AddWithValue("@Pagesize", PageSize);
            com.Parameters.AddWithValue("@PageNumber", PageNumber);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "UserTable");
            int row = ds.Tables["UserTable"].Rows.Count;
            ViewState["UserTable"] = ds.Tables["UserTable"];
            UserReapeter.DataSource = ds.Tables["UserTable"];
            UserReapeter.DataBind();
            con.Close();
            UpdatePageInfo(false, getTotalRow());
        }

        protected void UpdatePageInfo(bool isSearching, int row)
        {
            if (!isSearching)
            {
            int totalPage = (int)Math.Ceiling((double)row / (double)PageSize);
            lblPageInfo.Text = "Page " + PageNumber + " of " + totalPage;
            lblTotalRecord.Text = "Total Record: "+ row;
            btnPrevious.Enabled = PageNumber > 1;
            btnNext.Enabled = PageNumber < totalPage;
            }
            else if (isSearching)
            {
                lblPageInfo.Text = "Page " + 1 + " of " + 1;
                lblTotalRecord.Text = "Total Record: " + row;
                btnPrevious.Enabled = false;
                btnNext.Enabled = false;
            }

        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            PageNumber--;
            loadUserInfo();
            updateUserTable.Update();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            PageNumber++;
            loadUserInfo();
            updateUserTable.Update();
        }

        protected int getTotalRow()
        {
           String selectAll = "SELECT COUNT(*) FROM ApplicationUser";       
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectAll, con);
            con.Open();
            return (int)com.ExecuteScalar();
        }

        protected void btnSort_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            string name = button.CommandName;
            string sort = button.CommandArgument;
            if (sort == "DESC")
            {
                button.CommandArgument = "ASC";
            }
            else
            {
                button.CommandArgument = "DESC";
            }
            DataTable carData = (DataTable)ViewState["UserTable"];
            DataView dataView = carData.DefaultView;
            dataView.Sort = name + " " + sort;
            DataTable sortedData = dataView.ToTable();
            ViewState["UserTable"] = sortedData;
            UserReapeter.DataSource = sortedData;
            UserReapeter.DataBind();
            updateUserTable.Update();
        }

        protected void hiddenBtn_Click(object sender, EventArgs e)
        {
            string selectUser = "SELECT * FROM ApplicationUser WHERE Username Like @search OR Email Like @search";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            string search = searchBar.Text.Replace(" ","");
            if (search == "")
            {
                loadUserInfo();
                updateUserTable.Update();
                return;
            }
            else
            {
                con.Open();
                SqlCommand com = new SqlCommand(selectUser, con);
                com.Parameters.AddWithValue("@search", "%" + searchBar.Text + "%");
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet ds = new DataSet();
                da.Fill(ds, "UserTable");
                int row = ds.Tables["UserTable"].Rows.Count;
                ViewState["UserTable"] = ds.Tables["UserTable"];
                UserReapeter.DataSource = ds.Tables["UserTable"];
                UserReapeter.DataBind();
                con.Close();
                UpdatePageInfo(true, row);
            }
        }


        protected void UserReapeter_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            Button btnView = (Button)e.Item.FindControl("btnView");

            if (btnView != null)
            {
                ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
                scriptManager.RegisterPostBackControl(btnView);
            }
        }

        protected void UserReapeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblRegDate = (Label)e.Item.FindControl("lblRegDate");
            Label lblBdate = (Label)e.Item.FindControl("lblBdate");
            Label lblUserStatus = (Label)e.Item.FindControl("lblUserStatus");
            DropDownList ddlRoles = (DropDownList)e.Item.FindControl("ddlRoles");
            DateTime bDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "DOB");
            DateTime regDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "RegistrationDate");
            string isBan = DataBinder.Eval(e.Item.DataItem, "IsBan").ToString();

            lblBdate.Text = bDate.ToString("dd/MM/yyyy");
            lblRegDate.Text = regDate.ToString("dd/MM/yyyy");

            ddlRoles.Items.Add(new ListItem("Admin", "Admin"));
            ddlRoles.Items.Add(new ListItem("Customer", "Customer"));

            string roles = DataBinder.Eval(e.Item.DataItem, "Roles").ToString();            
            ddlRoles.SelectedValue = roles;

            if (isBan == "0")
            {
                lblUserStatus.Text = "Active";
            }else if (isBan == "1") { 
                lblUserStatus.Text = "Banned";
            }
        }

        protected void ddlRolesSelect(object sender, EventArgs e)
        {
            DropDownList ddlRoles = (DropDownList)sender;
            RepeaterItem item = (RepeaterItem)ddlRoles.NamingContainer;
            HiddenField hfUserId = (HiddenField)item.FindControl("hdnIdField");
            string userId = hfUserId.Value;
            string roles = ddlRoles.SelectedValue;

            string sql = "UPDATE ApplicationUser SET Roles = @roles WHERE Id = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@roles", roles);
            com.Parameters.AddWithValue("@id", userId);
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            String id = btnView.CommandArgument;
            UserDriverReapeter.DataSource = null;
            UserDriverReapeter.DataBind();
            LoadAvailableUser(id);
            loadDriverInfo(id);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "modal()", true);
        }

        protected void LoadAvailableUser(String id)
        {
            String selectDriver = "SELECT * FROM ApplicationUser WHERE Id = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Session["UserTableID"] = reader["id"].ToString();
                txtUsername.Text = reader["Username"].ToString();
                txtEmailAddress.Text = reader["Email"].ToString();
                txtRoles.Text = reader["Roles"].ToString();
                DateTime driverBdate = reader.GetDateTime(reader.GetOrdinal("DOB"));
                DateTime regDate = reader.GetDateTime(reader.GetOrdinal("RegistrationDate"));
                txtBirthday.Text = driverBdate.ToString("yyyy-MM-dd");               
                txtMemberSince.Text = regDate.ToString("yyyy-MM-dd");               
                userProfilePic.ImageUrl = reader["ProfilePicture"].ToString();
                string isBan = reader["IsBan"].ToString();
                if(isBan == "0")
                {
                    hdnUserStatus.Value = "0";
                }
                else if(isBan == "1")
                {
                    hdnUserStatus.Value = "1";
                }
            }
            con.Close();
            reader.Close();
        }

        protected void loadDriverInfo(string id)
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
                UserDriverReapeter.DataSource = ds.Tables["DriverData"];
                UserDriverReapeter.DataBind();
            }
            con.Close();
        }

        protected void UserDriverReapeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblApproval = (Label)e.Item.FindControl("lblApproval");
            Label lblReject = (Label)e.Item.FindControl("lblReject");
            string approvalStatus = DataBinder.Eval(e.Item.DataItem, "Approval").ToString();
            string rejectReason = DataBinder.Eval(e.Item.DataItem, "rejectReason").ToString();

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
                default:
                    lblApproval.Text = "Unknown";
                    break;
            }
        }

        protected void btnBan_Click(object sender, EventArgs e)
        {
            string sql = "UPDATE ApplicationUser SET IsBan = 1 , BanReason = @banReason WHERE Id = @id";
            banUser(sql, true);
            Server.Transfer("UserManagement.aspx");
        }

        protected void btnUnban_Click(object sender, EventArgs e)
        {
            string sql = "UPDATE ApplicationUser SET IsBan = 0 , BanReason = @banReason WHERE Id = @id";
            banUser(sql, false);
            Server.Transfer("UserManagement.aspx");
        }

        protected void banUser(string sql,Boolean isBan)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@id", Session["UserTableID"].ToString());
            if (isBan)
            {
                if(ddlBanReason.SelectedValue != "Other")
                {
                    com.Parameters.AddWithValue("@banReason", ddlBanReason.SelectedValue);
                }
                else
                {
                    com.Parameters.AddWithValue("@banReason", txtOtherReason.Text);
                }
            }
            else
            {
                com.Parameters.AddWithValue("@banReason", "");
            }
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string delString = "DELETE FROM ApplicationUser WHERE Id = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(delString, con);
            con.Open();
            com.Parameters.AddWithValue("@id", Session["UserTableID"].ToString());
            com.ExecuteNonQuery();
            con.Close();
            Server.Transfer("UserManagement.aspx");
        }

        protected void emailExist_ServerValidate(object source, ServerValidateEventArgs args)
        {
            SystemDatabaseEntities db = new SystemDatabaseEntities();
            string email = args.Value;

            if(db.ApplicationUsers.Any(u => u.Email == email))
            {
                args.IsValid = false;
                addUpdatePanel.Update();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "addNewmodal()", true);
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SystemDatabaseEntities db = new SystemDatabaseEntities();
                string folderLocation = Server.MapPath("~/Image/UserProfile");
                string relfolderLocation = "~/Image/UserProfile";
                string relPath = "";
                Guid guid = Guid.NewGuid();
                if (fuAddProfile.HasFile)
                {
                    int fileSize = fuAddProfile.PostedFile.ContentLength;
                    string ext = Path.GetExtension(fuAddProfile.FileName);
                    string fileName = guid + ext;
                    string savePath = Path.Combine(folderLocation, fileName);
                    relPath = Path.Combine(relfolderLocation, fileName);
                    fuAddProfile.SaveAs(savePath);
                }
                else
                {
                    relPath = "~/Image/UserProfile/noImg.svg";
                }

                ApplicationUser user = new ApplicationUser()
                {
                    Id = guid.ToString(),
                    Username = txtAddUsername.Text,
                    Email = txtAddEmail.Text,
                    Password = Security.hashing(txtAddPassword.Text,guid.ToString()),
                    DOB = DateTime.Parse(txtAddBdate.Text),
                    RegistrationDate = DateTime.Now,
                    Roles = ddlAddRoles.SelectedValue,
                    ProfilePicture = relPath,
                    TwoStepVerification = 0,
                    EmailVerification = 0,
                    IsBan = 0,
                    BanReason = "",
                    RewardPoints = 0,
                };

                db.ApplicationUsers.Add(user);
                db.SaveChanges();

                Server.Transfer("UserManagement.aspx");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Server.Transfer("UserManagement.aspx");
        }
    }
}