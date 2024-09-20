using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class bookingRecordUpdate : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            string bookingId = Session["BookingRecordId"] as string;
            
            if (!Page.IsPostBack)
            {
                BindAddOns();
                             

                if (!string.IsNullOrEmpty(bookingId))
                {
                    // Fetch booking details from the database
                    GetRentalDetails(bookingId);

                }
            }
        }

        private void GetRentalDetails(string bookingId)
        {
           

            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                string query = "SELECT * FROM Booking WHERE Id = @BookingId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        // Populate the table with the data
                        lblBookingNumber.Text = bookingId;
                        lblPlateNum.Text = reader["CarPlate"].ToString();
                        lblPickUpLocation.Text = reader["Pickup_point"].ToString();
                        lblDropOffLocation.Text = reader["Dropoff_point"].ToString();

                        DateTime startDate = reader.GetDateTime(reader.GetOrdinal("StartDate"));
                        DateTime endDate = reader.GetDateTime(reader.GetOrdinal("EndDate"));
                        lblPickUpTime.Text =startDate.ToString("dd/MM/yyyy hh:mm:ss");
                        lblDropOffTime.Text = endDate.ToString("dd/MM/yyyy hh:mm:ss");

                    }

                }
            }
        }

        private void BindAddOns()
        {
            // Assuming you have a method GetAddOns() that returns a DataTable or List<AddOn>
            var addOns = GetAddOns();

            if (addOns.Rows.Count == 0)
            {
                // Add a row manually with "No Record Found"
                DataRow noRecordRow = addOns.NewRow();
                noRecordRow["Name"] = "No Record Found";
                
                addOns.Rows.Add(noRecordRow);
            }

            rptAddOnList.DataSource = addOns;
            rptAddOnList.DataBind();
        }
        private DataTable GetAddOns()
        {
            string bookingId= Session["BookingRecordId"].ToString();
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT * FROM AddOn a JOIN BookingAddOn b ON a.Id=b.AddOnId WHERE BookingId =@BookingId";

                SqlCommand cmd = new SqlCommand(sql, con);

                cmd.Parameters.AddWithValue("@BookingId", bookingId);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }

        }

        protected void rptAddOnList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Find the DropDownList control within the current Repeater item
                DropDownList ddlNewQuantity = (DropDownList)e.Item.FindControl("ddlNewQuantity");

                // Retrieve the maxQuantity value for this particular item
                int maxQuantity = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "maxQuantity"));

                // Populate the DropDownList with items from 1 to maxQuantity
                for (int i = 1; i <= maxQuantity; i++)
                {
                    ddlNewQuantity.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                // Optionally, set the selected value based on existing quantity
                int currentQuantity = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "Quantity"));
                ddlNewQuantity.SelectedValue = currentQuantity.ToString();
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", " modal();", true);
        }

        protected void modalYesBtn_Click(object sender, EventArgs e)
        {
            // Retrieve BookingId from session


            //update sql!!!!

            Response.Redirect("bookingrecord.aspx");
        }

    }
}