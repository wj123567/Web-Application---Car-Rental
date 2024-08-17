<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="testModel.aspx.cs" Inherits="Assignment.Management.testModel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ListView ID="lstAU" runat="server">
        <LayoutTemplate>
            <table class="table tableReward table-striped">
                <thead>
                    <tr>
                        <td colspan="4" class="header-title table-dark"><h1>Reward Points Management</h1></td>
                        <tr class="header-section">
                            <th>Username</th>
                            <th>Price</th>
                            <th>Remaining Points</th>
                            <th>Actions</th>
                        </tr>
                    </tr>
                </thead>
        
                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />

                <tr>
                    <td colspan="4" class="asd">
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
            <tr class="rp-record">
                <td><%# Eval("Username") %></td>
                <td><%# Eval("Price") %></td>
                <td><%# Eval("PointsRemaining") %></td>
                <td>
                    <asp:Button ID="EditButton" runat="server" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" />
                </td>
            </tr>
        </ItemTemplate>
    </asp:ListView>
</asp:Content>
