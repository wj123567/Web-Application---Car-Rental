﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
                loadTopRental();
            }
        }

        private void loadTopRental()
        {
            string select = @"SELECT TOP 5 COUNT(B.CarPlate) AS RentalCount, MAX(C.CarImage) AS Image, SUM(C.CarDayPrice) AS Price, SUM(B.Price) AS TotalRevenue, (C.CarBrand + ' ' + C.CarName) AS CarName FROM [Car] C JOIN [Booking] B ON C.CarPlate = B.CarPlate WHERE (B.StartDate BETWEEN CONVERT (date, GETDATE()) AND CONVERT (date, GETDATE())) AND B.Status NOT IN ('Cancelled') GROUP BY C.CarBrand, C.CarName ORDER BY COUNT(B.CarPlate) DESC";
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
            }
            else
            {
                noCarPlaceholder.Visible = true;
            }
            
        }

        [WebMethod] //Declare this for the ajax call
        public static string getCarCategory()
        {
            string select = @"SELECT C.CType as CarType, count(B.CarPlate) as CarCount FROM Car C JOIN Booking B ON C.CarPlate = B.CarPlate GROUP BY C.CType";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            DataTable dt = new DataTable();
            SqlCommand com = new SqlCommand(select, con);
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(com);
            da.Fill(dt);

            string jsonData = JsonConvert.SerializeObject(dt);
            return jsonData;
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
    }
}