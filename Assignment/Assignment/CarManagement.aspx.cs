using System;
using System.Collections.Generic;
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

            }
        }

        protected void btnUpdateCar_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {

            }
        }
    }
}