<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRewardPoint.aspx.cs" Inherits="Assignment.AdminRewardPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT * FROM [RewardPoint]">
    </asp:SqlDataSource>

    <asp:Repeater ID="RewardPointsRepeater" runat="server" DataSourceID="SqlDataSource1">
        <HeaderTemplate>
            <table class="table1 table-bordered">
                <tr>
                    <td colspan="7" class="header-title" style="background-color: #000000; color: white;"><h1>Reward Points Management</h1></td>
                </tr>

                <tr class="header-section">
                    <th>Reward Point ID</th>
                    <th>User ID</th>
                    <th>Point</th>
                    <th>Create Date</th>
                    <th>Update Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td><%# Eval("RewardPointID") %></td>
                <td><%# Eval("UserID") %></td>
                <td><%# Eval("Points") %></td>
                <td><%# Eval("CreatedAt") %></td>
                <td><%# Eval("UpdatedAt") %></td>
                <td><%# Eval("Status") %></td>
                <td>
                    <asp:Button ID="EditButton" runat="server" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" />
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </ table>
        </FooterTemplate>
    </asp:Repeater>

    <asp:Panel ID="Panel1" runat="server">
        <asp:LinkButton ID="LinkButton1" runat="server">LinkButton</asp:LinkButton>
    </asp:Panel>
</asp:Content>
