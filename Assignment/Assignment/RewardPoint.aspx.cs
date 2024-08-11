using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//step1
using System.Data.SqlClient;
using System.Configuration;

namespace Assignment
{
    public partial class RewardPoint : System.Web.UI.Page
    {
        //step2
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnUserRegister_Click(object sender, EventArgs e)
        {   
            con.Open();
            //simulate when user successfully register
            string query = "INSERT INTO RewardPoint (UserID, Points, CreatedAt, UpdatedAt, Status) " +
                   "VALUES (@UserID, 0, GETDATE(), GETDATE(), 'active');";
            //pass query in database
            SqlCommand cmd = new SqlCommand(query, con);

            // Add the user ID parameter to the query.
            cmd.Parameters.AddWithValue("@UserID", "U001");

            // Execute the query to insert the record.
            cmd.ExecuteNonQuery();

            con.Close();
        }
    }
}