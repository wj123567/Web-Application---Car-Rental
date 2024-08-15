<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Redemption.aspx.cs" Inherits="Assignment.Redemption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT [ItemStatus], [RedeemItemId], [ItemPoints], [ItemImage], [ItemDescription] FROM [RedeemItem] WHERE ([ItemStatus] = @ItemStatus)">
        <SelectParameters>
            <asp:Parameter DefaultValue="active" Name="ItemStatus" Type="String"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:Repeater ID="rptRedemption" runat="server">
        <ItemTemplate>
            
        </ItemTemplate>
    </asp:Repeater>
    
</asp:Content>
