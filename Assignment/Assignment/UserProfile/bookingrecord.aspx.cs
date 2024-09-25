using System;
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
    public partial class bookingrecord : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack) {
                string userId = Session["Id"].ToString();

                GetBookRecords("All",userId);
            }
  
        }

        private void GetBookRecords(string statusFilter, string userId)
        {
            
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT * FROM Booking b JOIN Car c ON b.CarPlate = c.CarPlate WHERE UserId = @UserId ";


                // Apply status filter if necessary
                if (statusFilter != "All")
                {
                    sql += " WHERE b.Status = @Status";
                }

                SqlCommand cmd = new SqlCommand(sql, con);
                if (Session["Id"].ToString() != null)
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
                
                
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
            int totalRow = getTotalRow(userId);
            lblTotalRecord.Text = "Total Record(s) = " + totalRow.ToString();
        }

        protected int getTotalRow(string userId)
        {
            string countRowSql = "SELECT COUNT(*) FROM Booking b JOIN Car c ON b.CarPlate = c.CarPlate WHERE UserId = @UserId";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(countRowSql, con);
            com.Parameters.AddWithValue("@UserId", userId);
            int totalRow = (int)com.ExecuteScalar();
            con.Close();
            return totalRow;
            
        }

        protected string GetBadgeClass(string status)
        {
            switch (status)
            {
                case "Pending":
                    return "bg-warning";
                case "Booked":
                    return "bg-success";
                case "Cancelled":
                    return "bg-danger";
                case "Completed":
                    return "bg-primary";
                default:
                    return "bg-default"; // Or any default class
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
            // Retrieve the Button that raised the event
            Button btnView = (Button)sender;

            // Get the ID from the CommandArgument
            string bookingId = btnView.CommandArgument;

            // Store the bookingId in session
            Session["bookingrecordID"] = bookingId;

            Response.Redirect("bookingrecorddetail.aspx");
        }

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            string userId = Session["UserId"].ToString();
            string selectedStatus = ddlStatusFilter.SelectedValue;
            GetBookRecords(selectedStatus,userId);
        }

        protected void sortReview(object sender, EventArgs e)
        {

           /* Button button = (Button)sender;
            string sort = button.CommandArgument; //u see u wan pass wat*/
            
        }
    }
    }
