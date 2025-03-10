﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AddOnManagement.aspx.cs" Inherits="Assignment.Management.AddOnManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/carManagement.css" rel="stylesheet" />
    <link href="../CSS/addonManagement.css" rel="stylesheet" />
    <link href="../CSS/paging.css" rel="stylesheet" />

    <style>
        .form {
            position: relative;
        }

            .form .fa-search {
                position: absolute;
                top: 20px;
                left: 20px;
                color: #9ca3af;
            }

        .form-input {
            height: 55px;
            text-indent: 33px;
            border-radius: 10px;
        }
    </style>

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnAddOnId" runat="server" />
    <asp:HiddenField ID="hdnSortDirection" runat="server" Value="" />

    <%--image cropping--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js" integrity="sha512-JyCZjCOZoyeQZSd5+YEAcFgz2fowJ1F1hyJOXgtKu4llIa0KneLcidn5bwfutiehUTiOuK87A986BZJMko0eWQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.css" integrity="sha512-087vysR/jM0N5cp13Vlp+ZF9wx6tKbvJLwPO8Iit6J7R+n7uIMMjg37dEgexOshDmDITHYY5useeSmfD1MYiQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <div class="modal fade" id="cropModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="cropModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="cropModalLabel">Crop Add On Picture</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="cropped-container">
                        <asp:Image ID="imgCropImage" runat="server" Width="100%" />
                        <asp:HiddenField ID="hdnAddOnPicture" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnUpload" runat="server" Text="Upload Add On Picture" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </div>
    <%--image cropping--%>

    <div class="modal fade" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel">Add On Detail</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <h5 class="text-dark">Are you sure you want to delete?</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup" OnClick="btnConfirmDelete_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="container-xl px-4 mt-4">
        <h1 class="text-dark">Add Ons Management</h1>
        <hr class="mt-0 mb-4">

        <asp:Panel ID="AddOnPanel" runat="server">
            <div class="row">
                <div class="col-xl-4">
                    <div class="card mb-0 mb-xl-0">
                        <div class="card-header">Add On Picture/Icon</div>
                        <div class="card-body text-center">
                            <asp:LinkButton ID="btnUploadPic" runat="server" CssClass="car-pic-wrapper image-frame mx-auto" OnClientClick="return fileUpload()">
                                <span class="upload-text">Upload</span>
                                <asp:Image ID="imgAddOnPic" runat="server" CssClass="img-car-pic mb-2" Width="300px" ImageUrl="~/Image/no-img -long.png" />
                            </asp:LinkButton>
                            <div id="img-warning-text" class="small font-italic text-muted">JPG or PNG no larger than 2 MB</div>
                            <asp:RequiredFieldValidator ID="rqfuAddOnPic" runat="server" ControlToValidate="fuAddOnPic" ErrorMessage="Please upload an image." InitialValue="" ValidationGroup="uploadAddOn" Display="Dynamic" CssClass="validate">
                            </asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="validateAddOnPic" runat="server" ControlToValidate="fuAddOnPic" CssClass="validate" ValidationGroup="uploadAddOn" ValidateEmptyText="True" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile"></asp:CustomValidator>
                            <asp:FileUpload ID="fuAddOnPic" runat="server" CssClass="uploadPicture" onchange="ShowCropModal(event)" />
                            <br />
                        </div>
                    </div>
                </div>

                <div class="col-xl-8 mb-5">
                    <div class="card mb-4">
                        <div class="card-header">Add/Edit Add On</div>
                        <div class="card-body">
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1">Add On Name</label>
                                    <asp:TextBox ID="txtAddonName" runat="server" CssClass="form-control" placeholder="Name" ValidationGroup="uploadAddOn"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="regexAddOnName" runat="server" ErrorMessage="Use only character that can be declared as file name" Display="Dynamic" CssClass="validate" ValidationGroup="uploadAddOn" ControlToValidate="txtAddOnName" ValidationExpression="^[A-Za-z0-9_\-()\. ]+$"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rqAddonName" runat="server" ErrorMessage="Add On Name is required" ControlToValidate="txtAddOnName" CssClass="validate" ValidationGroup="uploadAddOn"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-12">
                                    <label class="small mb-1">Add On Description</label>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" placeholder="Description" ValidationGroup="uploadAddOn"></asp:TextBox>

                                    </div>

                                    <asp:RequiredFieldValidator ID="rqDescription" runat="server" ErrorMessage="Add On Description is required" ControlToValidate="txtDescription" CssClass="validate" ValidationGroup="uploadAddOn"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1">Add On Price(MYR)</label>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <asp:TextBox ID="txtAddonPrice" runat="server" CssClass="form-control" placeholder="0.00" ValidationGroup="uploadAddOn"></asp:TextBox>

                                    </div>

                                    <asp:RequiredFieldValidator ID="rqPrice" runat="server" ErrorMessage="Add On Price is required" ControlToValidate="txtAddonPrice" CssClass="validate" ValidationGroup="uploadAddOn"></asp:RequiredFieldValidator>
                                     <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid Price Range (1 - 999.99)" MaximumValue="999.99" MinimumValue="1.00" ControlToValidate="txtAddonPrice" ValidationGroup="uploadAddOn" CssClass="validate" Display="Dynamic" CultureInvariantValues="False" Type="Double"></asp:RangeValidator>
                                </div>

                                <div class="col-md-6">
                                    <label class="small mb-1">Add On Maximum Quantity</label>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <asp:TextBox ID="txtMaxQuantity" runat="server" CssClass="form-control" TextMode="Number" ValidationGroup="uploadAddOn" min="1" max="99" step="1"  ></asp:TextBox>

                                    </div>

                                    <asp:RequiredFieldValidator ID="rqMaxQuantity" runat="server" ErrorMessage="Add On Quantity is required" ControlToValidate="txtMaxQuantity" CssClass="validate" ValidationGroup="uploadAddOn"></asp:RequiredFieldValidator>
                                </div>
                            </div>




                            <asp:Button ID="btnUploadAddOn" runat="server" Text="Add" CssClass='btn btn-primary' ValidationGroup="uploadAddOn" OnClick="btnUploadAddOn_Click" />
                            <asp:Button ID="btnUpdateAddOn" runat="server" Text="Update" CssClass='btn btn-primary' Visible="False" OnClick="btnUpdateAddOn_Click" />
                            <asp:Button ID="btnDelete" runat="server" Text="Delete " CssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="False" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <div class="container">
            <h1 class="text-dark d-inline">Add On Detail</h1>
            <asp:Button ID="btnAddNewCar" runat="server" Text="Add New Add On" CssClass="btn btn-primary btn-sm mx-2 mb-2" OnClick="btnAddNewCar_Click" />
            <hr class="mt-0 mb-4">
            <asp:UpdatePanel ID="updateAddOn" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
                    <div>
                        <div class="col-6 col-md-8 search_style">
                            <div class="form">
                                <i class="fa fa-search"></i>
                                <asp:TextBox ID="txtAddOnSearch" CssClass="form-control form-input" runat="server" placeholder="Search.."></asp:TextBox>
                            </div>
                        </div>
                        <div class="table-responsive">
                            <table id="addOnTable" class="addon_table table table-striped table-bordered table-hover mb-2 mt-4">
                                <thead>
                                    <tr style="text-align: center;">
                                        <th scope="col" class="name_header">
                                            <asp:LinkButton ID="btnSortName" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Name" CssClass="text-dark sort-button">
                            Add On Name<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                            </asp:LinkButton>
                                        </th>
                                        <th scope="col" class="desc_header">
                                            <asp:LinkButton ID="btnSortDescription" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Description" CssClass="text-dark sort-button">
                            Add On Description<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px">

                                            </asp:LinkButton></th>
                                        <th scope="col" class="price_header">
                                            <asp:LinkButton ID="btnSortPrice" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Price" CssClass="text-dark sort-button">
                            Add On Price
                            <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                            </asp:LinkButton></th>
                                        <th scope="col" class="quantity_header">
                                            <asp:LinkButton ID="btnSortMaxQuantity" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="maxQuantity" CssClass="text-dark sort-button">
                            Add On Maximum Quantity
                            <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                            </asp:LinkButton></th>

                                        <th scope="col">Actions</th>
                                    </tr>
                                </thead>
                                <tbody id="addOnTable_record">
                                    <asp:Repeater ID="repeaterAddOnTable" runat="server" OnItemCreated="repeaterAddOnTable_ItemCreated">
                                        <ItemTemplate>
                                            <tr style="text-align: center;">
                                                <td scope="col"><%# Eval("Name") %></td>
                                                <td scope="col"><%# Eval("Description") %></td>
                                                <td scope="col"><%# Eval("Price") %></td>
                                                <td scope="col"><%# Eval("maxQuantity") %></td>


                                                <td scope="col">
                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm text-primary" OnClick="btnEditAddOn_Click" CommandArgument='<%# Eval("Id") %>' />
                                                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-primary" OnClick="btnViewAddOn_Click" CommandArgument='<%# Eval("Id") %>' />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                                <asp:Label ID="lblTotalRecord" runat="server" Text="" CssClass="float-end text-muted"></asp:Label>
                            </table>
                        </div>
                        <div>
                        </div>
                    </div>
                    <div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>


    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

    <script type="text/javascript" src="../JS/paging.js"></script>

    <script>
        $(document).ready(function () {
            var searchBoxId = "#" + '<%= txtAddOnSearch.ClientID %>';


            $(searchBoxId).on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#addOnTable_record tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });

            function initializePagination() {
                $('#addOnTable').paging({ limit: 10 });
            }

            initializePagination(); // Initialize on page load

        });

        function fileUpload() {
            document.getElementById('<%= validateAddOnPic.ClientID %>').enabled = true;
            document.getElementById('<%= fuAddOnPic.ClientID %>').click();


            return false;
        }

        function disableUpload() {
            linkButton = document.getElementById('<%= btnUploadPic.ClientID %>');

            linkButton.onclick = function (event) {
                event.preventDefault();

            };

            linkButton.classList.remove('car-pic-wrapper');
            linkButton.classList.remove('car-pic-wrapper-no-hover');
            linkButton.style.pointerEvents = 'none';
            document.getElementById('img-warning-text').style.display = 'none';
        }


        function ShowPreview(event) {
            //read content of the file
            var ImageDir = new FileReader();
            //when file read update the image element
            ImageDir.onload = function () {
                var image = document.getElementById('<%= imgAddOnPic.ClientID %>');
                image.src = ImageDir.result;
            };
            //get file and convert to data url to use in img src = ""
            ImageDir.readAsDataURL(event.target.files[0]);
        }

        function validateFile(sender, args) {
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

        function updateSortIcons() {
            // Get the current sort direction from the HiddenField
            var sortDirection = document.getElementById('<%= hdnSortDirection.ClientID %>').value;

            // Update icon classes based on the current sort direction
            document.querySelectorAll('.sort-button').forEach(function (button) {
                var icon = button.querySelector('.sort-icon');
                if (icon) {
                    if (sortDirection === 'ASC') {
                        icon.classList.remove('ri-arrow-up-s-fill');
                        icon.classList.add('ri-arrow-down-s-fill');
                    } else {
                        icon.classList.remove('ri-arrow-down-s-fill');
                        icon.classList.add('ri-arrow-up-s-fill');
                    }
                }
            });
        }
    </script>

    <%--image cropping--%>
        <script>
            var isPass = false;
            function ShowCropModal(event) {
                if (isPass) {
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
            }

            let cropper;
            const imageInput = document.getElementById('<%= fuAddOnPic.ClientID %>');
            const imageElement = document.getElementById('<%= imgCropImage.ClientID %>');
            const uploadButton = document.getElementById('<%= btnUpload.ClientID %>');
            const result = document.getElementById('<%= hdnAddOnPicture.ClientID %>');
            const preview = document.getElementById('<%= imgAddOnPic.ClientID %>');


            // Initialize cropper when the modal is shown
            $('#cropModal').on('shown.bs.modal', function () {
                cropper = new Cropper(imageElement, {
                    aspectRatio: 1,  // Adjust based on your needs
                    viewMode: 1,
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
                    preview.src = base64Image;

                    result.value = base64Image;
                    $('#cropModal').modal('hide');
                    return false;

                };

            }).on('hidden.bs.modal', function () {
                // Destroy the cropper instance when the modal is closed
                cropper.destroy();
                cropper = null;
            });
        </script>
    <%--image cropping--%>
</asp:Content>
