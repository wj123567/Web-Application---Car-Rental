<%@ Page Title="" Language="C#" MasterPageFile="~/profile.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Assignment.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT * FROM [ApplicationUser]"></asp:SqlDataSource>
<div class="container-xl px-4 mt-4">
    <h1>User Profile</h1>
    <hr class="mt-0 mb-4">
    <div class="row">
        <div class="col-xl-4">
            <!-- Profile picture card-->
            <div class="card mb-4 mb-xl-0">
                <div class="card-header">Profile Picture</div>
                <div class="card-body text-center">
                    <!-- Profile picture image-->
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="profile-pic-wrapper" OnClientClick="return fileUpload()">
                     <span class="upload-text">Upload</span>
                    <asp:Image ID="userProfilePic" runat="server" CssClass="img-account-profile rounded-circle mb-2" Width="100px" BorderColor="Black" BorderStyle="Solid" />
                    </asp:LinkButton>
                    <!-- Profile picture help block-->
                    <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 2 MB</div>
                    <!-- Profile picture upload button-->
                    <asp:Button ID="userUploadProfile" runat="server" Text="Upload new image" CssClass="btn btn-primary" OnClick="userUploadProfile_Click" ValidationGroup="uploadProfilePic"/>
                    <asp:FileUpload ID="fuProfile" runat="server" CssClass="uploadPicture" onchange="ShowPreview(event)"/>
                    <br />
                    <asp:CustomValidator ID="validateProfilePic" runat="server" ControlToValidate="fuProfile" CssClass="validate" ValidationGroup="uploadProfilePic" ValidateEmptyText="True" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile"></asp:CustomValidator>
                    <asp:Label ID="lblProfilePic" runat="server" Text="" CssClass="d-block mt-2 validate"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-xl-8">
            <!-- Account details card-->
            <div class="card mb-4">
                <div class="card-header">Account Details</div>
                <div class="card-body">
                    <div>
                        <!-- Form Group (username)-->
                        <div class="mb-3">
                            <label class="small mb-1">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Enabled="False" ValidationGroup="changUname"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqTxtUsername" runat="server" ErrorMessage="Username is required" CssClass="validate" ControlToValidate="txtUsername" ValidationGroup="changUname"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Form Row        -->
                        <div class="row gx-3 mb-3">
                        <!-- Form Group (email address)-->
                        <div class="mb-3">
                            <label class="small mb-1">Email address</label>
                            <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control" ReadOnly="True" Enabled="False"></asp:TextBox>
                        </div>
                        <!-- Form Row-->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (birthday)-->
                            <div class="col-md-6">
                                <label class="small mb-1">Birthday</label>
                                 <asp:TextBox ID="txtBirthday" runat="server" CssClass="form-control" ReadOnly="True" Disabled="true" Enabled="False"></asp:TextBox>
                            </div>                            
                            <div class="col-md-6">
                                <label class="small mb-1">Member Since</label>
                                 <asp:TextBox ID="txtMemberSince" runat="server" CssClass="form-control" ReadOnly="True" Enabled="False"></asp:TextBox>
                            </div>
                        </div>
                        <!-- Save changes button-->
                            <asp:Button ID="btnEditUserProfile" runat="server" Text="Edit" CssClass="btn btn-primary" OnClick="btnEditUserProfile_Click" ValidationGroup="changUname" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<script>

    function fileUpload() {
        document.getElementById('<%= fuProfile.ClientID %>').click();

        return false;
    }

    function ShowPreview(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= userProfilePic.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
    } 

    function validateFile(sender, args) {
        var fileUpload = document.getElementById('<%= fuProfile.ClientID %>');
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

</script>



</asp:Content>
