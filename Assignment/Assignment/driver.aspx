<%@ Page Title="" Language="C#" MasterPageFile="~/profile.Master" AutoEventWireup="true" CodeBehind="driver.aspx.cs" Inherits="Assignment.driver" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT * FROM [Driver]"></asp:SqlDataSource>
    <div class="container-xl px-4 mt-4">
    <h1>Available Driver</h1>
    <hr class="mt-0 mb-4">
    <div class="card-container mb-3">
        <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
            <ItemTemplate>
                <div class="card-body rounded border border-dark px-0 py-2 mb-3" Style="background-color:#effaf6">
                    <div class="d-flex align-items-center justify-content-between px-4">
                        <div class="d-flex align-items-center">
                             <i class="fa-regular fa-id-card" style="font-size:1.5em;"></i>
                            <div class="mx-4">
                                    <asp:Label ID="lblDriverName" runat="server" Text='<%# Eval("DriverName") %>' CssClass="small d-block" />
                                    <asp:Label ID="lblDriverBdate" runat="server" Text='<%# Eval("DriverID") %>' CssClass="text-xs text-muted d-inline" />
                            </div>
                        </div>
                        <div class="ms-4 small">
                            <asp:Label ID="Label1" runat="server" Text="Pending" CssClass="badge bg-light text-dark me-3"></asp:Label>
                            <a href="#!">Edit</a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <h1>New Driver</h1>
    <hr class="mt-0 mb-4">
        <div class="col-xl-8 mb-5 mx-auto">
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
                                <label class="small mb-1">Driver Phone number</label>
                                <asp:TextBox ID="txtPhoneNum" runat="server" CssClass="form-control" placeholder="Enter driver phone number"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPhone" runat="server" ErrorMessage="Driver Phone number is required" ControlToValidate="txtPhoneNum" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputBirthday">Driver Birthdate</label>
                                <asp:TextBox ID="txtBirthdate" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqBirthDate" runat="server" ErrorMessage="Driver Birthdate is required" ControlToValidate="txtName" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Gender</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select" ValidationGroup="uploadDoc">
                                    <asp:ListItem>Select Gender</asp:ListItem>
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqGender" runat="server" ErrorMessage="Name is required" ControlToValidate="ddlGender" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
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
                    <asp:RequiredFieldValidator ID="reqIdPic" runat="server" ErrorMessage="Driver ID/Passport Picture is required" ControlToValidate="fuID" CssClass="validate mx-auto" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                                <br />
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
                    <asp:RequiredFieldValidator ID="reqSelfie" runat="server" ErrorMessage="Driver Selfie is required" ControlToValidate="fuSelfie" CssClass="validate mx-auto" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                                <br />
                                <asp:Label ID="lblSelfiePic" runat="server" CssClass="validate mx-auto"></asp:Label>
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
                    <asp:RequiredFieldValidator ID="reqLicenseF" runat="server" ErrorMessage="Front Driver License Picture is required" ControlToValidate="fuLicenseF" CssClass="validate mx-auto" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                                <br />
                                <asp:Label ID="lblLicenseFpic" runat="server" CssClass="validate mx-auto"></asp:Label>
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
                    <asp:RequiredFieldValidator ID="reqLicenseB" runat="server" ErrorMessage="Back Driver Selfie Picture is required" ControlToValidate="fuLicenseB" CssClass="validate mx-auto" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                                <br />
                                <asp:Label ID="lblLicenseBpic" runat="server" CssClass="validate mx-auto"></asp:Label>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuLicenseB" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewLicenseB(event)"/>
                                <asp:Button ID="btnLicenseBpic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadLicenseB()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                        </div>
                    <asp:Button ID="btnUploadDoc" runat="server" Text="Upload" CssClass='btn btn-primary' ValidationGroup="uploadDoc" OnClick="btnUploadDoc_Click" />

                </div>
            </div>
        </div>
    </div>

    <script>

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
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

    </script>




</asp:Content>
