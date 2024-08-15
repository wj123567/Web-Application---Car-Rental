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
                txtStartTime.Attributes["min"] = DateTime.Now.AddDays(1).ToString("yyyy-MM-ddTHH:mm");
                txtStartTime.Attributes["max"] = DateTime.Now.AddMonths(3).ToString("yyyy-MM-ddTHH:mm");                
                txtEndTime.Attributes["min"] = DateTime.Now.AddDays(2).ToString("yyyy-MM-ddTHH:mm");
                txtEndTime.Attributes["max"] = DateTime.Now.AddMonths(4).ToString("yyyy-MM-ddTHH:mm");

                    try
                    {
                    retrievedAllData();
                    }
                    catch (Exception ex)
                    {
                        Response.Redirect("Home.aspx");
                    }
            }
        }

        protected void retrievedAllData() {
            string pickupPoint = Session["Pickup_point"].ToString();
            DateTime startDate = DateTime.Parse(Session["StartDate"].ToString());
            DateTime endDate = DateTime.Parse(Session["EndDate"].ToString());
            addDdlDFLocation();
            addDdlPULocation();
            ddlPULocation.SelectedValue = pickupPoint;
            ddlDFLocation.SelectedValue = Session["Dropoff_point"].ToString();
            ddlPUState.SelectedValue = Session["Pickup_state"].ToString();
            ddlDFState.SelectedValue = Session["Dropoff_state"].ToString();
            txtStartTime.Text = startDate.ToString("yyyy-MM-ddTHH:mm");
            txtEndTime.Text = endDate.ToString("yyyy-MM-ddTHH:mm");
            string findCar = "SELECT C.* FROM Car C JOIN Location L ON C.LocationId = L.Id WHERE IsDelisted = 0 AND L.LocationName = @Pickup_point AND C.CarPlate NOT IN (SELECT B.CarPlate FROM Booking B WHERE (B.StartDate < @endDate AND B.EndDate > @startDate) AND B.CarPlate IS NOT NULL)";

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

            ViewState["CarData"] = ds.Tables["CarData"];
            productRepeater.DataSource = ds.Tables["CarData"];
            productRepeater.DataBind();


            con.Close();


        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            List<ListItem> brandSelected = new List<ListItem>();
            List<ListItem> typeSelected = new List<ListItem>();
            TimeSpan delta = DateTime.Parse(txtEndTime.Text) - DateTime.Parse(txtStartTime.Text);
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

            string carInfo = "SELECT C.* FROM Car C JOIN Location L ON C.LocationId = L.Id WHERE IsDelisted = 0 AND L.LocationName = @LocationName AND C.CarPlate NOT IN (SELECT B.CarPlate FROM Booking B WHERE (B.StartDate < @endDate AND B.EndDate > @startDate) AND B.CarPlate IS NOT NULL)";

            List<SqlParameter> parameters = new List<SqlParameter>();
            parameters.Add(new SqlParameter("@LocationName", ddlPULocation.SelectedValue));

            if (brandSelected.Count > 0)
            {
                carInfo += " AND C.CarBrand IN (";
                for (int i = 0; i < brandSelected.Count; i++)
                {
                    string paramName = "@Brand" + i;
                    carInfo += (i > 0 ? ", " : "") + paramName;
                    parameters.Add(new SqlParameter(paramName, brandSelected[i].Value));
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
                    parameters.Add(new SqlParameter(paramName, typeSelected[i].Value));
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

            DateTime startDate = DateTime.Parse(txtStartTime.Text);
            DateTime endDate = DateTime.Parse(txtEndTime.Text);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString))
            {
                using (SqlCommand com = new SqlCommand(carInfo, con))
                {
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
                    Session["Dropoff_point"] = ddlDFLocation.SelectedValue;
                    Session["StartDate"] = txtStartTime.Text;
                    Session["EndDate"] = txtEndTime.Text;
                    Session["Dropoff_state"] = ddlDFState.SelectedValue;
                    Session["Pickup_state"] = ddlPUState.SelectedValue;
                }
            }
        }
        protected void btnProductRent_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;
            String carPlate = button.CommandArgument.ToString();

            Session["CarPlate"] = carPlate;
            Response.Redirect("infopage.aspx");
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

        protected void ddlDFLocation_DataBound(object sender, EventArgs e)
        {
            ddlDFLocation.Items.Insert(0, new ListItem("Select Location", "0"));
        }

        protected void productRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblCarPrice = (Label)e.Item.FindControl("lblCarPrice");
            Label lblDay = (Label)e.Item.FindControl("lblDay");
            string carDayPrice = DataBinder.Eval(e.Item.DataItem, "CarDayPrice").ToString();

            TimeSpan delta = DateTime.Parse(txtEndTime.Text)- DateTime.Parse(txtStartTime.Text);
            int days = (int)Math.Ceiling((double)delta.TotalHours / 24.0);
            double totalPrice = days * int.Parse(carDayPrice);

            lblCarPrice.Text = "RM " + totalPrice;
            lblDay.Text = "For " +days + " days";
        }

        protected void ddlDFState_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectState = "Select * from Location where LocationState = @state";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectState, con);
            con.Open();
            com.Parameters.AddWithValue("@state", ddlDFState.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "Location");
            ddlDFLocation.DataSource = ds;
            ddlDFLocation.DataTextField = "LocationName";
            ddlDFLocation.DataValueField = "LocationName";
            ddlDFLocation.DataBind();
            con.Close();
            updateLocation.Update();
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

        protected void addDdlDFLocation()
        {
            string selectState = "Select * from Location where LocationState = @state";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectState, con);
            con.Open();
            com.Parameters.AddWithValue("@state", Session["Dropoff_state"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "Location");
            ddlDFLocation.DataSource = ds;
            ddlDFLocation.DataTextField = "LocationName";
            ddlDFLocation.DataValueField = "LocationName";
            ddlDFLocation.DataBind();
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
            btnPU.Visible = true;
            btnDW.Visible = false;

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
    }
        }