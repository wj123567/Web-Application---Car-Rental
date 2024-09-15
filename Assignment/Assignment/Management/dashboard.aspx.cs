using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;

namespace Assignment.Management
{
    public partial class dashboard : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                /*loadDataofLineChart();*/
            }
        }

        private void loadTopRental()
        {
            string select = @"SELECT TOP 5 COUNT(B.CarPlate) AS RentalCount, MAX(C.CarImage) AS Image, SUM(C.CarDayPrice) AS Price, SUM(B.Price) AS TotalRevenue, (C.CarBrand + ' ' + C.CarName) AS CarName FROM [Car] C JOIN [Booking] B ON C.CarPlate = B.CarPlate WHERE B.Status NOT IN ('Cancelled') GROUP BY C.CarBrand, C.CarName ORDER BY COUNT(B.CarPlate) DESC";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(select, con);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();            
            da.Fill(ds, "TopData");
            con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                noCarPlaceholder.Visible = false;
                rptTopRental.DataSource = ds.Tables["TopData"];
                rptTopRental.DataBind();
                UpdatePanel1.Update();
            }
            else
            {
                rptTopRental.DataSource = ds.Tables["TopData"];
                rptTopRental.DataBind();
                UpdatePanel1.Update();
                noCarPlaceholder.Visible = true;
            }
            
        }

        protected void btnAllTopRental_Click(object sender, EventArgs e)
        {
            loadTopRental();
        }

        protected void btnTopDateFilter_Click(object sender, EventArgs e)
        {
            DateTime startDate = DateTime.Parse(hdnTopRentalStart.Value);
            DateTime endDate = DateTime.Parse(hdnTopRentalEnd.Value);
            string select = @"SELECT TOP 5 COUNT(B.CarPlate) AS RentalCount, MAX(C.CarImage) AS Image, AVG(C.CarDayPrice) AS Price, SUM(B.Price) AS TotalRevenue, (C.CarBrand + ' ' + C.CarName) AS CarName FROM [Car] C  JOIN [Booking] B ON C.CarPlate = B.CarPlate WHERE (B.StartDate BETWEEN @StartDate AND @EndDate) AND B.Status NOT IN ('Cancelled') GROUP BY C.CarBrand, C.CarName ORDER BY COUNT(B.CarPlate) DESC";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(select, con);
            con.Open();
            com.Parameters.AddWithValue("@StartDate", startDate);
            com.Parameters.AddWithValue("@EndDate", endDate);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "TopData");
            con.Close();

            if (ds.Tables[0].Rows.Count > 0)
            {
                noCarPlaceholder.Visible = false;
                rptTopRental.DataSource = ds.Tables["TopData"];
                rptTopRental.DataBind();
                UpdatePanel1.Update();
            }
            else
            {
                rptTopRental.DataSource = ds.Tables["TopData"];
                rptTopRental.DataBind();
                UpdatePanel1.Update();
                noCarPlaceholder.Visible = true;
            }

        }

        [WebMethod] //Declare this for the ajax call
        public static string getCarCategory()
        {
            string select = @"SELECT C.CType as CarType, count(B.CarPlate) as CarCount FROM Car C JOIN Booking B ON C.CarPlate = B.CarPlate WHERE B.Status NOT IN ('Cancelled') GROUP BY C.CType";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            DataTable dt = new DataTable();
            SqlCommand com = new SqlCommand(select, con);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(com);
            da.Fill(dt);

            string jsonData = JsonConvert.SerializeObject(dt);
            return jsonData;
        }

        [WebMethod] //Declare this for the ajax call
        public static string filterCategory(string start, string end)
        {
            DateTime startDate = DateTime.Parse(start);
            DateTime endDate = DateTime.Parse(end);
            string select = @"SELECT C.CType as CarType, count(B.CarPlate) as CarCount FROM Car C JOIN Booking B ON C.CarPlate = B.CarPlate WHERE (B.StartDate BETWEEN @StartDate AND @EndDate) AND B.Status NOT IN ('Cancelled') GROUP BY C.CType";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            DataTable dt = new DataTable();
            SqlCommand com = new SqlCommand(select, con);
            con.Open();
            com.Parameters.AddWithValue("@StartDate", startDate);
            com.Parameters.AddWithValue("@EndDate", endDate);
            SqlDataAdapter da = new SqlDataAdapter(com);
            da.Fill(dt);

            string jsonData = JsonConvert.SerializeObject(dt);
            return jsonData;
        }

        protected void btnCustRecord_Click(object sender, EventArgs e)
        {
            DateTime dateFrom = new DateTime();
            DateTime dateTo = new DateTime();
            if (hdnTimeFilter_cust.Value == "Custom")
            {
                dateFrom = DateTime.Parse(txtStartDate_cust.Text);
                dateTo = DateTime.Parse(txtEndDate_cust.Text);
            }
            string timeFilter = ddlTimeFilter_cust.SelectedValue;

            loadTopCust(dateFrom,dateTo,timeFilter);
        }

        private void loadTopCust(DateTime dateFrom,DateTime dateTo,string timeFilter)
        {
            string query = "";
            /*string sql = @"SELECT TOP 1 a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                         FROM ApplicationUser a JOIN Booking b
                         ON a.Id = b.UserId
                         GROUP BY a.ProfilePicture,a.Username,a.Email";*/
                         
            switch (timeFilter)
            {
                case "Day":
                    query = @"SELECT a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                              FROM ApplicationUser a JOIN Booking b
                              ON a.Id = b.UserId
                              WHERE CONVERT(DATE, BookingDate) = CONVERT(DATE, GETDATE())  -- Filter by current date
                              GROUP BY a.ProfilePicture,a.Username,a.Email 
                              ORDER BY TotalPrice DESC";     
                    break;
                case "Week":
                    string weekFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                              DECLARE @StartOfWeek DATE = DATEADD(DAY, -DATEPART(WEEKDAY, @CurrentDate) + 1, @CurrentDate) 
                              DECLARE @EndOfWeek DATE = DATEADD(DAY, 7 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate) ";//start - Sunday , end-Saturday 

                    query = weekFilter
                      + @"SELECT a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                              FROM ApplicationUser a JOIN Booking b
                              ON a.Id = b.UserId
                              WHERE BookingDate >= @StartOfWeek AND BookingDate < DATEADD(DAY, 1, @EndOfWeek)
                              GROUP BY a.ProfilePicture,a.Username,a.Email
                              ORDER BY TotalPrice DESC";

                    
                    break;
                case "Month":
                    string monthFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                                           DECLARE @StartOfMonth DATE = DATEADD(DAY, -DAY(@CurrentDate) + 1, @CurrentDate)
                                           DECLARE @EndOfMonth DATE = EOMONTH(@CurrentDate)";

                    query = monthFilter
                            + @"SELECT a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE BookingDate BETWEEN @StartOfMonth AND @EndOfMonth
                            GROUP BY a.ProfilePicture,a.Username,a.Email 
                            ORDER BY TotalPrice DESC";



                    
                    break;
                case "Quarter":
                    query = @"SELECT a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE YEAR(BookingDate) = YEAR(CONVERT(DATE, GETDATE()))
                            AND DATEPART(QUARTER,b.BookingDate) = DATEPART(QUARTER,(CONVERT(DATE, GETDATE())))
                            GROUP BY a.ProfilePicture, a.Username, a.Email
                            ORDER BY TotalPrice DESC";
                   
                    break;
                case "Year":
                    query = @"SELECT a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE BookingDate IS NOT NULL  
                            AND YEAR(BookingDate) = YEAR(CONVERT(DATE, GETDATE()))
                            GROUP BY a.ProfilePicture, a.Username, a.Email
                            ORDER BY TotalPrice DESC";
                    
                    break;

                case "Custom":

                    query = @"SELECT a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                             FROM ApplicationUser a JOIN Booking b
                             ON a.Id = b.UserId
                             WHERE BookingDate IS NOT NULL
                             AND BookingDate BETWEEN @StartDate AND @EndDate
                             GROUP BY a.ProfilePicture, a.Username, a.Email
                             ORDER BY TotalPrice DESC ";
                   
                    break;
            }
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(query, con);

            if (timeFilter == "Custom")
            {
                cmd.Parameters.AddWithValue("@StartDate", dateFrom);
                cmd.Parameters.AddWithValue("@EndDate", dateTo);
            }
            
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "TopData");
            con.Close();
            if (ds.Tables[0].Rows.Count > 0)
            {
                rptTopCustRental.DataSource = ds.Tables["TopData"];
                rptTopCustRental.DataBind();
                updateTopCust.Update();

                noCarPlaceholder.Visible = false;
                lblTopUser.Visible = true;
                txtTopUser.Visible=true;
            }
            else
            {
                rptTopRental.DataSource = ds.Tables["TopData"];
                rptTopRental.DataBind();         
                updateTopCust.Update();

                noCarPlaceholder.Visible = true;
               
            }
            
            con.Close();
        }

        protected void btnBookRecord_Click(object sender, EventArgs e)
        {
            DateTime dateFrom = new DateTime();
            DateTime dateTo = new DateTime();
            if(hdnTimeFilter.Value == "Custom")
            {
               dateFrom = DateTime.Parse(txtStartDate.Text);
               dateTo = DateTime.Parse(txtEndDate.Text);
            }
           
            string timeFilter = ddlTimeFilter.SelectedValue;

            loadDataofLineChart(dateFrom, dateTo, timeFilter);
        }

        public void loadDataofLineChart(DateTime dateFrom, DateTime dateTo, string timeFilter)
        {
            lblCheck.Text = hdnTimeFilter.Value;
            string dateFromTitleFormat = dateFrom.ToString("dd/MM/yyyy");
            string dateToTitleFormat = dateTo.ToString("dd/MM/yyyy");

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            string query = "";
            string xAxisTitle = "";
            string categories = "";
            string lineRecordData = "";
            string lineAmtData = "";
            List<string> categoryList = new List<string>();
            StringBuilder lineBuilder = new StringBuilder("[");
            StringBuilder lineAmtBuilder = new StringBuilder("[");

            switch (timeFilter)
            {
                case "Day":
                    query = @"SELECT DATEPART(HOUR, BookingDate) AS Hour , COUNT(*) AS BookingCount, SUM(Price) AS BookingAmount
                      FROM Booking 
                      WHERE CONVERT(DATE, BookingDate) = CONVERT(DATE, GETDATE())  -- Filter by current date
                      GROUP BY DATEPART(HOUR, BookingDate)
                      ORDER BY DATEPART(HOUR, BookingDate)";
                    xAxisTitle = "Hours in 24-hour system";
                    break;
                case "Week":
                    string weekFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                              DECLARE @StartOfWeek DATE = DATEADD(DAY, -DATEPART(WEEKDAY, @CurrentDate) + 1, @CurrentDate) 
                              DECLARE @EndOfWeek DATE = DATEADD(DAY, 7 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate) ";//start - Sunday , end-Saturday 

                            query = weekFilter
                              + @"SELECT CONVERT(VARCHAR, BookingDate, 101) AS DatePerWeek, COUNT(*) AS BookingCount, SUM(Price) AS BookingAmount
                              FROM Booking 
                              WHERE BookingDate >= @StartOfWeek AND BookingDate < DATEADD(DAY, 1, @EndOfWeek)
                              GROUP BY CONVERT(VARCHAR, BookingDate, 101)  -- Group by day
                              ORDER BY CONVERT(VARCHAR, BookingDate, 101)  -- Sort by formatted date";

                    xAxisTitle = "Date of The Week";
                    break;
                case "Month":
                    string monthFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                                           DECLARE @StartOfMonth DATE = DATEADD(DAY, -DAY(@CurrentDate) + 1, @CurrentDate)
                                           DECLARE @EndOfMonth DATE = EOMONTH(@CurrentDate)";

                    query = monthFilter 
                            + @"SELECT CONVERT(VARCHAR, BookingDate, 103) AS BookingDate, COUNT(*) AS BookingCount, SUM(Price) AS BookingAmount
                            FROM Booking
                            WHERE BookingDate BETWEEN @StartOfMonth AND @EndOfMonth
                            GROUP BY CONVERT(VARCHAR, BookingDate, 103)
                            ORDER BY BookingDate";



                    xAxisTitle = "Day of The Month";
                    break;
                case "Quarter":
                    query = @"SELECT YEAR(BookingDate) AS Year, DATEPART(QUARTER, BookingDate) AS Quarter, COUNT(*) AS BookingCount ,SUM(Price) AS BookingAmount
                            FROM Booking 
                            WHERE BookingDate IS NOT NULL  
                            GROUP BY YEAR(BookingDate), DATEPART(QUARTER, BookingDate)
                            ORDER BY YEAR(BookingDate), DATEPART(QUARTER, BookingDate)";
                    xAxisTitle = "Quarter";
                    break;
                case "Year":
                    query = @"SELECT YEAR(BookingDate) AS Year, FORMAT(BookingDate,'MMM') AS Month, COUNT(*) AS BookingCount, SUM(Price) AS BookingAmount
                            FROM Booking 
                            WHERE BookingDate IS NOT NULL  
                            GROUP BY YEAR(BookingDate), FORMAT(BookingDate, 'MMM')
                            ORDER BY YEAR(BookingDate), FORMAT(BookingDate, 'MMM')";
                    xAxisTitle = "Month of The Year";
                    break;

                case "Custom":

                    query = @"WITH BookingCTE AS (
                                SELECT 
                                    YEAR(BookingDate) AS Year,
                                    MONTH(BookingDate) AS Month,
                                    DAY(BookingDate) AS Day,
                                    FORMAT(BookingDate, 'MMM') AS MonthABC,
                                    Price
                                FROM 
                                    Booking
                                WHERE  
                                    BookingDate >= @StartDate 
                                    AND BookingDate <= @EndDate
                            )
                            SELECT Year, Month, MonthABC,COUNT(*) AS BookingCount, SUM(Price) AS BookingAmount
                             FROM BookingCTE
                             GROUP BY Year, Month, MonthABC 
                             ORDER BY Year, Month ";

                    xAxisTitle = "Custom Date Range From " + dateFromTitleFormat + " to "+ dateToTitleFormat;
                    break;
            }


            SqlCommand cmd = new SqlCommand(query, con);
            

            if (timeFilter == "Custom")
            {
                cmd.Parameters.AddWithValue("@StartDate", dateFrom);
                cmd.Parameters.AddWithValue("@EndDate", dateTo);
            }

   
            DataTable dtBooking = new DataTable();
            dtBooking.Load(cmd.ExecuteReader());

            gvBooking.DataSource = dtBooking;
            gvBooking.DataBind();

            //start population to the line graph(data format in [ [x1,y1],[x2,y2],...]
           
            foreach (DataRow dr in dtBooking.Rows)
            {

                switch (timeFilter)
                {
                    case "Day":
                        lineBuilder.Append($"[\"{dr["Hour"]}\",{dr["BookingCount"]}],");
                        string hourFormat = dr["Hour"].ToString() + ":00";
                        lineAmtBuilder.Append($"[\"{dr["Hour"]}\",{dr["BookingAmount"]}],");
                        categoryList.Add(hourFormat);
                        break;
                    case "Week":
                        /*string date = dr["DatePerWeek"].ToString();*/
                        lineBuilder.Append($"[\"{dr["DatePerWeek"]}\",{dr["BookingCount"]}],");
                        categoryList.Add(dr["DatePerWeek"].ToString());
                        lineAmtBuilder.Append($"[\"{dr["DatePerWeek"]}\",{dr["BookingAmount"]}],");
                        break;
                    case "Month":
                        lineBuilder.Append($"[\"{dr["BookingDate"]}\",{dr["BookingCount"]}],");
                        categoryList.Add(dr["BookingDate"].ToString());
                        lineAmtBuilder.Append($"[\"{dr["BookingDate"]}\",{dr["BookingAmount"]}],");
                        break;
                    case "Quarter":
                        lineBuilder.Append($"[\"{dr["Quarter"]}\",{dr["BookingCount"]}],");
                        string quarterFormat = dr["Quarter"].ToString();
                        lineAmtBuilder.Append($"[\"{dr["Quarter"]}\",{dr["BookingAmount"]}],");
                        switch (quarterFormat)
                        {
                            case "1":
                                categoryList.Add("Q1");
                                break;

                            case "2":
                                categoryList.Add("Q2");
                                break;

                            case "3":
                                categoryList.Add("Q3");
                                break;

                            case "4":
                                categoryList.Add("Q4");
                                break;
                        }
                        break;
                    case "Year":
                        lineBuilder.Append($"[\"{dr["Month"]}\",{dr["BookingCount"]}],");
                        lineAmtBuilder.Append($"[\"{dr["Month"]}\",{dr["BookingAmount"]}],");
                        categoryList.Add(dr["Month"].ToString());
                        break;

                    case "Custom":
                        lineBuilder.Append($"[\"{dr["MonthABC"]}\",{dr["BookingCount"]}],");
                        lineAmtBuilder.Append($"[\"{dr["MonthABC"]}\",{dr["BookingAmount"]}],");
                        categoryList.Add(dr["MonthABC"].ToString());
                        break;
                }

            }

           

            // Remove the last comma and close the JSON array
            if (lineBuilder.Length > 1)
                lineBuilder.Length--; // Remove trailing comma
            if(lineAmtBuilder.Length > 1)
                lineAmtBuilder.Length--;

            lineBuilder.Append("]");
            lineAmtBuilder.Append("]");

            lineRecordData = lineBuilder.ToString();
            lineAmtData = lineAmtBuilder.ToString();
            categories = string.Join(",", categoryList.Select(c => $"'{c}'"));


            // Inject the lineData and JavaScript into the page
            string script = $"renderBookingRecordChart({lineRecordData},'{xAxisTitle}',[{categories}]);"; // Pass the data to JavaScript function
            string script2 = $"renderBookingAmtChart({lineAmtData},'{xAxisTitle}',[{categories}]);"; // Pass the data to JavaScript function

            ClientScript.RegisterStartupScript(this.GetType(), "renderBookingRecordScript", script, true);
            ClientScript.RegisterStartupScript(this.GetType(), "renderBookingAmtScript", script2, true);

            con.Close();
        }
    }
}