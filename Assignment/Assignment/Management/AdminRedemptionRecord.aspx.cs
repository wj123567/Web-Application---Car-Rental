using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Runtime.Remoting.Contexts;
using System.Data.Entity.Validation;
using System.Data.Entity.Infrastructure;

namespace Assignment.Management
{
    public partial class AdminRedemptionRecord : System.Web.UI.Page
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
                var redemptionRecords = db.Redemptions
                                        .Include("RedeemItem")
                                        .Include("ApplicationUser")
                                        .Select(r => new
                                        {
                                            r.RedeemItemId,
                                            r.UserId,
                                            UserName = r.ApplicationUser.Username,
                                            ItemName = r.RedeemItem.ItemName,
                                            ItemPoints = r.RedeemItem.ItemPoints,
                                            r.RedeemDate,
                                            r.IsActive
                                        }).ToList();

                lvRedemption.DataSource = redemptionRecords;
                lvRedemption.DataBind();
            }
        }

        protected void lvRedemption_Sorting(object sender, ListViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;
            string sortDirection = ViewState["SortDirection"] as string == "ASC" ? "DESC" : "ASC";

            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = sortExpression;

            using (var db = new SystemDatabaseEntities())
            {
                var redemptions = db.Redemptions
                                    .Include("ApplicationUser")
                                    .Include("RedeemItem")
                                    .Select(r => new
                                    {
                                        r.RedeemItemId,
                                        r.UserId,
                                        UserName = r.ApplicationUser.Username,
                                        ItemName = r.RedeemItem.ItemName,
                                        ItemPoints = r.RedeemItem.ItemPoints,
                                        r.RedeemDate,
                                        r.IsActive
                                    })
                                    .AsQueryable();

                switch (sortExpression)
                {
                    case "UserName":
                        redemptions = sortDirection == "ASC" ? redemptions.OrderBy(i => i.UserName) :
                            redemptions.OrderByDescending(i => i.UserName);
                        break;
                    case "ItemName":
                        redemptions = sortDirection == "ASC"
                            ? redemptions.OrderBy(i => i.ItemName)
                            : redemptions.OrderByDescending(i => i.ItemName);
                        break;
                    case "ItemPoints":
                        redemptions = sortDirection == "ASC"
                            ? redemptions.OrderBy(i => i.ItemPoints)
                            : redemptions.OrderByDescending(i => i.ItemPoints);
                        break;
                    case "RedeemDate":
                        redemptions = sortDirection == "ASC"
                            ? redemptions.OrderBy(r => r.RedeemDate)
                            : redemptions.OrderByDescending(r => r.RedeemDate);
                        break;
                    case "Status":
                        redemptions = sortDirection == "ASC"
                            ? redemptions.OrderBy(i => i.IsActive)
                            : redemptions.OrderByDescending(i => i.IsActive);
                        break;
                }

                lvRedemption.DataSource = redemptions.ToList();
                lvRedemption.DataBind();

                UpdateSortIcons(sortExpression, sortDirection);
                DataPager reviewsPager = (DataPager)lvRedemption.FindControl("ReviewsPager");
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
                case "UserName":
                    var litUserNameIcon = (Literal)lvRedemption.FindControl("litUserNameIcon");
                    if (litUserNameIcon != null) litUserNameIcon.Text = sortIcon;
                    break;
                case "ItemName":
                    var litItemNameIcon = (Literal)lvRedemption.FindControl("litItemNameIcon");
                    if (litItemNameIcon != null) litItemNameIcon.Text = sortIcon;
                    break;
                case "ItemPoints":
                    var litItemPointsIcon = (Literal)lvRedemption.FindControl("litItemPointsIcon");
                    if (litItemPointsIcon != null) litItemPointsIcon.Text = sortIcon;
                    break;
                case "RedeemDate":
                    var litRedeemDateIcon = (Literal)lvRedemption.FindControl("litRedeemDateIcon");
                    if (litRedeemDateIcon != null) litRedeemDateIcon.Text = sortIcon;
                    break;
                case "Status":
                    var litStatusIcon = (Literal)lvRedemption.FindControl("litStatusIcon");
                    if (litStatusIcon != null) litStatusIcon.Text = sortIcon;
                    break;
            }



        }

        private void ClearSortIcons()
        {
            var icons = new[] { "litUserNameIcon", "litItemNameIcon", "litItemPointsIcon", "litRedeemDateIcon" , "litStatusIcon" };

            foreach (var iconId in icons)
            {
                var literal = (Literal)lvRedemption.FindControl(iconId);
                if (literal != null)
                {
                    literal.Text = "";
                }
            }
        }

        protected void lvRedemption_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            // Set the new page index
            DataPager reviewsPager = (DataPager)lvRedemption.FindControl("ReviewsPager");
            reviewsPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindListView();

        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Ensure the sender is of the correct type
            if (sender is DropDownList ddlStatus)
            {
                ListViewItem item = (ListViewItem)ddlStatus.NamingContainer;

                HiddenField hfRedeemItemId = (HiddenField)item.FindControl("hfRedeemItemId");
                HiddenField hfRedeemDate = (HiddenField)item.FindControl("hfRedeemDate");
                HiddenField hfUserId = (HiddenField)item.FindControl("hfUserId");

                if (hfRedeemItemId == null || hfRedeemDate == null || hfUserId == null)
                {
                    ShowErrorMessage("Required data is missing.");
                    return;
                }

                if (!int.TryParse(hfRedeemItemId.Value, out int redeemItemId))
                {
                    ShowErrorMessage("Invalid redeem item ID.");
                    return;
                }

                if (!DateTime.TryParse(hfRedeemDate.Value, out DateTime redeemDate))
                {
                    ShowErrorMessage("Invalid redeem date format.");
                    return;
                }

                string userId = hfUserId.Value;

                try
                {
                    using (var db = new SystemDatabaseEntities())
                    {
                        string query = "UPDATE Redemption SET IsActive = @IsActive WHERE RedeemItemId = @RedeemItemId AND UserId = @UserId AND CAST(RedeemDate AS DATE) = @RedeemDate";

                        var parameters = new[]
                        {
                    new SqlParameter("@IsActive", ddlStatus.SelectedValue == "True"),
                    new SqlParameter("@RedeemItemId", redeemItemId),
                    new SqlParameter("@UserId", userId),
                    new SqlParameter("@RedeemDate", redeemDate)
                };

                        int rowsAffected = db.Database.ExecuteSqlCommand(query, parameters);

                        // Optionally, check if any rows were affected and give feedback if needed
                        if (rowsAffected == 0)
                        {
                            ShowErrorMessage("No records were updated. Please verify the details.");
                        }
                    }
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Status Updated successfully!');", true);
                    // Rebind the ListView to reflect changes
                    BindListView();


                }
                catch (Exception ex)
                {
                    string escapedMessage = ex.Message.Replace("'", "\\'").Replace("\"", "\\\"");
                    ScriptManager.RegisterStartupScript(this, GetType(), "showErrorMessage", $"alert('{escapedMessage}');", true);
                }
            }
            else
            {
                ShowErrorMessage("Invalid sender type.");
            }
        }

        // Helper method to display error messages
        private void ShowErrorMessage(string message)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showErrorMessage", $"alert('{message}');", true);
        }


        protected void lvRedemption_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                // Get the data item
                var dataItem = e.Item.DataItem as dynamic;

                // Find the DropDownList
                DropDownList ddlStatus = (DropDownList)e.Item.FindControl("ddlStatus");

                if (ddlStatus != null)
                {
                    ddlStatus.SelectedValue = dataItem.IsActive ? "True" : "False";
                }
            }
        }



        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            string commandArgument = btn.CommandArgument;

            // Split command argument to retrieve IDs
            string[] args = commandArgument.Split('|');
            string redeemItemId = args[0];
            string userId = args[1];
            DateTime redeemDate = DateTime.Parse(args[2]);

            using (var db = new SystemDatabaseEntities())
            {
                string query = "DELETE FROM Redemption WHERE RedeemItemId = @RedeemItemId AND UserId = @UserId AND CAST(RedeemDate AS DATE) = @RedeemDate";

                var parameters = new[]
                {
                    new SqlParameter("@RedeemItemId", redeemItemId),
                    new SqlParameter("@UserId", userId),
                    new SqlParameter("@RedeemDate", redeemDate)
                };


                int rowsAffected = db.Database.ExecuteSqlCommand(query, parameters);

                if (rowsAffected > 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Redemption Record Deleted successfully!');", true);
                    BindListView();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Redemption Record Deleted Failed!');", true);
                }
            }
        }
    }
}