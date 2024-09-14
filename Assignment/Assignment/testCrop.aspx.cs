using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class testCrop : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string savePathSelfie = " ";
            string relPathSelfie = " ";
            if (!string.IsNullOrEmpty(hdnProfilePicture.Value))
            {
                // Decode the Base64 string and save it as an image file
                string base64String = hdnProfilePicture.Value.Split(',')[1]; // Remove the data URI scheme part
                byte[] imageBytes = Convert.FromBase64String(base64String);

                string folderLocation = Server.MapPath("~/Image/DriverSelfie");
                string relfolderLocation = "~/Image/DriverSelfie";
                string fileName = 1234 + ".jpg"; // Assuming JPEG format
                savePathSelfie = Path.Combine(folderLocation, fileName);
                relPathSelfie = Path.Combine(relfolderLocation, fileName);
                // Log before saving the file
                System.Diagnostics.Debug.WriteLine("Saving captured selfie to: " + savePathSelfie);

                File.WriteAllBytes(savePathSelfie, imageBytes); // Save the file

                // Log success
                System.Diagnostics.Debug.WriteLine("Selfie saved successfully!");
            }
        }
    }
}