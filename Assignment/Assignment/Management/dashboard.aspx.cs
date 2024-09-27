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
                loadVisitorState();

                //you
                loadTopUsers(); 
            }
        }

        //you start
        private void loadTopUsers()
        {
            using (var db = new SystemDatabaseEntities())
            {
                var topFiveUser = db.ApplicationUsers
                                    .OrderByDescending(u => u.RewardPoints)
                                    .Select(user => new
                                    {
                                        Username = user.Username,
                                        RewardPoints = user.RewardPoints,
                                        ProfilePic = user.ProfilePicture
                                    })
                                    .Take(5)
                                    .ToList();
                lvTopFiveUser.DataSource = topFiveUser;
                lvTopFiveUser.DataBind();       
            }
        }
        //you end
        private void loadVisitorState()
        {
            try
            {
            lblVisitor.Text = Application["VisitorCount"].ToString();
            lblVisitorDate.Text += DateTime.Parse(Application["LastVisitDate"].ToString()).ToString("dd/MM/yyyy");
            lblActiveUser.Text = Application["ActiveUsers"].ToString();
            lblActiveDate.Text += DateTime.Parse(Application["ActiveDate"].ToString()).ToString("dd/MM/yyyy HH:mm");
            }
            catch(Exception e)
            {
                Response.Redirect("~/Error.aspx");
            }

            string select = @"SELECT COUNT(*) as Sales, COALESCE(SUM(FinalPrice), 0) as Earn , (SELECT TOP 1 BookingDate FROM Booking WHERE Status NOT IN ('Cancelled', 'Pending') ORDER BY BookingDate DESC) AS LastBooking FROM Booking WHERE Status NOT IN ('Cancelled', 'Pending') AND CAST(BookingDate AS DATE) = CAST(SYSDATETIME() AS DATE)";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(select, con);
            con.Open();
            SqlDataReader reader = com.ExecuteReader();
            if (reader.Read())
            {
                lblEarning.Text += Convert.ToDouble(reader["Earn"]).ToString("F2");
                lblSales.Text += reader["Sales"].ToString();
                if (reader["LastBooking"] != DBNull.Value)
                {
                    lblEarningLast.Text += DateTime.Parse(reader["LastBooking"].ToString()).ToString("dd/MM/yyyy");
                    lblLastSales.Text += DateTime.Parse(reader["LastBooking"].ToString()).ToString("dd/MM/yyyy");
                }
                else
                {
                    lblEarningLast.Text += "No Booking Today";
                    lblLastSales.Text += "No Booking Today";
                }
            }


        }
        private void loadTopRental()
        {
            string select = @"SELECT TOP 5 COUNT(B.CarPlate) AS RentalCount, MAX(C.CarImage) AS Image, SUM(C.CarDayPrice) AS Price, SUM(B.Price) AS TotalRevenue, (C.CarBrand + ' ' + C.CarName) AS CarName FROM [Car] C JOIN [Booking] B ON C.CarPlate = B.CarPlate WHERE B.Status NOT IN ('Cancelled', 'Pending') GROUP BY C.CarBrand, C.CarName ORDER BY COUNT(B.CarPlate) DESC";
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
            string select = @"SELECT TOP 5 COUNT(B.CarPlate) AS RentalCount, MAX(C.CarImage) AS Image, AVG(C.CarDayPrice) AS Price, SUM(B.Price) AS TotalRevenue, (C.CarBrand + ' ' + C.CarName) AS CarName FROM [Car] C  JOIN [Booking] B ON C.CarPlate = B.CarPlate WHERE (B.StartDate BETWEEN @StartDate AND @EndDate) AND B.Status NOT IN ('Cancelled', 'Pending') GROUP BY C.CarBrand, C.CarName ORDER BY COUNT(B.CarPlate) DESC";
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
            string select = @"SELECT C.CType as CarType, count(B.CarPlate) as CarCount FROM Car C JOIN Booking B ON C.CarPlate = B.CarPlate WHERE B.Status NOT IN ('Cancelled', 'Pending') GROUP BY C.CType";
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
            string select = @"SELECT C.CType as CarType, count(B.CarPlate) as CarCount FROM Car C JOIN Booking B ON C.CarPlate = B.CarPlate WHERE (B.StartDate BETWEEN @StartDate AND @EndDate) AND B.Status NOT IN ('Cancelled', 'Pending') GROUP BY C.CType";
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
            string timeFilter = hdnTimeFilter_cust.Value;
            string quarterFilter = "ddl.SelectedValue";
            loadTopCust(dateFrom,dateTo,timeFilter,quarterFilter);
        }

    
        /*
         CONVERT 103 - convert date to format in "dd/MM/yyyy"
         */

        protected void btnBookRecord_Click(object sender, EventArgs e)
        {
            DateTime dateFrom = new DateTime();
            DateTime dateTo = new DateTime();
            string customFormat = "";

            if(hdnTimeFilter.Value == "Custom")
            {
               dateFrom = DateTime.Parse(txtStartDate.Text);
               dateTo = DateTime.Parse(txtEndDate.Text);
               TimeSpan timeDifference = dateTo - dateFrom;
               
               if(timeDifference.Days <=180 )
                {
                    customFormat = "In Date";
                }
               else 
                {
                    customFormat = "In Month";
                }
               
            }
           
            string timeFilter = hdnTimeFilter.Value;

            loadDataofLineChart(dateFrom, dateTo, timeFilter,customFormat);
        }

        public void loadDataofLineChart(DateTime dateFrom, DateTime dateTo, string timeFilter,string customFormat)
        {
            lblCheck.Text = hdnTimeFilter.Value;
            string dateFromTitleFormat = dateFrom.ToString("dd/MM/yyyy");
            string dateToTitleFormat = dateTo.ToString("dd/MM/yyyy");
            DateTime today = DateTime.Today;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            string query = "";
            string title = "";
            string xAxisTitle = "";
            string categories = "";
            string lineRecordData = "";
            string lineAmtData = "";
            List<string> categoryList = new List<string>();
            StringBuilder lineBuilder = new StringBuilder("[");
            StringBuilder lineAmtBuilder = new StringBuilder("[");

            int daysToSOW = (int)today.DayOfWeek;
            int daysToEOW = 6 - (int)today.DayOfWeek; // 0,1,2,3,4,5,6
            string weekFilter = " ";
            switch (timeFilter)
            {

                case "Today":
                    query = @"SELECT DATEPART(HOUR, BookingDate) AS Hour , COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                      FROM Booking 
                      WHERE CONVERT(DATE, BookingDate) = CONVERT(DATE, GETDATE())  -- Filter by current date
                      AND Status NOT IN ('Cancelled', 'Pending')
                      GROUP BY DATEPART(HOUR, BookingDate)
                      ORDER BY DATEPART(HOUR, BookingDate)";
                    xAxisTitle = "Hours in 24-hour system";
                    title = "on "+ today.Date.ToString("dd-MMM-yyyy");
                    break;
                case "Yesterday":
                    query = @"SELECT DATEPART(HOUR, BookingDate) AS Hour , COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                      FROM Booking 
                      WHERE CONVERT(DATE, BookingDate) = CONVERT(DATE, DATEADD(DAY,-1,GETDATE()))  -- Filter by current date
                      AND Status NOT IN ('Cancelled', 'Pending')
                      GROUP BY DATEPART(HOUR, BookingDate)
                      ORDER BY DATEPART(HOUR, BookingDate)";
                    xAxisTitle = "Hours in 24-hour system";
                    title = "on " + today.AddDays(-1).ToString("dd-MMM-yyyy");
                    break;
                    
                case "This Week":
                    DateTime startofWeek = today.AddDays(-daysToSOW);
                    DateTime endOfWeek = today.AddDays(daysToEOW);

                    weekFilter= @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                              DECLARE @StartOfWeek DATE = DATEADD(DAY, -DATEPART(WEEKDAY, @CurrentDate) + 1, @CurrentDate) 
                              DECLARE @EndOfWeek DATE = DATEADD(DAY, 7 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate) ";//(WEEKDAY) = Sunday-1...Saturday-7 ,start - Sunday , end-Saturday 

                            query = weekFilter
                              + @"SELECT CONVERT(VARCHAR, BookingDate, 103) AS DatePerWeek, COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                              FROM Booking 
                              WHERE BookingDate >= @StartOfWeek AND BookingDate < DATEADD(DAY, 1, @EndOfWeek)
                              AND Status NOT IN ('Cancelled', 'Pending')
                              GROUP BY CONVERT(VARCHAR, BookingDate, 103)  -- Group by day
                              ORDER BY CONVERT(VARCHAR, BookingDate, 103)  -- Sort by formatted date";
                    title = "from " + startofWeek.ToString("dd-MMM-yyyy") + " to " + endOfWeek.ToString("dd-MMM-yyyy");
                    xAxisTitle = "Date of The Week";
                    break;
                case "Last Week":
                    DateTime startofLastWeek = today.AddDays(-daysToSOW-7);
                    DateTime endofLastWeek = today.AddDays(-daysToSOW-1);//take note 

                    weekFilter= @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                              DECLARE @StartOfLastWeek DATE = DATEADD(DAY, -DATEPART(WEEKDAY, @CurrentDate) - 7, @CurrentDate) 
                              DECLARE @EndOfLastWeek DATE = DATEADD(DAY, - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate) ";

                    query = weekFilter
                              + @"SELECT CONVERT(VARCHAR, BookingDate, 103) AS DatePerWeek, COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                              FROM Booking 
                              WHERE BookingDate >= @StartOfLastWeek AND BookingDate < DATEADD(DAY, 1, @EndOfLastWeek)
                              AND Status NOT IN ('Cancelled', 'Pending')
                              GROUP BY CONVERT(VARCHAR, BookingDate, 103)  -- Group by day
                              ORDER BY CONVERT(VARCHAR, BookingDate, 103)  -- Sort by formatted date";
                    title = "from " + startofLastWeek.ToString("dd-MMM-yyyy") + " to " + endofLastWeek.ToString("dd-MMM-yyyy"); 
                    break;
                case "This Month":
                    string monthFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                                           DECLARE @StartOfMonth DATE = DATEADD(DAY, -DAY(@CurrentDate) + 1, @CurrentDate)
                                           DECLARE @EndOfMonth DATE = EOMONTH(@CurrentDate)";

                    query = monthFilter 
                            + @"SELECT CONVERT(VARCHAR, BookingDate, 103) AS BookingDate, COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                            FROM Booking
                            WHERE BookingDate BETWEEN @StartOfMonth AND @EndOfMonth
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY CONVERT(VARCHAR, BookingDate, 103)
                            ORDER BY BookingDate";

                    title = "in " + today.ToString("MMMM");

                    
                    break;
                case "Last Month":
                    //DAY(return the day of the date, eg 17/9/2024 -> 17 (+1 and become first day of month)
                    //EOMONTH -1 = last day of prev month
                    string lastMonthFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())                               
                                               DECLARE @StartOfPrevMonth DATE = DATEADD(MONTH, -1, DATEADD(DAY, -DAY(@CurrentDate) + 1, @CurrentDate)) 
                                               DECLARE @EndOfPrevMonth DATE = EOMONTH(@CurrentDate, -1)"; 

                    query = lastMonthFilter
                            + @"SELECT CONVERT(VARCHAR, BookingDate, 103) AS BookingDate, COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                            FROM Booking
                            WHERE BookingDate BETWEEN @StartOfPrevMonth AND DATEADD(DAY ,1, @EndOfPrevMonth)
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY CONVERT(VARCHAR, BookingDate, 103)
                            ORDER BY BookingDate"; // need plus 1 on the EOM because time issue, if no add last day will nt include

                    title = "in " + today.AddMonths(-1).ToString("MMMM");
                    break;
                case "Quarter":
                    query = @"SELECT YEAR(BookingDate) AS Year, DATEPART(QUARTER, BookingDate) AS Quarter, COUNT(*) AS BookingCount ,SUM(FinalPrice) AS BookingAmount
                            FROM Booking 
                            WHERE BookingDate IS NOT NULL  
                            AND YEAR(BookingDate) = YEAR(CONVERT(DATE,GETDATE()))
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY YEAR(BookingDate), DATEPART(QUARTER, BookingDate)
                            ORDER BY YEAR(BookingDate), DATEPART(QUARTER, BookingDate)";
                    title = "for Quarters of "+ today.ToString("yyyy");
                    
                    break;
                case "This Year":
                    query = @"SELECT YEAR(BookingDate) AS Year, FORMAT(BookingDate,'MMM') AS MonthABC, MONTH(BookingDate) AS Month , COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                            FROM Booking 
                            WHERE BookingDate IS NOT NULL 
                            AND YEAR(BookingDate) = YEAR(CONVERT(DATE,GETDATE()))
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY YEAR(BookingDate), FORMAT(BookingDate, 'MMM'),MONTH(BookingDate)
                            ORDER BY YEAR(BookingDate), MONTH(BookingDate)";
                    title = "for Year "+today.ToString("yyyy");
                    xAxisTitle = "Month of The Year";
                    break;
                case "3 Year":
                    query = @"SELECT YEAR(BookingDate) AS Year, COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                            FROM Booking 
                            WHERE YEAR(BookingDate) BETWEEN YEAR(CONVERT(DATE,GETDATE()))-2 AND YEAR(CONVERT(DATE,GETDATE()))
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY YEAR(BookingDate)
                            ORDER BY YEAR(BookingDate)";
                    title = "from Year " + today.AddYears(-2).ToString("yyyy") +" to Year " + today.ToString("yyyy");
                    break;
                case "Custom":
                    /*
                     * customFormat - day(input date diff <= 180 days) & month(input date diff >180 days)
                     */
                    if(customFormat=="In Date")
                    {
                        query = @"
                            SELECT YEAR(BookingDate) AS Year, MONTH(BookingDate) AS Month, DAY(BookingDate) AS Day, FORMAT(BookingDate, 'MMM') AS MonthABC, COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                             FROM Booking
                             WHERE BookingDate >= @StartDate AND BookingDate <= DATEADD(DAY, 1, @EndDate)
                             AND Status NOT IN ('Cancelled', 'Pending')
                             GROUP BY YEAR(BookingDate), MONTH(BookingDate),DAY(BookingDate),FORMAT(BookingDate, 'MMM')
                             ORDER BY Year, Month ";
                    }
                    else if(customFormat =="In Month")
                    {
                        query = @"
                            SELECT YEAR(BookingDate) AS Year, MONTH(BookingDate) AS Month, FORMAT(BookingDate, 'MMM') AS MonthABC, COUNT(*) AS BookingCount, SUM(FinalPrice) AS BookingAmount
                             FROM Booking
                             WHERE BookingDate >= @StartDate AND BookingDate <= DATEADD(DAY, 1, @EndDate)
                             AND Status NOT IN ('Cancelled', 'Pending')
                             GROUP BY YEAR(BookingDate), MONTH(BookingDate),FORMAT(BookingDate, 'MMM')
                             ORDER BY Year, Month ";
                    }
                    
                    title = "from " + dateFromTitleFormat + " to " + dateToTitleFormat;
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
                    case "Today":
                        lineBuilder.Append($"[\"{dr["Hour"]}\",{dr["BookingCount"]}],");
                        string hourFormat = dr["Hour"].ToString() + ":00";
                        lineAmtBuilder.Append($"[\"{dr["Hour"]}\",{dr["BookingAmount"]}],");
                        categoryList.Add(hourFormat);
                        break;
                    case "Yesterday":
                        lineBuilder.Append($"[\"{dr["Hour"]}\",{dr["BookingCount"]}],");
                        lineAmtBuilder.Append($"[\"{dr["Hour"]}\",{dr["BookingAmount"]}],");
                        categoryList.Add(dr["Hour"].ToString()+ ":00");
                        break;
                    case "This Week":
                        /*string date = dr["DatePerWeek"].ToString();*/
                        lineBuilder.Append($"[\"{dr["DatePerWeek"]}\",{dr["BookingCount"]}],");
                        categoryList.Add(dr["DatePerWeek"].ToString());
                        lineAmtBuilder.Append($"[\"{dr["DatePerWeek"]}\",{dr["BookingAmount"]}],");
                        break;
                    case "Last Week":
                        lineBuilder.Append($"[\"{dr["DatePerWeek"]}\",{dr["BookingCount"]}],");
                        categoryList.Add(dr["DatePerWeek"].ToString());
                        lineAmtBuilder.Append($"[\"{dr["DatePerWeek"]}\",{dr["BookingAmount"]}],");
                        break;
                    case "This Month":
                        lineBuilder.Append($"[\"{dr["BookingDate"]}\",{dr["BookingCount"]}],");
                        categoryList.Add(dr["BookingDate"].ToString());
                        lineAmtBuilder.Append($"[\"{dr["BookingDate"]}\",{dr["BookingAmount"]}],");
                        break;
                    case "Last Month":
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
                                categoryList.Add("Quarter 1");
                                break;

                            case "2":
                                categoryList.Add("Quarter 2");
                                break;

                            case "3":
                                categoryList.Add("Quarter 3");
                                break;

                            case "4":
                                categoryList.Add("Quarter 4");
                                break;
                        }
                        break;
                    case "This Year":
                        lineBuilder.Append($"[\"{dr["Month"]}\",{dr["BookingCount"]}],");
                        lineAmtBuilder.Append($"[\"{dr["Month"]}\",{dr["BookingAmount"]}],");
                        categoryList.Add(dr["Month"].ToString());
                        break;
                    case "3 Year":
                        lineBuilder.Append($"[\"{dr["Year"]}\",{dr["BookingCount"]}],");
                        lineAmtBuilder.Append($"[\"{dr["Year"]}\",{dr["BookingAmount"]}],");
                        categoryList.Add(dr["Year"].ToString());
                        break;
                    case "Custom":
                        if(customFormat == "In Date")
                        {
                            lineBuilder.Append($"[\"{dr["Day"]}/{dr["Month"]}/{dr["Year"]}\",{dr["BookingCount"]}],");
                            lineAmtBuilder.Append($"[\"{dr["Day"]}/{dr["Month"]}/{dr["Year"]}\",{dr["BookingAmount"]}],");
                            categoryList.Add(dr["Day"].ToString()+"/"+dr["Month"].ToString() + "/" + dr["Year"].ToString());
                        }
                        else if (customFormat == "In Month")
                        {
                            lineBuilder.Append($"[\"{dr["MonthABC"]}/{dr["Year"]}\",{dr["BookingCount"]}],");
                            lineAmtBuilder.Append($"[\"{dr["MonthABC"]}/{dr["Year"]}\",{dr["BookingAmount"]}],");
                            categoryList.Add(dr["MonthABC"].ToString() + "/" + dr["Year"].ToString());
                        }
                        
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
            string script = $"renderBookingRecordChart({lineRecordData},'{xAxisTitle}',[{categories}],'{title}');"; // Pass the data to JavaScript function
            string script2 = $"renderBookingAmtChart({lineAmtData},'{xAxisTitle}',[{categories}],'{title}');"; // Pass the data to JavaScript function

            ScriptManager.RegisterStartupScript(this,this.GetType(), "renderBookingRecordScript", script, true);
            ScriptManager.RegisterStartupScript(this,this.GetType(), "renderBookingAmtScript", script2, true);

            con.Close();
        }
        private void loadTopCust(DateTime dateFrom, DateTime dateTo, string timeFilter, string quarterFilter)
        {
            string query = "";
            string lackTimeString = ""; //to show when the record is nt enuf for top 5
            string quarterCondition = ""; // to add in the report title depending on which quarter is picked
            DateTime today = DateTime.Now;

            int daysToSOW = (int)today.DayOfWeek;
            int daysToEOW = 6 - (int)today.DayOfWeek;
            string weekFilter = "";
            switch (timeFilter)
            {
                case "Today":
                    query = @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                              FROM ApplicationUser a JOIN Booking b
                              ON a.Id = b.UserId
                              WHERE CONVERT(DATE, BookingDate) = CONVERT(DATE, GETDATE())  -- Filter by current date
                              AND Status NOT IN ('Cancelled', 'Pending')
                              GROUP BY a.ProfilePicture,a.Username,a.Email 
                              ORDER BY TotalPrice DESC";
                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made on " + today.ToString("dd-MMM-yyyy");
                    lackTimeString = " today";
                    break;
                case "Yesterday":
                    query = @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                              FROM ApplicationUser a JOIN Booking b
                              ON a.Id = b.UserId
                              WHERE CONVERT(DATE, BookingDate) = CONVERT(DATE, DATEADD(DAY,-1,GETDATE()))  -- Filter by current date
                              AND Status NOT IN ('Cancelled', 'Pending')
                              GROUP BY a.ProfilePicture,a.Username,a.Email 
                              ORDER BY TotalPrice DESC";
                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made on " + today.AddDays(-1).ToString("dd-MMM-yyyy");
                    lackTimeString = " yesterday";
                    break;
                case "This Week":

                    DateTime startofWeek = today.AddDays(-daysToSOW);
                    DateTime endOfWeek = today.AddDays(daysToEOW);

                    weekFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                              DECLARE @StartOfWeek DATE = DATEADD(DAY, -DATEPART(WEEKDAY, @CurrentDate) + 1, @CurrentDate) 
                              DECLARE @EndOfWeek DATE = DATEADD(DAY, 7 - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate) ";//start - Sunday , end-Saturday 

                    query = weekFilter
                      + @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                              FROM ApplicationUser a JOIN Booking b
                              ON a.Id = b.UserId
                              WHERE BookingDate >= @StartOfWeek AND BookingDate < DATEADD(DAY, 1, @EndOfWeek)
                              AND Status NOT IN ('Cancelled', 'Pending')
                              GROUP BY a.ProfilePicture,a.Username,a.Email
                              ORDER BY TotalPrice DESC";

                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made from " + startofWeek.ToString("dd-MMM-yyyy") + " to " + endOfWeek.ToString("dd-MMM-yyyy");
                    lackTimeString = " from " + startofWeek.ToString("dd-MMM-yyyy") + " to " + endOfWeek.ToString("dd-MMM-yyyy");
                    break;
                case "Last Week":
                    DateTime startofLastWeek = today.AddDays(-daysToSOW - 7);
                    DateTime endofLastWeek = today.AddDays(-daysToSOW - 1);//take note 

                    weekFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                              DECLARE @StartOfLastWeek DATE = DATEADD(DAY, -DATEPART(WEEKDAY, @CurrentDate) - 7, @CurrentDate) 
                              DECLARE @EndOfLastWeek DATE = DATEADD(DAY, - DATEPART(WEEKDAY, @CurrentDate), @CurrentDate) ";

                    query = weekFilter
                             + @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                              FROM ApplicationUser a JOIN Booking b
                              ON a.Id = b.UserId 
                              WHERE BookingDate >= @StartOfLastWeek AND BookingDate < DATEADD(DAY, 1, @EndOfLastWeek)
                              AND Status NOT IN ('Cancelled', 'Pending')
                              GROUP BY a.ProfilePicture,a.Username,a.Email
                              ORDER BY TotalPrice DESC";
                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made from " + startofLastWeek.ToString("dd-MMM-yyyy") + " to " + endofLastWeek.ToString("dd-MMM-yyyy");
                    lackTimeString = " from " + startofLastWeek.ToString("dd-MMM-yyyy") + " to " + endofLastWeek.ToString("dd-MMM-yyyy");
                    break;

                case "This Month":
                    string monthFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())
                                           DECLARE @StartOfMonth DATE = DATEADD(DAY, -DAY(@CurrentDate) + 1, @CurrentDate)
                                           DECLARE @EndOfMonth DATE = EOMONTH(@CurrentDate)";

                    query = monthFilter
                            + @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE BookingDate BETWEEN @StartOfMonth AND @EndOfMonth
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY a.ProfilePicture,a.Username,a.Email 
                            ORDER BY TotalPrice DESC";
                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made in " + today.ToString("MMMM");
                    lackTimeString = " in " + today.ToString("MMMM");
                    break;
                case "Last Month":
                    //description at below part
                    string lastMonthFilter = @"DECLARE @CurrentDate DATE = CONVERT(DATE, GETDATE())                               
                                               DECLARE @StartOfPrevMonth DATE = DATEADD(MONTH, -1, DATEADD(DAY, -DAY(@CurrentDate) + 1, @CurrentDate)) 
                                               DECLARE @EndOfPrevMonth DATE = EOMONTH(@CurrentDate, -1)";
                    query = lastMonthFilter
                            + @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE BookingDate BETWEEN @StartOfPrevMonth AND DATEADD(DAY ,1, @EndOfPrevMonth)
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY a.ProfilePicture,a.Username,a.Email 
                            ORDER BY TotalPrice DESC";
                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made in " + today.AddMonths(-1).ToString("MMMM");
                    lackTimeString = " in " + today.AddMonths(-1).ToString("MMMM");
                    break;
                case "Quarter":

                    switch (quarterFilter)
                    {
                        case "Quarter1":
                            quarterCondition = "AND DATEPART(QUARTER, b.BookingDate) = 1";
                            lblTopCust.Text = "Top 5 Customers on Rental Amount Made in 1st Quarter of Year " + today.ToString("yyyy");
                            lackTimeString = " in 1st Quarter of Year " + today.ToString("yyyy");
                            break;
                        case "Quarter2":
                            quarterCondition = "AND DATEPART(QUARTER, b.BookingDate) = 2";
                            lblTopCust.Text = "Top 5 Customers on Rental Amount Made in 2nd Quarter of Year " + today.ToString("yyyy");
                            lackTimeString = " in 2nd Quarter of Year " + today.ToString("yyyy");
                            break;
                        case "Quarter3":
                            quarterCondition = "AND DATEPART(QUARTER, b.BookingDate) = 3";
                            lblTopCust.Text = "Top 5 Customers on Rental Amount Made in 3rd Quarter of Year " + today.ToString("yyyy");
                            lackTimeString = " in 3rd Quarter of Year " + today.ToString("yyyy");
                            break;
                        case "Quarter4":
                            quarterCondition = "AND DATEPART(QUARTER, b.BookingDate) = 4";
                            lblTopCust.Text = "Top 5 Customers on Rental Amount Made in 4th Quarter of Year " + today.ToString("yyyy");
                            lackTimeString = " in 4th Quarter of Year " + today.ToString("yyyy");
                            break;
                    }
                    query = @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.Price) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE YEAR(BookingDate) = YEAR(CONVERT(DATE, GETDATE()))
                            " + quarterCondition +
                            @"
                            GROUP BY a.ProfilePicture, a.Username, a.Email
                            ORDER BY TotalPrice DESC";
                    break;
                case "This Year":
                    query = @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE BookingDate IS NOT NULL  
                            AND YEAR(BookingDate) = YEAR(CONVERT(DATE, GETDATE()))
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY a.ProfilePicture, a.Username, a.Email
                            ORDER BY TotalPrice DESC";
                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made in Year " + today.ToString("yyyy");
                    lackTimeString = " in " + today.ToString("yyyy");
                    break;
                case "All Time":
                    query = @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                            FROM ApplicationUser a JOIN Booking b
                            ON a.Id = b.UserId
                            WHERE BookingDate IS NOT NULL  
                            AND Status NOT IN ('Cancelled', 'Pending')
                            GROUP BY a.ProfilePicture, a.Username, a.Email
                            ORDER BY TotalPrice DESC";
                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made of All Time";
                    lackTimeString = " of All Time";
                    break;
                case "Custom":
                    query = @"SELECT TOP 5 a.ProfilePicture, a.Username, a.Email,SUM(b.FinalPrice) AS TotalPrice
                             FROM ApplicationUser a JOIN Booking b
                             ON a.Id = b.UserId
                             WHERE BookingDate IS NOT NULL
                             AND BookingDate BETWEEN @StartDate AND @EndDate
                             AND Status NOT IN ('Cancelled', 'Pending')
                             GROUP BY a.ProfilePicture, a.Username, a.Email
                             ORDER BY TotalPrice DESC ";

                    lblTopCust.Text = "Top 5 Customers on Booking Amount Made " + "from " + dateFrom.ToString("dd-MM-yyyy") + " to " + dateTo.ToString("dd-MM-yyyy");
                    lackTimeString = " from " + dateFrom.ToString("dd-MM-yyyy") + " to " + dateTo.ToString("dd-MM-yyyy");

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
            if (ds.Tables[0].Rows.Count == 5)
            {
                rptTopCustRental.DataSource = ds.Tables["TopData"];
                rptTopCustRental.DataBind();
                updateTopCust.Update();
                phNoCustRecord.Visible = false;
                phLackCustRecord.Visible = false;
                ;
            }
            else if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows.Count < 5)
            {
                rptTopCustRental.DataSource = ds.Tables["TopData"];
                rptTopCustRental.DataBind();
                updateTopCust.Update();
                phNoCustRecord.Visible = false;
                phLackCustRecord.Visible = true;
                lblLackCustRecord.Text = "Existing Customer Rental Record(s)" + lackTimeString + ": " + ds.Tables[0].Rows.Count + "😦";

            }
            else
            {
                /*rptTopRental.DataSource = ds.Tables["TopData"];*/
                rptTopCustRental.DataSource = null; //no record found, clear rpt and show placeholder txt
                rptTopCustRental.DataBind();
                updateTopCust.Update();

                phNoCustRecord.Visible = true;
                phLackCustRecord.Visible = false;
            }

            con.Close();
        }

    }
}