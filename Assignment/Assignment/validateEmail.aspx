<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="validateEmail.aspx.cs" Inherits="Assignment.validateEmail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
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

        let timer;
        let countdown = 60; // Set the countdown duration in seconds

        function startResendTimer() {
            addEventListener("DOMContentLoaded", (event) => {
                // Disable the button during the countdown
                document.getElementById('<%= sendNewCode.ClientID %>').disabled = true;

                // Start the countdown
                timer = setInterval(updateTimer, 1000); s
            });
        }

        function updateTimer() {
            var resendBtn = document.getElementById('<%= sendNewCode.ClientID %>')
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
