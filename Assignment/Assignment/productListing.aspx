<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="productListing.aspx.cs" Inherits="Assignment.productListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">


<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" SelectCommand="SELECT * FROM [Car]"></asp:SqlDataSource>
    <asp:DataList ID="DataList1" runat="server" DataKeyField="CarId" DataSourceID="SqlDataSource1" Width="310px">
        <ItemTemplate>
            CarId:
            <asp:Label ID="CarIdLabel" runat="server" Text='<%# Eval("CarId") %>' />
            <br />
            CarBrand:
            <asp:Label ID="CarBrandLabel" runat="server" Text='<%# Eval("CarBrand") %>' />
            <br />
            CarName:
            <asp:Label ID="CarNameLabel" runat="server" Text='<%# Eval("CarName") %>' />
            <br />
            CType:
            <asp:Label ID="CTypeLabel" runat="server" Text='<%# Eval("CType") %>' />
            <br />
            CarDesc:
            <asp:Label ID="CarDescLabel" runat="server" Text='<%# Eval("CarDesc") %>' />
            <br />
            CarImage:
            <asp:Label ID="CarImageLabel" runat="server" Text='<%# Eval("CarImage") %>' />
            <br />
            CarHourPrice:
            <asp:Label ID="CarHourPriceLabel" runat="server" Text='<%# Eval("CarHourPrice") %>' />
            <br />
<br />
        </ItemTemplate>
    </asp:DataList>
</asp:Content>
