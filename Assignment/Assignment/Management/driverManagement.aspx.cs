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
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Web.Services.Description;
using static System.Net.Mime.MediaTypeNames;

namespace Assignment
{
    public partial class driverManagement : System.Web.UI.Page
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
                ViewState["SortSelection"] = "P";
                ViewState["SQLQuery"] = "SELECT * FROM Driver WHERE Approval = 'P'";
                loadDriverInfo();
            }
        }


        protected void loadDriverInfo()
        {
            string sort = ViewState["SortSelection"].ToString();
            string selectDriver = ViewState["SQLQuery"].ToString() + " ORDER BY DateApply OFFSET @Pagesize*(@PageNumber - 1) ROWS FETCH NEXT @Pagesize ROWS ONLY";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Pagesize", PageSize);
            com.Parameters.AddWithValue("@PageNumber", PageNumber);
            com.Parameters.AddWithValue("@search", "%" + searchBar.Text.Replace(" ", "") + "%");
            if(sort != "" && sort != "All")
            {
                com.Parameters.AddWithValue("@Approval", sort);
            }
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "DriverTable");
            ViewState["DriverTable"] = ds.Tables["DriverTable"];
            DriverReapeter.DataSource = ds.Tables["DriverTable"];
            DriverReapeter.DataBind();
            con.Close();
            UpdatePageInfo(getTotalRow(sort));
            btnSelectStyle(sort);
            removeSort();
            btnSortDateApply.CssClass = "text-dark sort-up";
        }

        protected void UpdatePageInfo(int row)
        {
                int totalPage = (int)Math.Ceiling((double)row / (double)PageSize);
                lblPageInfo.Text = "Page " + PageNumber + " of " + totalPage;
                lblTotalRecord.Text = "Total Record: " + row;
                btnPrevious.Enabled = PageNumber > 1;
                btnNext.Enabled = PageNumber < totalPage;
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            PageNumber--;
            loadDriverInfo();
            updateDriverTable.Update();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            PageNumber++;
            loadDriverInfo();
            updateDriverTable.Update();
        }

        protected int getTotalRow(string sort)
        {
            String selectAll = "SELECT COUNT(*) FROM Driver ";
            int whereIndex = ViewState["SQLQuery"].ToString().IndexOf("WHERE", StringComparison.OrdinalIgnoreCase);

            if (whereIndex != -1)
            {
                string afterWhere = ViewState["SQLQuery"].ToString().Substring(whereIndex).Trim();
                selectAll += afterWhere;
            }

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectAll, con);
            com.Parameters.AddWithValue("@search", "%" + searchBar.Text.Replace(" ", "") + "%");
            if (sort != "" && sort != "All")
            {
                com.Parameters.AddWithValue("@Approval", sort);
            }
            con.Open();
            return (int)com.ExecuteScalar();
        }

        protected void DriverReapeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblApproval = (Label)e.Item.FindControl("lblApproval");
            Label lblBdate = (Label)e.Item.FindControl("lblBdate");
            Label lblDateApply = (Label)e.Item.FindControl("lblDateApply");
            Label lblReject = (Label)e.Item.FindControl("lblReject");
            Label lblUserAvailable = (Label)e.Item.FindControl("lblUserAvailable");
            string approvalStatus = DataBinder.Eval(e.Item.DataItem, "Approval").ToString();
            DateTime bDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "DriverBdate");
            DateTime dateApply = (DateTime)DataBinder.Eval(e.Item.DataItem, "DateApply");
            string rejectReason = DataBinder.Eval(e.Item.DataItem, "rejectReason").ToString();
            string userID = DataBinder.Eval(e.Item.DataItem, "UserId").ToString();

            lblBdate.Text = bDate.ToString("dd/MM/yyyy");
            lblDateApply.Text = dateApply.ToString("dd/MM/yyyy");

            if (String.IsNullOrEmpty(userID))
            {
                lblUserAvailable.Text = "N/A";
            }
            else
            {
                lblUserAvailable.Text = "Available";
            }

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
                    lblReject.Text = rejectReason;
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
            string selectDriver = "SELECT * FROM Driver WHERE Id = @id";
            string userId = "";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                hdnDriverId.Value = reader["id"].ToString();
                txtName.Text = reader["DriverName"].ToString();
                txtDriverID.Text = reader["DriverId"].ToString();
                txtDriverLicense.Text = reader["DriverLicense"].ToString();
                txtPhoneNum.Text = reader["DriverPno"].ToString();
                DateTime driverBdate = reader.GetDateTime(reader.GetOrdinal("DriverBdate"));
                txtBirthdate.Text = driverBdate.ToString("yyyy-MM-dd");
                ddlGender.SelectedValue = reader["driverGender"].ToString();
                imgID.ImageUrl = reader["IDpic"].ToString(); ;
                imgSelfie.ImageUrl = reader["Selfiepic"].ToString();
                imgLicenseF.ImageUrl = reader["LicenseFpic"].ToString();
                imgLicenseB.ImageUrl = reader["LicenseBpic"].ToString();
                userId = reader["UserId"].ToString();
            }
            con.Close();
            reader.Close();

            if (String.IsNullOrEmpty(userId))
            {
                btnApprove.Visible = false;
                btnReject.Visible = false;
                btnDelete.Visible = true;
            }
            else
            {
                btnApprove.Visible = true;
                btnReject.Visible = true;
                btnDelete.Visible = false;
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            string approve = "UPDATE Driver SET Approval = 'A', RejectReason = @RejectReason WHERE Id = @Id";
            string rejectReason = " ";
            updateApproval(approve, rejectReason);
        }

        protected void btnReject2_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string reject = "UPDATE Driver SET Approval = 'R', RejectReason = @RejectReason WHERE Id = @Id";
                string rejectReason = " ";
                if (ddlRejectReason.SelectedValue == "Other")
                {
                    rejectReason = txtOtherReason.Text;
                }
                else
                {
                    rejectReason = ddlRejectReason.SelectedValue;
                }
                updateApproval(reject, rejectReason);
            }
        }

        protected void updateApproval(string sql, string reject)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@Id", hdnDriverId.Value);
            com.Parameters.AddWithValue("@RejectReason", reject);
            com.ExecuteNonQuery();
            con.Close();
            reload();
        }

        protected void ddlRejectReason_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRejectReason.SelectedValue == "Other")
            {
                txtOtherReason.Visible = true;
                requireOtherReason.Enabled = true;
                updateReason.Update();
            }
            else
            {
                txtOtherReason.Visible = false;
                requireOtherReason.Enabled = false;
                updateReason.Update();
            }
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
            DataTable carData = (DataTable)ViewState["DriverTable"];
            DataView dataView = carData.DefaultView;
            dataView.Sort = name + " " + sort;
            DataTable sortedData = dataView.ToTable();
            ViewState["DriverTable"] = sortedData;
            DriverReapeter.DataSource = sortedData;
            DriverReapeter.DataBind();
            updateDriverTable.Update();
        }

        protected void removeSort()
        {
            btnSortAccountAvailable.CssClass = "text-dark";
            btnSortDriverName.CssClass = "text-dark";
            btnSortDriverBdate.CssClass = "text-dark";
            btnSortPno.CssClass = "text-dark";
            btnSortDateApply.CssClass = "text-dark";
            btnSortApproval.CssClass = "text-dark";
            btnSortDriverId.CssClass = "text-dark";
            btnSortDriverLicense.CssClass = "text-dark";
            btnSortRejectReason.CssClass = "text-dark";

        }

        protected void DriverReapeter_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            Button btnView = (Button)e.Item.FindControl("btnView");
            if (btnView != null)
            {
                ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
                scriptManager.RegisterPostBackControl(btnView);
            }
        }

        protected void hiddenBtn_Click(object sender, EventArgs e)
        {
            string selectDriver = "SELECT * FROM Driver WHERE DriverName Like @search OR DriverId Like @search OR DriverPno Like @search OR DriverLicense LIKE @search";
            ViewState["SQLQuery"] = selectDriver;
            loadDriverInfo();
            updateDriverTable.Update();
        }

        protected void sortCategory(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            string sort = button.CommandArgument;
            string selectDriver = " ";

            if (sort != "All")
            {
                selectDriver = "SELECT * FROM Driver WHERE Approval = @Approval";
            }
            else
            {
                selectDriver = "SELECT * FROM Driver";
            }

            ViewState["SortSelection"] = sort;
            ViewState["SQLQuery"] = selectDriver;
            loadDriverInfo();
            updateDriverTable.Update();

        }

        protected void reload()
        {
            if (ViewState["SortSelection"] != null)
            {
                string sort = ViewState["SortSelection"].ToString();
                if (sort != "All")
                {
                    ViewState["SQLQuery"] = "SELECT * FROM Driver WHERE Approval = @Approval";
                }
                else
                {
                    ViewState["SQLQuery"] = "SELECT * FROM Driver";
                }
                loadDriverInfo();
                updateDriverTable.Update();
            }
        }

        protected void btnSelectStyle(string sort)
        {
            Button[] btnGroup = { btnAll, btnPending, btnApproved, btnRejected };

            for(int i = 0; i < btnGroup.Length; i++)
            {
                btnGroup[i].CssClass = "btn border border-dark sort-button-group";
            }

            Boolean found = false;
            for (int i = 0; i < btnGroup.Length && !found; i++)
            {
                if (btnGroup[i].CommandArgument == sort)
                {
                    btnGroup[i].CssClass = "btn border border-dark sort-button-group active-btn";
                    found = true;
                }
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string deleteDriver = "DELETE FROM Driver WHERE Id = @id";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            string[] path = { MapPath("~/Image/DriverId/"), MapPath("~/Image/DriverLB/"), MapPath("~/Image/DriverLF/"), MapPath("~/Image/DriverSelfie/") };
            string id = hdnDriverId.Value;
            for (int i = 0; i < path.Length; i++)
            {
                File.Delete(path[i] + id + ".jpg");
            }

            con.Open();

            SqlCommand com = new SqlCommand(deleteDriver, con);

            com.Parameters.AddWithValue("@Id", id);

            com.ExecuteNonQuery();

            reload();
        }
    }
}