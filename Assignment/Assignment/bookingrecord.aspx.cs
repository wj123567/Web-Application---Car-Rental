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

        protected string GetBadgeClass(string status)
        {
            switch (status)
            {
                case "Processing":
                    return "bg-primary";
                case "Booked":
                    return "bg-success";
                case "Cancelled":
                    return "bg-danger";
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
            string selectedStatus = ddlStatusFilter.SelectedValue;
            GetBookRecords(selectedStatus);
        }


       
    }
    }
