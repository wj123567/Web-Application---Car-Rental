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
                loadDriverInfo();
            }
        }


        protected void loadDriverInfo()
        {
            string selectDriver = "SELECT * FROM Driver ORDER BY DateApply OFFSET @Pagesize*(@PageNumber - 1) ROWS FETCH NEXT @Pagesize ROWS ONLY";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Pagesize", PageSize);
            com.Parameters.AddWithValue("@PageNumber", PageNumber);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "DriverTable");
            ViewState["DriverTable"] = ds.Tables["DriverTable"];
            DriverReapeter.DataSource = ds.Tables["DriverTable"];
            DriverReapeter.DataBind();
            con.Close();
            UpdatePageInfo(false, getTotalRow());
        }

        protected void UpdatePageInfo(bool isSearching, int row)
        {
            if (!isSearching)
            {
                int totalPage = (int)Math.Ceiling((double)row / (double)PageSize);
                lblPageInfo.Text = "Page " + PageNumber + " of " + totalPage;
                lblTotalRecord.Text = "Total Record: " + row;
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
            loadDriverInfo();
            updateDriverTable.Update();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            PageNumber++;
            loadDriverInfo();
            updateDriverTable.Update();
        }

        protected int getTotalRow()
        {
            String selectAll = "SELECT COUNT(*) FROM Driver";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectAll, con);
            con.Open();
            return (int)com.ExecuteScalar();
        }

        protected void DriverReapeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblApproval = (Label)e.Item.FindControl("lblApproval");
            Label lblBdate = (Label)e.Item.FindControl("lblBdate");
            Label lblReject = (Label)e.Item.FindControl("lblReject");
            Button btnView = (Button)e.Item.FindControl("btnView");
            string approvalStatus = DataBinder.Eval(e.Item.DataItem,"Approval").ToString();
            DateTime bDate = (DateTime)DataBinder.Eval(e.Item.DataItem,"DriverBdate");
            string rejectReason = DataBinder.Eval(e.Item.DataItem,"rejectReason").ToString();

            lblBdate.Text = bDate.ToString("dd/MM/yyyy");

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

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            string approve = "UPDATE Driver SET Approval = 'A', RejectReason = @RejectReason WHERE Id = @Id";
            string rejectReason = " ";
            updateApproval(approve, rejectReason);
            Server.Transfer("driverManagement.aspx");
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
                Server.Transfer("driverManagement.aspx");
            }
        }

        protected void updateApproval(string sql, string reject)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@Id", Session["DriverID"].ToString());
            com.Parameters.AddWithValue("@RejectReason", reject);
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void ddlRejectReason_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlRejectReason.SelectedValue == "Other")
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
            if (sort == "DESC")
            {
                button.CommandArgument = "ASC";
            }
            else
            {
                button.CommandArgument = "DESC";
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
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            string search = searchBar.Text.Replace(" ", "");
            if (search == "")
            {
                loadDriverInfo();
                updateDriverTable.Update();
            }
            else
            {
                con.Open();
                SqlCommand com = new SqlCommand(selectDriver, con);
                com.Parameters.AddWithValue("@search", "%" + searchBar.Text + "%");
                SqlDataAdapter da = new SqlDataAdapter(com);
                DataSet ds = new DataSet();
                da.Fill(ds, "DriverTable");
                int row = ds.Tables["DriverTable"].Rows.Count;
                ViewState["DriverTable"] = ds.Tables["DriverTable"];
                DriverReapeter.DataSource = ds.Tables["DriverTable"];
                DriverReapeter.DataBind();
                con.Close();
                UpdatePageInfo(true, row);
            }
        }

        protected void sortCategory(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            string sort = button.CommandArgument;
            string selectDriver = " ";



            if(sort == "All")
            {
                loadDriverInfo();
                updateDriverTable.Update();
                return;
            }
            else if(sort == "P")
            {
                selectDriver = "SELECT * FROM Driver WHERE Approval = @Approval ORDER BY DateApply";
            }
            else
            {
                selectDriver = "SELECT * FROM Driver WHERE Approval = @Approval";
            }

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            if(sort != "All")
            {
                com.Parameters.AddWithValue("@Approval", sort);
            }
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "DriverTable");
            int row = ds.Tables["DriverTable"].Rows.Count;
            ViewState["DriverTable"] = ds.Tables["DriverTable"];
            DriverReapeter.DataSource = ds.Tables["DriverTable"];
            DriverReapeter.DataBind();
            con.Close();
            UpdatePageInfo(true, row);
        }
    }
}