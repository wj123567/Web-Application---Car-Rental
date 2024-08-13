using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.ConstrainedExecution;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
	public partial class infopage : System.Web.UI.Page
	{
       

      
        

        
  
 
        protected void Page_Load(object sender, EventArgs e)
		{
            if (!Page.IsPostBack)
            {
                if (Session["CarPlate"] != null)
                {
                    string carPlate = Session["CarPlate"].ToString();

                    // Assuming you have a method to get car details by carPlate
                    GetCarDetailsByCarPlate(carPlate);
   
                }
            }
            
        }

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

                            headerCarModel.Text = reader["CarBrand"].ToString() + " " +reader["CarName"].ToString()+"["+reader["CarPlate"]+"]";
                            specType.Text = reader["CType"].ToString();
                            specSeat.Text = reader["CarSeat"].ToString() +" People";
                            carImage.ImageUrl = reader["CarImage"].ToString();
                            specTransmission.Text = reader["CarTransmission"].ToString();
                            specFuel.Text = reader["CarEnergy"].ToString();

                            DateTime startDateTime = DateTime.Parse(Session["StartDate"].ToString());
                            DateTime endDateTime = DateTime.Parse(Session["EndDate"].ToString());

                            // Extract only the date component
                            DateTime startDate = new DateTime(startDateTime.Year, startDateTime.Month, startDateTime.Day);
                            DateTime endDate = new DateTime(endDateTime.Year, endDateTime.Month, endDateTime.Day);

                            // Calculate the difference in days
                            TimeSpan dateDifference = endDate - startDate;
                            int dayDifference = dateDifference.Days; // This will be 3
                            decimal carDayPrice;
                            if (decimal.TryParse(reader["CarDayPrice"].ToString(), out carDayPrice))
                            {
                                decimal totalCost = carDayPrice * dayDifference;
                                carRental.Text = totalCost.ToString("F2"); // Format as currency
                            }
                            else
                            {
                                carRental.Text = "Price not available";
                            }
                        };
                    }
                }

                reader.Close();
                con.Close();
            }
              
          
        }

       
       
     
        protected void btnNext_Click(object sender, EventArgs e)
        {
            Server.Transfer("bookinfo.aspx");
        }

        protected void previous_btn_Click(object sender, EventArgs e)
        {
            Server.Transfer("Home.aspx");
        }
    }
}