using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Management
{
    public partial class AdminRedemption : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindListView();
            }
        }

        private void BindListView()
        {
            using (var db = new SystemDatabaseEntities())
            {
                var redeemItem = db.RedeemItems.ToList();

                lvRedeemItems.DataSource = redeemItem;
                lvRedeemItems.DataBind();
            }
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            var button = (LinkButton)sender;

            int RedeemItemId = int.Parse(button.CommandArgument);

            using (var db = new SystemDatabaseEntities())
            {
                var redeemItems = db.RedeemItems.FirstOrDefault(r => r.RedeemItemId == RedeemItemId);

                if (redeemItems != null)
                {
                    db.RedeemItems.Remove(redeemItems);

                    db.SaveChanges();

                    BindListView();
                }
            }
        }


        protected void btnSaveItem_Click(object sender, EventArgs e)
        {
            string itemName = txtItemName.Text;
            int itemPoints = int.Parse(txtItemPoints.Text);
            string itemDescription = txtItemDescription.Text;
            string status = ddlStatus.SelectedValue;
            string fileName = "";

            if (fuItemImage.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(fuItemImage.FileName).ToLower();

                if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                {
                    try
                    {
                        fileName = Guid.NewGuid().ToString() + fileExtension;
                        string filePath = Server.MapPath("~/Image/RedeemItem/") + fileName;

                        fuItemImage.SaveAs(filePath);

                        lblMessage.CssClass = "text-success";
                        lblMessage.Text = "File uploaded successfully!";
                    }
                    catch (Exception ex)
                    {
                        lblMessage.CssClass = "text-danger";
                        lblMessage.Text = "Error uploading file: " + ex.Message;
                        lblMessage.Visible = true;
                        return;
                    }
                }
                else
                {
                    lblMessage.CssClass = "text-warning";
                    lblMessage.Text = "Only .jpg, .jpeg, or .png files are allowed.";
                    lblMessage.Visible = true;
                    return;
                }
            }
            else
            {
                lblMessage.CssClass = "text-warning";
                lblMessage.Text = "Please select a file to upload.";
                lblMessage.Visible = true;
                return;
            }

            using (var db = new SystemDatabaseEntities())
            {
                var newItem = new RedeemItem
                {
                    ItemName = itemName,
                    ItemPoints = itemPoints,
                    ItemDescription = itemDescription,
                    Status = status,
                    ItemImage = fileName
                };

                db.RedeemItems.Add(newItem);
                db.SaveChanges();

                lblMessage.CssClass = "text-success";
                lblMessage.Text = "Redeem item added successfully!";
                lblMessage.Visible = true;
                ClearFormFields();
            }
        }

        private void ClearFormFields()
        {
            txtItemName.Text = "";
            txtItemPoints.Text = "";
            txtItemDescription.Text = "";
            ddlStatus.SelectedIndex = 0;
            lblMessage.Visible = false;
        }

        protected void btnEditRedeemItem_Click(object sender, EventArgs e)
        {

        }
    }
}