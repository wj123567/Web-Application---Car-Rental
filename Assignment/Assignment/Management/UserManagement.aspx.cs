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
                ViewState["SQLQuery"] = "SELECT * FROM ApplicationUser";
                loadUserInfo();
                loadState();
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

        protected void loadState()
        {
            string selectValidate = @"SELECT (SUM(CASE WHEN EmailVerification = 1 THEN 1 ELSE 0 END)) AS TotalValidated, COUNT(*) AS TotalUser, (SUM(CASE WHEN TwoStepVerification = 1 THEN 1 ELSE 0 END)) AS TotalTFA FROM ApplicationUser";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectValidate, con);
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            int totalUser = 0;
            int totalValidated = 0;
            int totalTFA = 0;
            if (reader.Read())
            {
                totalUser = int.Parse(reader["TotalUser"].ToString());
                totalValidated = int.Parse(reader["TotalValidated"].ToString());
                totalTFA = int.Parse(reader["TotalTFA"].ToString());
            }
            reader.Close();
            con.Close();
            lblValidatedUser.Text = ((double)totalValidated / totalUser * 100).ToString("F2") + "%";
            lblNumValidatedUser.Text = totalValidated + "/" + totalUser + " Users";
            lbltfa.Text = ((double)totalTFA / totalUser * 100).ToString("F2") + "%";
            lbltfanum.Text = totalTFA + "/" + totalUser + " Users";
        }

        protected void loadUserInfo()
        {
            string selectUser = ViewState["SQLQuery"].ToString() + " ORDER BY Username OFFSET @Pagesize*(@PageNumber - 1) ROWS FETCH NEXT @Pagesize ROWS ONLY";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectUser, con);            
            com.Parameters.AddWithValue("@Pagesize", PageSize);
            com.Parameters.AddWithValue("@PageNumber", PageNumber);
            com.Parameters.AddWithValue("@search", "%" + searchBar.Text.Replace(" ", "") + "%");
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "UserTable");
            int row = ds.Tables["UserTable"].Rows.Count;
            ViewState["UserTable"] = ds.Tables["UserTable"];
            UserReapeter.DataSource = ds.Tables["UserTable"];
            UserReapeter.DataBind();
            con.Close();
            UpdatePageInfo(getTotalRow());
            removeSort();
            btnSortUsername.CssClass = "text-dark sort-up";
        }

        protected void UpdatePageInfo(int row)
        {
            int totalPage = (int)Math.Ceiling((double)row / (double)PageSize);
            lblPageInfo.Text = "Page " + PageNumber + " of " + totalPage;
            lblTotalRecord.Text = "Total Record: "+ row;
            btnPrevious.Enabled = PageNumber > 1;
            btnNext.Enabled = PageNumber < totalPage;
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
           String selectAll = "SELECT COUNT(*) FROM ApplicationUser ";
            int whereIndex = ViewState["SQLQuery"].ToString().IndexOf("WHERE", StringComparison.OrdinalIgnoreCase);

            if (whereIndex != -1)
            {
                string afterWhere = ViewState["SQLQuery"].ToString().Substring(whereIndex).Trim();
                selectAll += afterWhere;
            }

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectAll, con);
            com.Parameters.AddWithValue("@search", "%" + searchBar.Text.Replace(" ", "") + "%");
            con.Open();
            return (int)com.ExecuteScalar();
        }

        protected void btnSort_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            string name = button.CommandName;
            string sort = button.CommandArgument;
            removeSort();
            if (sort == "DESC")
            {
                button.CommandArgument = "ASC";
                button.CssClass = "text-dark sort-down";
            }
            else
            {
                button.CommandArgument = "DESC";
                button.CssClass = "text-dark sort-up";
            }
            DataTable carData = (DataTable)ViewState["UserTable"];
            DataView dataView = carData.DefaultView;
            dataView.Sort = name + " " + sort;
            DataTable sortedData = dataView.ToTable();
            ViewState["UserTable"] = sortedData;
            UserReapeter.DataSource = sortedData;
            UserReapeter.DataBind();
            updateUserTable.Update();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "UpdateSorting", $"showSortDirection('{button.ClientID}', '{sort}');", true);
        }

        protected void removeSort()
        {
            btnSortUsername.CssClass = "text-dark";
            btnSortEmail.CssClass = "text-dark";
            btnSortRP.CssClass = "text-dark";
            btnSortRegDate.CssClass = "text-dark";
            btnSortRoles.CssClass = "text-dark";
            btnSortBan.CssClass = "text-dark";
            btnBanReason.CssClass = "text-dark";
        }

        protected void hiddenBtn_Click(object sender, EventArgs e)
        {
            string selectUser = "SELECT * FROM ApplicationUser WHERE Username Like @search OR Email Like @search";
            ViewState["SQLQuery"] = selectUser;
            loadUserInfo();
            updateUserTable.Update();
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
            Label lblUserStatus = (Label)e.Item.FindControl("lblUserStatus");
            DropDownList ddlRoles = (DropDownList)e.Item.FindControl("ddlRoles");
            DateTime regDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "RegistrationDate");
            string isBan = DataBinder.Eval(e.Item.DataItem, "IsBan").ToString();

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
            loadAvailableUser(id);
            loadDriverInfo(id);
            loadBookingInfo(id);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "modal()", true);
        }

        protected void loadAvailableUser(String id)
        {
            String selectDriver = "SELECT * FROM ApplicationUser WHERE Id = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                hdnUserId.Value = reader["id"].ToString();
                txtUsername.Text = reader["Username"].ToString();
                txtEmailAddress.Text = reader["Email"].ToString();
                txtRoles.Text = reader["Roles"].ToString();
                DateTime driverBdate = reader.GetDateTime(reader.GetOrdinal("DOB"));
                DateTime regDate = reader.GetDateTime(reader.GetOrdinal("RegistrationDate"));
                txtBirthday.Text = driverBdate.ToString("yyyy-MM-dd"); 
                txtRewardPoint.Text = reader["RewardPoints"].ToString();
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
            SqlDataReader reader = com.ExecuteReader();
            if (reader.HasRows)
            {
                phUserDriver.Visible = true;
                lblDriverText.Text = "";
                if (reader.Read())
                {
                    lblDriverName.Text = reader["DriverName"].ToString();
                    lblDriverId.Text = "Driver ID: "+reader["DriverId"].ToString();
                    string approvalStatus = reader["Approval"].ToString();
                    switch (approvalStatus)
                    {
                        case "P":
                            lblApproval.Text = "Pending";
                            lblApproval.CssClass = "badge bg-warning text-dark";
                            break;
                        case "A":
                            lblApproval.Text = "Approved";
                            lblApproval.CssClass = "badge bg-success text-light";
                            break;
                        case "R":
                            lblApproval.Text = "Rejected";
                            lblApproval.CssClass = "badge bg-danger text-light";
                            lblReject.Text = "Reject Reason:" + reader["RejectReason"].ToString();
                            break;
                        default:
                            lblApproval.Text = "Unknown";
                            break;
                    }
                }
            }
            else
            {
                phUserDriver.Visible = false;
                lblDriverText.Text = "No Driver Available";
            }
            con.Close();
            reader.Close();
        }
        protected void loadBookingInfo(String id)
        {
            String selectDriver = "SELECT B.*, C.CarImage FROM Booking B JOIN Car C ON B.CarPlate = C.CarPlate WHERE UserId = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Id", id);

            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "BookingData");
            if (ds.Tables["BookingData"].Rows.Count == 0)
            {
                rptBookingRec.DataSource = ds.Tables["BookingData"];
                rptBookingRec.DataBind();
                lblNoBooking.Text = "No Booking Record";
            }
            else
            {
                lblNoBooking.Text = "";
                rptBookingRec.DataSource = ds.Tables["BookingData"];
                rptBookingRec.DataBind();
            }
            con.Close();
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
            com.Parameters.AddWithValue("@id", hdnUserId.Value);
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
            string deleteCom = "DELETE FROM PaymentCard WHERE UserId = @id;DELETE FROM ApplicationUser WHERE Id = @id";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(deleteCom, con);
            con.Open();
            com.Parameters.AddWithValue("@id", hdnUserId.Value);
            com.ExecuteNonQuery();
            con.Close();
            string path = MapPath("~/Image/UserProfile/");
            File.Delete(path + hdnUserId.Value + ".jpg");
            Response.Redirect("UserManagement.aspx");
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
                if (!string.IsNullOrEmpty(hdnProfilePicture.Value))
                {
                    // Decode the Base64 string and save it as an image file
                    string base64String = hdnProfilePicture.Value.Split(',')[1]; // Remove the data URI scheme part
                    byte[] imageBytes = Convert.FromBase64String(base64String);
                    string fileName = guid + ".jpg";
                    relPath = Path.Combine(relfolderLocation, fileName);
                    string savePath = Path.Combine(folderLocation, fileName);
                    File.WriteAllBytes(savePath, imageBytes); // Save the file
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

                Response.Redirect("UserManagement.aspx");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserManagement.aspx");
        }

        protected void rptBookingRec_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblBookUpdate = (Label)e.Item.FindControl("lblBookUpdate");
            Label lblBookReject = (Label)e.Item.FindControl("lblBookReject");
            Label lblStatus = (Label)e.Item.FindControl("lblstatus");
            string Status = DataBinder.Eval(e.Item.DataItem, "Status").ToString();
            string updateReason = DataBinder.Eval(e.Item.DataItem, "UpdateReason").ToString();
            string rejectReason = DataBinder.Eval(e.Item.DataItem, "RejectReason").ToString();

            lblStatus.Text = Status;

            switch (Status)
            {
                case "Completed":
                    lblStatus.CssClass = "badge bg-primary text-light";
                    break;
                case "Cancelled":
                    lblStatus.CssClass = "badge bg-danger text-light";
                    lblBookUpdate.Text = "Cancelled Reason: " + updateReason;
                    break;
                case "Booked":
                    lblStatus.CssClass = "badge bg-success text-light";
                    if(!String.IsNullOrEmpty(updateReason))
                    {
                        lblBookReject.Text = "Reject Reason: " + rejectReason;
                    }
                    break;
                case "Pending":
                    lblStatus.CssClass = "badge bg-warning text-dark";
                    lblBookUpdate.Text = "Cancelled Reason: " + updateReason;
                    break;
                default:
                    lblStatus.CssClass = "badge bg-default text-light";
                    break;
            }
        }
    }
}
