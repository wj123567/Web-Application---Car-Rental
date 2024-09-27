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
                
                GetBookRecords("All",userId,"" ,"", "");
            }
  
        }

        protected void btnFilterBookingDate_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            string commandName = button.CommandName;
            string userId = Session["Id"].ToString();
            
            string filterStartDate = txtFilterStartDate.Text;
            string filterEndDate = txtFilterEndDate.Text;

            GetBookRecords("All", userId, commandName ,filterStartDate, filterEndDate);
            //refresh pagination
            ScriptManager.RegisterStartupScript(this, GetType(), "refreshPagination", "initializePagination();", true);
            int totalRow = getTotalRow(userId, "All", commandName, filterStartDate, filterEndDate);
            lblTotalRecord.Text = "Total Record(s) = " + totalRow.ToString();

        }
      


        protected void btnFilterPickUpDate_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            string commandName = button.CommandName;

            string userId = Session["Id"].ToString();
            string filterStartDate = txtFilterStartDate.Text;
            string filterEndDate = txtFilterEndDate.Text;
            
            GetBookRecords("All", userId, commandName, filterStartDate, filterEndDate);
            //refresh pagination
            ScriptManager.RegisterStartupScript(this, GetType(), "refreshPagination", "initializePagination();", true);
            int totalRow = getTotalRow(userId, "All", commandName, filterStartDate, filterEndDate);
            lblTotalRecord.Text = "Total Record(s) = " + totalRow.ToString();

        }

        protected void btnClearFilter_Click(object sender, EventArgs e)
        {
            string userId = Session["Id"].ToString();
            GetBookRecords("All", userId,"" ,"", "");
            //refresh pagination
            ScriptManager.RegisterStartupScript(this, GetType(), "refreshPagination", "initializePagination();", true);
        }

        private void GetBookRecords(string statusFilter, string userId, string filterType, string filterStartDate, string filterEndDate)
        {
            
            int totalRow;
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT * FROM Booking b JOIN Car c ON b.CarPlate = c.CarPlate WHERE UserId = @UserId ";


                // Apply status filter if necessary
                if (statusFilter != "All")
                {
                    sql += " AND b.Status = @Status";
                }
          
                if(filterType == "BookingDate")
                {
                    sql += " AND BookingDate BETWEEN @FilterStartDate AND DATEADD(day,1,@FilterEndDate)";

                }
                else if(filterType == "PickUpDate")
                {
                    sql += " AND StartDate BETWEEN @FilterStartDate AND DATEADD(day,1,@FilterEndDate)";
                }
               

                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@UserId", userId);
              
                
                
                if (statusFilter != "All")
                {
                    cmd.Parameters.AddWithValue("@Status", statusFilter);
                }

                if (filterStartDate != "" && filterEndDate != "")
                {
                    cmd.Parameters.AddWithValue("@FilterStartDate", filterStartDate);
                    cmd.Parameters.AddWithValue("@FilterEndDate", filterEndDate);
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
       
           if(filterStartDate=="" && filterStartDate == "")
            {
                totalRow = getTotalRow(userId, "All","" ,"", "");
                lblTotalRecord.Text = "Total Record(s) = " + totalRow.ToString();
            }
                  
        }

        private void updateFinalPrice(string userId)
        {
            
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();

        }

       

        protected int getTotalRow(string userId,string statusFilter,string filterType ,string filterStartDate , string filterEndDate)
        {
            string countRowSql = "SELECT COUNT(*) FROM Booking b JOIN Car c ON b.CarPlate = c.CarPlate WHERE UserId = @UserId";
            if (statusFilter != "All")
            {
                countRowSql += " AND b.Status = @Status";
            }

            if (filterType == "BookingDate")
            {
                countRowSql += " AND BookingDate BETWEEN @FilterStartDate AND DATEADD(day,1,@FilterEndDate)";

            }
            else if (filterType == "PickUpDate")
            {
                countRowSql += " AND StartDate BETWEEN @FilterStartDate AND DATEADD(day,1,@FilterEndDate)";
            }

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(countRowSql, con);
            com.Parameters.AddWithValue("@UserId", userId);

            if (statusFilter != "All")
            {
                com.Parameters.AddWithValue("@Status", statusFilter);
            }

            if (filterStartDate != "" && filterEndDate != "")
            {
                com.Parameters.AddWithValue("@FilterStartDate", filterStartDate);
                com.Parameters.AddWithValue("@FilterEndDate", filterEndDate);
            }
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
            string userId = Session["Id"].ToString();
            string selectedStatus = ddlStatusFilter.SelectedValue;
            GetBookRecords(selectedStatus,userId,"","", "");
            //refresh searching
            string searchBoxID = txtBookingSearch.ClientID;
            string searchScript = $"setupSearchFunctionality({searchBoxID});";
            ScriptManager.RegisterStartupScript(this, GetType(), "refreshSearching", searchScript, true);
            //refresh pagination
            ScriptManager.RegisterStartupScript(this, GetType(), "refreshPagination", "initializePagination();", true);

            int totalRow = getTotalRow(userId,selectedStatus,"" ,"", "");
            lblTotalRecord.Text = "Total Record(s) = " + totalRow.ToString();
        }

        protected void sortReview(object sender, EventArgs e)
        {

           /* Button button = (Button)sender;
            string sort = button.CommandArgument; //u see u wan pass wat*/
            
        }
    }
    }
