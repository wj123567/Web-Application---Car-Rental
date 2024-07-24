<%@ Page Title="" Language="C#" MasterPageFile="~/profile.Master" AutoEventWireup="true" CodeBehind="security.aspx.cs" Inherits="Assignment.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="container-xl px-4 mt-4">
        <h1>Security</h1>
        <hr class="mt-0 mb-4">
        <div class="row">
            <div class="col-lg-8">
                <!-- Change password card-->
                <div class="card mb-4">
                    <div class="card-header">Change Password</div>
                    <div class="card-body">
                            <!-- Form Group (current password)-->
                            <div class="mb-3">
                                <label class="small mb-1" for="currentPassword">Current Password</label>
                                <asp:TextBox ID="txtCurrentPass" runat="server" CssClass="form-control" placeholder="Enter current password" TextMode="Password" ValidationGroup="passwordGroup"></asp:TextBox>
                                <asp:CustomValidator ID="validCurrentPassword" runat="server" ErrorMessage="Incorrect Password" CssClass="validate" ControlToValidate="txtCurrentPass" ValidationGroup="passwordGroup" OnServerValidate="validCurrentPassword_ServerValidate"></asp:CustomValidator>
                            </div>
                            <!-- Form Group (new password)-->
                            <div class="mb-3">
                                <label class="small mb-1" for="newPassword">New Password</label>
                     <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" placeholder="Enter new password" TextMode="Password" onkeyup="validatePassword()" ValidationGroup="passwordGroup"></asp:TextBox>

                     <asp:CustomValidator ID="validNewPassword" runat="server" ErrorMessage="New Password Cannot be same as Old Password" CssClass="validate" ControlToValidate="txtNewPassword" ValidationGroup="passwordGroup" OnServerValidate="validNewPassword_ServerValidate"></asp:CustomValidator>
                    <br />
                        <asp:CheckBox ID="cbEight" runat="server" Text="must contain at least eight characters" Enabled="True" Checked="False" CssClass="passCheckBox" ValidationGroup="passwordGroup" />
            <br />
                        <asp:CheckBox ID="cbNum" runat="server" Text="at least one number" Enabled="True" CssClass="passCheckBox" ValidationGroup="passwordGroup" />
            <br />
                        <asp:CheckBox ID="cbUpLow" runat="server" Text="both lower and uppercase letters" Enabled="True" CssClass="passCheckBox" ValidationGroup="passwordGroup" />
            <br />
                         <asp:CheckBox ID="cbSpecial" runat="server" Text="must contain one special characters" Enabled="True" CssClass="passCheckBox" ValidationGroup="passwordGroup" />

            <asp:RequiredFieldValidator ID="reqPass" runat="server" ErrorMessage="RequiredFieldValidator" ValidationGroup="passwordGroup" ControlToValidate="txtNewPassword" hidden="true"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regPass" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txtNewPassword" ValidationGroup="passwordGroup" ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+\-=\[\]{};':&quot;\\|,.&lt;&gt;\/?]).{8,}$" hidden="true"></asp:RegularExpressionValidator>
                            </div>
                            <!-- Form Group (confirm password)-->
                            <div class="mb-3">
                                <label class="small mb-1" for="confirmPassword">Confirm Password</label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" placeholder="Confirm new password" TextMode="Password" ValidationGroup="passwordGroup"></asp:TextBox>
                                <asp:CompareValidator ID="cprConfirmPass" runat="server" ErrorMessage="Both Password need to be same" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmPassword" CssClass="validate" ValidationGroup="passwordGroup"></asp:CompareValidator>
                            </div>
            <input id="cbShowPass" type="checkbox" onClick="showPass()"/>
            <span>Show Password</span>
                        <asp:Button ID="btnChange" runat="server" Text="Save" CssClass="btn btn-primary d-block mt-2" ValidationGroup="passwordGroup" OnClick="btnChange_Click" />
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <!-- Two factor authentication card-->
                <div class="card mb-4">
                    <div class="card-header">Two-Factor Authentication</div>
                    <div class="card-body">
                        <p>Add another level of security to your account by enabling two-factor authentication. We will send you a OTP to verify your login attempts.</p>
                                <asp:RadioButtonList ID="rblOtpSwitch" runat="server">
                                    <asp:ListItem>On</asp:ListItem>
                                    <asp:ListItem>Off</asp:ListItem>
                                </asp:RadioButtonList>
                            <div class="mt-3">
                                <label class="small mb-1" for="twoFactorSMS">Email:</label>
                                <asp:TextBox ID="txtTwoFactorEmail" runat="server" CssClass="form-control" Enabled="False"></asp:TextBox>
                            </div>
                    </div>
                </div>
                <!-- Delete account card-->
                <div class="card mb-4">
                    <div class="card-header">Delete Account</div>
                    <div class="card-body">
                        <p>Deleting your account is a permanent action and cannot be undone. If you are sure you want to delete your account, select the button below.</p>
                        <asp:Button ID="btnDeleteAcc" runat="server" Text="I UNDERSTAND, DELETE MY ACCOUNT" CssClass="btn btn-danger-soft text-danger" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function showPass() {
            var password1 = document.getElementById('<%= txtCurrentPass.ClientID %>');
            var password2 = document.getElementById('<%= txtNewPassword.ClientID %>');
            var password3 = document.getElementById('<%= txtConfirmPassword.ClientID %>');
            var checkBox = document.getElementById('cbShowPass');

            if (checkBox.checked) {
                password1.type = 'text';
                password2.type = 'text';
                password3.type = 'text';
            } else {
                password1.type = 'password';
                password2.type = 'password';
                password3.type = 'password';
            }
        }

        function validatePassword() {
            var password = document.getElementById('<%= txtNewPassword.ClientID %>').value;
            var hasEightChars = password.length >= 8;
            var hasNum = /\d/.test(password);
            var hasUpLow = /[a-z]/.test(password) && /[A-Z]/.test(password);
            var hasSpecial = /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]+/.test(password);

            if (password.length > 0) {
                console.log("Password: " + password);
            } else {
                console.log("Password: ");
            }

            document.getElementById('<%= cbEight.ClientID %>').checked = hasEightChars;
            document.getElementById('<%= cbNum.ClientID %>').checked = hasNum;
            document.getElementById('<%= cbUpLow.ClientID %>').checked = hasUpLow;
            document.getElementById('<%= cbSpecial.ClientID %>').checked = hasSpecial;

            if (!hasEightChars && !hasNum && !hasUpLow && !hasSpecial) {
                document.getElementById('<%= btnChange.ClientID %>').enabled = false;
            }
        }

    </script>

</asp:Content>
