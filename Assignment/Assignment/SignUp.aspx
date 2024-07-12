<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Assignment.SignUp" %>

<asp:Content ID="userReg" ContentPlaceHolderID="main" runat="server">
        <h1>Log In</h1>
        <div>Email:

            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
            <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please Enter a valid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            <br />
            Password:
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            <asp:Label ID="labelValidUser" runat="server" Text="Label" Visible="False"></asp:Label>
            <br />
            <asp:Button ID="btnLogIn" runat="server" Text="Log In"/>
        </div>
</asp:Content>
