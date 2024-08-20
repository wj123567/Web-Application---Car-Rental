using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Management
{
    public partial class BookingManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetBookRecords();
            }
        }


        private void GetBookRecords(string statusFilter = "All")
        {

            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT * FROM Booking b JOIN Car c ON b.CarPlate = c.CarPlate ";


                // Apply status filter if necessary
                if (statusFilter != "All")
                {
                    sql += " WHERE b.Status = @Status";
                }

                SqlCommand cmd = new SqlCommand(sql, con);

                if (statusFilter != "All")
                {
                    cmd.Parameters.AddWithValue("@Status", statusFilter);
                }


                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataSet ds = new DataSet();
                    da.Fill(ds, "BookingRecordTable");
                    ViewState["BookingRecordTable"] = ds.Tables["BookingRecordTable"];
                    rptBookingList.DataSource = ds.Tables["BookingRecordTable"];
                    rptBookingList.DataBind();
                }

            }
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedStatus = ddlStatusFilter.SelectedValue;
            GetBookRecords(selectedStatus);
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

            // Trigger client-side icon update
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateSortIcon", "updateSortIcons();", true);


            DataTable bookingData = (DataTable)ViewState["BookingRecordTable"];
            DataView dataView = bookingData.DefaultView;
            dataView.Sort = name + " " + sort;
            DataTable sortedData = dataView.ToTable();

            // Update ViewState and Repeater
            ViewState["BookingRecordTable"] = sortedData;
            rptBookingList.DataSource = sortedData;
            rptBookingList.DataBind();
            updatebookingRecordTable.Update();

            // Store the current sort direction
            hdnSortDirection.Value = button.CommandArgument; // Store current sort direction

            // Trigger client-side pagination reinitialization
            ScriptManager.RegisterStartupScript(this, GetType(), "ReinitializePagination", "$('#bookingRecordTable').paging({ limit: 10 });", true);

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
                if (isBan == "0")
                {
                    hdnUserStatus.Value = "0";
                }
                else if (isBan == "1")
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


      /*  protected void UserReapeter_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            Button btnView = (Button)e.Item.FindControl("btnView");
            Button btnDelete = (Button)e.Item.FindControl("btnDelete");
            if (btnView != null)
            {
                ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
                scriptManager.RegisterPostBackControl(btnView);
                scriptManager.RegisterPostBackControl(btnDelete);
            }
        }

        protected void UserReapeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblRegDate = (Label)e.Item.FindControl("lblRegDate");
            Label lblBdate = (Label)e.Item.FindControl("lblBdate");
            Label lblUserStatus = (Label)e.Item.FindControl("lblUserStatus");
            DateTime bDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "DOB");
            DateTime regDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "RegistrationDate");
            string isBan = DataBinder.Eval(e.Item.DataItem, "IsBan").ToString();

            lblBdate.Text = bDate.ToString("dd/MM/yyyy");
            lblRegDate.Text = regDate.ToString("dd/MM/yyyy");

            if (isBan == "0")
            {
                lblUserStatus.Text = "Active";
            }
            else if (isBan == "1")
            {
                lblUserStatus.Text = "Banned";
            }
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

        protected void banUser(string sql, Boolean isBan)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@id", Session["UserTableID"].ToString());
            if (isBan)
            {
                if (ddlBanReason.SelectedValue != "Other")
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
        }*/
    }
}