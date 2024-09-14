<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testCrop.aspx.cs" Inherits="Assignment.testCrop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js" integrity="sha512-JyCZjCOZoyeQZSd5+YEAcFgz2fowJ1F1hyJOXgtKu4llIa0KneLcidn5bwfutiehUTiOuK87A986BZJMko0eWQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.css" integrity="sha512-087vysR/jM0N5cp13Vlp+ZF9wx6tKbvJLwPO8Iit6J7R+n7uIMMjg37dEgexOshDmDITHYY5useeSmfD1MYiQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <style>
    .cropper-view-box,
    .cropper-face {
      border-radius: 50%;
    }

    /* The css styles for `outline` do not follow `border-radius` on iOS/Safari (#979). */
    .cropper-view-box {
      outline: 0;
      box-shadow: 0 0 0 1px #39f;
    }

    </style>
    <form id="form1" runat="server">
        <div>
    <div class="modal fade" id="cropModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="cropModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel">Crop Profile Picture</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="cropped-container">
              <asp:Image ID="imgCropImage" runat="server" Width="100%" />
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:Button ID="btnUpload" runat="server" Text="Change Profile Picture" CssClass="btn btn-primary" OnClick="btnUpload_Click"/>
      </div>
    </div>
  </div>   
</div>
</div>
        <asp:HiddenField ID="hdnProfilePicture" runat="server" />
        <asp:FileUpload ID="uploadImage" runat="server" onchange="ShowCropModal(event)"/>
    </form>
</body>
    <script>
        function ShowCropModal(event) {
            //read content of the file
            var ImageDir = new FileReader();
            //when file read update the image element
            ImageDir.onload = function () {
                var image = document.getElementById('<%= imgCropImage.ClientID %>');
                image.src = ImageDir.result;
                $('#cropModal').modal('show');
            };
            //get file and convert to data url to use in img src = ""
            ImageDir.readAsDataURL(event.target.files[0]);            
        }

        let cropper;
        const imageInput = document.getElementById('<%= uploadImage.ClientID %>');
        const imageElement = document.getElementById('<%= imgCropImage.ClientID %>');
        const uploadButton = document.getElementById('<%= btnUpload.ClientID %>');
        const result = document.getElementById('<%= hdnProfilePicture.ClientID %>');
        
        
        // Initialize cropper when the modal is shown
        $('#cropModal').on('shown.bs.modal', function () {
            cropper = new Cropper(imageElement, {
                aspectRatio: 1,  // Adjust based on your needs
                viewMode: 3,
                movable: true,
                guides: false,
                cropBoxResizable: true,
                modal: true,
                zoomable: true,
                rotatable: true,
                scalable: true,
                width: 100,
                height: 100,
            });

            uploadButton.onclick = function () {
                var croppedCanvas;
                var roundedCanvas;
                var roundedImage;
                // Crop
                croppedCanvas = cropper.getCroppedCanvas();
                // Round
                roundedCanvas = getRoundedCanvas(croppedCanvas);
                // Convert the rounded image to Base64 image string
                base64Image = roundedCanvas.toDataURL('image/jpg');
                // pass value to hidden field to access at backend
                result.value = base64Image;
                console.log(result.value);
            };

        }).on('hidden.bs.modal', function () {
            // Destroy the cropper instance when the modal is closed
            cropper.destroy();
            cropper = null;
        });


        function getRoundedCanvas(sourceCanvas) {
            var canvas = document.createElement('canvas');
            var context = canvas.getContext('2d');
            var width = sourceCanvas.width;
            var height = sourceCanvas.height;

            canvas.width = width;
            canvas.height = height;

            // for better quality
            context.imageSmoothingEnabled = true;
            // Draw the cropped image onto the new canvas
            context.drawImage(sourceCanvas, 0, 0, width, height);
            // Clip the image into a circular shape
            context.globalCompositeOperation = 'destination-in';
            context.beginPath();
            context.arc(width / 2, height / 2, Math.min(width, height) / 2, 0, 2 * Math.PI, true);
            context.fill();

            return canvas;
        }
    </script>

</html>
