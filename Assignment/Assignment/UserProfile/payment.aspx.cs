using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Xml.Linq;
using System.Drawing;
using System.Configuration;
using System.Web.Security;

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
                    Session["Id"] = getCookies();
                    LoadUserData(Session["Id"].ToString());
                }

            }
        }
        protected string getCookies()
        {
            HttpCookie authCookie = Request.Cookies[FormsAuthentication.FormsCookieName];
            string userId = null;
            if (authCookie != null)
            {
                FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(authCookie.Value);
                if (ticket != null)
                {
                    userId = ticket.Name;
                }
            }

            return userId;
        }

        protected void LoadUserData(string id)
        {
            string loadUser = "SELECT * FROM PaymentCard WHERE UserId = @UserId ORDER BY IsDefault DESC";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();

            SqlCommand com = new SqlCommand(loadUser, con);
            com.Parameters.AddWithValue("@UserId", id);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds,"PaymentCardInfo");
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

            if(isDefault == "0")
            {
                btnDefault.Text = "Set as Default";
            }else if(isDefault == "1"){
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

        protected void btnUpdateCard_Click(object sender, EventArgs e)
        {
            string updateString = "UPDATE PaymentCard SET CardNumber = @CardNumber, CardHolderName = @CardHolderName, ExpDate = @ExpDate, CVV = @CVV, UserId = @UserId, CardType = @CardType, IsDefault = @IsDefault WHERE Id = @Id";

            SaveCardInfo(updateString, Session["cardID"].ToString());
        }

        protected void btnUploadCard_Click(object sender, EventArgs e)
        {
            string insertString = "INSERT into PaymentCard (CardNumber, CardHolderName, ExpDate, CVV, UserId, CardType, Id, IsDefault) VALUES (@CardNumber , @CardHolderName, @ExpDate, @CVV, @UserId, @CardType, @Id, @IsDefault)";
            Guid newGUID = Guid.NewGuid();
            SaveCardInfo(insertString, newGUID.ToString());
        }

        protected void SaveCardInfo(string uploadString, string id)
        {
            if (Page.IsValid)
            {
                int defaultCard = 0;
                if (Session["firstCard"] != null)
                {
                    defaultCard = 1;
                }
                Session["firstCard"] = null;
                String cardType = hdnCardType.Value;               

                DateTime expDate = DateTime.Parse(txtExpDate.Text);
                String cardNumber = txtCardNum.Text.Replace(" ","");

                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                con.Open();
                SqlCommand com = new SqlCommand(uploadString, con);
                com.Parameters.AddWithValue("@CardNumber", cardNumber);
                com.Parameters.AddWithValue("@CardHolderName", txtCHName.Text);
                com.Parameters.AddWithValue("@ExpDate", expDate);
                com.Parameters.AddWithValue("@CVV", txtCvv.Text);
                com.Parameters.AddWithValue("@UserId", Session["Id"].ToString());
                com.Parameters.AddWithValue("@CardType", cardType);
                com.Parameters.AddWithValue("@Id", id);
                com.Parameters.AddWithValue("@IsDefault", defaultCard);
                com.ExecuteNonQuery();
                Server.Transfer("payment.aspx");
            }

        }

        protected void validateCard_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string selectCard = "Select count(*) from PaymentCard WHERE CardNumber = @CardNumber AND UserId = @Id";
            String cardNumber = txtCardNum.Text.Replace(" ", "");
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectCard, con);
            com.Parameters.AddWithValue("@CardNumber",cardNumber);
            com.Parameters.AddWithValue("@Id", Session["Id"].ToString());
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            if(temp == 0)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;

            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            btnUploadCard.Visible = false;
            btnUpdateCard.Visible = true;
            btnDelete.Visible = true;
            validateCardExist.Enabled = false;

            String selectDriver = "SELECT * FROM PaymentCard WHERE Id = @id";
            Button btnEdit = (Button)sender;
            String id = btnEdit.CommandArgument;
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectDriver, con);
            com.Parameters.AddWithValue("@Id", id);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Session["CardID"] = reader["Id"].ToString();
                txtCardNum.Text = reader["CardNumber"].ToString();
                txtCHName.Text = reader["CardHolderName"].ToString();
                DateTime expDate = reader.GetDateTime(reader.GetOrdinal("ExpDate"));
                txtExpDate.Text = expDate.ToString("yyyy-MM");
            }
            con.Close();
            reader.Close();
        }
        protected void btnDefault_Click(object sender, EventArgs e)
        {
            Button btnDelete = (Button)sender;
            String cardId = btnDelete.CommandArgument;
            String updateString = "UPDATE PaymentCard SET IsDefault = 0 WHERE UserID = @UserID";
            String defaultString = "UPDATE PaymentCard SET IsDefault = 1 WHERE Id = @id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(updateString,con);
            com.Parameters.AddWithValue("@UserID", Session["Id"].ToString());
            com.ExecuteNonQuery();
            com = new SqlCommand(defaultString,con);
            com.Parameters.AddWithValue("@id",cardId);
            com.ExecuteNonQuery();
            con.Close();
            Server.Transfer("payment.aspx");
        }

        protected void btnAddNewCard_Click(object sender, EventArgs e)
        {
            Server.Transfer("payment.aspx");
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            
            string deleteString = "DELETE FROM PaymentCard WHERE Id = @Id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(deleteString,con);
            com.Parameters.AddWithValue("@Id", Session["CardID"].ToString());
            com.ExecuteNonQuery();
            checkNoDefault();
            Server.Transfer("payment.aspx");
            con.Close();
        }

        protected void checkNoDefault()
        {
            string checkString = "SELECT COUNT(*) FROM PaymentCard WHERE UserId = @UserId AND IsDefault = 1";
            string addDefault = "UPDATE PaymentCard SET IsDefault = 1 WHERE UserId = @UserId AND Id = (SELECT MAX(Id) From PaymentCard WHERE UserId = @UserId)";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(checkString, con);
            com.Parameters.AddWithValue("@UserId", Session["Id"].ToString());
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());
            if (temp == 0)
            {
                com = new SqlCommand(addDefault,con);
                com.Parameters.AddWithValue("@UserId", Session["Id"].ToString());
                com.ExecuteNonQuery();
            }
            con.Close();
        }
    }
}