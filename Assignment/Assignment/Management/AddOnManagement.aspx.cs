using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Printing;

namespace Assignment.Management
{
    public partial class AddOnManagement : System.Web.UI.Page
    {
        private int PageSize = 5;  // Number of records per page
        private int PageNumber
        {
            get { return Session["PageNumber"] != null ? (int)Session["PageNumber"] : 1; }
            set { Session["PageNumber"] = value; }
        }

        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                loadAddOnData();
            }
        }


        protected void loadAddOnData()
        {
            string selectAddOn = "SELECT * FROM AddOn ORDER BY Id OFFSET @Pagesize*(@PageNumber - 1) ROWS FETCH NEXT @Pagesize ROWS ONLY";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectAddOn, con);
            com.Parameters.AddWithValue("@PageSize", PageSize);
            com.Parameters.AddWithValue("@PageNumber", PageNumber);
            SqlDataAdapter da = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds, "AddOnTable");
            ViewState["AddOnTable"] = ds.Tables["AddOnTable"];
            repeaterAddOnTable.DataSource = ds.Tables["AddOnTable"];
            repeaterAddOnTable.DataBind();
            con.Close();
            UpdatePageInfo(false, getTotalRow());
        }

        protected void btnSort_Click(object sender, EventArgs e)
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

            // Trigger client-side icon update
            ScriptManager.RegisterStartupScript(this, GetType(), "UpdateSort", "updateSortIcons();", true);


            DataTable AddOnData = (DataTable)ViewState["AddOnTable"];
            DataView dataView = AddOnData.DefaultView;
            dataView.Sort = name + " " + sort;
            DataTable sortedData = dataView.ToTable();

            ViewState["AddOnTable"] = sortedData;
            repeaterAddOnTable.DataSource = sortedData;
            repeaterAddOnTable.DataBind();
            updateAddOn.Update();

            // Store the current sort direction
            hdnSortDirection.Value = button.CommandArgument; // Store current sort direction
        }

        protected int getTotalRow()
        {
            string selectAll = "SELECT COUNT(*) FROM AddOn";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            SqlCommand com = new SqlCommand(selectAll, con);
            con.Open();
            return (int)com.ExecuteScalar();
        }

        protected void UpdatePageInfo(bool isSearching, int row)
        {
            if (!isSearching)
            {
                int totalPage = (int)Math.Ceiling((double)row / (double)PageSize);
                lblPageInfo.Text = "Page " + PageNumber + " of " + totalPage;
                lblTotalRecord.Text = "Total Record: " + row;
                btnPrevious.Enabled = PageNumber > 1;
                btnNext.Enabled = PageNumber < totalPage;
            }
            else if (isSearching)
            {
                lblPageInfo.Text = "Page " + 1 + " of " + 1;
                lblTotalRecord.Text = "Total Record: " + row;
                btnPrevious.Enabled = false;
                btnNext.Enabled = false;
            }

        }


        protected void btnUploadAddOn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string savePath = " ";
                string relPath = " ";
                string insertString = "INSERT into AddOn(Name,Description,Price,Url,maxQuantity) VALUES (@Name,@Description,@Price,@Url,@maxQuantity)";
                 if (fuAddOnPic.HasFile)
                  {
                      savePath = " ";
                      relPath = " ";
                      string ext = Path.GetExtension(fuAddOnPic.FileName);
                      string folderLocation = Server.MapPath("~/Image/AddOnImg");
                      string relfolderLocation = "~/Image/AddOnImg";
                      string fileInputName = txtAddonName.Text.Trim();
                      fileInputName = fileInputName.Replace(" ", "");
                      string fileName = fileInputName + ext;
                      savePath = Path.Combine(folderLocation, fileName);
                      relPath = Path.Combine(relfolderLocation, fileName);
                      fuAddOnPic.SaveAs(savePath);
                  }
                uploadAddOn(insertString, relPath);
                Server.Transfer("AddOnManagement.aspx");
            }
        }


        protected void uploadAddOn(string uploadString, string imgPath)
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(uploadString, con);
            com.Parameters.AddWithValue("@Name", txtAddonName.Text);
            com.Parameters.AddWithValue("@Description",txtDescription.Text);
            com.Parameters.AddWithValue("@Price", txtAddonPrice.Text);
            com.Parameters.AddWithValue("@maxQuantity", txtMaxQuantity.Text);
            com.Parameters.AddWithValue("@Url", imgPath);
            com.Parameters.AddWithValue("@Id", hdnAddOnId.Value);
            com.ExecuteNonQuery();
            con.Close();
        }

        protected void btnUpdateAddOn_Click(object sender, EventArgs e)
        {
             if (Page.IsValid)
             {
                 string savePath = " ";
                 string relPath = imgAddOnPic.ImageUrl;
                 string updateString = "UPDATE AddOn SET Name=@Name, Description=@Description, Price=@Price, maxQuantity=@maxQuantity WHERE Id = @Id";
                 if (fuAddOnPic.HasFile)
                 {
                     savePath = " ";
                     relPath = " ";
                     string ext = Path.GetExtension(fuAddOnPic.FileName);
                     string folderLocation = Server.MapPath("~/Image/AddOnImg");
                     string relfolderLocation = "~/Image/AddOnImg";
                     string fileInputName = txtAddonName.Text.Trim();
                     fileInputName = fileInputName.Replace(" ", "");
                    string fileName = fileInputName + ext;
                     savePath = Path.Combine(folderLocation, fileName);
                     relPath = Path.Combine(relfolderLocation, fileName);
                     fuAddOnPic.SaveAs(savePath);
                 }
                 uploadAddOn(updateString, relPath);
                 Server.Transfer("AddOnManagement.aspx");
             }
        }

        protected void btnAddNewCar_Click(object sender, EventArgs e)
        { 
            Server.Transfer("AddOnManagement.aspx");
        }

        protected void hiddenBtn_Click(object sender, EventArgs e)
        {
            /*  string findCar = "SELECT C.*, L.LocationName FROM Car C JOIN Location L ON C.LocationId = L.Id WHERE (CarName LIKE @searchString OR CType LIKE @searchString OR CarBrand LIKE @searchString OR (CarBrand + CarName) LIKE @searchString) OR CarPlate LIKE @searchString";
              string search = searchBar.Text.Replace(" ", "");
              if (search == "")
              {
                  loadCarData();
                  UpdatePanel1.Update();
              }
              else
              {
                  SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
                  SqlCommand com = new SqlCommand(findCar, con);
                  con.Open();
                  com.Parameters.AddWithValue("@searchString", "%" + search + "%");
                  SqlDataAdapter da = new SqlDataAdapter(com);
                  DataSet ds = new DataSet();
                  da.Fill(ds, "CarTable");
                  int row = ds.Tables["CarTable"].Rows.Count;
                  ViewState["CarTable"] = ds.Tables["CarTable"];
                  repeaterCarTable.DataSource = ds.Tables["CarTable"];
                  repeaterCarTable.DataBind();
                  con.Close();
                  UpdatePageInfo(true, row);
                  UpdatePanel1.Update();
              }*/
        }



        protected void btnEditAddOn_Click(object sender, EventArgs e)
        {
            ShowControls(AddOnPanel);          
            validateAddOnPic.Enabled = false;
            btnUploadAddOn.Visible = false;
            btnUpdateAddOn.Visible = true;
            btnDelete.Visible = true;
            Button btnEdit = (Button)sender;
            String addOnID = btnEdit.CommandArgument;
            hdnAddOnId.Value = addOnID;
            loadAddOnData(addOnID);
        }


        protected void loadAddOnData(String addOnID)
        {
            String selectAddOn = "SELECT * FROM AddOn WHERE Id = @addOnID";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(selectAddOn, con);
            com.Parameters.AddWithValue("@addOnID", addOnID);

            SqlDataReader reader = com.ExecuteReader();

            if (reader.Read())
            {
                Session["AddOnName"] = reader["Name"].ToString();
                txtAddonName.Text = reader["Name"].ToString();
                txtDescription.Text = reader["Description"].ToString();

                double price = Convert.ToDouble(reader["Price"]);
                string price2dp= price.ToString("F2");
                txtAddonPrice.Text = price2dp;

                txtMaxQuantity.Text = reader["maxQuantity"].ToString();
                imgAddOnPic.ImageUrl = reader["Url"].ToString();
            }
            con.Close();
            reader.Close();
        }

        protected void btnViewAddOn_Click(object sender, EventArgs e)
        {
            HideControls(AddOnPanel);
            btnDelete.Visible = true;
            Button btnView = (Button)sender;
            String addOnID = btnView.CommandArgument;
            hdnAddOnId.Value = addOnID;
            loadAddOnData(addOnID);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", "disableUpload()", true);
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
         /*   PageNumber--;
            loadCarData();
            UpdatePanel1.Update();*/
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
           /* PageNumber++;
            loadCarData();
            UpdatePanel1.Update();*/
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

       

        protected void repeaterAddOnTable_ItemCreated(object sender, RepeaterItemEventArgs e)
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

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            string deleteString = "DELETE FROM AddOn WHERE Id = @Id";
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["DatabaseConnectionString"].ConnectionString);
            con.Open();
            SqlCommand com = new SqlCommand(deleteString, con);
            com.Parameters.AddWithValue("@Id", hdnAddOnId.Value);
            com.ExecuteNonQuery();
            con.Close();
            Server.Transfer("AddOnManagement.aspx");
        }
    }
}