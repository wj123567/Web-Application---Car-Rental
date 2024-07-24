<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="resetPassword.aspx.cs" Inherits="Assignment.resetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
         <div id="loginForm">
            <div id="resetInputGroup" class="inputGroup">
            <h1 class="verifyHead">Reset Password</h1>
            <asp:TextBox ID="txtRegPassword" runat="server" TextMode="Password" CssClass="inputField" placeholder="Password" onkeyup="validatePassword()" ValidationGroup="SignUpGroup"></asp:TextBox>
                     <asp:CustomValidator ID="validNewPassword" runat="server" ErrorMessage="New Password Cannot be same as Old Password" CssClass="validate" ControlToValidate="txtRegPassword" ValidationGroup="SignUpGroup" OnServerValidate="validNewPassword_ServerValidate"></asp:CustomValidator>
                <br />

                        <asp:CheckBox ID="cbEight" runat="server" Text="must contain at least eight characters" Enabled="True" Checked="False" CssClass="passCheckBox" ValidationGroup="SignUpGroup" />
            <br />
                        <asp:CheckBox ID="cbNum" runat="server" Text="at least one number" Enabled="True" CssClass="passCheckBox" ValidationGroup="SignUpGroup" />
            <br />
                        <asp:CheckBox ID="cbUpLow" runat="server" Text="both lower and uppercase letters" Enabled="True" CssClass="passCheckBox" />
            <br />
                         <asp:CheckBox ID="cbSpecial" runat="server" Text="must contain one special characters" Enabled="True" CssClass="passCheckBox" ValidationGroup="SignUpGroup" />
            <asp:RequiredFieldValidator ID="reqRegPass" runat="server" ErrorMessage="RequiredFieldValidator" ValidationGroup="SignUpGroup" ControlToValidate="txtRegPassword" hidden="true"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regRegPass" runat="server" ErrorMessage="RegularExpressionValidator" ControlToValidate="txtRegPassword" ValidationGroup="SignUpGroup" ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&amp;*()_+\-=\[\]{};':&quot;\\|,.&lt;&gt;\/?]).{8,}$" hidden="true"></asp:RegularExpressionValidator>

            <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="inputField" placeholder="Confirm Password" ValidationGroup="SignUpGroup"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqConfirmPass" runat="server" ErrorMessage="RequiredFieldValidator" ControlToValidate="txtConfirmPass" ValidationGroup="SignUpGroup" hidden="true"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="validPassword" runat="server" ErrorMessage="Both Password Must be Same" ControlToCompare="txtRegPassword" ControlToValidate="txtConfirmPass" CssClass="validate" ValidationGroup="SignUpGroup"></asp:CompareValidator>
            <br />
            <input id="cbShowPass" type="checkbox" onClick="showPass()"/>
            <span>Show Password</span>

            <asp:Button ID="btnSignup" runat="server" Text="Reset" CssClass="btnUser mx-auto" ValidationGroup="SignUpGroup" OnClick="btnSignup_Click"/>

            <asp:Label ID="lblSucReset" runat="server" Text="" CssClass="validate"></asp:Label>
          </div>
       </div>

    <script>
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };

        function validatePassword() {
            var password = document.getElementById('<%= txtRegPassword.ClientID %>').value;
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
                        document.getElementById('<%= btnSignup.ClientID %>').enabled = false;
                    }
        }

        function showPass() {
            var password1 = document.getElementById('<%= txtRegPassword.ClientID %>');
            var password2 = document.getElementById('<%= txtConfirmPass.ClientID %>');
            var checkBox = document.getElementById('cbShowPass');

                    if (checkBox.checked) {
                        password1.type = 'text';
                        password2.type = 'text';
                    } else {
                        password1.type = 'password';
                        password2.type = 'password';
                    }
                }
    </script>
</asp:Content>
