<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="ErrorPage.aspx.cs" Inherits="Assignment.ErrorPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="CSS/errorPage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <div class="container-fluid mt-5">
        <div class="text-center">
            <asp:Label ID="lblError" runat="server" Text="404" CssClass="errorText mx-auto" data-error-msg="404"></asp:Label>
            <asp:Label ID="lblErrorMsg" runat="server" Text="Page Not Found" CssClass="lead text-gray-800 mb-3 d-block"></asp:Label>
            <p class="text-gray-500 mb-2">Oop somethings gone wrong ...</p>
            <a href="Home.aspx">&larr; Back to Home</a>
        </div>

    </div>
</asp:Content>
