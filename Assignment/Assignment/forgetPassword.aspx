<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="forgetPassword.aspx.cs" Inherits="Assignment.forgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="CSS/SignUp.css" rel="stylesheet" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
        <asp:Timer ID="verifyTimer" runat="server" Interval="1000" OnTick="verifyTimer_Tick"></asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>

     <div id="loginForm">
            <div id="forgetInputGroup" class="inputGroup">
            <h1 class="verifyHead">Forget Password</h1>
            <asp:TextBox ID="txtForgetEmail" runat="server" CssClass="inputField" placeholder="Email" ReadOnly="True"></asp:TextBox>
             <asp:TextBox ID="txtforgetVerify" runat="server" CssClass="inputField" placeholder="Verification Code"></asp:TextBox>
                <asp:RequiredFieldValidator ID="reqOtp" runat="server" ErrorMessage="Otp is Require" ValidationGroup="checkOtp" CssClass="validate" Display="Dynamic" ControlToValidate="txtforgetVerify"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="validateVerificationCode" runat="server" ErrorMessage="The Verification Code is Incorrect" OnServerValidate="validateVerificationCode_ServerValidate" ValidationGroup="checkOtp" CssClass="validate" Display="Dynamic"></asp:CustomValidator>
                <br />
            <asp:Label ID="labelForgetSend" runat="server" Text="Verification Code Has Been Sent" Visible="False" CssClass="validate"></asp:Label>
            <asp:Button ID="sendForgetCode" runat="server" CssClass="btnUser mx-auto"  Text="Send" OnClick="sendForgetCode_Click" ValidationGroup="sendOtp" />

            <asp:Button ID="btnForgetVerify" runat="server" Text="Verify" CssClass="btnUser mx-auto" OnClick="btnForgetVerify_Click" ValidationGroup="checkOtp"/>
        </div>

       </div>

    <script>

        function startCountdown(seconds) {
            var countdown = seconds;
            var button = document.getElementById('<%= sendForgetCode.ClientID %>');
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
