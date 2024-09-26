using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Entity.Validation;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class AdminRewardPoint : System.Web.UI.Page
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
                var user = db.ApplicationUsers.ToList();

                RewardPointsListView.DataSource = user;
                RewardPointsListView.DataBind();
            }
        }

        protected void btnAddRewardPoints_Click(object sender, EventArgs e)
        {
            ClearForm();

            LinkButton btn = (LinkButton)sender;
            var userId = btn.CommandArgument.ToString();

            Session["UserIdRP"] = userId;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$(document).ready(function() { $('#pointsManagementModal').modal('show'); });", true);
        }

        protected void btnDeductRewardPoints_Click(object sender, EventArgs e)
        {
            ClearForm();

            LinkButton btn = (LinkButton)sender;
            var userId = btn.CommandArgument.ToString();

            Session["UserIdRP"] = userId;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal",
                "$(document).ready(function () { $('#pointsManagementModal').modal('show'); $('#deduct-tab').tab('show');});", true);
        }

        private void ClearForm()
        {
            txtPointsToAdd.Text = string.Empty;
            txtPointsToDeduct.Text = string.Empty;
        }

        protected void btnConfirmAddPoints_Click(object sender, EventArgs e)
        {

            var userId = Session["UserIdRP"]?.ToString();

            if (!string.IsNullOrEmpty(userId))
            {
                var pointsToAdd = int.TryParse(txtPointsToAdd.Text, out int points) ? points : 0;

                if (pointsToAdd > 0)
                {
                    using (var db = new SystemDatabaseEntities())
                    {
                        var user = db.ApplicationUsers.FirstOrDefault(u => u.Id == userId);

                        if (user != null)
                        {
                            user.RewardPoints += pointsToAdd;

                            db.SaveChanges();

                            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Reward Points inserted successfully!'); setTimeout(function() { window.location = 'AdminRewardPoint.aspx'; }, 1000);", true);
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Failed to Insert Reward Points!');", true);
                        }
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Failed to Insert Reward Points!');", true);
            }

        }

        protected void btnConfirmDeductPoints_Click(object sender, EventArgs e)
        {

            var userId = Session["UserIdRP"]?.ToString();

            if (!string.IsNullOrEmpty(userId))
            {
                var pointsToDeduct = int.TryParse(txtPointsToDeduct.Text, out int points) ? points : 0;

                if (pointsToDeduct > 0)
                {
                    using (var db = new SystemDatabaseEntities())
                    {
                        var user = db.ApplicationUsers.FirstOrDefault(u => u.Id == userId);

                        if (user != null)
                        {
                            if (user.RewardPoints >= pointsToDeduct)
                            {
                                user.RewardPoints -= pointsToDeduct;
                                db.SaveChanges();

                                ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "alert('Reward Points deducted successfully!'); setTimeout(function() { window.location = 'AdminRewardPoint.aspx'; }, 1000);", true);
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Insufficient points to deduct.');", true);
                            }

                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Failed to Deduct Reward Points');", true);
                        }
                    }
                }


            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('Failed to Deduct Reward Points!');", true);

            }
        }

        protected void RewardPointsListView_Sorting(object sender, ListViewSortEventArgs e)
        {
            string sortExpression = e.SortExpression;
            string sortDirection = ViewState["SortDirection"] as string == "ASC" ? "DESC" : "ASC";

            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = sortExpression;

            using (var db = new SystemDatabaseEntities())
            {
                var users = db.ApplicationUsers.AsQueryable();

                switch (sortExpression)
                {
                    case "Username":
                        users = sortDirection == "ASC" ? users.OrderBy(i => i.Username) :
                            users.OrderByDescending(i => i.Username);
                        break;
                    case "Email":
                        users = sortDirection == "ASC"
                            ? users.OrderBy(i => i.Email)
                            : users.OrderByDescending(i => i.Email);
                        break;
                    case "Reward Points":
                        users = sortDirection == "ASC"
                            ? users.OrderBy(i => i.RewardPoints)
                            : users.OrderByDescending(i => i.RewardPoints);
                        break;
                }

                RewardPointsListView.DataSource = users.ToList();
                RewardPointsListView.DataBind();

                UpdateSortIcons(sortExpression, sortDirection);
                DataPager reviewsPager = (DataPager)RewardPointsListView.FindControl("RewardPointsPager");
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
                case "Username":
                    var litUsernameIcon = (Literal)RewardPointsListView.FindControl("litUsernameIcon");
                    if (litUsernameIcon != null) litUsernameIcon.Text = sortIcon;
                    break;
                case "Email":
                    var litEmailIcon = (Literal)RewardPointsListView.FindControl("litEmailIcon");
                    if (litEmailIcon != null) litEmailIcon.Text = sortIcon;
                    break;
                case "Reward Points":
                    var litRewardPointsIcon = (Literal)RewardPointsListView.FindControl("litRewardPointsIcon");
                    if (litRewardPointsIcon != null) litRewardPointsIcon.Text = sortIcon;
                    break;
            }
        }

        private void ClearSortIcons()
        {
            var icons = new[] { "litUsernameIcon", "litEmailIcon", "litRewardPointsIcon"};

            foreach (var iconId in icons)
            {
                var literal = (Literal)RewardPointsListView.FindControl(iconId);
                if (literal != null)
                {
                    literal.Text = "";
                }
            }


        }

        protected void RewardPointsListView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            // Set the new page index
            DataPager reviewsPager = (DataPager)RewardPointsListView.FindControl("RewardPointsPager");
            reviewsPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            BindListView();
        }
    }
}