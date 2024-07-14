<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="validateEmail.aspx.cs" Inherits="Assignment.validateEmail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
        <div id="loginForm">
            <div id="verifyInputGroup" class="inputGroup">
            <h1 class="verifyHead">Verify Email</h1>
            <asp:TextBox ID="txtVerifyEmail" runat="server" CssClass="inputField" placeholder="Email" ReadOnly="True"></asp:TextBox>
             <asp:TextBox ID="txtNewVerify" runat="server" CssClass="inputField" placeholder="Verification Code"></asp:TextBox>
            <asp:Label ID="labelNewSend" runat="server" Text="Verification Code Has Been Sent" Visible="False"></asp:Label>
            <asp:Button ID="sendNewCode" runat="server" CssClass="btnUser"  Text="Send" />
            <asp:Button ID="btnNewVerify" runat="server" Text="Verify" CssClass="btnUser"/>
            </div>
        </div>
</asp:Content>
