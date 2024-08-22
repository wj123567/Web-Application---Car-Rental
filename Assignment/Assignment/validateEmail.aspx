<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="validateEmail.aspx.cs" Inherits="Assignment.validateEmail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="CSS/SignUp.css" rel="stylesheet" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <asp:Timer ID="verifyTimer" runat="server" Interval="1000" OnTick="verifyTimer_Tick"></asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>


    <asp:HiddenField ID="hdnRoles" runat="server" />
        <div id="loginForm">
            <div id="verifyInputGroup" class="inputGroup">
            <h1 class="verifyHead">Verify Email</h1>
            <asp:TextBox ID="txtVerifyEmail" runat="server" CssClass="inputField" placeholder="Email" ReadOnly="True" ValidationGroup="checkOtp"></asp:TextBox>
             <asp:TextBox ID="txtNewVerify" runat="server" CssClass="inputField" placeholder="Verification Code" ValidationGroup="checkOtp"></asp:TextBox>
             <asp:RequiredFieldValidator ID="reqOtp" runat="server" ErrorMessage="Otp is Require" ValidationGroup="checkOtp" CssClass="validate" Display="Dynamic" ControlToValidate="txtNewVerify"></asp:RequiredFieldValidator>
             <asp:CustomValidator ID="validateVerificationCode" runat="server" ErrorMessage="The Verification Code is Incorrect" OnServerValidate="validateVerificationCode_ServerValidate" ValidationGroup="checkOtp" CssClass="validate" ControlToValidate="txtNewVerify" Display="Dynamic"></asp:CustomValidator>
                <br />
            <asp:Label ID="labelValidateSend" runat="server" Text="Verification Code Has Been Sent" Visible="False" CssClass="validate"></asp:Label>
            <asp:Button ID="sendNewCode" runat="server" CssClass="btnUser mx-auto"  Text="Send" OnClick="sendNewCode_Click" ValidationGroup="SendOtp" />
            <asp:Button ID="btnNewVerify" runat="server" Text="Verify" CssClass="btnUser mx-auto" ValidationGroup="checkOtp" OnClick="btnNewVerify_Click" />
            <asp:Label ID="lblSucValidate" runat="server" Text="" CssClass="validate"></asp:Label>
            </div>
        </div>

    <script>

        function startCountdown(seconds) {
            var countdown = seconds;
            var button = document.getElementById('<%= sendNewCode.ClientID %>');
            button.classList.add('disable-resend');

            if (countdown > 0) {
                button.value = "Resend in " + countdown;
                button2.value = "Resend in " + countdown;
            } else {
                button.classList.remove('disable-resend');
                button.disabled = false;
                button.value = "Send";
            }
    }

        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>
</asp:Content>
