<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRewardPoint.aspx.cs" Inherits="Assignment.AdminRewardPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' 
        SelectCommand="SELECT * FROM [RewardPoint]">
    </asp:SqlDataSource>

    <asp:ListView ID="RewardPointsListView" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="RewardPointID">
        <LayoutTemplate>
            <table class="tableReward">
                <tr>
                    <td colspan="7" class="header-title table-dark"><h1>Reward Points Management</h1></td>
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

                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />

                <tr>
                    <td colspan="7" class="asd">
                        <asp:DataPager ID="RewardPointsPager" runat="server" PageSize="5">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Link" ShowPreviousPageButton="true" ShowNextPageButton="false"/>
                                <asp:NumericPagerField ButtonType="Link" />
                                <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowPreviousPageButton="false"/>
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>

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

        <EmptyDataTemplate>
            <table class="table">
                <tr>
                <td colspan="7" class="header-title table-dark"><h1>Reward Points Management</h1></td>
            </tr>

            <tr>                                                                
                <td colspan="7" style="font: 50px black;">No Data Available
                    <span style="float: right; text-align:center;"><asp:Button ID="btnInsert" runat="server" Text="Create" CssClass="btn btn-warning" style="width:100px; margin-bottom:10px;" OnClick="btnInsert_Click" ViewStateMode="Inherit" /></span>
                </td>
            </tr>
        </EmptyDataTemplate>
    </asp:ListView>
</asp:Content>
