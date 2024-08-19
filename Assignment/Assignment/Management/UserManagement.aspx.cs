using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class UserManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadUserInfo("SELECT * FROM ApplicationUser");
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
        protected void loadUserInfo(string selectUser)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectUser, con);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "UserTable");
            ViewState["UserTable"] = ds.Tables["UserTable"];
            UserReapeter.DataSource = ds.Tables["UserTable"];
            UserReapeter.DataBind();
            con.Close();
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
            con.Open();
            SqlCommand com = new SqlCommand(selectUser, con);
            com.Parameters.AddWithValue("@search", "%" + searchBar.Text + "%");
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "UserTable");
            ViewState["UserTable"] = ds.Tables["UserTable"];
            UserReapeter.DataSource = ds.Tables["UserTable"];
            UserReapeter.DataBind();
            con.Close();
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
               if (fuAddProfile.HasFile)
               {
                 string yeet = "nice";
               }

                Server.Transfer("UserManagement.aspx");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Server.Transfer("UserManagement.aspx");
        }
    }
}