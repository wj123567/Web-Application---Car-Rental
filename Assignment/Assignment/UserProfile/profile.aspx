<%@ Page Title="" Language="C#" MasterPageFile="~/UserProfile/profile.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Assignment.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT * FROM [ApplicationUser]"></asp:SqlDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnEmail" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <asp:Timer ID="verifyTimer" runat="server" Interval="1000" OnTick="verifyTimer_Tick"></asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>
 <div class="modal fade" id="changeEmail" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="changeEmail" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
    <asp:UpdatePanel ID="updateChangeEmail" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">Validate Email</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <span>Email:</span>
          <asp:TextBox ID="txtIniMail" runat="server" CssClass="form-control" ValidationGroup="verifyMail" Enabled="False"></asp:TextBox> 
          <div class="mt-2">
          <span>Verification Code:</span>       
          <asp:TextBox ID="txtIniCode" runat="server" CssClass="form-control d-inline" ValidationGroup="verifyMail" Width="73%" Placeholder="Verification Code"></asp:TextBox>
          <asp:Button ID="btnSendIniCode" runat="server" Text="Send" CssClass="btn btn-primary d-inline" Width="25%" Style="margin-left: 3px;" OnClick="btnSendIniCode_Click" OnClientClick="getEmail()"/>
          <asp:CustomValidator ID="cvIniCode" runat="server" ErrorMessage="Invalid Otp" CssClass="validate" ControlToValidate="txtIniCode" ValidationGroup="verifyMail" Display="Dynamic" OnServerValidate="validateVerificationCode_ServerValidate"></asp:CustomValidator>
          <asp:RequiredFieldValidator ID="reqIniCode" runat="server" ErrorMessage="Otp is Require" ValidationGroup="verifyMail" ControlToValidate="txtIniCode" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="labelValidateSend" runat="server" Text="Verification Code Has Been Sent" Visible="False" CssClass="validate"></asp:Label>
          </div>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click"/>
        <asp:Button ID="btnVerify" runat="server" Text="Verify" CssClass="btn btn-primary" ValidationGroup="verifyMail" OnClick="btnVerify_Click"/>        
      </div>
      </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnVerify" />
        </Triggers>
      </asp:UpdatePanel>
    </div>
  </div>   
</div>
    
    <div class="modal fade" id="changeEmail2" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="changeEmail2" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
    <asp:UpdatePanel ID="updateChangeEmail2" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel3">Change New Email</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <span>New Email:</span>
          <asp:TextBox ID="txtIniMail2" runat="server" CssClass="form-control" ValidationGroup="verifyMail2" Placeholder="Email"></asp:TextBox> 
            <asp:RequiredFieldValidator ID="reqIniEmail2" runat="server" ErrorMessage="Email is required" ControlToValidate="txtIniMail2" CssClass="validate" ValidationGroup="verifyMail2" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regIniMail2" runat="server" ControlToValidate="txtIniMail2" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="validate" ValidationGroup="verifyMail2" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:CustomValidator ID="emailExist" runat="server" ErrorMessage="Email Already Exist" ControlToValidate="txtIniMail2" CssClass="validate" OnServerValidate="emailExist_ServerValidate" Display="Dynamic" ValidationGroup="verifyMail2"></asp:CustomValidator>
          <div class="mt-2">
          <span>Verification Code:</span>       
          <asp:TextBox ID="txtIniCode2" runat="server" CssClass="form-control d-inline" ValidationGroup="verifyMailCode" Width="73%" Placeholder="Verification Code"></asp:TextBox>
          <asp:Button ID="btnSendIniCode2" runat="server" Text="Send" CssClass="btn btn-primary d-inline" Width="25%" Style="margin-left: 3px;" OnClick="btnSendIniCode_Click" ValidationGroup="verifyMail2" OnClientClick="getEmail2()"/>
          <asp:CustomValidator ID="cvIniCode2" runat="server" ErrorMessage="Invalid Otp" CssClass="validate" ControlToValidate="txtIniCode2" ValidationGroup="verifyMailCode" Display="Dynamic" OnServerValidate="validateVerificationCode_ServerValidate"></asp:CustomValidator>
          <asp:RequiredFieldValidator ID="reqIniCode2" runat="server" ErrorMessage="Otp is Require" ValidationGroup="verifyMailCode" ControlToValidate="txtIniCode2" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="labelValidateSend2" runat="server" Text="Verification Code Has Been Sent" Visible="False" CssClass="validate"></asp:Label>
          </div>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnCancel2" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click"/>
        <asp:Button ID="btnChangeValidMail" runat="server" Text="Change Email" CssClass="btn btn-primary" ValidationGroup="verifyMailCode" OnClick="btnChangeValidMail_Click"/>        
      </div>
      </ContentTemplate>
      </asp:UpdatePanel>
    </div>
  </div>   
</div>

<div class="container-xl px-4 mt-4">
    <h1>User Profile</h1>
    <hr class="mt-0 mb-4">
    <div class="row">
        <div class="col-xl-4">
            <div class="card mb-4 mb-xl-0">
                <div class="card-header">Profile Picture</div>
                <div class="card-body text-center">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="profile-pic-wrapper profile-image-frame mx-auto" OnClientClick="return fileUpload()">
                     <span class="upload-text">Upload</span>
                    <asp:Image ID="userProfilePic" runat="server" CssClass="img-account-profile rounded-circle" Width="100px"/>
                    </asp:LinkButton>
                    <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 2 MB</div>
                    <asp:Button ID="userUploadProfile" runat="server" Text="Upload new image" CssClass="btn btn-primary" OnClick="userUploadProfile_Click" ValidationGroup="uploadProfilePic" Enabled="False" />
                    <asp:FileUpload ID="fuProfile" runat="server" CssClass="uploadPicture" onchange="ShowPreview(event)"/>
                    <br />
                    <asp:CustomValidator ID="validateProfilePic" runat="server" ControlToValidate="fuProfile" CssClass="validate" ValidationGroup="uploadProfilePic" ValidateEmptyText="True" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile"></asp:CustomValidator>
                    <asp:Label ID="lblProfilePic" runat="server" Text="" CssClass="d-block mt-2 validate"></asp:Label>
                </div>
            </div>
        </div>
        <div class="col-xl-8">
            <div class="card mb-4">
                <div class="card-header">Account Details</div>
                <div class="card-body">
                    <div>
                        <div class="mb-3">
                            <label class="small mb-1">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Enabled="False" ValidationGroup="changUname"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqTxtUsername" runat="server" ErrorMessage="Username is required" CssClass="validate" ControlToValidate="txtUsername" ValidationGroup="changUname"></asp:RequiredFieldValidator>
                        </div>
                        <div class="row gx-3 mb-3">
                        <div class="mb-3">
                            <label class="small mb-1 d-block">Email address</label>
                            <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control d-inline" ReadOnly="True" Enabled="False" Width="82%"></asp:TextBox>
                            <asp:Button ID="btnChangeEmail" runat="server" Text="Change Email" CssClass="btn d-inline btn-primary" data-bs-toggle="modal" data-bs-target="#changeEmail" OnClientClick="return transferText()" Width="16%" style="margin-left:2px;"/>
                        </div>
                        <div class="row gx-3 mb-3">
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
        var fileUpload = document.getElementById(sender.controltovalidate);
        var button = document.getElementById('<%= userUploadProfile.ClientID %>');
        var fileName = fileUpload.value;
        var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
        var maxSize = 2097152; 

        if (!allowedExtensions.exec(fileName)) {
            args.IsValid = false;
            button.disabled = true;
            return;
        }

        if (fileUpload.files[0].size > maxSize) {
            args.IsValid = false;
            button.disabled = true;
            return;
        }

        args.IsValid = true;
        button.disabled = false;
    }

    function transferText() {
        var email = document.getElementById('<%= txtEmailAddress.ClientID %>').value;
        document.getElementById('<%= txtIniMail.ClientID %>').value = email;
        return false;
    }

    function modal2() {
        addEventListener("DOMContentLoaded", (event) => {
            console.log("I'm in")
            $('#changeEmail2').modal('toggle');
            showhideButton();
            return false;
        });
    };

    function modal() {
        addEventListener("DOMContentLoaded", (event) => {
            console.log("I'm in")
            $('#changeEmail').modal('toggle');
            showhideButton();
            return false;
        });
    };

    function getEmail() {
        document.getElementById('<%= hdnEmail.ClientID %>').value = document.getElementById('<%= txtIniMail.ClientID %>').value;
    }

    function getEmail2() {
        document.getElementById('<%= hdnEmail.ClientID %>').value = document.getElementById('<%= txtIniMail2.ClientID %>').value;
    }

    function startCountdown(seconds) {
        var countdown = seconds;
        var button = document.getElementById('<%= btnSendIniCode.ClientID %>');
        var button2 = document.getElementById('<%= btnSendIniCode2.ClientID %>');
            button.disabled = true;
            button2.disabled = true;

            if (countdown > 0) {
                button.value = "Resend " + countdown;
                button2.value = "Resend " + countdown;
            } else {
                button.disabled = false;
                button2.disabled = false;
                button.value = "Send";
                button2.value = "Send";
            }
        }



    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }

</script>



</asp:Content>
