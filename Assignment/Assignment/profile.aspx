<%@ Page Title="" Language="C#" MasterPageFile="~/profile.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="Assignment.profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT * FROM [UserRegistration]"></asp:SqlDataSource>
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
                    <asp:Image ID="userProfilePic" runat="server" CssClass="img-account-profile rounded-circle mb-2" Width="100px" BorderColor="Black" BorderStyle="Solid" />
                    <!-- Profile picture help block-->
                    <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>
                    <!-- Profile picture upload button-->
                    <asp:Button ID="userUploadProfile" runat="server" Text="Upload new image" CssClass="btn btn-primary" />
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
                            <label class="small mb-1" for="inputUsername">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" Enabled="False"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqTxtUsername" runat="server" ErrorMessage="Username is required" CssClass="validate" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
                        </div>
                        <!-- Form Row        -->
                        <div class="row gx-3 mb-3">
                        <!-- Form Group (email address)-->
                        <div class="mb-3">
                            <label class="small mb-1" for="inputEmailAddress">Email address</label>
                            <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control" ReadOnly="True" Enabled="False"></asp:TextBox>
                        </div>
                        <!-- Form Row-->
                        <div class="row gx-3 mb-3">
                            <!-- Form Group (birthday)-->
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputBirthday">Birthday</label>
                                 <asp:TextBox ID="txtBirthday" runat="server" CssClass="form-control" ReadOnly="True" Disabled="true" Enabled="False"></asp:TextBox>
                            </div>                            
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputBirthday">Member Since</label>
                                 <asp:TextBox ID="txtMemberSince" runat="server" CssClass="form-control" ReadOnly="True" Enabled="False"></asp:TextBox>
                            </div>
                        </div>
                        <!-- Save changes button-->
                            <asp:Button ID="btnEditUserProfile" runat="server" Text="Edit" CssClass="btn btn-primary" OnClick="btnEditUserProfile_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>





</asp:Content>
