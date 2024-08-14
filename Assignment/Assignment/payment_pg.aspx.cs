using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class payment_pg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["Id"] != null)
                {
                    LoadUserData();
                   
                }

            }
        }

        protected void LoadUserData()
        {
            string loadUser = "SELECT * FROM PaymentCard WHERE UserId = @UserId ORDER BY IsDefault DESC";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();

            SqlCommand com = new SqlCommand(loadUser, con);
            com.Parameters.AddWithValue("@UserId", "8cad4cfc - fa92 - 4e08 - 9092 - 0ca067260e0a");
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "PaymentCardInfo");
            if (ds.Tables["PaymentCardInfo"].Rows.Count == 0)
            {
                lblPaymentText.Text = "You have not added any payment card yet";
                Session["firstCard"] = "1";
            }
            else
            {
                lblPaymentText.Text = " ";
                paymentRepeater.DataSource = ds;
                paymentRepeater.DataBind();
            }
        }

        protected void paymentRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Label lblCardNumber = (Label)e.Item.FindControl("lblCardNumber");
            Label lblExp = (Label)e.Item.FindControl("lblExp");
            Label lblCardType = (Label)e.Item.FindControl("lblCardType");
            string isDefault = DataBinder.Eval(e.Item.DataItem, "IsDefault").ToString();
            string cardType = DataBinder.Eval(e.Item.DataItem, "CardType").ToString();
            Button btnDefault = (Button)e.Item.FindControl("btnDefault");

            if (isDefault == "0")
            {
                btnDefault.Text = "Set as Default";
            }
            else if (isDefault == "1")
            {
                btnDefault.Text = "Default";
            }

            switch (cardType)
            {
                case "Visa":
                    lblCardType.CssClass = "fab fa-cc-visa fa-2x";
                    break;
                case "Master":
                    lblCardType.CssClass = "fab fa-cc-mastercard fa-2x";
                    break;
                case "Amex":
                    lblCardType.CssClass = "fab fa-cc-amex fa-2x";
                    break;
            }

            lblCardNumber.Text = lblCardNumber.Text.Substring(lblCardNumber.Text.Length - 4, 4);

            DateTime exp = DateTime.Parse(lblExp.Text);
            lblExp.Text = exp.ToString("MM/yy");

        }

        protected void btnPaymentPgBack_Click(object sender, EventArgs e)
        {
            Server.Transfer("bookinfo.aspx");

        }

        protected void btnPaymentPgPay_Click(object sender, EventArgs e)
        {
            Server.Transfer("bookingrecord.aspx");
        }

        
    }
}