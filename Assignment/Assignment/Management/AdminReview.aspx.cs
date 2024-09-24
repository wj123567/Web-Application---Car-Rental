using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment.Management
{
    public partial class AdminReview : System.Web.UI.Page
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
                var reviews = db.Reviews.ToList();

                lvReview.DataSource = reviews;
                lvReview.DataBind();
            }
        }


        protected void btnViewReview_Click(object sender, EventArgs e)
        {
            
            var button = (LinkButton)sender;
            int reviewId = int.Parse(button.CommandArgument);

            using (var db = new SystemDatabaseEntities())
            {
                var review = db.Reviews
                    .Include("Booking.Car")
                    .Include("Booking.ApplicationUser")
                    .FirstOrDefault(r => r.ReviewId == reviewId);

                if (review != null)
                {
                    lblBookingId.Text = review.Booking.Id.ToString();
                    lblCarName.Text = review.Booking.Car.CarBrand.ToString() + " " + review.Booking.Car.CarName.ToString();
                    lblUserId.Text = review.Booking.ApplicationUser.Username.ToString();
                    lblReviewText.Text = review.ReviewText;
                    lblRating.Text = review.Rating.ToString();
                    lblReviewDate.Text = review.ReviewDate.ToString();


                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowModal", "$(document).ready(function() { $('#staticBackdrop').modal('show'); });", true);

                }
            }
        }

        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            var button = (LinkButton)sender;

            int reviewId = int.Parse(button.CommandArgument);

            using (var db = new SystemDatabaseEntities())
            {
                var review = db.Reviews.FirstOrDefault(r => r.ReviewId == reviewId);

                if (review != null)
                {
                    db.Reviews.Remove(review);

                    db.SaveChanges();

                    BindListView();
                }
            }
        }

        protected void lvReview_Sorting(object sender, ListViewSortEventArgs e)
        {
            var reviews = GetReviews();

            string sortDirection = ViewState["SortDirection"] as string == "ASC" ? "DESC" : "ASC";

            //save direction in viewstate
            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = e.SortExpression;

            switch (e.SortExpression)
            {
                case "ReviewId":
                    reviews = sortDirection == "ASC" ? reviews.OrderBy(r => r.ReviewId).ToList() : reviews.OrderByDescending(r => r.ReviewId).ToList();
                    SetSortIcon("ReviewId", sortDirection);
                    break;
                case "BookingId":
                    reviews = sortDirection == "ASC" ? reviews.OrderBy(r => r.BookingId).ToList() : reviews.OrderByDescending(r => r.BookingId).ToList();
                    SetSortIcon("BookingId", sortDirection);
                    break;
                case "ReviewText":
                    reviews = sortDirection == "ASC" ? reviews.OrderBy(r => r.ReviewText).ToList() : reviews.OrderByDescending(r => r.ReviewText).ToList();
                    SetSortIcon("ReviewText", sortDirection);
                    break;
                case "Rating":
                    reviews = sortDirection == "ASC" ? reviews.OrderBy(r => r.Rating).ToList() : reviews.OrderByDescending(r => r.Rating).ToList();
                    SetSortIcon("Rating", sortDirection);
                    break;
                case "ReviewDate":
                    reviews = sortDirection == "ASC" ? reviews.OrderBy(r => r.ReviewDate).ToList() : reviews.OrderByDescending(r => r.ReviewDate).ToList();
                    SetSortIcon("ReviewDate", sortDirection);
                    break;
            }

            //bind sorted data back to listView
            lvReview.DataSource = reviews;
            lvReview.DataBind();

            UpdatePanel1.Update();
        }

        private void SetSortIcon(string sortExpression, string sortDirection)
        {
            //reset all icons
            ClearSortIcons();

            string sortIcon = sortDirection == "ASC" ? " ▲" : " ▼";

            // Set the icon for the sorted column
            switch (sortExpression)
            {
                case "ReviewId":
                    var litReviewIdIcon = (Literal)lvReview.FindControl("litReviewIdIcon");
                    if (litReviewIdIcon != null) litReviewIdIcon.Text = sortIcon;
                    break;
                case "BookingId":
                    var litBookingIdIcon = (Literal)lvReview.FindControl("litBookingIdIcon");
                    if (litBookingIdIcon != null) litBookingIdIcon.Text = sortIcon;
                    break;
                case "ReviewText":
                    var litReviewTextIcon = (Literal)lvReview.FindControl("litReviewTextIcon");
                    if (litReviewTextIcon != null) litReviewTextIcon.Text = sortIcon;
                    break;
                case "Rating":
                    var litRatingIcon = (Literal)lvReview.FindControl("litRatingIcon");
                    if (litRatingIcon != null) litRatingIcon.Text = sortIcon;
                    break;
                case "ReviewDate":
                    var litReviewDateIcon = (Literal)lvReview.FindControl("litReviewDateIcon");
                    if (litReviewDateIcon != null) litReviewDateIcon.Text = sortIcon;
                    break;
            }
        }

        //reset icons
        private void ClearSortIcons()
        {
            var icons = new[] { "litReviewIdIcon", "litBookingIdIcon", "litReviewTextIcon", "litRatingIcon", "litReviewDateIcon" };

            foreach (var iconId in icons)
            {
                var literal = (Literal)lvReview.FindControl(iconId);
                if (literal != null)
                {
                    literal.Text = "";
                }
            }


        }

        private List<Review> GetReviews()
        {
            using (var db = new SystemDatabaseEntities())
            {
                return db.Reviews.Include("Booking").ToList();
            }
        }

        protected void ddlStarRating_SelectedIndexChanged(object sender, EventArgs e)
        {

            var ddlStarRating = (DropDownList)sender;

            int selectedRating = int.Parse(ddlStarRating.SelectedValue);

            using (var db = new SystemDatabaseEntities())
            {
                var reviews = GetReviews().AsQueryable();

                if (selectedRating > 0)
                {
                    reviews = reviews.Where(r => r.Rating == selectedRating);
                }

                lvReview.DataSource = reviews.ToList();
                lvReview.DataBind();
            }

            
        }

    }
}