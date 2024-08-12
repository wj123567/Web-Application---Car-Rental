<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Assignment.UserManagement" %>
<asp:Content ID="adminUser" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnUserStatus" runat="server" />
<div class="modal fade" id="banReasonModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="rejectReason" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
    <asp:UpdatePanel ID="banReasonUpdate" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
        <ContentTemplate>
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel">Ban Reason</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <asp:DropDownList ID="ddlBanReason" runat="server" CssClass="form-select" AutoPostBack="True" ValidationGroup="rejectGroup">
              <asp:ListItem Value="0">Select Reject Reason</asp:ListItem>
              <asp:ListItem>Invalid driving license (expired/illegible)</asp:ListItem>
              <asp:ListItem>Mismatch in driving license information</asp:ListItem>
              <asp:ListItem>Expired/invalid passport or ID</asp:ListItem>
              <asp:ListItem>Mismatch in passport or ID information</asp:ListItem>
              <asp:ListItem>Unclear document scan or image</asp:ListItem>
              <asp:ListItem>Selfie does not match documents</asp:ListItem>
              <asp:ListItem>Unclear selfie quality (poor lighting/visibility)</asp:ListItem>
              <asp:ListItem>Other</asp:ListItem>
          </asp:DropDownList>
          <asp:RequiredFieldValidator ID="requireReason" runat="server" ErrorMessage="Reject Reason is Required" CssClass="validate" InitialValue="0" ValidationGroup="banGroup" ControlToValidate="ddlbanReason"></asp:RequiredFieldValidator>
          <asp:TextBox ID="txtOtherReason" runat="server" ValidationGroup="banGroup" CssClass="form-control mt-1" placeholder="Other Reason" Visible="False"></asp:TextBox>
          <asp:RequiredFieldValidator ID="requireOtherReason" runat="server" ErrorMessage="Other Reason is Required" CssClass="validate" ValidationGroup="banGroup" ControlToValidate="txtOtherReason" Enabled="False"></asp:RequiredFieldValidator>
      </div>
        </ContentTemplate>
    </asp:UpdatePanel>
      <div class="modal-footer">
        <asp:Button ID="btnCancelBan" runat="server" Text="Review Again" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reviewDriver" OnClientClick="return false"/>
        <asp:Button ID="btnReject2" runat="server" Text="Reject" CssClass="btn btn-danger" ValidationGroup="rejectGroup"/>
      </div>
    </div>
  </div>   
</div>    
    
<div class="modal fade" id="userInfoModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userInfoModal" aria-hidden="true">
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
                        <div class="mb-3">
                            <label class="small mb-1">Email address</label>
                            <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
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
</div>
      <div class="modal-footer">
        <asp:Button ID="btnBan" runat="server" Text="Ban User" CssClass="btn btn-danger btn-ban btn-both" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#rejectReason" OnClientClick="return false"/>          
        <asp:Button ID="btnUnban" runat="server" Text="Unban User" CssClass="btn btn-primary btn-unban btn-both" ValidationGroup="reviewGroup"/>          
      </div>
    </div>
    </div>
  </div>
    
    <div class="modal fade" id="userDriverModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userDriverModal" aria-hidden="true">
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
        <asp:Button ID="btnBan2" runat="server" Text="Ban User" CssClass="btn btn-danger btn-ban btn-both" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#rejectReason" OnClientClick="return false"/>          
        <asp:Button ID="btnUnban2" runat="server" Text="Unban User" CssClass="btn btn-primary btn-unban btn-both" ValidationGroup="reviewGroup"/>  
      </div>
    </div>
    </div>
  </div>   

        
    <div class="container-xl px-4 mt-4">
    <h1 class="text-dark">User Management</h1>
    <hr class="mt-0 mb-4">
     <div class="row">
         <div class="float-end" style="width: 250px;">
            <asp:TextBox ID="searchBar" runat="server" CssClass="form-control rounded border-dark" placeholder="Search" ValidationGroup="searchBar" onkeypress="triggerButtonClick(event)"></asp:TextBox>
            <asp:Button ID="hiddenBtn" runat="server" Text="Button" OnClick="hiddenBtn_Click" ValidationGroup="searchBar" style="display:none;"/>
         </div>
         </div>
    <div>
                <asp:UpdatePanel ID="updateUserTable" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
            <table id="userTable" class="table table-striped table-bordered table-hover table-responsive">
            <thead>
                <tr style="text-align: center;">
                    <th scope="col">
                        <asp:LinkButton ID="btnSortId" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Id" CssClass="text-dark">User Id</asp:LinkButton>
                     </th>                    
                    <th scope="col">
                        <asp:LinkButton ID="btnSortUsername" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Username" CssClass="text-dark">Username</asp:LinkButton>
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
                    <th scope="col">Actions</th>
                </tr>
            </thead>                
            <tbody>
                <asp:Repeater ID="UserReapeter" runat="server"  OnItemDataBound="UserReapeter_ItemDataBound" OnItemCreated="UserReapeter_ItemCreated">
                <ItemTemplate>
                <tr style="text-align: center;">
                    <td scope="col"><%# Eval("Id") %></td>
                    <td scope="col"><%# Eval("UserName") %></td>
                    <td scope="col"><%# Eval("Email") %></td>
                    <td scope="col">
                        <asp:Label ID="lblBdate" runat="server"></asp:Label>
                    </td>                    
                    <td scope="col">
                        <asp:Label ID="lblRegdate" runat="server"></asp:Label>
                    </td>
                    <td scope="col"><%# Eval("Roles") %></td>
                    <td scope="col">
                        <asp:Label ID="lblUserStatus" runat="server"></asp:Label>
                    </td>
                    <td scope="col">
                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-primary" OnClick="btnView_Click" CommandArgument='<%# Eval("Id") %>'/>
                    </td>
                </tr>
                </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
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
            $('#userInfoModal').modal('toggle');
            return false;
        };

        function triggerButtonClick(event) {
            if (event.keyCode == 13) {
                event.preventDefault(); 
                document.getElementById('<%= hiddenBtn.ClientID %>').click();
            }
        }

    </script>
</asp:Content>
