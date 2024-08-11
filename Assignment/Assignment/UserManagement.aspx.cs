﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
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

        protected void loadUserInfo(string selectUser)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
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
            string selectDriver = "SELECT * FROM Driver WHERE DriverName Like @search OR DriverId Like @search OR DriverPno Like @search OR DriverLicense LIKE @search";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
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
            DateTime bDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "DOB");
            DateTime regDate = (DateTime)DataBinder.Eval(e.Item.DataItem, "RegistrationDate");
            string isBan = DataBinder.Eval(e.Item.DataItem, "IsBan").ToString();

            lblBdate.Text = bDate.ToString("dd/MM/yyyy");
            lblRegDate.Text = regDate.ToString("dd/MM/yyyy");

            if(isBan == "0")
            {
                lblUserStatus.Text = "Active";
            }else if (isBan == "1") { 
                lblUserStatus.Text = "Banned";
            }
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Button btnView = (Button)sender;
            String id = btnView.CommandArgument;
            UserDriverReapeter.DataSource = null;
            UserDriverReapeter.DataBind();
            LoadAvailableUser(id);
            loadDriverInfo(id);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "loadModal()", true);
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


    }
}