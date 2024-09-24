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

            int redeemItemId = int.Parse(button.CommandArgument);
            using (var db = new SystemDatabaseEntities())
            {
                var redeemItem = db.RedeemItems.FirstOrDefault(r => r.RedeemItemId == redeemItemId);

                if (redeemItem != null)
                {
                    string imagePath = Server.MapPath("~/Image/RedeemItem/") + redeemItem.ItemImage;

                    try
                    {
                        if (System.IO.File.Exists(imagePath))
                        {
                            System.IO.File.Delete(imagePath);
                        }

                        db.RedeemItems.Remove(redeemItem);
                        db.SaveChanges();

                        ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Redeem item and associated image deleted successfully!');", true);

                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showErrorMessage", "alert('An unexpected error occurred. Please try again later.');", true);
                    }

                    
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showErrorMessage", "alert('Error: Redeem item not found.');", true);
                }
            }

            BindListView();
        }
        
            


        protected void btnSaveItem_Click(object sender, EventArgs e)
        {
            int redeemItemId;
            //try parse success ok, fail return false and value = 0
            int.TryParse(hfRedeemItemId.Value, out redeemItemId);

            using (var db = new SystemDatabaseEntities())
            {
                var item = db.RedeemItems.FirstOrDefault(i => i.RedeemItemId == redeemItemId);

                //update item
                if (item != null)
                {
                    item.ItemName = txtItemName.Text;
                    item.ItemPoints = int.Parse(txtItemPoints.Text);
                    item.ItemDescription = txtItemDescription.Text;
                    item.Status = ddlStatus.SelectedValue;

                    if (fuItemImage.HasFile)
                    {
                        string fileExtension = System.IO.Path.GetExtension(fuItemImage.FileName).ToLower();
                        if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png")
                        {
                            string oldImagePath = Server.MapPath("~/Image/RedeemItem/") + item.ItemImage;
                            if (System.IO.File.Exists(oldImagePath))
                            {
                                System.IO.File.Delete(oldImagePath);
                            }

                            string newFileName = Guid.NewGuid().ToString() + fileExtension;
                            string newFilePath = Server.MapPath("~/Image/RedeemItem/") + newFileName;
                            fuItemImage.SaveAs(newFilePath);

                            item.ItemImage = newFileName;

                            lblMessage.CssClass = "text-success";
                            lblMessage.Text = "File uploaded and updated successfully!";
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
                        lblMessage.CssClass = "text-info";
                        lblMessage.Text = "No new image uploaded. Existing image retained.";
                    }

                    db.SaveChanges();
                    ClearFormFields();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Redeem item updated successfully!'); setTimeout(function() { window.location = 'AdminRedemption.aspx'; }, 2000);", true);

                }
                else
                {
                    //add new redeem item
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

                    ClearFormFields();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Redeem item added successfully!'); setTimeout(function() { window.location = 'AdminRedemption.aspx'; }, 2000);", true);

                }

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
            LinkButton btnEdit = (LinkButton)sender;
            int redeemItemId = Convert.ToInt32(btnEdit.CommandArgument);

            using (var db = new SystemDatabaseEntities())
            {
                var item = db.RedeemItems.FirstOrDefault(i => i.RedeemItemId == redeemItemId);
                if (item != null)
                {
                    txtItemName.Text = item.ItemName;
                    txtItemPoints.Text = item.ItemPoints.ToString();
                    txtItemDescription.Text = item.ItemDescription;
                    ddlStatus.SelectedValue = item.Status;

                    hfRedeemItemId.Value = redeemItemId.ToString();

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$(document).ready(function() { $('#staticBackdrop').modal('show'); });", true);
                }
            }
        }

        protected void lvRedeemItems_Sorting(object sender, ListViewSortEventArgs e)
        {

        }
    }
}