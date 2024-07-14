<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="forgetPassword.aspx.cs" Inherits="Assignment.forgetPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

     <div id="loginForm">
            <div id="forgetInputGroup" class="inputGroup">
            <h1 class="verifyHead">Forget Password</h1>
            <asp:TextBox ID="txtForgetEmail" runat="server" CssClass="inputField" placeholder="Email" ReadOnly="True"></asp:TextBox>
             <asp:TextBox ID="txtforgetVerify" runat="server" CssClass="inputField" placeholder="Verification Code"></asp:TextBox>
            <asp:Label ID="labelForgetSend" runat="server" Text="Verification Code Has Been Sent" Visible="False"></asp:Label>
            <asp:Button ID="sendForgetCode" runat="server" CssClass="btnUser"  Text="Send" />

            <asp:Button ID="btnForgetVerify" runat="server" Text="Verify" CssClass="btnUser"/>
        </div>

       </div>
</asp:Content>
