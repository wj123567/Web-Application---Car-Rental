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
    public partial class productListing : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (!Page.IsPostBack)
            {
                try
                {
                    retrievedAllData();
                }
                catch (Exception)
                {
                    Response.Redirect("Home.aspx?Error=1");
                }
            }
        }

        protected void retrievedAllData() {
            string pickupPoint = Session["Pickup_point"].ToString();
            DateTime startDate = DateTime.Parse(Session["StartDate"].ToString());
            DateTime endDate = DateTime.Parse(Session["EndDate"].ToString());            
            addDdlPULocation();
            ddlPULocation.SelectedValue = pickupPoint;
            ddlPUState.SelectedValue = Session["Pickup_state"].ToString();
            hdnStart.Text = startDate.ToString("dd-MM-yyyy HH:mm");
            hdnEnd.Text = endDate.ToString("dd-MM-yyyy HH:mm");
            string findCar = @"SELECT C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy, AVG(R.Rating) as AVG 
                              FROM Car C JOIN Location L ON C.LocationId = L.Id LEFT JOIN Booking B ON C.CarPlate = B.CarPlate LEFT JOIN Reviews R ON B.Id = R.BookingId 
                              WHERE IsDelisted = 0 AND L.LocationName = @Pickup_point 
                              AND C.CarPlate NOT IN (SELECT B.CarPlate FROM Booking B WHERE (B.StartDate < @endDate AND B.EndDate > @startDate) AND B.CarPlate IS NOT NULL AND B.Status IN('Booked','Pending')) 
                              GROUP BY C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy";

            //initial one
            //"SELECT C.*FROM Car C JOIN Location L ON C.LocationId = L.Id LEFT JOIN TestTrip T ON C.CarPlate = T.CarPlateNo WHERE IsDelisted = 0 AND L.LocationName = @Pickup_point AND(T.Id IS NULL OR NOT(@startDate < T.EndDate AND @endDate > T.StartDate))"

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

            con.Open();

            SqlCommand com = new SqlCommand(findCar, con);
            com.Parameters.AddWithValue("@Pickup_point", pickupPoint);
            com.Parameters.AddWithValue("@startDate", startDate);
            com.Parameters.AddWithValue("@endDate", endDate);

            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "CarData");

            if (ds.Tables["CarData"].Rows.Count == 0)
            {
                lblSearchFail.Text = "No search results found";
            }
            else
            {
                lblSearchFail.Text = string.Empty;
                ViewState["CarData"] = ds.Tables["CarData"];
            }

            productRepeater.DataSource = ds.Tables["CarData"];
            productRepeater.DataBind();

            con.Close();


        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            List<ListItem> brandSelected = new List<ListItem>();
            List<ListItem> typeSelected = new List<ListItem>();
            TimeSpan delta = DateTime.Parse(hdnEnd.Text) - DateTime.Parse(hdnStart.Text);
            int days = (int)Math.Ceiling((double)delta.TotalHours / 24.0);

            foreach (ListItem item in cblCarBrand.Items)
            {
                if (item.Selected)
                {
                    brandSelected.Add(item);
                }
            }

            foreach (ListItem item in cblCarType.Items)
            {
                if (item.Selected)
                {
                    typeSelected.Add(item);
                }
            }

            string carInfo = "SELECT C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy, AVG(R.Rating) as AVG FROM Car C JOIN Location L ON C.LocationId = L.Id LEFT JOIN Booking B ON C.CarPlate = B.CarPlate LEFT JOIN Reviews R ON B.Id = R.BookingId WHERE IsDelisted = 0 AND L.LocationName = @LocationName AND C.CarPlate NOT IN (SELECT B.CarPlate FROM Booking B WHERE (B.StartDate < @endDate AND B.EndDate > @startDate) AND B.CarPlate IS NOT NULL AND B.Status IN('Booked','Pending'))";

            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@LocationName", ddlPULocation.SelectedValue));

            if (brandSelected.Count > 0)
            {
                carInfo += " AND C.CarBrand IN (";
                for (int i = 0; i < brandSelected.Count; i++)
                {
                    string paramName = "@Brand" + i;
                    carInfo += (i > 0 ? ", " : "") + paramName;
                    parameters.Add(new SqlParameter(paramName, brandSelected[i].Text));
                }
                carInfo += ")";
            }

            if (typeSelected.Count > 0)
            {
                carInfo += " AND C.CType IN (";
                for (int i = 0; i < typeSelected.Count; i++)
                {
                    string paramName = "@Type" + i;
                    carInfo += (i > 0 ? ", " : "") + paramName;
                    parameters.Add(new SqlParameter(paramName, typeSelected[i].Text));
                }
                carInfo += ")";
            }

            if (!string.IsNullOrEmpty(txtMinPrice.Text))
            {
                carInfo += " AND C.CarDayPrice >= @MinPrice";
                parameters.Add(new SqlParameter("@MinPrice", double.Parse(txtMinPrice.Text)/days));
            }

            if (!string.IsNullOrEmpty(txtMaxPrice.Text))
            {
                carInfo += " AND C.CarDayPrice <= @MaxPrice";
                parameters.Add(new SqlParameter("@MaxPrice", double.Parse(txtMaxPrice.Text)/days));
            }

            if (!string.IsNullOrEmpty(searchBar.Text))
            {
                carInfo += " AND (CarName LIKE @searchString OR CType LIKE @searchString OR CarBrand LIKE @searchString OR (CarBrand + CarName) LIKE @searchString)";
                parameters.Add(new SqlParameter("@searchString", searchBar.Text.Replace(" ","")));
            }

            DateTime startDate = DateTime.Parse(hdnStart.Text);
            DateTime endDate = DateTime.Parse(hdnEnd.Text);

            carInfo += " GROUP BY C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);


             SqlCommand com = new SqlCommand(carInfo, con);

                    com.Parameters.AddWithValue("@startDate", startDate);
                    com.Parameters.AddWithValue("@endDate", endDate);
                    com.Parameters.AddRange(parameters.ToArray());

                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(com);
                    DataSet ds = new DataSet();
                    da.Fill(ds, "CarData");

                    if (ds.Tables["CarData"].Rows.Count == 0)
                    {
                        lblSearchFail.Text = "No search results found";
                    }
                    else
                    {
                        lblSearchFail.Text = string.Empty;
                        ViewState["CarData"] = ds.Tables["CarData"];
                    }

                    productRepeater.DataSource = ds;
                    productRepeater.DataBind();
                    Session["Pickup_point"] = ddlPULocation.SelectedValue;
                    Session["Dropoff_point"] = ddlPULocation.SelectedValue;
                    Session["StartDate"] = hdnStart.Text;
                    Session["EndDate"] = hdnEnd.Text;
                    Session["Dropoff_state"] = ddlPULocation.SelectedValue;
                    Session["Pickup_state"] = ddlPUState.SelectedValue;
            con.Close();
        }
        protected void btnProductRent_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            String carPlate = button.CommandArgument.ToString();

            Session["CarPlate"] = carPlate;
            Response.Redirect("infopage.aspx?prevCar=" + Request.QueryString["prevCar"]);
        }

        protected void btnA2Z_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnA2Z.Visible = false;
            btnZ2A.Visible = true;

            if(carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "CarName ASC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }

        protected void btnZ2A_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnA2Z.Visible = true;
            btnZ2A.Visible = false;

            if (carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "CarName DESC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }

        protected void ddlPULocation_DataBound(object sender, EventArgs e)
        {
            ddlPULocation.Items.Insert(0, new ListItem("Select Location", "0"));
        }

        protected void productRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblCarPrice = (Label)e.Item.FindControl("lblCarPrice");
            Label lblDay = (Label)e.Item.FindControl("lblDay");
            string carDayPrice = DataBinder.Eval(e.Item.DataItem, "CarDayPrice").ToString();

            TimeSpan delta = DateTime.Parse(hdnEnd.Text)- DateTime.Parse(hdnStart.Text);
            int days = (int)Math.Ceiling((double)delta.TotalHours / 24.0);
            double totalPrice = days * int.Parse(carDayPrice);

            lblCarPrice.Text = "RM " + totalPrice;
            if(days == 1)
            {
                lblDay.Text = "For " +days + " day";
            }
            else
            {
                lblDay.Text = "For " + days + " days";
            }
            
        }


        protected void ddlPUState_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectState = "Select * from Location where LocationState = @state";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectState, con);
            con.Open();
            com.Parameters.AddWithValue("@state", ddlPUState.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "Location");
            ddlPULocation.DataSource = ds;
            ddlPULocation.DataTextField = "LocationName";
            ddlPULocation.DataValueField = "LocationName";
            ddlPULocation.DataBind();
            con.Close();
            updateLocation.Update();
        }

        protected void addDdlPULocation()
        {
            string selectState = "Select * from Location where LocationState = @state";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectState, con);
            con.Open();
            com.Parameters.AddWithValue("@state", Session["Pickup_state"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "Location");
            ddlPULocation.DataSource = ds;
            ddlPULocation.DataTextField = "LocationName";
            ddlPULocation.DataValueField = "LocationName";
            ddlPULocation.DataBind();
            con.Close();
        }

        protected void btnPU_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnDW.Visible = true;
            btnPU.Visible = false;

            if (carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "CarDayPrice ASC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }

        protected void btnDW_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnDW.Visible = false;
            btnPU.Visible = true;

            if (carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "CarDayPrice DESC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }        
        
        protected void btnRtUp_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnRtUp.Visible = false;
            btnRtDw.Visible = true;

            if (carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "AVG ASC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }        
        
        protected void btnRtDw_Click(object sender, EventArgs e)
        {
            DataTable carData = ViewState["CarData"] as DataTable;
            btnRtDw.Visible = false;
            btnRtUp.Visible = true;

            if (carData != null)
            {
                DataView dataView = carData.DefaultView;
                dataView.Sort = "AVG DESC";
                DataTable sortedData = dataView.ToTable();

                ViewState["CarData"] = sortedData;
                productRepeater.DataSource = sortedData;
                productRepeater.DataBind();
            }
        }
    }
        }