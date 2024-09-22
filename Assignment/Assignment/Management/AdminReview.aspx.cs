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


        protected void btnEditReview_Click(object sender, EventArgs e)
        {
            
            var button = (LinkButton)sender;
            int reviewId = int.Parse(button.CommandArgument);

            using (var db = new SystemDatabaseEntities())
            {
                var review = db.Reviews
                    .Include("Booking.Car")
                    .FirstOrDefault(r => r.ReviewId == reviewId);

                if (review != null)
                {
                    lblBookingId.Text = review.Booking.Id.ToString();
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
    }
}