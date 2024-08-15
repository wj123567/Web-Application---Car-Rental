<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Assignment.SignUp" %>
<asp:Content ID="userReg" ContentPlaceHolderID="main" runat="server">
    <link href="CSS/SignUp.css" rel="stylesheet" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="loginForm">
        <div id="switchForm" class="btn-group d-flex justify-content-center">
            <div id="switchIndicator"> </div>
            <input id="switchLogin" class="switchBtn btn" type="button" value="Login" onclick="logIn()"/>
            <input id="switchSignup" class="switchBtn btn" type="button" value="Sign Up" onclick="signUp()"/>
        </div>

        <div id="loginInputGroup" class="inputGroup">
            <asp:UpdatePanel ID="updateLogin" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="inputField" placeholder="Email" ValidationGroup="LoginGroup"></asp:TextBox>
             <asp:RequiredFieldValidator ID="requireEmail" runat="server" ErrorMessage="Email is Required" Display="Dynamic" CssClass="validate" ControlToValidate="txtEmail" ValidationGroup="LoginGroup"></asp:RequiredFieldValidator>
             <asp:RegularExpressionValidator ID="regexEmail" runat="server" ErrorMessage="Invalid Email" CssClass="validate" ValidationGroup="LoginGroup" ControlToValidate="txtEmail" Display="Dynamic" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
             <asp:CustomValidator ID="emailNotExist" runat="server" ErrorMessage="Email Not Exist" CssClass="validate" OnServerValidate="emailNotExist_ServerValidate" Display="Dynamic" ValidationGroup="LoginGroup" ControlToValidate="txtEmail" ValidateEmptyText="False"></asp:CustomValidator>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="inputField" placeholder="Password" ValidationGroup="LoginGroup" onkeypress="triggerLoginButtonClick(event)"></asp:TextBox>
            <asp:Label ID="labelValidUser" runat="server" Text="Label" Visible="False" CssClass="validate"></asp:Label>
            <br />
            <input id="cbShowPass" type="checkbox" onClick="showPass()"/>
            <span>Show Password</span>
            <br />

            <asp:Button ID="btnLogIn" runat="server" Text="Log In" CssClass="btnUser mx-auto" ValidationGroup="LoginGroup" OnClick="btnLogIn_Click" />
            <asp:Button ID="btnForget" runat="server" Text="Forget Password?" CssClass="forgetPass" OnClick="btnForget_Click" ValidationGroup="LoginGroup"/>
        </div>
                </ContentTemplate>
            </asp:UpdatePanel>

        <div id="signupInputGroup" class="inputGroup">
            <asp:UpdatePanel ID="updateRegEmail" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
                <ContentTemplate>
             <asp:TextBox ID="txtUname" runat="server" CssClass="inputField" placeholder="Username" ValidationGroup="SignUpGroup"></asp:TextBox>
             <asp:RequiredFieldValidator ID="validUname" runat="server" ErrorMessage="Username cannot be empty" ControlToValidate="txtUname" CssClass="validate" ValidationGroup="SignUpGroup"></asp:RequiredFieldValidator>
            <asp:TextBox ID="txtRegEmail" runat="server" CssClass="inputField" placeholder="Email" ValidationGroup="SignUpGroup"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqRegEmail" runat="server" ErrorMessage="Email is required" ControlToValidate="txtRegEmail" CssClass="validate" ValidationGroup="SignUpGroup" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="regRegEmail" runat="server" ControlToValidate="txtRegEmail" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="validate" ValidationGroup="SignUpGroup" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:CustomValidator ID="emailExist" runat="server" ErrorMessage="Email Already Exist" ControlToValidate="txtRegEmail" CssClass="validate" OnServerValidate="emailExist_ServerValidate" Display="Dynamic" ValidationGroup="SignUpGroup"></asp:CustomValidator>
            <asp:TextBox ID="txtRegPassword" runat="server" TextMode="Password" CssClass="inputField" placeholder="Password" onkeyup="validatePassword()" ValidationGroup="SignUpGroup"></asp:TextBox>
                        <asp:CheckBox ID="cbEight" runat="server" Text="at least eight characters" Enabled="True" Checked="False" CssClass="passCheckBox" ValidationGroup="SignUpGroup" />
            <br />
                        <asp:CheckBox ID="cbNum" runat="server" Text="at least one number" Enabled="True" CssClass="passCheckBox" ValidationGroup="SignUpGroup" />
            <br />
                        <asp:CheckBox ID="cbUpLow" runat="server" Text="both lower and uppercase letters" Enabled="True" CssClass="passCheckBox" />
            <br />
                         <asp:CheckBox ID="cbSpecial" runat="server" Text="must contain one special characters" Enabled="True" CssClass="passCheckBox" ValidationGroup="SignUpGroup" />
           <asp:CustomValidator ID="validatePassword" runat="server" ControlToValidate="txtRegPassword" ErrorMessage="Invalid Password" ValidationGroup="SignUpGroup" CssClass="validate" ClientValidationFunction="validatePassword" ValidateEmptyText="True" Visible="False"></asp:CustomValidator>

            <asp:TextBox ID="txtConfirmPass" runat="server" TextMode="Password" CssClass="inputField" placeholder="Confirm Password" ValidationGroup="SignUpGroup"></asp:TextBox>
            <asp:RequiredFieldValidator ID="reqConfirmPass" runat="server" ErrorMessage="Confirm Password is Required" ControlToValidate="txtConfirmPass" ValidationGroup="SignUpGroup" Display="Dynamic" CssClass="validate"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="validPassword" runat="server" ErrorMessage="Both Password Must be Same" ControlToCompare="txtRegPassword" ControlToValidate="txtConfirmPass" CssClass="validate" ValidationGroup="SignUpGroup" Display="Dynamic"></asp:CompareValidator>
            <br />
            <p class="label">Date of Birth:</p>
            <asp:TextBox ID="txtRegDOB" runat="server" TextMode="Date" ValidationGroup="SignUpGroup"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator runat="server" ErrorMessage="Date of Birth cannot be empty" ID="validDOB" ControlToValidate="txtRegDOB" CssClass="validate" ValidationGroup="SignUpGroup"></asp:RequiredFieldValidator>
            <br />
            <input id="cbShowRegPass" type="checkbox" onClick="showRegPass()"/>
            <span>Show Password</span>
            <asp:Button ID="btnSignup" runat="server" Text="Sign Up" CssClass="btnUser mx-auto" ValidationGroup="SignUpGroup" OnClick="btnSignup_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>


    </div>
        </div>

    <script>
        var login = document.getElementById("loginInputGroup")
        var signup = document.getElementById("signupInputGroup")
        var switches = document.getElementById("switchIndicator")
        var loginform = document.getElementById("loginForm")
        var switchForm = document.getElementById("switchForm")

        function triggerLoginButtonClick(event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                document.getElementById('<%= btnLogIn.ClientID %>').click();
                }
            }

        function signUp() {
            signup.style.left = "55px";
            login.style.left = "-500px";
            switches.style.left = "110px";
            loginform.style.height = "700px";
        }

        function logIn() {
            signup.style.left = "500px";
            login.style.left = "55px";
            switches.style.left = "0";
            loginform.style.height = "480px";
        }

        function showPass() {
            var password = document.getElementById('<%= txtPassword.ClientID %>');
            var checkBox = document.getElementById('cbShowPass');

            if (checkBox.checked) {
                password.type = 'text';
            } else {
                password.type = 'password';
            }
        }

        function showRegPass() {
            var password1 = document.getElementById('<%= txtRegPassword.ClientID %>');
            var password2 = document.getElementById('<%= txtConfirmPass.ClientID %>');
            var checkBox = document.getElementById('cbShowRegPass');

                    if (checkBox.checked) {
                        password1.type = 'text';
                        password2.type = 'text';
                    } else {
                        password1.type = 'password';
                        password2.type = 'password';
                    }
                }

        function validatePassword(sender, args) {
            var password = document.getElementById('<%= txtRegPassword.ClientID %>').value;
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


    </script>

</asp:Content>
