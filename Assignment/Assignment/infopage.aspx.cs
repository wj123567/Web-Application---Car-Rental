using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Security.Cryptography.Xml;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

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

                hdnSessionId.Value = Session["Id"] as string ?? string.Empty;

                BindAddOns();

                //you
                string sortOption = Request.QueryString["sort"];
                LoadComments(sortOption);
            }
            
        }

        private void LoadComments(string sortOption)
        {
            using (var db = new SystemDatabaseEntities())
            {
                var query = from Review in db.Reviews
                            join Booking in db.Bookings on Review.BookingId equals Booking.Id
                            join ApplicationUser in db.ApplicationUsers on Booking.UserId equals ApplicationUser.Id
                            select new
                            {
                                profilePicture = ApplicationUser.ProfilePicture,
                                commentTime = Review.ReviewDate,
                                username = ApplicationUser.Username,
                                reviewText = Review.ReviewText,
                                userRating = Review.Rating
                            };
                switch (sortOption)
                {
                    case "ratingHigh":
                        query = query.OrderByDescending(c => c.userRating);
                        break;
                    case "ratingLow":
                        query = query.OrderBy(c => c.userRating);
                        break;
                    default:
                        query = query.OrderByDescending((c) => c.commentTime);
                        break;
                }

                var comments = query.ToList();
                CommentsListView.DataSource = comments;
                CommentsListView.DataBind();

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


                            
                            Session["CarName"]    = headerCarModel.Text; 
                            Session["CarImg"]     = carImage.ImageUrl;
                            
                            
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
                            Session["TotalDayRent"] = lblTotalDayRent.Text;
                            decimal carDayPrice;
                            decimal totalRentalCost;
                            if (decimal.TryParse(reader["CarDayPrice"].ToString(), out carDayPrice))
                            {
                                totalRentalCost = carDayPrice * dayDifference;
                                lblCarRental.Text = totalRentalCost.ToString("F2"); // Format as currency
                                Session["CarRental"] = lblCarRental.Text;
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


        protected void btnNext_Click(object sender, EventArgs e)
        {
 
             ScriptManager.RegisterStartupScript(this, GetType(), "showModal", " handleButtonClick();", true);
            
            
            Session["TotalPrice"] = hdnTotalPrice.Value;
            Session["TotalAddOn"] = hdnTotalAddOn.Value;

        }

        protected void previous_btn_Click(object sender, EventArgs e)
        {
            Response.Redirect("Home.aspx");
        }
       

    }
}