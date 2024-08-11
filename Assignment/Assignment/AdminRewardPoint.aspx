<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRewardPoint.aspx.cs" Inherits="Assignment.AdminRewardPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT * FROM [RewardPoint]"></asp:SqlDataSource>

</asp:Content>
