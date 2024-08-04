using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
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
            ddlCarBrand.Items.Insert(0, new ListItem("Select Brand", "0"));
            string[] carBrand = {"Select Brand","Abarth","Alfa Romeo","Aston Martin","Audi","Bentley","BMW","Bugatti","Cadillac","Chevrolet","Chrysler","Citroën","Dacia","Daewoo","Daihatsu","Dodge","Donkervoort","DS","Ferrari","Fiat","Fisker","Ford","Honda","Hummer","Hyundai","Infiniti","Iveco","Jaguar","Jeep","Kia","KTM","Lada","Lamborghini","Lancia","Land Rover","Landwind","Lexus","Lotus","Maserati","Maybach","Mazda","McLaren","Mercedes-Benz","MG","Mini","Mitsubishi","Morgan","Nissan","Opel","Peugeot","Porsche","Renault","Rolls Royce","Rover","Saab","Seat","Skoda","Smart","SsangYong","Subaru","Suzuki","Tesla","Toyota","Volkswagen","Volvo" };
            for(int i=1; i<carBrand.Length; i++)
                {
                    ddlCarBrand.Items.Insert(i, new ListItem(carBrand[i], carBrand[i]));
                }
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
                string price = txtCarPrice.Text.Replace("MYR ", "");
            }
        }

        protected void btnUpdateCar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

            }
        }

        protected void btnEditCar_Click(object sender, EventArgs e)
        {
            ShowControls(carPanel);
            validateCarPic.Enabled = false;
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
    }
}