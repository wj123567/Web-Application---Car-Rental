using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Security.Cryptography.Xml;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Assignment
{
	public partial class infopage :System .Web.UI.Page
	{
        protected void Page_Load(object sender, EventArgs e)
		{
            
            if (!Page.IsPostBack)
            {
                string prevCar = Request.QueryString["prevCar"];
                string currentCar = (string)Session["CarPlate"]; 
                if (Request.QueryString["prevCar"] != null){
                    if (prevCar != currentCar)
                    {
                        Session["SelectedAddOns"] = null;
                    }
                }
                lblCheck.Text = Session["BookingID"].ToString();
                Session["CurrentStep"] = 2;
                int currentStep = (int)(Session["CurrentStep"]);
                UpdateProgressBar(currentStep);
                if (Session["CarPlate"] != null)
                {
                 
                    string carPlate = Session["CarPlate"].ToString();

                    // Assuming you have a method to get car details by carPlate
                    GetCarDetailsByCarPlate(carPlate);
                    
                }

                hdnSessionId.Value = Session["Id"] as string ?? string.Empty;
                
                BindAddOns();

                LoadAddOnSelection();
                
                //you
                string sortOption = Request.QueryString["sort"];
                LoadComments(sortOption);
            }
            
        }

        private void LoadAddOnSelection()
        {
            if (Session["SelectedAddOns"] != null)
            {
                var selectedAddOns = (Dictionary<int, int>)Session["SelectedAddOns"];
                

                foreach (RepeaterItem item in rptAddOns.Items)
                {
                    // Find the Label control within the RepeaterItem
                    Label lblTotalAddOn = item.FindControl("lblTotalAddOn") as Label;

                    var txtQuantity = (TextBox)item.FindControl("txtAddOnQuantity");
                    var hfAddOnID = (HiddenField)item.FindControl("hfAddOnID");

                    int addOnID = int.Parse(hfAddOnID.Value);
                    if (selectedAddOns.ContainsKey(addOnID))
                    {
                        txtQuantity.Text = selectedAddOns[addOnID].ToString();
                    }
                    
                }


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

        public string GetStarRating(int rating)
        {

            // Create the star rating HTML
            StringBuilder sb = new StringBuilder();
            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                {
                    sb.Append("<span class='fa fa-star' style='color: orange;'></span>"); // Filled star
                }
                else
                {
                    sb.Append("<span class='fa fa-star' style='color: lightgray;'></span>"); // Empty star
                }
            }
            return sb.ToString();
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
                            ltrCarPlate.Text =reader["CarPlate"].ToString();
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

        private void SaveAddOnSelection()
        {
            Dictionary<int, int> selectedAddOns = new Dictionary<int, int>();
            

            foreach (RepeaterItem item in rptAddOns.Items)
            {
                var txtQuantity = (TextBox)item.FindControl("txtAddOnQuantity");
                
                var hfAddOnID = (HiddenField)item.FindControl("hfAddOnID");

                int quantity = int.Parse(txtQuantity.Text);
                
                int addOnID = int.Parse(hfAddOnID.Value);

                if (quantity > 0)
                {
                    selectedAddOns.Add(addOnID, quantity);
                    
                }
            }

            Session["SelectedAddOns"] = selectedAddOns;
           
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            SaveAddOnSelection();

            int currentStep = (int)(Session["CurrentStep"] ?? 1);
            currentStep = Math.Min(currentStep + 1, 4);
            Session["CurrentStep"] = currentStep;
            UpdateProgressBar(currentStep);

            Session["TotalPrice"] = hdnTotalPrice.Value;
            Session["TotalAddOn"] = hdnTotalAddOn.Value;
            
            Response.Redirect("bookInfo.aspx");
        }

        protected void previous_btn_Click(object sender, EventArgs e)
        {
            
            Response.Redirect("productListing.aspx?prevCar="+ltrCarPlate.Text);
        }

        private void UpdateProgressBar(int currentStep)
        {
            // Register a script to update the progress bar client-side
            string script = $"updateProgressBar({currentStep});";
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateProgressBar", script, true);
        }
    }
}