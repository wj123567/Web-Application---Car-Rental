<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRedemption.aspx.cs" Inherits="Assignment.Management.AdminRedemption" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js" integrity="sha512-JyCZjCOZoyeQZSd5+YEAcFgz2fowJ1F1hyJOXgtKu4llIa0KneLcidn5bwfutiehUTiOuK87A986BZJMko0eWQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.css" integrity="sha512-087vysR/jM0N5cp13Vlp+ZF9wx6tKbvJLwPO8Iit6J7R+n7uIMMjg37dEgexOshDmDITHYY5useeSmfD1MYiQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <%--Crop Modal--%>
        <div class="modal fade" id="cropModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="cropModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="cropModalLabel">Crop Car Picture</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="cropped-container">
                        <asp:Image ID="imgCropImage" runat="server" Width="100%" />
                        <asp:HiddenField ID="hdnRedemptionPicture" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">Cancel</button>
                    <asp:Button ID="btnUpload" runat="server" Text="Upload Redemption Picture" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </div>

    <%-- add modal --%>
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Add New Redeem Item</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfRedeemItemId" runat="server" />
                    <div class="form-group">
                        <label for="txtItemName" class="fs-6"><b>Item Name</b></label>
                        <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control mb-2" placeholder="Enter Item Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ControlToValidate="txtItemName" 
        ErrorMessage="Item Name is required." CssClass="text-warning" Display="Dynamic" ValidationGroup="AddItem" />
                    </div>
                    <div class="form-group">
                        <label for="txtItemPoints" class="fs-6"><b>Item Points</b></label>
                        <asp:TextBox ID="txtItemPoints" runat="server" CssClass="form-control mb-2" placeholder="Enter Item Points"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemPoints" runat="server" ControlToValidate="txtItemPoints" 
        ErrorMessage="Item Points are required." CssClass="text-warning" Display="Dynamic" ValidationGroup="AddItem" />
                        <asp:RegularExpressionValidator ID="revItemPoints" runat="server" ControlToValidate="txtItemPoints" 
                            ErrorMessage="Item Points must be a number." CssClass="text-warning" 
                            ValidationExpression="^\d+$" Display="Dynamic" ValidationGroup="AddItem" />
                    </div>
                    <div class="form-group">
                        <label for="txtItemDescription" class="fs-6"><b>Item Description</b></label>
                        <asp:TextBox ID="txtItemDescription" runat="server" CssClass="mb-2 form-control txtItemDescription " TextMode="MultiLine" Rows="3" Columns="100" placeholder="Enter Item Description"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemDescription" runat="server" ControlToValidate="txtItemDescription" 
        ErrorMessage="Item Description is required." CssClass="text-warning" Display="Dynamic" ValidationGroup="AddItem" />
                    </div>
                    <div class="form-group">
                        <label for="ddlStatus" class="fs-6"><b>Status</b></label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control mb-2">
                            <asp:ListItem Value="Available" Text="Available"></asp:ListItem>
                            <asp:ListItem Value="Unavailable" Text="Unavailable"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="fuItemImage" class="fs-6"><b>Item Image</b></label>
                        <asp:FileUpload ID="fuRdmItem" runat="server" CssClass="form-control-file mb-2" onchange="ShowCropModal(event)"/>
                        <asp:CustomValidator ID="cvFileUpload" runat="server" 
                            ErrorMessage="Only .jpg, .jpeg, or .png files are allowed." 
                            CssClass="text-warning" 
                            ClientValidationFunction="validateFileUpload" 
                            Display="Dynamic" ValidationGroup="AddItem" ControlToValidate="fuRdmItem" />
                        <asp:Label ID="lblMessage" runat="server" Text="" Visible="false" CssClass="text-success"></asp:Label>
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveItem" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSaveItem_Click" OnClientClick="return validateForm();" CausesValidation="true" ValidationGroup="AddItem" />
                </div>
            </div>
        </div>
    </div>


    <div class="Redemption container-xl px-4 mt-4 container-fluid">
    <div class="title">
        <h1>Redemption Management</h1>
    </div>
    <div class="RedeemItemAdd">
        <asp:LinkButton ID="btnAddReviewItem" 
                        runat="server"
                        CssClass="btn btn-primary"
                        OnClick="btnAddReviewItem_Click"
                        OnClientClick="">
            Add New Redeem Item
        </asp:LinkButton>
    </div>

        <asp:ListView ID="lvRedeemItems" runat="server" OnSorting="lvRedeemItems_Sorting">
            <LayoutTemplate>
                <table class="table table-striped table-bordered table-responsive redeemTable">
                    <thead>
                        <tr class="">
                            <th>
                                <asp:LinkButton ID="lbItemName" runat="server" CommandName="Sort" CommandArgument="ItemName" CssClass="link-button">
                                    ItemName
                                    <asp:Literal ID="litItemNameIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton ID="lbItemPoints" runat="server" CommandName="Sort" CommandArgument="ItemPoints" CssClass="link-button">
                                    ItemPoints
                                    <asp:Literal ID="litItemPointsIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton ID="lbItemDescription" runat="server" CommandName="Sort" CommandArgument="ItemDescription" CssClass="link-button">
                                    ItemDescription
                                    <asp:Literal ID="litItemDescriptionIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton ID="lbStatus" runat="server" CommandName="Sort" CommandArgument="Status" CssClass="link-button">
                                    Status
                                    <asp:Literal ID="litStatusIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton ID="lbItemImage" runat="server" CommandName="Sort" CommandArgument="ItemImage" CssClass="link-button">
                                    ItemDescription
                                    <asp:Literal ID="litItemImageIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>

                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceHolder" runat="server"></tr>
                    </tbody>
                    
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("ItemName") %></td>
                    <td><%# Eval("ItemPoints") %></td>
                    <td><%# Eval("ItemDescription") %></td>
                    <td><%# Eval("Status") %></td>
                    <td>
                        <img src='<%# ResolveUrl("~/Image/RedeemItem/" + Eval("ItemImage")) %>' alt="<%# Eval("ItemName") %>" style="width: 100px; height: auto;" class="" />
                    </td>
                    <td >

                        <asp:LinkButton ID="btnEditRedeemItem" 
                                        runat="server" 
                                        CommandArgument='<%# Eval("RedeemItemId") %>' 
                                        OnClick="btnEditRedeemItem_Click">
                            <i class="fas fa-edit" style="color: #ffbb00;"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" CommandArgument='<%# Eval("RedeemItemId") %>' OnClick="DeleteButton_Click" OnClientClick="return confirm('Are you sure you want to delete this Redeem Item?');">
                            <i class="fa-solid fa-trash-can" style="color: #ff0000;"></i>
                        </asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <script>
        function openModal() {
            $('#staticBackdrop').modal('show');
        }

        function validateForm() {
            Page_ClientValidate('AddItem');

            // Check if all validators are valid
            if (Page_IsValid) {
                return true; // Proceed with form submission
            } else {
                return false; // Prevent form submission if validation fails
            }
        }


    </script>

    <script>
        function validateFileUpload(sender, args) {
            var fileUpload = document.getElementById(sender.controltovalidate);
            var fileName = fileUpload.value;
            var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
            var maxSize = 2097152;

            if (!allowedExtensions.test(fileName)) {
                args.IsValid = false;
                isPass = false;
                fileUpload.value = "";
                return;
            }

            if (fileUpload.files[0].size > maxSize) {
                args.IsValid = false;
                isPass = false;
                fileUpload.value = "";
                return;
            }

            args.IsValid = true;
            isPass = true;

        }

        var isPass = false;
        function ShowCropModal(event) {
            if (isPass) {
                //read content of the file
                var ImageDir = new FileReader();
                //when file read update the image element
                ImageDir.onload = function () {
                    var image = document.getElementById('<%= imgCropImage.ClientID %>');
                    image.src = ImageDir.result;
                    $('#staticBackdrop').modal('hide');
                    $('#cropModal').modal('show');
                };
                //get file and convert to data url to use in img src = ""
                ImageDir.readAsDataURL(event.target.files[0]);
            } else {
                console.log("out");
            }
        }

        let cropper;
        const imageInput = document.getElementById('<%= fuRdmItem.ClientID %>');
        const imageElement = document.getElementById('<%= imgCropImage.ClientID %>');
        const uploadButton = document.getElementById('<%= btnUpload.ClientID %>');
        const result = document.getElementById('<%= hdnRedemptionPicture.ClientID %>');
       <%-- const preview = document.getElementById('<%= imgCarPic.ClientID %>');--%>


        // Initialize cropper when the modal is shown
        $('#cropModal').on('shown.bs.modal', function () {
            cropper = new Cropper(imageElement, {
                aspectRatio: 0.8,  // Adjust based on your needs
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

                base64Image = cropper.getCroppedCanvas().toDataURL('image/png');
                //preview.src = base64Image;

                result.value = base64Image;
                console.log(result.value);
                $('#cropModal').modal('hide');
                $('#staticBackdrop').modal('show');
                return false;

            };

        }).on('hidden.bs.modal', function () {
            // Destroy the cropper instance when the modal is closed
            cropper.destroy();
            cropper = null;
        });

        function hihi() {
            console.log("in");
        }
    </script>



</asp:Content>
