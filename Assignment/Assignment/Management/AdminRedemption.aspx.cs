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
                var itemData = db.RedeemItems.ToList();

                lvRedeemItems.DataSource = itemData;
                lvRedeemItems.DataBind();
            }
        }

        protected void lvRedeemItems_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            //Let listView know which row is in editing mode
            lvRedeemItems.EditIndex = e.NewEditIndex;
            BindListView();
        }

        protected void lvRedeemItems_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            using (var db = new SystemDatabaseEntities())
            {
                //Retrieve item being edited
                int id = (int)lvRedeemItems.DataKeys[e.ItemIndex].Value;
                //Compare id match in database then take it out
                var item = db.RedeemItems.FirstOrDefault(x => x.RedeemItemId == id);

                if (item != null)
                {
                    //item found
                    //take user input store in textbox for later use
                    TextBox txtItemName = (TextBox)lvRedeemItems.Items[e.ItemIndex].FindControl("txtItemName");
                    TextBox txtItemPoints = (TextBox)lvRedeemItems.Items[e.ItemIndex].FindControl("txtItemPoints");
                    TextBox txtItemDescription = (TextBox)lvRedeemItems.Items[e.ItemIndex].FindControl("txtItemDescription");
                    TextBox txtStatus = (TextBox)lvRedeemItems.Items[e.ItemIndex].FindControl("txtStatus");
                    TextBox txtItemImage = (TextBox)lvRedeemItems.Items[e.ItemIndex].FindControl("txtItemImage");

                    //update to database
                    item.ItemName = txtItemName.Text;
                    item.ItemPoints = int.Parse(txtItemPoints.Text);
                    item.ItemDescription = txtItemDescription.Text;
                    item.Status = txtStatus.Text;
                    item.ItemImage = txtItemImage.Text;

                    //save changes to the database
                    db.SaveChanges();
                }

                //reset edit index and rebind
                lvRedeemItems.EditIndex = -1;
                BindListView();
            }
        }
        protected void lvRedeemItems_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvRedeemItems.EditIndex = -1;
            BindListView();
        }
    }
}