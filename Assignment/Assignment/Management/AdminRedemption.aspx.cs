using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
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

                    if (fuRdmItem.HasFile)
                    {
                        if (!string.IsNullOrEmpty(hdnRedemptionPicture.Value))
                        {
                            string oldImagePath = Server.MapPath("~/Image/RedeemItem/") + item.ItemImage;
                            if (System.IO.File.Exists(oldImagePath))
                            {
                                System.IO.File.Delete(oldImagePath);
                            }

                            string newFileName = Guid.NewGuid().ToString() + ".png";
                            string newFilePath = Server.MapPath("~/Image/RedeemItem/") + newFileName;
                            // Decode the Base64 string and save it as an image file
                            string base64String = hdnRedemptionPicture.Value.Split(',')[1]; // Remove the data URI scheme part
                            byte[] imageBytes = Convert.FromBase64String(base64String);
                            File.WriteAllBytes(newFilePath, imageBytes); // Save the file

                            item.ItemImage = newFileName;

                            lblMessage.CssClass = "text-success";
                            lblMessage.Text = "File uploaded and updated successfully!";
                        }
                        else
                        {
                            lblMessage.CssClass = "text-warning";
                            lblMessage.Text = "Only .jpg or .png files are allowed.";
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Redeem item updated successfully!'); setTimeout(function() { window.location = 'AdminRedemption.aspx'; }, 1000);", true);

                }
                else
                {
                    //add new redeem item
                    string itemName = txtItemName.Text;
                    int itemPoints = int.Parse(txtItemPoints.Text);
                    string itemDescription = txtItemDescription.Text;
                    string status = ddlStatus.SelectedValue;
                    string fileName = "";

                    if (!string.IsNullOrEmpty(hdnRedemptionPicture.Value))
                    {
                        try
                        {
                            fileName = Guid.NewGuid().ToString() + ".png";
                            string filePath = Server.MapPath("~/Image/RedeemItem/") + fileName;
                            // Decode the Base64 string and save it as an image file
                            string base64String = hdnRedemptionPicture.Value.Split(',')[1]; // Remove the data URI scheme part
                            byte[] imageBytes = Convert.FromBase64String(base64String);
                            File.WriteAllBytes(filePath, imageBytes); // Save the file

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
                        lblMessage.Text = "Please select a file to upload.";
                        lblMessage.Visible = true;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$(document).ready(function() { $('#staticBackdrop').modal('show'); });", true);
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
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Redeem item added successfully!'); setTimeout(function() { window.location = 'AdminRedemption.aspx'; }, 1000);", true);

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
            hfRedeemItemId.Value = string.Empty;
            lblMessage.Text = string.Empty;
        }

        protected void btnEditRedeemItem_Click(object sender, EventArgs e)
        {
            ClearFormFields();
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
            string sortExpression = e.SortExpression;
            string sortDirection = ViewState["SortDirection"] as string == "ASC" ? "DESC" : "ASC";

            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = sortExpression;

            using (var db = new SystemDatabaseEntities())
            {
                var redeemItems = db.RedeemItems.AsQueryable();

                switch (sortExpression)
                {
                    case "ItemName":
                        redeemItems = sortDirection == "ASC" ? redeemItems.OrderBy(i => i.ItemName) :
                            redeemItems.OrderByDescending(i => i.ItemName);
                        break;
                    case "ItemPoints":
                        redeemItems = sortDirection == "ASC"
                            ? redeemItems.OrderBy(i => i.ItemPoints)
                            : redeemItems.OrderByDescending(i => i.ItemPoints);
                        break;
                    case "ItemDescription":
                        redeemItems = sortDirection == "ASC"
                            ? redeemItems.OrderBy(i => i.ItemDescription)
                            : redeemItems.OrderByDescending(i => i.ItemDescription);
                        break;
                    case "Status":
                        redeemItems = sortDirection == "ASC"
                            ? redeemItems.OrderBy(i => i.Status)
                            : redeemItems.OrderByDescending(i => i.Status);
                        break;
                }

                lvRedeemItems.DataSource = redeemItems.ToList();
                lvRedeemItems.DataBind();

                UpdateSortIcons(sortExpression, sortDirection);
                DataPager reviewsPager = (DataPager)lvRedeemItems.FindControl("ReviewsPager");
                reviewsPager.DataBind();
                UpdatePanel1.Update();
            }
        }

        private void UpdateSortIcons(string sortExpression, string sortDirection)
        {
            ClearSortIcons();

            string sortIcon = sortDirection == "ASC" ? " ▲" : " ▼";

            switch (sortExpression)
            {
                case "ItemName":
                    var litItemNameIcon = (Literal)lvRedeemItems.FindControl("litItemNameIcon");
                    if (litItemNameIcon != null) litItemNameIcon.Text = sortIcon;
                    break;
                case "ItemPoints":
                    var litItemPointsIcon = (Literal)lvRedeemItems.FindControl("litItemPointsIcon");
                    if (litItemPointsIcon != null) litItemPointsIcon.Text = sortIcon;
                    break;
                case "ItemDescription":
                    var litItemDescriptionIcon = (Literal)lvRedeemItems.FindControl("litItemDescriptionIcon");
                    if (litItemDescriptionIcon != null) litItemDescriptionIcon.Text = sortIcon;
                    break;
                case "Status":
                    var litStatusIcon = (Literal)lvRedeemItems.FindControl("litStatusIcon");
                    if (litStatusIcon != null) litStatusIcon.Text = sortIcon;
                    break;
            }

        }

        private void ClearSortIcons()
        {
            var icons = new[] { "litItemNameIcon", "litItemPointsIcon", "litItemDescriptionIcon", "litStatusIcon"};

            foreach (var iconId in icons)
            {
                var literal = (Literal)lvRedeemItems.FindControl(iconId);
                if (literal != null)
                {
                    literal.Text = "";
                }
            }


        }

        protected void btnAddReviewItem_Click(object sender, EventArgs e)
        {
            ClearFormFields();

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$(document).ready(function() { $('#staticBackdrop').modal('show'); });", true);
        }

        protected void lvRedeemItems_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {

            // Set the new page index
            DataPager reviewsPager = (DataPager)lvRedeemItems.FindControl("ReviewsPager");
            reviewsPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindListView();
        }
    }
}