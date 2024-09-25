using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Contexts;
using System.Security.Cryptography.Xml;
using System.Text;
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
                if (Session["Id"] != null)
                {
                    string prevCar = Request.QueryString["prevCar"];
                    string currentCar = (string)Session["CarPlate"];
                    if (Request.QueryString["prevCar"] != null)
                    {
                        if (prevCar != currentCar)
                        {
                            Session["SelectedAddOns"] = null;
                        }
                    }

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

                    /*    LoadAddOnSelection();*/

                    //you

                    LoadReviewData(currentCar);

                    LoadComments(currentCar);

                    LoadActiveVouchers();

                }
                else
                {
                    Response.Redirect("~/Home.aspx");
                }
            }
                

        }



      /*  private void LoadAddOnSelection()
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
        }*/

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
                            ltrCarPlate.Text = reader["CarPlate"].ToString();
                            specType.Text = reader["CType"].ToString();
                            specSeat.Text = reader["CarSeat"].ToString() + " People";
                            carImage.ImageUrl = reader["CarImage"].ToString();
                            imgSticky.ImageUrl = reader["CarImage"].ToString();
                            specTransmission.Text = reader["CarTransmission"].ToString();
                            specFuel.Text = reader["CarEnergy"].ToString();



                            Session["CarName"] = headerCarModel.Text;
                            Session["CarImg"] = carImage.ImageUrl;


                            DateTime startDateTime = DateTime.Parse(Session["StartDate"].ToString());
                            DateTime endDateTime = DateTime.Parse(Session["EndDate"].ToString());

                          /*  // Extract only the date component
                            DateTime startDate = new DateTime(startDateTime.Year, startDateTime.Month, startDateTime.Day);
                            DateTime endDate = new DateTime(endDateTime.Year, endDateTime.Month, endDateTime.Day);*/


                            // Calculate the difference in days
                            TimeSpan dateTimeDifference = endDateTime - startDateTime;
                            
                            int dayDifference = (int)dateTimeDifference.TotalDays; 

                            if(dateTimeDifference.TotalHours %24 > 0)
                            {
                                dayDifference += 1;
                            }
                            
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


                        }

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


            //you start
            string finalDiscountString = Request.Form[hdnFinalDiscount.UniqueID];

            if (!string.IsNullOrEmpty(finalDiscountString))
            {
                // Store the discount in session
                Session["Discount"] = finalDiscountString;
            }

            string selectedValue = ddlVouchers.SelectedValue;
            int selectedVoucherId;

            if (int.TryParse(selectedValue, out selectedVoucherId))
            {
                // Store the voucher ID in the session
                Session["SelectedVoucherId"] = selectedVoucherId;

            }
            else
            {
                Debug.WriteLine("No valid voucher selected.");
            }

            //you end

            Dictionary<int, int> selectedAddOns = Session["SelectedAddOns"] as Dictionary<int, int>;


            Response.Redirect("bookInfo.aspx");
        }
       
        

    protected void previous_btn_Click(object sender, EventArgs e)
        {

            Response.Redirect("productListing.aspx?prevCar=" + ltrCarPlate.Text);
        }

        private void UpdateProgressBar(int currentStep)
        {
            // Register a script to update the progress bar client-side
            string script = $"updateProgressBar({currentStep});";
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateProgressBar", script, true);
        }



        //You
        private void LoadReviewData(string currentCar)
        {
            using (var db = new SystemDatabaseEntities())
            {

                var reviews = db.Reviews.Where(r => r.Booking.Car.CarPlate == currentCar).ToList();

                int totalReviews = reviews.Count;

                double averageRating = reviews.Any() ? (double)reviews.Average(r => r.Rating) : 0;

                int fiveStar = reviews.Count(r => r.Rating == 5);
                int fourStar = reviews.Count(r => r.Rating == 4);
                int threeStar = reviews.Count(r => r.Rating == 3);
                int twoStar = reviews.Count(r => r.Rating == 2);
                int oneStar = reviews.Count(r => r.Rating == 1);

                double fiveStarPercentage = totalReviews > 0 ? (fiveStar * 100.0) / totalReviews : 0;
                double fourStarPercentage = totalReviews > 0 ? (fourStar * 100.0) / totalReviews : 0;
                double threeStarPercentage = totalReviews > 0 ? (threeStar * 100.0) / totalReviews : 0;
                double twoStarPercentage = totalReviews > 0 ? (twoStar * 100.0) / totalReviews : 0;
                double oneStarPercentage = totalReviews > 0 ? (oneStar * 100.0) / totalReviews : 0;

                ViewState["TotalReviews"] = totalReviews;
                ViewState["FiveStarPercentage"] = fiveStarPercentage;
                ViewState["FourStarPercentage"] = fourStarPercentage;
                ViewState["ThreeStarPercentage"] = threeStarPercentage;
                ViewState["TwoStarPercentage"] = twoStarPercentage;
                ViewState["OneStarPercentage"] = oneStarPercentage;
                ViewState["FiveStarCount"] = fiveStar;
                ViewState["FourStarCount"] = fourStar;
                ViewState["ThreeStarCount"] = threeStar;
                ViewState["TwoStarCount"] = twoStar;
                ViewState["OneStarCount"] = oneStar;

                lblTotalReview.Text = $"({totalReviews} total)";

                lblAverageRating.Text = averageRating.ToString("F1");

                ScriptManager.RegisterStartupScript(this, this.GetType(), "updateStars", $"updateStarDisplay({averageRating});", true);
            }
        }
        private void LoadComments(string currentCar)
        {
            using (var db = new SystemDatabaseEntities())
            {
                var comments = db.Reviews
                                .Where(r => r.Booking.Car.CarPlate == currentCar)
                                .Select(r => new
                                {
                                    Username = r.Booking.ApplicationUser.Username,
                                    ProfilePicture = r.Booking.ApplicationUser.ProfilePicture,
                                    r.ReviewText,
                                    r.ReviewDate,
                                    r.Rating
                                })
                                .ToList();
                lvComments.DataSource = comments;
                lvComments.DataBind();
            }
        }

        protected string GetStarRating(int rating)
        {
            string stars = "";

            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                {
                    stars += "<span class='fa fa-star checked'></span>";
                }
                else
                {
                    stars += "<span class='fa fa-star'></span>";
                }
            }

            return stars;
        }

        protected void ddlFilterStar_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlFilterStar.SelectedValue;
            LoadSortedComments(selectedValue);
        }

        private void LoadSortedComments(string sortOption)
        {
            using (var db = new SystemDatabaseEntities())
            {
                string currentCar = (string)Session["CarPlate"];
                var reviewsQuery = db.Reviews.AsQueryable();

                switch (sortOption)
                {

                    case "HighToLow":
                        reviewsQuery = reviewsQuery.OrderByDescending(r => r.Rating);
                        break;
                    case "LowToHigh":
                        reviewsQuery = reviewsQuery.OrderBy(r => r.Rating);
                        break;
                    case "Recent":
                    default:
                        reviewsQuery = reviewsQuery.OrderByDescending(r => r.ReviewDate);
                        break;
                }

                var comments = reviewsQuery
                                .Where(r => r.Booking.CarPlate == currentCar)
                                .Select(r => new
                {
                    Username = r.Booking.ApplicationUser.Username,
                    ProfilePicture = r.Booking.ApplicationUser.ProfilePicture,
                    r.ReviewText,
                    r.ReviewDate,
                    r.Rating
                }).ToList();

                lvComments.DataSource = comments;
                lvComments.DataBind();

            }
        }

        private void LoadActiveVouchers()
        {
            var userId = Session["Id"]?.ToString();
            var today = DateTime.Now.Date;

            using (var db = new SystemDatabaseEntities())
            {
                var redeemedVouchers = db.Redemptions
                                        .Where(r => r.UserId == userId &&
                                                    r.IsActive == true &&
                                                    DbFunctions.TruncateTime(r.RedeemDate) == today &&
                                                    new[] { 1, 2, 3 }.Contains(r.RedeemItemId))
                                        .Select(r => new
                                        {
                                            r.RedeemItem.ItemName,
                                            r.RedeemItemId
                                        })
                                        .ToList();

                ddlVouchers.DataSource = redeemedVouchers;
                ddlVouchers.DataTextField = "ItemName";
                ddlVouchers.DataValueField = "RedeemItemId";
                ddlVouchers.DataBind();

            }

            ddlVouchers.Items.Insert(0, new ListItem("Select a Voucher", ""));
        }


        protected void ddlVouchers_SelectedIndexChanged(object sender, EventArgs e)
        {
            int selectedVoucherId;
            
            if (int.TryParse(ddlVouchers.SelectedValue, out selectedVoucherId) && selectedVoucherId > 0)
            {
                using (var db = new SystemDatabaseEntities())
                {
                    var voucher = db.RedeemItems.FirstOrDefault(v => v.RedeemItemId == selectedVoucherId);

                    if (voucher != null)
                    {
                        lblVoucherName.Text = voucher.ItemName;
                        lblVoucherDescription.Text = voucher.ItemDescription;

                        voucherDetails.Visible = true;

                        decimal rentalPrice = decimal.Parse(lblCarRental.Text);
                        decimal addOnPrice = decimal.Parse(lblAddOnPrice.Text);
                        decimal discount = 0;

                        if (voucher.RedeemItemId == 1)
                        {
                            discount = (rentalPrice + addOnPrice) * (10 / 100);
                        }
                        else if (voucher.RedeemItemId == 2)
                        {
                            discount = (rentalPrice + addOnPrice) * (20 / 100);
                        }
                        else
                        {
                            discount = (rentalPrice + addOnPrice) * (30 / 100);
                        }

                        decimal totalPrice = rentalPrice + addOnPrice - discount;

                        lblTotalPrice.Text = totalPrice.ToString("F2");
                        hdnTotalPrice.Value = totalPrice.ToString();
                        Debug.WriteLine(hdnTotalPrice.Value);

                        ScriptManager.RegisterStartupScript(this, GetType(), "UpdateTotal", "if (typeof updateTotal === 'function') { updateTotal(); }", true);

                    }
                }
            }
            else
            {
                voucherDetails.Visible = false;
                lblVoucherName.Text = "";
                lblVoucherDescription.Text = "";
                lblTotalPrice.Text = "";
            }
        }

          
        
    }

}