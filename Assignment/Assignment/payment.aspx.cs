using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace Assignment
{
    public partial class payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["Id"] != null)
                {
                    LoadUserData(Session["Id"].ToString());
                    txtExpDate.Attributes["max"] = DateTime.Now.AddYears(+6).ToString("yyyy-MM");
                    txtExpDate.Attributes["min"] = DateTime.Now.AddMonths(+1).ToString("yyyy-MM");
                }
                else
                {
                    Server.Transfer("home.aspx");
                }
                
            }
        }

        protected void LoadUserData(string id)
        {
            string loadUser = "SELECT * FROM PaymentCard WHERE UserId = @UserId ORDER BY IsDefault DESC";
            SqlConnection con = new SqlConnection(Global.CS);
            con.Open();

            SqlCommand com = new SqlCommand(loadUser, con);
            com.Parameters.AddWithValue("@UserId", id);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds,"PaymentCardInfo");
            if (ds.Tables["PaymentCardInfo"].Rows.Count == 0)
            {
                lblPaymentText.Text = "You have not added any payment card yet";
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
            string isDefault = DataBinder.Eval(e.Item.DataItem, "IsDefault").ToString();
            Button btnDefault = (Button)e.Item.FindControl("btnDefault");

            if(isDefault == "0")
            {
                btnDefault.Text = "Set as Default";
            }else if(isDefault == "1"){
                btnDefault.Text = "Default";
            }

            lblCardNumber.Text = lblCardNumber.Text.Substring(lblCardNumber.Text.Length - 4, 4);

            DateTime exp = DateTime.Parse(lblExp.Text);
            lblExp.Text = exp.ToString("MM/yy");

        }
    }
}