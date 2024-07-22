<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="forgetPassword.aspx.cs" Inherits="Assignment.forgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

     <div id="loginForm">
            <div id="forgetInputGroup" class="inputGroup">
            <h1 class="verifyHead">Forget Password</h1>
            <asp:TextBox ID="txtForgetEmail" runat="server" CssClass="inputField" placeholder="Email" ReadOnly="True"></asp:TextBox>
             <asp:TextBox ID="txtforgetVerify" runat="server" CssClass="inputField" placeholder="Verification Code"></asp:TextBox>
                <asp:CustomValidator ID="validateVerificationCode" runat="server" ErrorMessage="The Verification Code is Incorrect" OnServerValidate="validateVerificationCode_ServerValidate" ValidationGroup="checkOtp" CssClass="validate"></asp:CustomValidator>
            <asp:Label ID="labelForgetSend" runat="server" Text="Verification Code Has Been Sent" Visible="False" CssClass="validate"></asp:Label>
            <asp:Button ID="sendForgetCode" runat="server" CssClass="btnUser mx-auto"  Text="Send" OnClick="sendForgetCode_Click" ValidationGroup="sendOtp" />

            <asp:Button ID="btnForgetVerify" runat="server" Text="Verify" CssClass="btnUser mx-auto" OnClick="btnForgetVerify_Click" ValidationGroup="checkOtp"/>
        </div>

       </div>

    <script>
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>
</asp:Content>
