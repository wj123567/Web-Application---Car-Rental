<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="forgetPassword.aspx.cs" Inherits="Assignment.forgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

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

        let timer;
        let countdown = 60; // Set the countdown duration in seconds

        function startResendTimer() {
            addEventListener("DOMContentLoaded", (event) => {
            // Disable the button during the countdown
            document.getElementById('<%= sendForgetCode.ClientID %>').disabled = true;

            // Start the countdown
                timer = setInterval(updateTimer, 1000);s
            });
        }

        function updateTimer() {            
            var resendBtn = document.getElementById('<%= sendForgetCode.ClientID %>')
            resendBtn.classList.add('disable-resend');

            if (countdown > 0) {
                resendBtn.value = `Resend in ${countdown} seconds`;
                countdown--;
            } else {
                // Enable the button when the countdown reaches zero
                resendBtn.disabled = false;
                resendBtn.classList.remove('disable-resend');
                resendBtn.value = 'Send';

                // Reset countdown for the next attempt
                countdown = 60;

                // Stop the timer
                clearInterval(timer);
            }
        }

        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>
</asp:Content>
