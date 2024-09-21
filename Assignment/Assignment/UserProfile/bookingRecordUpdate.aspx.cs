﻿using System;
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
                    string notes = Request.QueryString["notes"];
                    // Fetch booking details from the database
                    GetRentalDetails(bookingId,notes);

                }
            }
        }

        private void GetRentalDetails(string bookingId, string notes)
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
                        txtNotes.Text = notes;
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
                //used to check whether update should be done when update btn is clicked
                hdnAddOnUpdateChk.Value = "No Record Found";
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
            //check if it is run for actual data items in repeater(odd number& alternating rows)
            //header,footer,separator exclude
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                int maxQuantity = 0;
                int currentQuantity = 0;

                // Find the DropDownList control within the current Repeater item
                DropDownList ddlNewQuantity = (DropDownList)e.Item.FindControl("ddlNewQuantity");
                Button btnAddOnClear = (Button)e.Item.FindControl("btnAddOnClear");

                object maxQuantityValue = DataBinder.Eval(e.Item.DataItem, "maxQuantity");

                if (maxQuantityValue != DBNull.Value)
                {
                    maxQuantity = Convert.ToInt32(maxQuantityValue);
                }


                // Populate the DropDownList with items from 1 to maxQuantity
                for (int i = 1; i <= maxQuantity; i++)
                {
                    ddlNewQuantity.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                object currentQuantityValue = DataBinder.Eval(e.Item.DataItem, "Quantity");

                if(currentQuantityValue != DBNull.Value)
                {
                    currentQuantity = Convert.ToInt32(DataBinder.Eval(e.Item.DataItem, "Quantity"));
                }
                    
                    ddlNewQuantity.SelectedValue = currentQuantity.ToString();
                
            }
        }
        
        protected void lkbtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("bookingrecorddetail.aspx");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showModal", " modal();", true);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string addOnId = btn.CommandArgument;
            hdnDeletingAddOnId.Value = addOnId;
            ScriptManager.RegisterStartupScript(this, GetType(), "addOnModal", "addOnmodal();", true);

        }

        protected void modalAddOnClearBtn_Click(object sender, EventArgs e)
        {

            string bookingId = Session["BookingRecordId"].ToString();

            string addOnId = hdnDeletingAddOnId.Value;

            removeAddOn(bookingId, addOnId);

            BindAddOns();
            string oriAddOnPriceQuery = Request.QueryString["oriAddOnPrice"];

            //ori add on price
            double oriAddOnPrice = Convert.ToDouble(oriAddOnPriceQuery);


        }

        protected void modalYesBtn_Click(object sender, EventArgs e)
        {
            string rentalQuery="";
            double rental = 0.00; ;
            string oriAddOnPriceQuery="";
            double oriAddOnPrice=0.00;
            double addOnPriceDiff = 0.00;
            double newAddOnTotal = 0.00;
            // Retrieve BookingId from session
            string bookingID = Session["BookingRecordId"].ToString();
            
            //retrieve url query string     
            rentalQuery = Request.QueryString["rental"];
            rental = Convert.ToDouble(rentalQuery);

            oriAddOnPriceQuery = Request.QueryString["oriAddOnPrice"];

             //ori add on price
            oriAddOnPrice = Convert.ToDouble(oriAddOnPriceQuery);
               
            Dictionary<int, int> updatedAddOns = new Dictionary<int, int>();
            if (hdnAddOnUpdateChk.Value != "No Record Found")
            {
                updatedAddOns = saveBookingAddOnRecord();
                updateBookingAddOnRecord(updatedAddOns, bookingID);
                
                if(oriAddOnPrice!= 0.00)
                {
                    //new add on price
                    newAddOnTotal = calculateNewAddOnAmt(bookingID);

                    //difference between them, and pass back to the bookingrecorddetail
                    addOnPriceDiff = oriAddOnPrice - newAddOnTotal;
                }
                
                

                //update new total in Booking table
                updateBookingRecord(bookingID, rental, newAddOnTotal);
            }
            Response.Redirect("bookingrecorddetail.aspx?addOnUpdate="+addOnPriceDiff.ToString()+"&addOnDeleteAmt="+lblDeleteAddOnAmt.Text);
        }

        private Dictionary<int,int> saveBookingAddOnRecord()
        {
            Dictionary<int, int> updatedAddOns = new Dictionary<int, int>();


            foreach (RepeaterItem item in rptAddOnList.Items)
            {
                var hdnAddOnId = (HiddenField)item.FindControl("hdnAddOnId");
                var ddlNewQuantity = (DropDownList)item.FindControl("ddlNewQuantity");

                int addOnId = int.Parse(hdnAddOnId.Value);
                int addOnQuantity = int.Parse(ddlNewQuantity.SelectedValue);

                updatedAddOns.Add(addOnId, addOnQuantity);
            }

            
            return updatedAddOns;
        }

        private void updateBookingAddOnRecord(Dictionary <int,int> updatedAddOns, string bookingID)
        {
            string sql = @"UPDATE BookingAddOn
                         SET Quantity=@Quantity
                         WHERE BookingId=@BookingID
                         AND AddOnId=@ExistingAddOnID";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);

            foreach(var addons in updatedAddOns)
            {
                int addOnId = addons.Key;
                int addOnQuantity = addons.Value;
                //clear first before next parameter adding!
                cmd.Parameters.Clear();
                cmd.Parameters.AddWithValue("@ExistingAddOnID", addOnId);
                cmd.Parameters.AddWithValue("@Quantity",addOnQuantity);
                cmd.Parameters.AddWithValue("@BookingID", bookingID);      
                cmd.ExecuteNonQuery();
            }
            con.Close();
        }

        private void updateBookingRecord(string bookingID, double rental, double newAddOnPrice)
        {
            double totalPrice = 0.00;
            if (newAddOnPrice > 0.00)
            {
                totalPrice = rental + newAddOnPrice;
            }
            else
            {
                totalPrice = rental;
            }
             
            string sql = @"UPDATE Booking
                           SET FinalPrice =@FinalPrice,
                           Notes = @Notes
                           WHERE Id = @BookingID";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand (sql, con);
            cmd.Parameters.AddWithValue("@FinalPrice", totalPrice);
            cmd.Parameters.AddWithValue("@BookingID", bookingID);
            cmd.Parameters.AddWithValue("@Notes", txtNotes.Text);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        private double calculateNewAddOnAmt(string bookingID)
        {
            double newAddOn = 0.0;
            string sql = @"SELECT Price,Quantity
                          FROM AddOn a JOIN BookingAddOn b
                          ON a.Id = b.AddOnId
                          WHERE BookingId = @BookingID";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(sql,con);
            cmd.Parameters.AddWithValue("@BookingID", bookingID);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    double price =Convert.ToDouble(reader["Price"].ToString());
                    int quantity = Convert.ToInt16(reader["Quantity"].ToString());
                    newAddOn += price * quantity;
                }
            }
            con.Close();
            return newAddOn;
        }

        private void removeAddOn(string bookingId,string addOnId)
        {
         string deletesql = @"DELETE FROM BookingAddOn
                          WHERE BookingId = @BookingID
                          AND AddOnId=@AddOnID";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(deletesql,con);
            cmd.Parameters.AddWithValue("@BookingID", bookingId);
            cmd.Parameters.AddWithValue("@AddOnID", addOnId);
            cmd.ExecuteNonQuery();
            con.Close();
           
        }

      /*  private double calculateRemoveAmt(string bookingId, string addOnId)
        {
            double totalPrice = 0.00;
            string sql = @"SELECT Price,Quantity
                           FROM AddOn a JOIN BookingAddOn b
                           ON a.Id = b.AddOnId
                           WHERE BookingId = @BookingID
                           AND AddOnId = @AddOnID";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@BookingID", bookingId);
            cmd.Parameters.AddWithValue("@AddOnID", addOnId);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    double price = Convert.ToDouble(reader["Price"].ToString());
                    int quantity = Convert.ToInt16(reader["Quantity"].ToString());
                    totalPrice = price * quantity;
                }

            }
            con.Close();
            return totalPrice;
        }*/
    }
}