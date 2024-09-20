<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Assignment.UserManagement" %>
<asp:Content ID="adminUser" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/userManagement.css" rel="stylesheet" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnUserStatus" runat="server" />

<div class="modal animate__animated animate__slideInDown animate__faster" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel4">User Detail</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <h5 class="text-dark">Are you sure you want to delete?</h5>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnViewAgain" runat="server" Text="View User" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#userInfoModal" OnClientClick="return false"/>
        <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup" OnClick="btnConfirmDelete_Click"/>
      </div>
    </div>
  </div>   
</div>

<div class="modal animate__animated animate__slideInDown animate__faster" id="banReasonModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="rejectReason" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
    <asp:UpdatePanel ID="banReasonUpdate" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
        <ContentTemplate>
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel">Ban Reason</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <asp:DropDownList ID="ddlBanReason" runat="server" CssClass="form-select" AutoPostBack="True" ValidationGroup="banGroup" OnSelectedIndexChanged="ddlBanReason_SelectedIndexChanged">
              <asp:ListItem Value="0">Select Ban Reason</asp:ListItem>
              <asp:ListItem>Damage to Vehicle</asp:ListItem>
              <asp:ListItem>Violation of Rental Terms</asp:ListItem>
              <asp:ListItem>Unsafe Driving</asp:ListItem>
              <asp:ListItem>Suspicious Behavior</asp:ListItem>
              <asp:ListItem>Unreported Accidents</asp:ListItem>
              <asp:ListItem>Fraudulent Activity</asp:ListItem>
              <asp:ListItem>Other</asp:ListItem>
          </asp:DropDownList>
          <asp:RequiredFieldValidator ID="requireReason" runat="server" ErrorMessage="Reject Reason is Required" CssClass="validate" InitialValue="0" ValidationGroup="banGroup" ControlToValidate="ddlbanReason"></asp:RequiredFieldValidator>
          <asp:TextBox ID="txtOtherReason" runat="server" ValidationGroup="banGroup" CssClass="form-control mt-1" placeholder="Other Reason" Visible="False"></asp:TextBox>
          <asp:RequiredFieldValidator ID="requireOtherReason" runat="server" ErrorMessage="Other Reason is Required" CssClass="validate" ValidationGroup="banGroup" ControlToValidate="txtOtherReason" Enabled="False"></asp:RequiredFieldValidator>
      </div>
        </ContentTemplate>
    </asp:UpdatePanel>
      <div class="modal-footer">
        <asp:Button ID="btnCancelBan" runat="server" Text="Review Again" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#banReasonModal" OnClientClick="return false"/>
        <asp:Button ID="btnConfirmBan" runat="server" Text="Confirm Ban" CssClass="btn btn-danger" ValidationGroup="banGroup" OnClick="btnBan_Click"/>
      </div>
    </div>
  </div>   
</div>    
 <!-- -->  
     
<div class="modal animate__animated animate__slideInLeft animate__faster" id="userInfoModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userInfoModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">User Detail</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <ul class="nav nav-tabs mb-2 justify-content-center" id="userModalTab">
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="userInfoTab" data-bs-toggle="modal" data-bs-target="#userInfoModal" type="button">User Info</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="driverInfoTab" data-bs-toggle="modal" data-bs-target="#userDriverModal" type="button">Driver Info</button>
          </li>
        </ul>
        <div class="row">
                    <div class="Userprofile-image-frame mx-auto">
                    <asp:Image ID="userProfilePic" runat="server" CssClass="img-account-profile rounded-circle mb-2 mx-auto" Width="100px"/>
                    </div>
                    
                    <div>
                        <div class="mb-3">
                            <label class="small mb-1">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                        <div class="row gx-3 mb-3">
                        <div class="col-md-6">
                            <label class="small mb-1">Email address</label>
                            <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                                <label class="small mb-1">Roles</label>
                                 <asp:TextBox ID="txtRoles" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                            </div>  
                        </div>  
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Birthday</label>
                                 <asp:TextBox ID="txtBirthday" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                            </div>                            
                            <div class="col-md-6">
                                <label class="small mb-1">Member Since</label>
                                 <asp:TextBox ID="txtMemberSince" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
    </div>
      <div class="modal-footer">
        <asp:Button ID="btnDel1" runat="server" Text="Delete" CssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false"/>
        <asp:Button ID="btnBan" runat="server" Text="Ban User" CssClass="btn btn-warning btn-ban btn-both" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#banReasonModal" OnClientClick="return false"/>          
        <asp:Button ID="btnUnban" runat="server" Text="Unban User" CssClass="btn btn-primary btn-unban btn-both" ValidationGroup="reviewGroup" OnClick="btnUnban_Click"/>          
      </div>
    </div>
    </div>
  </div>  
    <div class="modal animate__animated animate__slideInRight animate__faster" id="userDriverModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userDriverModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel3">Available Driver</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <ul class="nav nav-tabs mb-2 justify-content-center" id="driverModalTab">
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="userInfoTab2" data-bs-toggle="modal" data-bs-target="#userInfoModal" type="button">User Info</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="driverInfoTab2" data-bs-toggle="modal" data-bs-target="#userDriverModal" type="button">Driver Info</button>
          </li>
        </ul>
        <div class="card-body row">
        <asp:Label ID="lblDriverText" runat="server" CssClass="text-dark"></asp:Label>
        <asp:Repeater ID="UserDriverReapeter" runat="server" OnItemDataBound="UserDriverReapeter_ItemDataBound">
            <ItemTemplate>
                <div class="card-body rounded border border-dark px-0 py-2 mb-2 text-dark">
                    <div class="d-flex align-items-center justify-content-between px-4">
                        <div class="d-flex align-items-center">
                             <i class="fa-regular fa-id-card" style="font-size:1.5em;"></i>
                            <div class="mx-4">
                                    <asp:Label ID="lblDriverName" runat="server" Text='<%# Eval("DriverName") %>' CssClass="small d-block" />
                                    <asp:Label ID="lblDriverBdate" runat="server" Text='<%# "Driver Id: " + Eval("DriverID") %>' CssClass="text-xs text-muted d-inline" />
                                <br />
                                    <asp:Label ID="lblReject" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                        </div>
                        <div class="d-flex align-items-center ms-4 small">
                            <asp:Label ID="lblApproval" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
      <div class="modal-footer">
        <asp:Button ID="btnDel2" runat="server" Text="Delete" CssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false"/>
        <asp:Button ID="btnBan2" runat="server" Text="Ban User" CssClass="btn btn-warning btn-ban btn-both" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#banReasonModal" OnClientClick="return false"/>          
        <asp:Button ID="btnUnban2" runat="server" Text="Unban User" CssClass="btn btn-primary btn-unban btn-both" ValidationGroup="reviewGroup" OnClick="btnUnban_Click"/>  
      </div>
    </div>
    </div>
  </div>

<div class="modal modal-lg animate__animated animate__slideInDown animate__faster" id="addNewUser" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addNewUser" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">     
<asp:UpdatePanel ID="addUpdatePanel" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
<ContentTemplate>           
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel5">Add New User</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row">
            <div class="col-12 col-md-6">
            <div class="text-center">
                     <asp:LinkButton ID="btnAddNewProfile" runat="server" CssClass="profile-pic-wrapper Userprofile-image-frame mx-auto" OnClientClick="return fileUpload()">
                     <span class="upload-text mx-auto">Upload</span>
                    <asp:Image ID="imgAddProfile" runat="server" CssClass="img-account-profile rounded-circle mb-2" Width="100px" ImageUrl="~/Image/UserProfile/noImg.svg" />
                    </asp:LinkButton>
                    <span class="small font-italic text-muted mx-auto">JPG or PNG no larger than 2 MB</span>
                    <asp:FileUpload ID="fuAddProfile" runat="server" style="display:none;" onchange="ShowPreview(event)"/>
                    <br />
                    <asp:CustomValidator ID="validateProfilePic" runat="server" ControlToValidate="fuAddProfile" CssClass="validate" ValidationGroup="addUser" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile"></asp:CustomValidator>             
            </div>
     
            <div>
                        <div class="mb-3">
                            <label class="small mb-1">Username</label>
                            <asp:TextBox ID="txtAddUsername" runat="server" CssClass="form-control" ValidationGroup="addUser"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqUserName" runat="server" ErrorMessage="Username is Require" CssClass="validate" ControlToValidate="txtAddUsername" ValidationGroup="addUser" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-3">
                            <label class="small mb-1">Email address</label>
                            <asp:TextBox ID="txtAddEmail" runat="server" CssClass="form-control" ValidationGroup="addUser"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqEmail" runat="server" ErrorMessage="Email is Require" CssClass="validate" ControlToValidate="txtAddEmail" ValidationGroup="addUser" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="exprEmail" runat="server" ErrorMessage="Invalid Email" CssClass="validate" ControlToValidate="txtAddEmail" ValidationGroup="addUser" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            <asp:CustomValidator ID="emailExist" runat="server" ErrorMessage="Email Already Exist" ControlToValidate="txtAddEmail" CssClass="validate" Display="Dynamic" ValidationGroup="addUser" OnServerValidate="emailExist_ServerValidate"></asp:CustomValidator>
                        </div>  
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Birthday</label>
                                 <asp:TextBox ID="txtAddBdate" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="addUser"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqBdate" runat="server" ErrorMessage="Birthdate is Require" CssClass="validate" ControlToValidate="txtAddBdate" ValidationGroup="addUser" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>    
                        <div class="col-md-6">
                                <label class="small mb-1">Roles</label>
                            <asp:DropDownList ID="ddlAddRoles" runat="server" ValidationGroup="addUser" CssClass="form-select">
                                <asp:ListItem Value="0">Select Roles</asp:ListItem>
                                <asp:ListItem>Admin</asp:ListItem>
                                <asp:ListItem>Customer</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Roles is Required" CssClass="validate" ControlToValidate="ddlAddRoles" ValidationGroup="addUser" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                        </div>                              
                        </div>
                    </div>
            </div>
            <div class="col-12 col-md-6">
             <div class="mb-3">
                  <label class="small mb-1">Password</label>
                   <asp:TextBox ID="txtAddPassword" runat="server" CssClass="form-control mb-2" TextMode="Password" ValidationGroup="addUser" onkeyup="validatePassword()"></asp:TextBox>
                        <asp:CheckBox ID="cbEight" runat="server" Text="at least eight characters" Enabled="True" Checked="False" CssClass="passCheckBox" ValidationGroup="addUser" />
            <br />
                        <asp:CheckBox ID="cbNum" runat="server" Text="at least one number" Enabled="True" CssClass="passCheckBox" ValidationGroup="addUser" />
            <br />
                        <asp:CheckBox ID="cbUpLow" runat="server" Text="both lower and uppercase letters" Enabled="True" CssClass="passCheckBox" ValidationGroup="addUser"/>
            <br />
                         <asp:CheckBox ID="cbSpecial" runat="server" Text="must contain one special characters" Enabled="True" CssClass="passCheckBox" ValidationGroup="addUser" />
                    <asp:CustomValidator ID="validatePassword" runat="server" ControlToValidate="txtAddPassword" ErrorMessage="Invalid Password" ValidationGroup="addUser" CssClass="validate" ClientValidationFunction="validatePassword" ValidateEmptyText="True" Visible="false"></asp:CustomValidator>
             </div>                        
             <div class="mb-3">
                 <label class="small mb-1">Confirm Password</label>
                 <asp:TextBox ID="txtAddConfirmPassword" runat="server" CssClass="form-control" ValidationGroup="addUser" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqConfirmPass" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtAddConfirmPassword" ValidationGroup="addUser" Display="Dynamic" CssClass="validate"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="validConfirmPassword" runat="server" ErrorMessage="Both Password Must be Same" ControlToCompare="txtAddPassword" ControlToValidate="txtAddConfirmPassword" CssClass="validate" ValidationGroup="addUser" Display="Dynamic"></asp:CompareValidator>
            <br />
            <input id="cbShowAddPass" type="checkbox" onClick="showPass()"/>
            <span>Show Password</span>
             </div>
            </div>
         </div>
    </div>
      <div class="modal-footer">
        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click"/>      
        <asp:Button ID="btnAddUser" runat="server" Text="Add New User" CssClass="btn btn-primary" ValidationGroup="addUser" OnClick="btnAddUser_Click"/>          
      </div>
</ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="btnAddUser" />
        <asp:PostBackTrigger ControlID="btnCancel" />
    </Triggers>
</asp:UpdatePanel>
    </div>
    </div>
  </div>
        
    <div class="container-xl px-4 mt-4">
    <h1 class="text-dark">User Management</h1>
    <hr class="mt-0 mb-4">
     <div class="row">
         <div class="col">
             <asp:Button ID="btnAddNewUser" runat="server" Text="Add New User" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNewUser" OnClientClick="return false"/>
         </div>
         <div class="float-end" style="width: 250px;">             
            <asp:TextBox ID="searchBar" runat="server" CssClass="form-control rounded border-dark" placeholder="Email/Username " ValidationGroup="searchBar" onkeypress="triggerButtonClick(event)"></asp:TextBox>
            <asp:Button ID="hiddenBtn" runat="server" Text="Button" OnClick="hiddenBtn_Click" ValidationGroup="searchBar" style="display:none;"/>
         </div>
         </div>
    <div>
                <asp:UpdatePanel ID="updateUserTable" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
            <div class="table-responsive">
            <table id="userTable" class="table table-striped table-bordered table-hover mb-2">
            <thead>
                <tr style="text-align: center;">                  
                    <th scope="col">
                        <asp:LinkButton ID="btnSortUsername" runat="server" OnClick="btnSort_Click" CommandArgument="DESC" CommandName="Username" CssClass="text-dark">Username</asp:LinkButton>
                     </th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortEmail" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Email" CssClass="text-dark">Email</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortDOB" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DOB" CssClass="text-dark">Date of Birth</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortRegDate" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="RegistrationDate" CssClass="text-dark">Registration Date</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortRoles" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Roles" CssClass="text-dark">Roles</asp:LinkButton></th>                     
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortBan" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="IsBan" CssClass="text-dark">User Status</asp:LinkButton></th>                     
                    <th scope="col">                        
                        <asp:LinkButton ID="btnBanReason" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="BanReason" CssClass="text-dark">Ban Reason</asp:LinkButton></th>               
                    <th scope="col">Actions</th>
                </tr>
            </thead>                
            <tbody>
                <asp:Repeater ID="UserReapeter" runat="server"  OnItemDataBound="UserReapeter_ItemDataBound" OnItemCreated="UserReapeter_ItemCreated">
                <ItemTemplate>
                <tr style="text-align: center;">                    
                    <td scope="col"><%# Eval("UserName") %></td>
                    <td scope="col"><%# Eval("Email") %></td>
                    <td scope="col">
                        <asp:Label ID="lblBdate" runat="server"></asp:Label>
                    </td>                    
                    <td scope="col">
                        <asp:Label ID="lblRegdate" runat="server"></asp:Label>
                    </td>
                    <td scope="col">                    
                        <asp:DropDownList ID="ddlRoles" runat="server" CssClass="form-select form-select-sm" AutoPostBack="True" OnSelectedIndexChanged="ddlRolesSelect">
                        </asp:DropDownList>
                        <asp:HiddenField ID="hdnIdField" runat="server" Value='<%# Eval("Id") %>' />
                    </td>
                    <td scope="col">
                        <asp:Label ID="lblUserStatus" runat="server"></asp:Label>
                    </td>
                    <td scope="col"><%# Eval("BanReason") %></td>
                    <td scope="col">
                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-primary" OnClick="btnView_Click" CommandArgument='<%# Eval("Id") %>'/>
                    </td>
                </tr>
                </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
</div>

        <div>
        <div class="float-start">
        <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" Enabled="False" CssClass="btn btn-primary btn-sm" />
        <asp:Label ID="lblPageInfo" runat="server" Text="" CssClass="text-dark mx-2"></asp:Label>
        <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn btn-primary btn-sm" />
        </div>  
        <asp:Label ID="lblTotalRecord" runat="server" Text="" CssClass="float-end text-muted"></asp:Label>
        </div>
                </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="hiddenBtn" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
      

    </div>
    </div>   
    <script>

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

        function fileUpload() {
            document.getElementById('<%= fuAddProfile.ClientID %>').click();

            return false;
        }

        function showSortDirection(buttonID, sort) {

            var button = document.getElementById(buttonID);

            if (sort == "ASC") {
                button.innerHTML = button.innerHTML + " ▲";
            } else {
                button.innerHTML = button.innerHTML + " ▼";
            }
        }

        function addUsername() {

            document.getElementById('<%= btnSortUsername.ClientID %>').innerHTML = document.getElementById('<%= btnSortUsername.ClientID %>').innerHTML + " ▲";
        }

        function ShowPreview(event) {          
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
                var image = document.getElementById('<%= imgAddProfile.ClientID %>');
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
                return;
            }

            if (fileUpload.files[0].size > maxSize) {
                args.IsValid = false;
                return;
            }

            args.IsValid = true;
        }

        function showPass() {
            var password1 = document.getElementById('<%= txtAddPassword.ClientID %>');
            var password2 = document.getElementById('<%= txtAddConfirmPassword.ClientID %>');
            var checkBox = document.getElementById('cbShowAddPass');

            if (checkBox.checked) {
                password1.type = 'text';
                password2.type = 'text';
            } else {
                password1.type = 'password';
                password2.type = 'password';
            }
        }

        function validatePassword(sender, args) {
            var password = document.getElementById('<%= txtAddPassword.ClientID %>').value;
            var hasEightChars = password.length >= 8;
            var hasNum = /\d/.test(password);
            var hasUpLow = /[a-z]/.test(password) && /[A-Z]/.test(password);
            var hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/.test(password);

            document.getElementById('<%= cbEight.ClientID %>').checked = hasEightChars;
            document.getElementById('<%= cbNum.ClientID %>').checked = hasNum;
            document.getElementById('<%= cbUpLow.ClientID %>').checked = hasUpLow;
            document.getElementById('<%= cbSpecial.ClientID %>').checked = hasSpecial;

            if (hasEightChars && hasNum && hasUpLow && hasSpecial) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        function loadModal() {
            document.addEventListener("DOMContentLoaded", modal);
            document.addEventListener("DOMContentLoaded", showhideButton);
        }

        function showhideButton() {
            var hdnUserStatus = document.getElementById('<%= hdnUserStatus.ClientID %>').value;
            var buttonGroup = document.querySelectorAll(".btn-both");
            var button = null;

            buttonGroup.forEach(function (btn) {
                btn.style.display = "none";
            });

            if (hdnUserStatus == "0") {
                button = document.querySelectorAll(".btn-ban");
            } else {
                button = document.querySelectorAll(".btn-unban");
            }

            button.forEach(function (btn) {
                btn.style.display = "block";
            });
        }


        function modal() {
            addEventListener("DOMContentLoaded", (event) => {
            $('#userInfoModal').modal('toggle');
            showhideButton();
            return false;
            });
        };

        function addNewmodal() {
            addEventListener("DOMContentLoaded", (event) => {
            $('#addNewUser').modal('toggle');
            showhideButton();
            return false;
            });
        };

        function modalDel() {
            addEventListener("DOMContentLoaded", (event) => {
                $('#ConfirmDelete').modal('toggle');
                showhideButton();
                return false;
            });
        };

        function triggerButtonClick(event) {
            if (event.keyCode == 13) {
                event.preventDefault(); 
                document.getElementById('<%= hiddenBtn.ClientID %>').click();
            }
        }

    </script>
</asp:Content>
