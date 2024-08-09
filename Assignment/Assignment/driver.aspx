<%@ Page Title="" Language="C#" MasterPageFile="~/profile.Master" AutoEventWireup="true" CodeBehind="driver.aspx.cs" Inherits="Assignment.driver" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:HiddenField ID="hdnCountryCode" runat="server" />
    <div class="modal fade" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Delete Confirmation</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <h5>Are you sure you want to delete?</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup" OnClick="btnConfirmDelete_Click" />
      </div>
    </div>
  </div>   
</div>

    <div class="container-xl px-4 mt-4">
    <h1>Available Driver</h1>
    <hr class="mt-0 mb-4">
    <div class="card-container mb-3">
        <asp:Label ID="lblDriverText" runat="server"></asp:Label>
        <asp:Repeater ID="DriverReapeter" runat="server" OnItemDataBound="DriverReapeter_ItemDataBound">
            <ItemTemplate>
                <div class="card-body rounded border border-dark px-0 py-2 mb-3" Style="background-color:#effaf6">
                    
                    <div class="d-flex align-items-center justify-content-between px-4">
                        <div class="d-flex align-items-center">
                             <i class="fa-regular fa-id-card" style="font-size:1.5em;"></i>
                            <div class="mx-4">
                                    <asp:Label ID="lblDriverName" runat="server" Text='<%# Eval("DriverName") %>' CssClass="small d-block" />
                                    <asp:Label ID="lblDriverBdate" runat="server" Text='<%# Eval("DriverID") %>' CssClass="text-xs text-muted d-inline" />
                                <br />
                                    <asp:Label ID="lblReject" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                        </div>
                        <div class="d-flex align-items-center ms-4 small">
                            <asp:Label ID="lblApproval" runat="server"></asp:Label>
                        <div>
                            <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-muted" CommandArgument='<%# Eval("Id") %>' OnClick="btnView_Click" />
                            <asp:Button ID="btnEdit" runat="server" Text="Edit " cssClass="btn btn-sm text-muted" CommandArgument='<%# Eval("Id") %>' OnClick="btnEdit_Click" />
                        </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:LinkButton ID="btnAddNew" runat="server" OnClick="btnAddNew_Click">
               <div class="card-body rounded border border-dark px-0 py-2 mb-3" Style="background-color:#effaf6">
                   <div class="d-flex align-items-center px-4">
                   <h5 class="mx-auto my-auto text-muted">Add New Driver</h5>
                   </div>
               </div>
        </asp:LinkButton>
    </div>
    <h1>Add/Edit Driver Info</h1>
    <hr class="mt-0 mb-4">
        <div class="col-xl-8 mb-5 mx-auto">
            <asp:Panel ID="Panel1" runat="server">
            <div class="card mb-4">
                <div class="card-header">Driver Details</div>
                <div class="card-body">
                        <div class="mb-3">
                            <label class="small mb-1">Driver Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter driver name" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver ID/Passport Number</label>
                                <asp:TextBox ID="txtDriverID" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqId" runat="server" ErrorMessage="Driver ID/Passport Number is required" ControlToValidate="txtDriverID" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License Number</label>
                                <asp:TextBox ID="txtDriverLicense" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqDriverLicense" runat="server" ErrorMessage="Driver License Number is required" ControlToValidate="txtDriverLicense" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Gender</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select" ValidationGroup="uploadDoc">
                                    <asp:ListItem Value="0">Select Gender</asp:ListItem>
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqGender" runat="server" ErrorMessage="Gender is required" ControlToValidate="ddlGender" CssClass="validate" ValidationGroup="uploadDoc" InitialValue="0"></asp:RequiredFieldValidator>
                             </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputBirthday">Driver Birthdate</label>
                                <asp:TextBox ID="txtBirthdate" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqBirthDate" runat="server" ErrorMessage="Driver Birthdate is required" ControlToValidate="txtBirthdate" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1 d-block">Driver Phone number</label>
                                <asp:TextBox ID="txtPhoneNum" runat="server" CssClass="form-control d-block" TextMode="Phone" ></asp:TextBox>
                        <asp:CustomValidator ID="validPhoneNum" runat="server" ErrorMessage="Invalid Phone Number" ClientValidationFunction="validatePhone" ControlToValidate="txtPhoneNum" ValidationGroup="uploadDoc" CssClass="validate" ValidateEmptyText="True"></asp:CustomValidator>
                            </div>
                        </div>
                        <h5>Driver Document</h5>
                        <hr class="mt-0 mb-4">
                     <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver ID/Passport Picture</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgID" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                   <asp:CustomValidator ID="validateIDpic" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuID" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <asp:Label ID="lblIdPic" runat="server" CssClass="validate mx-auto"></asp:Label>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuID" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewID(event)"/>
                                <asp:Button ID="btnIdPic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto"  OnClientClick="return fileUploadID()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Selfie</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgSelfie" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                   <asp:CustomValidator ID="validateSelfiePic" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuSelfie" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuSelfie" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewSelfie(event)"/>
                                <asp:Button ID="btnSelfiePic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadSelfie()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                        </div>                     
                    <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License (Front)</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgLicenseF" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                                <asp:CustomValidator ID="validateLicenseF" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuLicenseF" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuLicenseF" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewLicenseF(event)"/>
                                <asp:Button ID="btnLicenseFpic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadLicenseF()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License (Back)</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgLicenseB" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                    <asp:CustomValidator ID="validateLicenseB" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuLicenseB" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuLicenseB" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewLicenseB(event)"/>
                                <asp:Button ID="btnLicenseBpic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadLicenseB()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                        </div>
                    <asp:Button ID="btnUploadDoc" runat="server" Text="Add New Driver" CssClass='btn btn-primary' ValidationGroup="uploadDoc" OnClientClick="getCountryCode()" OnClick="btnUploadDoc_Click" />
                    <asp:Button ID="btnUpdateDoc" runat="server" Text="Update" CssClass='btn btn-primary' ValidationGroup="uploadDoc" OnClick="btnUpdateDoc_Click" OnClientClick="getCountryCode()" Visible="False"/>
                    <asp:Button ID="btnDelete" runat="server" Text="Delete " cssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="False"/>
                </div>
            </div>
            </asp:Panel>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/intlTelInput.min.js"></script>
    <script>
        const input = document.querySelector("#<%= txtPhoneNum.ClientID %>");
        const iti = window.intlTelInput(input, {
            initialCountry: "auto",
            geoIpLookup: callback => {
                fetch("https://ipapi.co/json")
                    .then(res => res.json())
                    .then(data => callback(data.country_code))
                    .catch(() => callback("us"));
            },
            utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/utils.js",
        });

        function validatePhone(sender, args) {          
            args.IsValid = iti.isValidNumber();
        }

        function getCountryCode() {
            document.getElementById('<%= hdnCountryCode.ClientID %>').value = iti.getSelectedCountryData().dialCode;
        }



        function fileUploadID() {
        document.getElementById('<%= fuID.ClientID %>').click();

        return false;
        }

        function fileUploadSelfie() {
        document.getElementById('<%= fuSelfie.ClientID %>').click();

        return false;
        }

        function fileUploadLicenseF() {
        document.getElementById('<%= fuLicenseF.ClientID %>').click();

        return false;
        }

        function fileUploadLicenseB() {
        document.getElementById('<%= fuLicenseB.ClientID %>').click();

        return false;
        }

    function ShowPreviewID(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgID.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewSelfie(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgSelfie.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewLicenseF(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgLicenseF.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewLicenseB(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgLicenseB.ClientID %>');
            image.src = ImageDir.result;
        } 
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
                    return;
                }

                if (fileUpload.files[0].size > maxSize) {
                    args.IsValid = false;
                    return;
                }

                args.IsValid = true;
            }

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

    </script>




</asp:Content>
