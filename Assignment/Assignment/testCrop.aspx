<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="testCrop.aspx.cs" Inherits="Assignment.testCrop" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
</head>
<body>
    <form id="form1" runat="server">
        <div>
    <div class="modal modal-xl fade" id="cropModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="cropModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel">Crop Profile Picture</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
              <asp:Image ID="imgCropImage" runat="server" Width="100%" />
      </div>
    </div>
  </div>   
</div>
</div>
        <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Image/CarImage/city.png" OnClientClick="return ShowImageModal(this)"/>
    </form>
</body>
    <script>
        function ShowImageModal(image) {            
            document.getElementById('<%= imgCropImage.ClientID %>').src = image.src;
            $('#cropModal').modal('show');         
            console.log("Im in");
            return false;
        }
    </script>

</html>
