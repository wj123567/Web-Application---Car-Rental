using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
	public partial class infopage : System.Web.UI.Page
	{
       
  
 
        protected void Page_Load(object sender, EventArgs e)
		{
            if (!Page.IsPostBack)
            {
                if (Session["CarPlate"] != null)
                {
                    string carPlate = Session["CarPlate"].ToString();

                    // Assuming you have a method to get car details by carPlate
                    GetCarDetailsByCarPlate(carPlate);
                    
                }
                BindAddOns();
            }
            
        }

        public void GetCarDetailsByCarPlate(string carPlate)
        {
          
            // Define your SQL query
            string query = "SELECT * FROM Car WHERE CarPlate = @CarPlate";

            // Assuming you're using ADO.NET for database access
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                SqlCommand command = new SqlCommand(query, con);
                command.Parameters.AddWithValue("@CarPlate", carPlate);

                con.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        
                        {   
                            headerCarModel.Text = reader["CarBrand"].ToString() + " " + reader["CarName"].ToString();
                            lblstickyCarModel.Text = reader["CarBrand"].ToString() + " " + reader["CarName"].ToString();
                            ltrCarPlate.Text="Plate Number: "+reader["CarPlate"].ToString();
                            specType.Text = reader["CType"].ToString();
                            specSeat.Text = reader["CarSeat"].ToString() +" People";
                            carImage.ImageUrl = reader["CarImage"].ToString();
                            imgSticky.ImageUrl = reader["CarImage"].ToString();
                            specTransmission.Text = reader["CarTransmission"].ToString();
                            specFuel.Text = reader["CarEnergy"].ToString();

                            DateTime startDateTime = DateTime.Parse(Session["StartDate"].ToString());
                            DateTime endDateTime = DateTime.Parse(Session["EndDate"].ToString());

                            // Extract only the date component
                            DateTime startDate = new DateTime(startDateTime.Year, startDateTime.Month, startDateTime.Day);
                            DateTime endDate = new DateTime(endDateTime.Year, endDateTime.Month, endDateTime.Day);

                            // Calculate the difference in days
                            TimeSpan dateDifference = endDate - startDate;
                            int dayDifference = dateDifference.Days; // This will be 3

                            //the total car rental
                            lblTotalDayRent.Text = dayDifference.ToString() + " Days";

                            decimal carDayPrice;
                            decimal totalRentalCost;
                            if (decimal.TryParse(reader["CarDayPrice"].ToString(), out carDayPrice))
                            {
                                totalRentalCost = carDayPrice * dayDifference;
                                lblCarRental.Text = totalRentalCost.ToString("F2"); // Format as currency
                            }
                            else
                            {
                                lblCarRental.Text = "Price not available";
                            }
                            
                            
                        };
                        
                    }
                }

                reader.Close();
                con.Close();
            }
              
          
        }

        private void BindAddOns()
        {
            // Assuming you have a method GetAddOns() that returns a DataTable or List<AddOn>
            var addOns = GetAddOns();

            rptAddOns.DataSource = addOns;
            rptAddOns.DataBind();
        }

        private DataTable GetAddOns()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "SELECT Id,Name, Description, Price, Url, MaxQuantity FROM AddOn";

                SqlDataAdapter da = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        protected void ProcessQuantities()
        {

            string bookID = Session["BookingID"].ToString();
            foreach (RepeaterItem item in rptAddOns.Items)
            {
                // Find the TextBox and HiddenField controls
                TextBox txtQuantity = item.FindControl("txtAddOnQuantity") as TextBox;
                

                //for insert
                HiddenField hfAddOnID = item.FindControl("hfAddOnID") as HiddenField;
                if (txtQuantity !=null && hfAddOnID != null)
                {
                    int quantity;
                    int addOnID;

                    // Try to parse the values
                    if (int.TryParse(txtQuantity.Text, out quantity) && int.TryParse(hfAddOnID.Value, out addOnID))
                    {
                        
                        //got only insert, no ignore
                        if (quantity > 0)
                        {
                            string sql = "INSERT INTO BookingAddOn(BookingId,AddOnId, Quantity) VALUES(@BookingId,@AddOnId,@Quantity)";
                            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                            SqlCommand cmd = new SqlCommand(sql, con);
                            cmd.Parameters.AddWithValue("@BookingId", bookID);
                            cmd.Parameters.AddWithValue("@AddOnId", addOnID);
                            cmd.Parameters.AddWithValue("@Quantity", quantity);

                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();

                            // Example: Add to a total price (assuming you have the price information)
                            // decimal price = GetPriceForAddOn(addOnID);
                            // total += price * quantity;
                        }
                    }
                }
            }

            // Update your label or process the total price accordingly
            // lblTotalPrice.Text = total.ToString("F2");
        }
        protected void btnNext_Click(object sender, EventArgs e)
        {
            Session["CarRental"] = lblCarRental.Text;
            Session["CarName"] = headerCarModel.Text;
            Session["TotalDayRent"] = lblTotalDayRent.Text;
            Session["TotalPrice"] = hdnTotalPrice.Value;
            Session["TotalAddOn"] = hdnTotalAddOn.Value;
            Session["CarImg"] = carImage.ImageUrl;
            ProcessQuantities();
            Server.Transfer("bookinfo.aspx");
        }

        protected void previous_btn_Click(object sender, EventArgs e)
        {
            Server.Transfer("Home.aspx");
        }
    }
}