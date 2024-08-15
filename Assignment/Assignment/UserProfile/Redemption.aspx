<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Redemption.aspx.cs" Inherits="Assignment.Redemption" %>

<asp:Content ID="Redemption" ContentPlaceHolderID="main" runat="server">
    <div class="redemption-container">
        <div class="redemption-container-header">
            <h2>Redeem What You Like?</h2>
        </div>

        <div class="redemption-container-body">
            <asp:ListView ID="ListView1" runat="server"></asp:ListView>
        </div>
    </div>
    
</asp:Content>
