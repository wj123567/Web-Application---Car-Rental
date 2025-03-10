﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Assignment.UserManagement" %>

<asp:Content ID="adminUser" ContentPlaceHolderID="main" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.min.js" integrity="sha512-JyCZjCOZoyeQZSd5+YEAcFgz2fowJ1F1hyJOXgtKu4llIa0KneLcidn5bwfutiehUTiOuK87A986BZJMko0eWQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.6.2/cropper.css" integrity="sha512-087vysR/jM0N5cp13Vlp+ZF9wx6tKbvJLwPO8Iit6J7R+n7uIMMjg37dEgexOshDmDITHYY5useeSmfD1MYiQA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link href="../CSS/userManagement.css" rel="stylesheet" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnUserStatus" runat="server" />
    <asp:HiddenField ID="hdnUserId" runat="server" />
    <div class="modal fade" id="cropModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="cropModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="cropModalLabel">Crop Profile Picture</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="cropped-container">
                        <asp:Image ID="imgCropImage" runat="server" Width="100%" />
                        <asp:HiddenField ID="hdnProfilePicture" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#addNewUser" >Cancel</button>
                    <asp:Button ID="btnUpload" runat="server" Text="Change Profile Picture" CssClass="btn btn-primary" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal animate__animated animate__slideInDown animate__faster" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel4">User Detail</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="autoscroll()"></button>
                </div>
                <div class="modal-body">
                    <h5 class="text-dark">Are you sure you want to delete?</h5>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnViewAgain" runat="server" Text="View User" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#userInfoModal" OnClientClick="return false" />
                    <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup" OnClick="btnConfirmDelete_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal animate__animated animate__slideInDown animate__faster" id="banReasonModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="rejectReason" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <asp:UpdatePanel ID="banReasonUpdate" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
                    <ContentTemplate>
                        <div class="modal-header">
                            <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel">Ban Reason</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="autoscroll()"></button>
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
                    <asp:Button ID="btnCancelBan" runat="server" Text="Review Again" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#userInfoModal" OnClientClick="return false" />
                    <asp:Button ID="btnConfirmBan" runat="server" Text="Confirm Ban" CssClass="btn btn-danger" ValidationGroup="banGroup" OnClick="btnBan_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal animate__animated animate__slideInLeft animate__faster" id="userInfoModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userInfoModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">User Detail</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="autoscroll()"></button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-tabs mb-2 justify-content-center" id="userModalTab">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="userBookingRec" data-bs-toggle="modal" data-bs-target="#userBookingModal" type="button">Booking Record</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="userInfoTab" data-bs-toggle="modal" data-bs-target="#userInfoModal" type="button">User Info</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="driverInfoTab" data-bs-toggle="modal" data-bs-target="#userDriverModal" type="button">Driver Info</button>
                        </li>
                    </ul>
                    <div class="row">
                        <div class="Userprofile-image-frame mx-auto">
                            <asp:Image ID="userProfilePic" runat="server" CssClass="img-account-profile rounded-circle mx-auto" Width="100px" />
                        </div>

                        <div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1">Username</label>
                                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1">Email address</label>
                                    <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1">Reward Point</label>
                                    <asp:TextBox ID="txtRewardPoint" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
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
                    <asp:Button ID="btnDel1" runat="server" Text="Delete" CssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" />
                    <asp:Button ID="btnBan" runat="server" Text="Ban User" CssClass="btn btn-warning btn-ban btn-both" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#banReasonModal" OnClientClick="return false" />
                    <asp:Button ID="btnUnban" runat="server" Text="Unban User" CssClass="btn btn-primary btn-unban btn-both" ValidationGroup="reviewGroup" OnClick="btnUnban_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-lg animate__animated animate__slideInLeft animate__faster" id="userBookingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userBookingModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="staticBookingLabel">Booking Record</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="autoscroll()"></button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-tabs mb-2 justify-content-center" id="bookingModalTab">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="userBookingRec3" data-bs-toggle="modal" data-bs-target="#userBookingModal" type="button">Booking Record</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="userInfoTab3" data-bs-toggle="modal" data-bs-target="#userInfoModal" type="button">User Info</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="driverInfoTab3" data-bs-toggle="modal" data-bs-target="#userDriverModal" type="button">Driver Info</button>
                        </li>
                    </ul>
                    <div class="card-body row">

                        <asp:Label ID="lblNoBooking" runat="server" CssClass="text-dark"></asp:Label>
                        <asp:Repeater ID="rptBookingRec" runat="server" OnItemDataBound="rptBookingRec_ItemDataBound">
                            <ItemTemplate>
                                <div class="card-body rounded border border-dark px-0 py-2 mb-2 text-dark">
                                    <div class="d-flex align-items-center justify-content-between px-2">
                                        <div class="d-flex align-items-center">
                                            <div class="user-car-frame me-2 flex-shrink-0">
                                                <asp:Image ID="carImage" runat="server" ImageUrl='<%# Eval("CarImage")%>' CssClass="img-fluid" />
                                            </div>
                                            <div>
                                                <asp:Label ID="lblBookingId" runat="server" Text='<%# Eval("Id") +" (" + Eval("CarPlate") +")"%>' CssClass="d-block" />
                                                <asp:Label ID="lblPickupPoint" runat="server" Text='<%# "Location: " + Eval("Pickup_point") %>' CssClass="text-xs text-muted d-block" />
                                                <asp:Label ID="lblPickupTime" runat="server" Text='<%# "Time: (" + Eval("StartDate") +")" + " - (" + Eval("EndDate") +")"%>' CssClass="text-xs text-muted d-block" />
                                                <asp:Label ID="lblBookUpdate" runat="server" CssClass="text-danger small"></asp:Label>
                                                <asp:Label ID="lblBookReject" runat="server" CssClass="text-danger small"></asp:Label>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-center ms-4">
                                            <asp:Label ID="lblstatus" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="Button1" runat="server" Text="Delete" CssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" />
                    <asp:Button ID="Button2" runat="server" Text="Ban User" CssClass="btn btn-warning btn-ban btn-both" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#banReasonModal" OnClientClick="return false" />
                    <asp:Button ID="Button3" runat="server" Text="Unban User" CssClass="btn btn-primary btn-unban btn-both" ValidationGroup="reviewGroup" OnClick="btnUnban_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal animate__animated animate__slideInRight animate__faster" id="userDriverModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userDriverModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel3">Available Driver</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="autoscroll()"></button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-tabs mb-2 justify-content-center" id="driverModalTab">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="userBookingRec2" data-bs-toggle="modal" data-bs-target="#userBookingModal" type="button">Booking Record</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="userInfoTab2" data-bs-toggle="modal" data-bs-target="#userInfoModal" type="button">User Info</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="driverInfoTab2" data-bs-toggle="modal" data-bs-target="#userDriverModal" type="button">Driver Info</button>
                        </li>
                    </ul>
                    <div class="card-body row">
                        <asp:Label ID="lblDriverText" runat="server" CssClass="text-dark"></asp:Label>
                        <asp:PlaceHolder ID="phUserDriver" runat="server">
                            <div class="card-body rounded border border-dark px-0 py-2 mb-2 text-dark">
                                <div class="d-flex align-items-center justify-content-between px-2 align-content-center">
                                    <div class="d-flex align-items-center">
                                            <div class="user-driver-frame me-3 flex-shrink-0">
                                                <asp:Image ID="imgDriverSelfie" runat="server" CssClass="img-fluid" />
                                            </div>
                                        <div>
                                            <asp:Label ID="lblDriverName" runat="server" Text="" CssClass="text-xs d-block" />
                                            <asp:Label ID="lblDriverId" runat="server" Text="" CssClass="text-xs text-muted d-block" />
                                            <asp:Label ID="lblDriverPno" runat="server" Text="Phone No: " CssClass="text-xs text-muted d-block" />
                                            <asp:Label ID="lblDriverBdate" runat="server" Text="Date Of Birth: " CssClass="text-xs text-muted d-block" />
                                            <br />
                                            <asp:Label ID="lblReject" runat="server" CssClass="text-danger small"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center ms-4 small">
                                        <asp:Label ID="lblApproval" runat="server"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </asp:PlaceHolder>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnDel2" runat="server" Text="Delete" CssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" />
                    <asp:Button ID="btnBan2" runat="server" Text="Ban User" CssClass="btn btn-warning btn-ban btn-both" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#banReasonModal" OnClientClick="return false" />
                    <asp:Button ID="btnUnban2" runat="server" Text="Unban User" CssClass="btn btn-primary btn-unban btn-both" ValidationGroup="reviewGroup" OnClick="btnUnban_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-lg animate__animated animate__slideInDown animate__faster" id="addNewUser" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addNewUser" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
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
                                            <asp:Image ID="imgAddProfile" runat="server" CssClass="img-account-profile rounded-circle" Width="100px" ImageUrl="~/Image/UserProfile/noImg.svg" />
                                        </asp:LinkButton>
                                        <span class="small font-italic text-muted mx-auto">JPG or PNG no larger than 2 MB</span>
                                        <asp:FileUpload ID="fuAddProfile" runat="server" Style="display: none;" onchange="ShowCropModal(event)" />
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
                                        <asp:CheckBox ID="cbEight" runat="server" Text="" Enabled="True" Checked="False" CssClass="passCheckBox" ValidationGroup="addUser" /><span> at least eight characters</span>
                                        <br />
                                        <asp:CheckBox ID="cbNum" runat="server" Text="" Enabled="True" CssClass="passCheckBox" ValidationGroup="addUser" /><span> at least one number</span>
                                        <br />
                                        <asp:CheckBox ID="cbUpLow" runat="server" Text="" Enabled="True" CssClass="passCheckBox" ValidationGroup="addUser" /><span> both lower and uppercase letters</span>
                                        <br />
                                        <asp:CheckBox ID="cbSpecial" runat="server" Text="" Enabled="True" CssClass="passCheckBox" ValidationGroup="addUser" /><span> must contain one special characters</span>
                                        <asp:CustomValidator ID="validatePassword" runat="server" ControlToValidate="txtAddPassword" ErrorMessage="Invalid Password" ValidationGroup="addUser" CssClass="validate" ClientValidationFunction="validatePassword" ValidateEmptyText="True" Visible="false"></asp:CustomValidator>
                                    </div>
                                    <div class="mb-3">
                                        <label class="small mb-1">Confirm Password</label>
                                        <asp:TextBox ID="txtAddConfirmPassword" runat="server" CssClass="form-control" ValidationGroup="addUser" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqConfirmPass" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtAddConfirmPassword" ValidationGroup="addUser" Display="Dynamic" CssClass="validate"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="validConfirmPassword" runat="server" ErrorMessage="Both Password Must be Same" ControlToCompare="txtAddPassword" ControlToValidate="txtAddConfirmPassword" CssClass="validate" ValidationGroup="addUser" Display="Dynamic"></asp:CompareValidator>
                                        <br />
                                        <input id="cbShowAddPass" type="checkbox" onclick="showPass()" />
                                        <span>Show Password</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click" />
                            <asp:Button ID="btnAddUser" runat="server" Text="Add New User" CssClass="btn btn-primary" ValidationGroup="addUser" OnClick="btnAddUser_Click" />
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
    <div class="px-4">
        <div class="container-xl mt-4">
            <h1 class="text-dark">Security Summary</h1>
            <hr class="mt-0 mb-4">
            <div class="col-12 d-flex">
                <div class="w-100">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Validated Users</h5>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3">
                                        <asp:Label ID="lblValidatedUser" runat="server" Text="Label"></asp:Label></h1>
                                    <div class="mb-0">
                                        <asp:Label ID="lblNumValidatedUser" runat="server" Text="Label" CssClass="text-muted"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Two-Factor Authentication Users</h5>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3"><asp:Label ID="lbltfa" runat="server" Text="Label"></asp:Label></h1>
                                    <div class="mb-0">
                                        <asp:Label ID="lbltfanum" runat="server" Text="Label" CssClass="text-muted"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container-xl mt-4">
            <h1 class="text-dark">User Management</h1>
            <hr class="mt-0 mb-4">
            <div class="d-flex justify-content-between">
                <div class="me-2">
                    <asp:Button ID="btnAddNewUser" runat="server" Text="Add New User" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNewUser" OnClientClick="return false" />
                </div>
                <div class="me-2 flex-shrink-3">
                    <asp:TextBox ID="searchBar" runat="server" CssClass="form-control rounded border-dark" placeholder="Email/Username " ValidationGroup="searchBar" onkeypress="triggerButtonClick(event)"></asp:TextBox>
                    <asp:Button ID="hiddenBtn" runat="server" Text="Button" OnClick="hiddenBtn_Click" ValidationGroup="searchBar" Style="display: none;" />
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
                                            <asp:LinkButton ID="btnSortEmail" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Email" CssClass="text-dark">Email</asp:LinkButton></th>                                        <th scope="col">
                                            <asp:LinkButton ID="btnSortValidate" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="EmailVerification" CssClass="text-dark">Email Verification</asp:LinkButton></th>                                        <th scope="col">
                                            <asp:LinkButton ID="btnSortTFA" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="TwoStepVerification" CssClass="text-dark">2FA</asp:LinkButton></th>
                                        <th scope="col">
                                            <asp:LinkButton ID="btnSortRP" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="RewardPoints" CssClass="text-dark">Reward Point</asp:LinkButton></th>
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
                                    <asp:Repeater ID="UserReapeter" runat="server" OnItemDataBound="UserReapeter_ItemDataBound" OnItemCreated="UserReapeter_ItemCreated">
                                        <ItemTemplate>
                                            <tr style="text-align: center;">
                                                <td scope="col"><%# Eval("UserName") %></td>
                                                <td scope="col"><%# Eval("Email") %></td>
                                                <td scope="col"><%# Eval("EmailVerification").ToString() == "1" ? "Valid" : "Invalid" %></td>
                                                <td scope="col"><%# Eval("TwoStepVerification").ToString() == "1" ? "Enabled" : "Disabled"%></td>
                                                <td scope="col"><%# Eval("RewardPoints") %></td>
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
                                                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-primary" OnClick="btnView_Click" CommandArgument='<%# Eval("Id") %>' />
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
                            <asp:Label ID="lblTotalRecord" runat="server" Text="" CssClass="float-end text-muted span-totalRecord"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="hiddenBtn" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>


            </div>
        </div>

    </div>
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
                    $('#addNewUser').modal('hide');
                };
                //get file and convert to data url to use in img src = ""
                ImageDir.readAsDataURL(event.target.files[0]);
            }
        }

        let cropper;
        const imageInput = document.getElementById('<%= fuAddProfile.ClientID %>');
        const imageElement = document.getElementById('<%= imgCropImage.ClientID %>');
        const uploadButton = document.getElementById('<%= btnUpload.ClientID %>');
        const result = document.getElementById('<%= hdnProfilePicture.ClientID %>');
        const preview = document.getElementById('<%= imgAddProfile.ClientID %>');


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
                preview.src = base64Image;
                $('#cropModal').modal('hide');
                $('#addNewUser').modal('show');
                return false;
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

        function fileUpload() {
            document.getElementById('<%= fuAddProfile.ClientID %>').click();

            return false;
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
                if (result.value != "") {
                    preview.src = result.value
                }
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

        function autoscroll() {
            window.scrollTo(0, document.body.scrollHeight);
        }

    </script>
</asp:Content>
