using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Imaging;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services.Description;

namespace Assignment
{
    public partial class CarManagement : System.Web.UI.Page
    {
        private int PageSize = 5;  // Number of records per page
        private int PageNumber
        {
            get { return ViewState["PageNumber"] != null ? (int)ViewState["PageNumber"] : 1; }
            set { ViewState["PageNumber"] = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                ViewState["SQLQuery"] = @"SELECT C.*, L.LocationName, (SUM(CASE WHEN B.StartDate >= CONVERT (date, SYSDATETIME()) AND Status NOT IN('Cancelled','Pending','Completed') THEN 1 ELSE 0 END)) as Upcoming, (SUM(CASE WHEN Status NOT IN('Cancelled','Pending') THEN 1 ELSE 0 END)) as Booking, SUM(CASE WHEN B.Status NOT IN ('Cancelled','Pending') THEN B.FinalPrice ELSE 0 END) AS Revenue FROM Car C JOIN Location L ON C.LocationId = L.Id LEFT JOIN Booking B ON C.CarPlate = B.CarPlate GROUP BY C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarDesc, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy, C.LocationId, C.IsDelisted, L.LocationName";
                loadCarData();
            }

            
        }

        protected void loadCarData()
        {
            string selectCar = ViewState["SQLQuery"].ToString() + " ORDER BY Upcoming DESC OFFSET @Pagesize*(@PageNumber - 1) ROWS FETCH NEXT @Pagesize ROWS ONLY";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCar, con);
            com.Parameters.AddWithValue("@PageSize", PageSize);
            com.Parameters.AddWithValue("@PageNumber", PageNumber);
            com.Parameters.AddWithValue("@searchString", "%" + searchBar.Text.Replace(" ", "") + "%");
            com.Parameters.AddWithValue("@LocationId", ddlTableLocation.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(com);      
            DataSet ds = new DataSet();
            da.Fill(ds, "CarTable");
            ViewState["CarTable"] = ds.Tables["CarTable"];
            repeaterCarTable.DataSource = ds.Tables["CarTable"];
            repeaterCarTable.DataBind();
            con.Close();
            UpdatePageInfo(getTotalRow());
            removeSort();
            btnSortUpcoming.CssClass = "text-dark sort-down";
        }

        protected void UpdatePageInfo(int row)
        {
                int totalPage = (int)Math.Ceiling((double)row / (double)PageSize);
                lblPageInfo.Text = "Page " + PageNumber + " of " + totalPage;
                lblTotalRecord.Text = "Total Record: " + row;
                btnPrevious.Enabled = PageNumber > 1;
                btnNext.Enabled = PageNumber < totalPage;

        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            PageNumber--;
            loadCarData();
            UpdatePanel1.Update();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            PageNumber++;
            loadCarData();
            UpdatePanel1.Update();
        }

        protected int getTotalRow()
        {
            string sqlQuery = ViewState["SQLQuery"].ToString();
            string selectAll = "SELECT COUNT(*) FROM Car C JOIN Location L ON C.LocationId = L.Id ";
            int whereIndex = sqlQuery.IndexOf("WHERE", StringComparison.OrdinalIgnoreCase);

            if (whereIndex != -1)
            {
                int groupByIndex = sqlQuery.IndexOf("GROUP BY", StringComparison.OrdinalIgnoreCase);
                if (groupByIndex != -1)
                {
                    string betweenWhereGroupBy = sqlQuery.Substring(whereIndex, groupByIndex - whereIndex).Trim();
                    selectAll += betweenWhereGroupBy;
                }
                // If no GROUP BY, extract everything after WHERE until the end of the query
                else
                {
                    string afterWhere = sqlQuery.Substring(whereIndex).Trim();
                    selectAll += afterWhere;
                }
            }

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectAll, con);
            com.Parameters.AddWithValue("@searchString", "%" + searchBar.Text.Replace(" ", "") + "%");
            com.Parameters.AddWithValue("@LocationId", ddlTableLocation.SelectedValue);
            con.Open();
            return (int)com.ExecuteScalar();
        }
        protected void ddlCarBrand_DataBound(object sender, EventArgs e)
        {
            ddlCarBrand.Items.Insert(0, new ListItem("Select Brand", "0"));
        }
        protected void ddlCarLocation_DataBound(object sender, EventArgs e)
        {
            ddlCarLocation.Items.Insert(0, new ListItem("Select Location", "0"));
        }

        protected void btnUploadCar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string savePath = " ";
                string relPath = " ";
                string insertString = "INSERT into Car (CarPlate, CarBrand, CarName, CType, CarDesc, CarDayPrice, CarSeat, CarTransmission, CarEnergy, LocationId, IsDelisted,CarImage) VALUES (@CarPlate, @CarBrand, @CarName, @CType, @CarDesc, @CarDayPrice, @CarSeat, @CarTransmission, @CarEnergy, @LocationId, @IsDelisted ,@CarImage)";
                if (!string.IsNullOrEmpty(hdnCarPicture.Value))
                {
                    savePath = " ";
                    relPath = " ";
                    string folderLocation = Server.MapPath("~/Image/CarImage");
                    string relfolderLocation = "~/Image/CarImage";
                    // Decode the Base64 string and save it as an image file
                    string base64String = hdnCarPicture.Value.Split(',')[1]; // Remove the data URI scheme part
                    byte[] imageBytes = Convert.FromBase64String(base64String);
                    string fileName = txtCarPlate.Text + ".png";
                    savePath = Path.Combine(folderLocation, fileName);
                    relPath = Path.Combine(relfolderLocation, fileName);

                    File.WriteAllBytes(savePath, imageBytes); // Save the file
                }
                uploadCar(insertString,relPath);
                Response.Redirect("CarManagement.aspx");
            }
        }

        protected void btnUpdateCar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string savePath = " ";
                string relPath = imgCarPic.ImageUrl;
                string updateString = "UPDATE Car SET CarPlate=@CarPlate, CarBrand=@CarBrand, CarName=@CarName, CType=@CType, CarDesc=@CarDesc, CarDayPrice=@CarDayPrice, CarSeat=@CarSeat, CarTransmission=@CarTransmission, CarEnergy=@CarEnergy, LocationId=@LocationId, IsDelisted=@IsDelisted ,CarImage=@CarImage WHERE CarPlate = @NewCarPlate";
                if (!string.IsNullOrEmpty(hdnCarPicture.Value))
                {
                    savePath = " ";
                    relPath = " ";
                    string folderLocation = Server.MapPath("~/Image/CarImage");
                    string relfolderLocation = "~/Image/CarImage";
                    // Decode the Base64 string and save it as an image file
                    string base64String = hdnCarPicture.Value.Split(',')[1]; // Remove the data URI scheme part
                    byte[] imageBytes = Convert.FromBase64String(base64String);
                    string fileName = txtCarPlate.Text + ".png"; 
                    savePath = Path.Combine(folderLocation, fileName);
                    relPath = Path.Combine(relfolderLocation, fileName);

                    File.WriteAllBytes(savePath, imageBytes); // Save the file

                    if (!txtCarPlate.Text.Equals(hdnCarPlate.Value))
                    {
                        string path = Server.MapPath("~/Image/CarImage/");
                        File.Delete(path + hdnCarPlate.Value + ".png");
                    }
                }else if(!txtCarPlate.Text.Equals(hdnCarPlate.Value)){
                    string absPath = Server.MapPath(relPath);
                    if (File.Exists(absPath))
                    {
                        string folderLocation = Server.MapPath("~/Image/CarImage");
                        string relfolderLocation = "~/Image/CarImage";
                        using (System.Drawing.Image img = System.Drawing.Image.FromFile(absPath))
                        {
                            string fileName = txtCarPlate.Text + ".png";
                            savePath = Path.Combine(folderLocation, fileName);
                            relPath = Path.Combine(relfolderLocation, fileName);
                            img.Save(savePath);
                        }
                        string path = Server.MapPath("~/Image/CarImage/");
                        File.Delete(path + hdnCarPlate.Value + ".png");
                    }
                }
                uploadCar(updateString,relPath);
                Response.Redirect("CarManagement.aspx");
            }
        }

        protected void uploadCar(string uploadString, string imgPath)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(uploadString,con);            
            com.Parameters.AddWithValue("@CarPlate",txtCarPlate.Text);
            com.Parameters.AddWithValue("@CarBrand", ddlCarBrand.SelectedValue);
            com.Parameters.AddWithValue("@CarName", txtCarName.Text);
            com.Parameters.AddWithValue("@CType", ddlCarType.SelectedValue);
            com.Parameters.AddWithValue("@CarDesc", txtCarDesc.Text);
            com.Parameters.AddWithValue("@CarDayPrice", hiddenCarPrice.Text);
            com.Parameters.AddWithValue("@CarSeat", txtCarSeat.Text);
            com.Parameters.AddWithValue("@CarTransmission", ddlCarTransmission.SelectedValue);
            com.Parameters.AddWithValue("@CarEnergy", ddlCarEnergy.SelectedValue);
            com.Parameters.AddWithValue("@LocationId", ddlCarLocation.SelectedValue);
            com.Parameters.AddWithValue("@IsDelisted", int.Parse(ddlCarState.SelectedValue));
            com.Parameters.AddWithValue("@CarImage", imgPath);
            com.Parameters.AddWithValue("@NewCarPlate", hdnCarPlate.Value);
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void btnEditCar_Click(object sender, EventArgs e)
        {
            ShowControls(carPanel);
            btnUploadCar.Visible = false;
            btnUpdateCar.Visible = true;
            btnDelete.Visible = true;
            validateCarPic.Enabled = false;
            Button btnEdit = (Button)sender;
            String carPlate = btnEdit.CommandArgument;
            loadCarData(carPlate);
        }

        protected void btnViewCar_Click(object sender, EventArgs e)
        {
            HideControls(carPanel);
            btnDelete.Visible = true;
            Button btnView = (Button)sender;
            String carPlate = btnView.CommandArgument;
            loadCarData(carPlate);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "disableUpload()", true);
        }

        protected void loadCarData(String carPlate)
        {
            hdnCarPlate.Value = carPlate;
            String selectCar = "SELECT * FROM Car WHERE CarPlate = @CarPlate";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCar, con);
            com.Parameters.AddWithValue("@CarPlate", carPlate);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Session["carPlate"] = reader["CarPlate"].ToString();
                txtCarPlate.Text = reader["CarPlate"].ToString();
                if(reader["CarBrand"] != DBNull.Value)
                {
                    ddlCarBrand.SelectedValue = reader["CarBrand"].ToString();
                }
                else
                {
                    ddlCarBrand.SelectedValue = "0";
                }
                txtCarName.Text = reader["CarName"].ToString();
                ddlCarType.SelectedValue = reader["CType"].ToString();
                txtCarDesc.Text = reader["CarDesc"].ToString();
                txtCarPrice.Text = reader["CarDayPrice"].ToString();
                txtCarSeat.Text = reader["CarSeat"].ToString();
                ddlCarTransmission.SelectedValue = reader["CarTransmission"].ToString();
                ddlCarEnergy.SelectedValue = reader["CarEnergy"].ToString();
                if(reader["LocationId"] != DBNull.Value)
                {
                    ddlCarLocation.SelectedValue = reader["LocationId"].ToString();
                }
                else
                {
                    ddlCarLocation.SelectedValue = "0";
                }
                ddlCarState.SelectedValue = reader["IsDelisted"].ToString();
                imgCarPic.ImageUrl = reader["CarImage"].ToString();
            }
            con.Close();
            reader.Close();
        }

        protected void btnUpcoming_Click(object sender, EventArgs e)
        {
            Button btnEdit = (Button)sender;
            String carPlate = btnEdit.CommandArgument;
            loadCarBookingData(carPlate);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "bookingModal()", true);
        }

        protected void loadCarBookingData(string carPlate)
        {
            String selectCar = "SELECT B.*, C.CarPlate, C.CarBrand, C.CarName, C.CarImage, D.DriverName, D.DriverGender, D.SelfiePic, D.DriverPno FROM Booking B JOIN Car C ON B.CarPlate = C.CarPlate JOIN Location L ON C.LocationId = L.Id JOIN Driver D ON B.DriverId = D.Id WHERE B.CarPlate = @CarPlate AND B.StartDate >= CONVERT (date, SYSDATETIME()) AND B.Status NOT IN('Cancelled','Pending','Completed') Order BY B.StartDate";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCar, con);
            com.Parameters.AddWithValue("@CarPlate", carPlate);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "BookingData");
            if (ds.Tables["BookingData"].Rows.Count == 0)
            {
                rptBookingRec.DataSource = ds.Tables["BookingData"];
                rptBookingRec.DataBind();
                lblNoBooking.Text = "No Booking Record";
            }
            else
            {
                lblNoBooking.Text = "";
                rptBookingRec.DataSource = ds.Tables["BookingData"];
                rptBookingRec.DataBind();
            }
            con.Close();
        }        
        protected void btnTotalBooking_Click(object sender, EventArgs e)
        {
            Button btnEdit = (Button)sender;
            String carPlate = btnEdit.CommandArgument;
            loadTotalBookingData(carPlate);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "TTbookingModal()", true);
        }

        protected void loadTotalBookingData(string carPlate)
        {
            String selectCar = "SELECT B.*, C.CarPlate, C.CarBrand, C.CarName, C.CarImage, D.DriverName, D.DriverGender, D.SelfiePic, D.DriverPno FROM Booking B JOIN Car C ON B.CarPlate = C.CarPlate JOIN Location L ON C.LocationId = L.Id LEFT JOIN Driver D ON B.DriverId = D.Id WHERE B.CarPlate = @CarPlate AND B.Status NOT IN('Cancelled','Pending') Order BY B.StartDate";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCar, con);
            com.Parameters.AddWithValue("@CarPlate", carPlate);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "TTBookingData");
            if (ds.Tables["TTBookingData"].Rows.Count == 0)
            {
                rptTotalBookingRec.DataSource = ds.Tables["TTBookingData"];
                rptTotalBookingRec.DataBind();
                ttlblNoBooking.Text = "No Booking Record";
            }
            else
            {
                ttlblNoBooking.Text = "";
                rptTotalBookingRec.DataSource = ds.Tables["TTBookingData"];
                rptTotalBookingRec.DataBind();
            }
            con.Close();
        }

        protected void HideControls(Control container)
        {
            foreach (Control c in container.Controls)
            {
                if (c is Button)
                {
                    c.Visible = false;
                }
                else if (c is TextBox)
                {
                    ((TextBox)c).ReadOnly = true;
                }
                else if (c is DropDownList)
                {
                    ((DropDownList)c).Enabled = false;
                }
            }
        }

        protected void ShowControls(Control container)
        {
            foreach (Control c in container.Controls)
            {
                if (c is Button)
                {
                    c.Visible = true;
                }
                else if (c is TextBox)
                {
                    ((TextBox)c).ReadOnly = false;
                }
                else if (c is DropDownList)
                {
                    ((DropDownList)c).Enabled = true;
                }
            }
        }

        protected void btnSortCarPlate_Click(object sender, EventArgs e)
        {
            LinkButton button = (LinkButton)sender;
            string name = button.CommandName;
            string sort = button.CommandArgument;
            removeSort();

            if (sort == "DESC")
            {
                button.CommandArgument = "ASC";
                button.CssClass = "text-dark sort-down";
            }
            else
            {
                button.CommandArgument = "DESC";
                button.CssClass = "text-dark sort-up";
            }
            DataTable carData = ViewState["CarTable"] as DataTable;
            DataView dataView = carData.DefaultView;
            dataView.Sort = name+" "+sort;
            DataTable sortedData = dataView.ToTable();
            ViewState["CarTable"] = sortedData;
            repeaterCarTable.DataSource = sortedData;
            repeaterCarTable.DataBind();
            UpdatePanel1.Update();
        }

        protected void removeSort()
        {
            btnSortCarPlate.CssClass = "text-dark";
            btnSortCarBrand.CssClass = "text-dark";
            btnSortCarName.CssClass = "text-dark";
            btnSortCarType.CssClass = "text-dark";
            btnSortCarDayPrice.CssClass = "text-dark";
            btnSortBooking.CssClass = "text-dark";
            btnSortRevenue.CssClass = "text-dark";
            btnSortCarLocation.CssClass = "text-dark";
            btnSortCarState.CssClass = "text-dark";
            btnSortUpcoming.CssClass = "text-dark";
        }
        

        protected void validateCarPlate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (!hdnCarPlate.Value.Equals(txtCarPlate.Text))
            {
                String selectCar = "SELECT COUNT(*) FROM Car WHERE CarPlate = @CarPlate";
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                con.Open();
                SqlCommand com = new SqlCommand(selectCar, con);
                com.Parameters.AddWithValue("@CarPlate", txtCarPlate.Text);
                int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
                if (temp == 0)
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            else
            {
                args.IsValid = true;
            }

        }

        protected void repeaterCarTable_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            Button btnView = (Button)e.Item.FindControl("btnView");
            Button btnEdit = (Button)e.Item.FindControl("btnEdit");
            Button btnUpcoming = (Button)e.Item.FindControl("btnUpcoming");
            Button btnTotalBooking = (Button)e.Item.FindControl("btnTotalBooking");
            if (btnView != null && btnEdit != null)
            {
                ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
                scriptManager.RegisterPostBackControl(btnView);
                scriptManager.RegisterPostBackControl(btnUpcoming);
                scriptManager.RegisterPostBackControl(btnEdit);
                scriptManager.RegisterPostBackControl(btnTotalBooking);
            }
        }

        protected void repeaterCarTable_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblCarState = (Label)e.Item.FindControl("lblCarState");
            string isDelisted = DataBinder.Eval(e.Item.DataItem, "IsDelisted").ToString();

            if(isDelisted == "1")
            {
                lblCarState.Text = "Delisted";
            }
            else
            {
               lblCarState.Text = "Listed";
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
            string deleteString = "DELETE FROM Car WHERE CarPlate = @CarPlate";

            string path = Server.MapPath("~/Image/CarImage/");
            File.Delete(path + hdnCarPlate.Value + ".png");

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(deleteString, con);
            com.Parameters.AddWithValue("@CarPlate", hdnCarPlate.Value);
            com.ExecuteNonQuery();
            con.Close();
            Response.Redirect("CarManagement.aspx");
            }
            else
            {
                upDelete.Update();
            }
        }

        protected void ddlChooseLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            String selectCar = "SELECT * FROM Location WHERE Id = @LocationId";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectCar, con);         

            if (ddlChooseLocation.SelectedIndex == 0)
            {
                btnUploadLocation.Visible = true;
                btnUpdateLocation.Visible = false;
                btnDeleteLocation.Visible = false;
                txtLocation.Text = " ";
                ddlState.SelectedValue = "0";
                txtPostcode.Text = " ";
                txtAddress.Text = " ";
            }
            else
            {
                btnUpdateLocation.Visible = true;
                btnUploadLocation.Visible = false;
                btnDeleteLocation.Visible = true;
                com.Parameters.AddWithValue("@LocationId", ddlChooseLocation.SelectedValue);
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                if (reader.Read())
                {
                    txtLocation.Text = reader["LocationName"].ToString();
                    ddlState.SelectedValue = reader["LocationState"].ToString();
                    txtPostcode.Text = reader["LocationPostcode"].ToString();
                    txtAddress.Text = reader["LocationAddress"].ToString();
                }
                con.Close();
                reader.Close();
            }

            updateAddLocation.Update();
        }

        protected void ddlChooseLocation_DataBound(object sender, EventArgs e)
        {
            ddlChooseLocation.Items.Insert(0, new ListItem("New Location", "0"));
        }

        protected void uploadLocation(string sql, string id)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@LocationName", txtLocation.Text);
            com.Parameters.AddWithValue("@LocationState", ddlState.SelectedValue);
            com.Parameters.AddWithValue("@LocationPostcode", txtPostcode.Text);
            com.Parameters.AddWithValue("@LocationAddress", txtAddress.Text);
            com.Parameters.AddWithValue("@LocationId", id);
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void btnUpdateLocation_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
            string updateString = "UPDATE Location SET LocationName=@LocationName, LocationState=@LocationState, LocationPostcode=@LocationPostcode, LocationAddress=@LocationAddress WHERE Id = @LocationId";
            string id = ddlChooseLocation.SelectedValue;
            uploadLocation(updateString, id);
            Server.Transfer("CarManagement.aspx");
            }

        }

        protected void btnUploadLocation_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
            string insertString = "INSERT INTO Location (LocationName, LocationState, LocationPostcode, LocationAddress) VALUES (@LocationName, @LocationState, @LocationPostcode, @LocationAddress)";
            string id = "NULL";
            uploadLocation(insertString, id);
            Server.Transfer("CarManagement.aspx");
            }

        }

        protected void btnDeleteLocation_Click(object sender, EventArgs e)
        {
            string deleteString = "DELETE FROM Location WHERE Id = @LocationId";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(deleteString, con);
            con.Open();
            com.Parameters.AddWithValue("@LocationId", ddlChooseLocation.SelectedValue);
            com.ExecuteNonQuery();
            con.Close();

            Server.Transfer("CarManagement.aspx");
        }

        protected void ddlCarNewCarbrand_DataBound(object sender, EventArgs e)
        {
            ddlCarNewCarbrand.Items.Insert(0, new ListItem("New Brand", "0"));
        }

        protected void ddlCarNewCarbrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            String selectBrand = "SELECT * FROM CarBrand WHERE BrandName = @bn";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectBrand, con);

            if (ddlCarNewCarbrand.SelectedIndex == 0)
            {
                btnUploadBrand.Visible = true;
                btnUpdateBrand.Visible = false;
                btnDeleteBrand.Visible = false;
                txtBrand.Text = " ";
            }
            else
            {
                btnUpdateBrand.Visible = true;
                btnUploadBrand.Visible = false;
                btnDeleteBrand.Visible = true;
                com.Parameters.AddWithValue("@bn", ddlCarNewCarbrand.SelectedValue);
                con.Open();
                SqlDataReader reader = com.ExecuteReader();
                if (reader.Read())
                {
                    txtBrand.Text = reader["BrandName"].ToString();
                }
                con.Close();
                reader.Close();
            }

            updateAddBrand.Update();
        }

        protected void btnDeleteBrand_Click(object sender, EventArgs e)
        {
            string deleteString = "DELETE FROM CarBrand WHERE BrandName = @bn";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(deleteString, con);
            con.Open();
            com.Parameters.AddWithValue("@bn", ddlCarNewCarbrand.SelectedValue);
            com.ExecuteNonQuery();
            con.Close();

            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", "window.location.href='CarManagement.aspx';", true);
        }

        protected void btnUploadBrand_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string insertString = "INSERT INTO CarBrand (BrandName) VALUES (@bn)";
                uploadBrand(insertString, "NULL");
                Response.Redirect("CarManagement.aspx");
            }
        }

        protected void btnUpdateBrand_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string updateString = "UPDATE CarBrand SET BrandName = @bn WHERE BrandName = @ibn";
                string ibn = ddlCarNewCarbrand.SelectedValue;
                uploadBrand(updateString, ibn);
                Response.Redirect("CarManagement.aspx");
            }
        }

        protected void uploadBrand(string sql, string ibn)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(sql, con);
            con.Open();
            com.Parameters.AddWithValue("@bn", txtBrand.Text);
            if(ibn != "NULL")
            {
                com.Parameters.AddWithValue("@ibn", ibn);
            }
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void cvBrand_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string sql = "SELECT COUNT(*) FROM CarBrand WHERE BrandName = @bn";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(sql, con);
            com.Parameters.AddWithValue("@bn",args.Value);
            int temp = (int)com.ExecuteScalar();
            con.Close();

            if(temp == 0)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void btnAddNewCar_Click(object sender, EventArgs e)
        {
            Response.Redirect("CarManagement.aspx");
        }
        protected void hiddenBtn_Click(object sender, EventArgs e)
        {
            string findCar = @"SELECT C.*, L.LocationName, (SUM(CASE WHEN B.StartDate > CONVERT (date, SYSDATETIME()) AND Status NOT IN('Cancelled','Pending','Completed') THEN 1 ELSE 0 END)) as Upcoming, (SUM(CASE WHEN Status NOT IN('Cancelled','Pending') THEN 1 ELSE 0 END)) as Booking, SUM(CASE WHEN B.Status NOT IN ('Cancelled', 'Pending') THEN B.FinalPrice ELSE 0 END) AS Revenue FROM Car C JOIN Location L ON C.LocationId = L.Id LEFT JOIN Booking B ON C.CarPlate = B.CarPlate WHERE (CarName LIKE @searchString OR CType LIKE @searchString OR CarBrand LIKE @searchString OR (CarBrand + CarName) LIKE @searchString) OR C.CarPlate LIKE @searchString GROUP BY C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarDesc, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy, C.LocationId, C.IsDelisted, L.LocationName";
            ViewState["SQLQuery"] = findCar;
            loadCarData();
            UpdatePanel1.Update();
        }

        protected void ddlTableLocation_DataBound(object sender, EventArgs e)
        {
            ddlTableLocation.Items.Insert(0, new ListItem("All Location", "0"));            
        }

        protected void ddlTableLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            string loc = ddlTableLocation.SelectedValue;
            string selectCar = " ";
            if (loc != "0")
            {
                selectCar = "SELECT C.*, L.LocationName, (SUM(CASE WHEN B.StartDate >= CONVERT (date, SYSDATETIME()) AND Status NOT IN('Cancelled','Pending','Completed') THEN 1 ELSE 0 END)) as Upcoming, (SUM(CASE WHEN Status NOT IN('Cancelled','Pending','Completed') THEN 1 ELSE 0 END)) as Booking, SUM(CASE WHEN B.Status NOT IN ('Cancelled', 'Pending') THEN B.FinalPrice ELSE 0 END) AS Revenue FROM Car C JOIN Location L ON C.LocationId = L.Id LEFT JOIN Booking B ON C.CarPlate = B.CarPlate WHERE C.LocationId = @LocationId GROUP BY C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarDesc, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy, C.LocationId, C.IsDelisted, L.LocationName";
            }
            else
            {
                selectCar = @"SELECT C.*, L.LocationName, (SUM(CASE WHEN B.StartDate >= CONVERT (date, SYSDATETIME()) AND Status NOT IN('Cancelled','Pending') THEN 1 ELSE 0 END)) as Upcoming, (SUM(CASE WHEN Status NOT IN('Cancelled','Pending') THEN 1 ELSE 0 END)) as Booking, SUM(CASE WHEN B.Status NOT IN ('Cancelled', 'Pending') THEN B.FinalPrice ELSE 0 END) AS Revenue FROM Car C JOIN Location L ON C.LocationId = L.Id LEFT JOIN Booking B ON C.CarPlate = B.CarPlate GROUP BY C.CarPlate, C.CarBrand, C.CarName, C.CType, C.CarDesc, C.CarImage, C.CarDayPrice, C.CarSeat, C.CarTransmission, C.CarEnergy, C.LocationId, C.IsDelisted, L.LocationName";
            }

            ViewState["SQLQuery"] = selectCar;
            loadCarData();
            UpdatePanel1.Update();
        }

        protected void rptBookingRec_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");
            string startDate = DataBinder.Eval(e.Item.DataItem, "StartDate").ToString();

            TimeSpan delta = DateTime.Parse(startDate) - DateTime.Now;
            int days = (int)Math.Ceiling((double)delta.TotalHours / 24.0);

            if(days <= 1)
            {
                lblStatus.CssClass = "badge bg-danger text-light";
                lblStatus.Text = "Urgent ("+days+" day left)";
            }else if (days >= 2 && days <= 5)
            {
                lblStatus.CssClass = "badge bg-warning text-dark";
                lblStatus.Text = "Be Ready (" + days + " days left)";
            }
            else if(days >= 6)
            {
                lblStatus.CssClass = "badge bg-primary text-light";
                lblStatus.Text = "Chill (" + days + " days left)";
            }
        }

        protected void cvDelete_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string selectCar = "SELECT COUNT(*) FROM Booking WHERE CarPlate = @CarPlate AND StartDate >= CONVERT (date, SYSDATETIME()) AND Status NOT IN('Cancelled')";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCar, con);
            com.Parameters.AddWithValue("@CarPlate", hdnCarPlate.Value);
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            con.Close();
            if(temp == 0)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }

        protected void rptTotalBookingRec_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblStatus = (Label)e.Item.FindControl("ttlblStatus");
            string status = DataBinder.Eval(e.Item.DataItem, "Status").ToString();

            if (status == "Booked")
            {
                lblStatus.CssClass = "badge bg-success text-light";
                lblStatus.Text = "Booked";
            }
            else if (status == "Completed")
            {
                lblStatus.CssClass = "badge bg-primary text-light";
                lblStatus.Text = "Completed";
            }
        }
    }
}