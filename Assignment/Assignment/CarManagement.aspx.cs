using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class CarManagement : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadCarBrand();
                loadCarData();
            }

            
        }
        
        protected void loadCarData()
        {
            string selectCar = "SELECT C.*, L.LocationName FROM Car C JOIN Location L ON C.LocationId = L.Id";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCar, con);
            SqlDataAdapter da = new SqlDataAdapter(com);      
            DataSet ds = new DataSet();
            da.Fill(ds, "CarTable");
            ViewState["CarTable"] = ds.Tables["CarTable"];
            repeaterCarTable.DataSource = ds.Tables["CarTable"];
            repeaterCarTable.DataBind();
        }
        protected void loadCarBrand()
        {
            ddlCarBrand.Items.Insert(0, new ListItem("Select Brand", "0"));
            string[] carBrand = { "Select Brand", "Abarth", "Alfa Romeo", "Aston Martin", "Audi", "Bentley", "BMW", "Bugatti", "Cadillac", "Chevrolet", "Chrysler", "Citroën", "Dacia", "Daewoo", "Daihatsu", "Dodge", "Donkervoort", "DS", "Ferrari", "Fiat", "Fisker", "Ford", "Honda", "Hummer", "Hyundai", "Infiniti", "Iveco", "Jaguar", "Jeep", "Kia", "KTM", "Lada", "Lamborghini", "Lancia", "Land Rover", "Landwind", "Lexus", "Lotus", "Maserati", "Maybach", "Mazda", "McLaren", "Mercedes-Benz", "MG", "Mini", "Mitsubishi", "Morgan", "Nissan", "Opel", "Peugeot", "Porsche", "Renault", "Rolls Royce", "Rover", "Saab", "Seat", "Skoda", "Smart", "SsangYong", "Subaru", "Suzuki", "Tesla", "Toyota", "Volkswagen", "Volvo" };
            for (int i = 1; i < carBrand.Length; i++)
            {
                ddlCarBrand.Items.Insert(i, new ListItem(carBrand[i], carBrand[i]));
            }
        }
        protected void ddlCarLocation_DataBound(object sender, EventArgs e)
        {
            ddlCarLocation.Items.Insert(0, new ListItem("Select Location", "0"));
        }

        protected void ddlCarType_DataBound(object sender, EventArgs e)
        {
            ddlCarType.Items.Insert(0, new ListItem("Select Car Type", "0"));
        }

        protected void btnUploadCar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string savePath = " ";
                string relPath = " ";
                string insertString = "INSERT into Car (CarPlate, CarBrand, CarName, CType, CarDesc, CarDayPrice, CarSeat, CarTransmission, CarEnergy, LocationId, IsDelisted,CarImage) VALUES (@CarPlate, @CarBrand, @CarName, @CType, @CarDesc, @CarDayPrice, @CarSeat, @CarTransmission, @CarEnergy, @LocationId, @IsDelisted ,@CarImage)";
                if (fuCarPic.HasFile)
                {
                    savePath = " ";
                    relPath = " ";
                    string ext = Path.GetExtension(fuCarPic.FileName);
                    string folderLocation = Server.MapPath("~/Image/CarImage");
                    string relfolderLocation = "~/Image/CarImage";
                    string fileName = txtCarPlate.Text + ext;
                    savePath = Path.Combine(folderLocation, fileName);
                    relPath = Path.Combine(relfolderLocation, fileName);
                    fuCarPic.SaveAs(savePath);
                }
                uploadCar(insertString,relPath);
                Server.Transfer("CarManagement.aspx");
            }
        }

        protected void btnUpdateCar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string savePath = " ";
                string relPath = imgCarPic.ImageUrl;
                string updateString = "UPDATE Car SET CarPlate=@CarPlate, CarBrand=@CarBrand, CarName=@CarName, CType=@CType, CarDesc=@CarDesc, CarDayPrice=@CarDayPrice, CarSeat=@CarSeat, CarTransmission=@CarTransmission, CarEnergy=@CarEnergy, LocationId=@LocationId, IsDelisted=@IsDelisted ,CarImage=@CarImage WHERE CarPlate = @CarPlate";
                if (fuCarPic.HasFile)
                {
                    savePath = " ";
                    relPath = " ";
                    string ext = Path.GetExtension(fuCarPic.FileName);
                    string folderLocation = Server.MapPath("~/Image/CarImage");
                    string relfolderLocation = "~/Image/CarImage";
                    string fileName = txtCarPlate.Text + ext;
                    savePath = Path.Combine(folderLocation, fileName);
                    relPath = Path.Combine(relfolderLocation, fileName);
                    fuCarPic.SaveAs(savePath);
                }
                uploadCar(updateString,relPath);
                Server.Transfer("CarManagement.aspx");
            }
        }

        protected void uploadCar(string uploadString, string imgPath)
        {
            string price = txtCarPrice.Text.Replace("MYR ", "");
            float prices = float.Parse(price);
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(uploadString,con);            com.Parameters.AddWithValue("@CarPlate",txtCarPlate.Text);
            com.Parameters.AddWithValue("@CarBrand", ddlCarBrand.SelectedValue);
            com.Parameters.AddWithValue("@CarName", txtCarName.Text);
            com.Parameters.AddWithValue("@CType", ddlCarType.SelectedValue);
            com.Parameters.AddWithValue("@CarDesc", txtCarDesc.Text);
            com.Parameters.AddWithValue("@CarDayPrice", prices);
            com.Parameters.AddWithValue("@CarSeat", txtCarSeat.Text);
            com.Parameters.AddWithValue("@CarTransmission", ddlCarTransmission.SelectedValue);
            com.Parameters.AddWithValue("@CarEnergy", ddlCarEnergy.SelectedValue);
            com.Parameters.AddWithValue("@LocationId", ddlCarLocation.SelectedValue);
            com.Parameters.AddWithValue("@IsDelisted", int.Parse(ddlCarState.SelectedValue));
            com.Parameters.AddWithValue("@CarImage", imgPath);
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void btnEditCar_Click(object sender, EventArgs e)
        {
            ShowControls(carPanel);
            validateCarPic.Enabled = false;
            btnUploadCar.Visible = false;
            btnUpdateCar.Visible = true;
            btnDelete.Visible = true;
            txtCarPlate.ReadOnly = true;
            validateCarPlate.Enabled = false;
            validateCarPic.Enabled = false;
            Button btnEdit = (Button)sender;
            String carPlate = btnEdit.CommandArgument;
            loadCarData(carPlate);
        }

        protected void btnViewCar_Click(object sender, EventArgs e)
        {
            HideControls(carPanel);
            Button btnView = (Button)sender;
            String carPlate = btnView.CommandArgument;
            loadCarData(carPlate);
        }

        protected void loadCarData(String carPlate)
        {
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
                ddlCarBrand.SelectedValue = reader["CarBrand"].ToString();
                txtCarName.Text = reader["CarName"].ToString();
                ddlCarType.SelectedValue = reader["CType"].ToString();
                txtCarDesc.Text = reader["CarDesc"].ToString();
                txtCarPrice.Text = reader["CarDayPrice"].ToString();
                txtCarSeat.Text = reader["CarSeat"].ToString();
                ddlCarTransmission.SelectedValue = reader["CarTransmission"].ToString();
                ddlCarEnergy.SelectedValue = reader["CarEnergy"].ToString();
                ddlCarLocation.SelectedValue = reader["LocationId"].ToString();
                ddlCarState.SelectedValue = reader["IsDelisted"].ToString();
                imgCarPic.ImageUrl = reader["CarImage"].ToString();
            }
            con.Close();
            reader.Close();
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
            if (sort == "DESC")
            {
                button.CommandArgument = "ASC";
            }
            else
            {
                button.CommandArgument = "DESC";
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

        protected void validateCarPlate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            String selectCar = "SELECT COUNT(*) FROM Car WHERE CarPlate = @CarPlate";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCar, con);
            com.Parameters.AddWithValue("@CarPlate",txtCarPlate.Text);
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

        protected void repeaterCarTable_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            Button btnView = (Button)e.Item.FindControl("btnView");
            Button btnEdit = (Button)e.Item.FindControl("btnEdit");
            if (btnView != null && btnEdit != null)
            {
                ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
                scriptManager.RegisterPostBackControl(btnView);
                scriptManager.RegisterPostBackControl(btnEdit);
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
            string deleteString = "DELETE FROM Car WHERE CarPlate = @CarPlate";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(deleteString, con);
            com.Parameters.AddWithValue("@CarPlate", txtCarPlate.Text);
            com.ExecuteNonQuery();
            con.Close();
            Server.Transfer("CarManagement.aspx");
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
    }
}