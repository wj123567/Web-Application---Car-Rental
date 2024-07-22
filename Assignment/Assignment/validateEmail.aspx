<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="validateEmail.aspx.cs" Inherits="Assignment.validateEmail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
        <div id="loginForm">
            <div id="verifyInputGroup" class="inputGroup">
            <h1 class="verifyHead">Verify Email</h1>
            <asp:TextBox ID="txtVerifyEmail" runat="server" CssClass="inputField" placeholder="Email" ReadOnly="True" ValidationGroup="checkOtp"></asp:TextBox>
             <asp:TextBox ID="txtNewVerify" runat="server" CssClass="inputField" placeholder="Verification Code" ValidationGroup="checkOtp"></asp:TextBox>
             <asp:CustomValidator ID="validateVerificationCode" runat="server" ErrorMessage="The Verification Code is Incorrect" OnServerValidate="validateVerificationCode_ServerValidate" ValidationGroup="checkOtp" CssClass="validate" ControlToValidate="txtNewVerify"></asp:CustomValidator>
                <br />
            <asp:Label ID="labelValidateSend" runat="server" Text="Verification Code Has Been Sent" Visible="False" CssClass="validate"></asp:Label>
            <asp:Button ID="sendNewCode" runat="server" CssClass="btnUser mx-auto"  Text="Send" OnClick="sendNewCode_Click" ValidationGroup="SendOtp" />
            <asp:Button ID="btnNewVerify" runat="server" Text="Verify" CssClass="btnUser mx-auto" ValidationGroup="checkOtp" OnClick="btnNewVerify_Click" />
            <asp:Label ID="lblSucValidate" runat="server" Text="" CssClass="validate"></asp:Label>
            </div>
        </div>

    <script>
        history.pushState(null, null, location.href);
        window.onpopstate = function () {
            history.go(1);
        };
    </script>
</asp:Content>
