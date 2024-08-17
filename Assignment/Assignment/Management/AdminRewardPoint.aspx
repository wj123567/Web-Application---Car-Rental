<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRewardPoint.aspx.cs" Inherits="Assignment.AdminRewardPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/AdminRewardpoint.css" rel="stylesheet" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT ApplicationUser.Username, Booking.Price, Booking.EarnDate, Booking.PointsRemaining, Booking.PointsStatus FROM ApplicationUser INNER JOIN Booking ON ApplicationUser.Id = Booking.UserId"></asp:SqlDataSource>

    <asp:ListView ID="RewardPointsListView" runat="server" DataSourceID="SqlDataSource1">
        <LayoutTemplate>
            <table class="table tableReward table-striped">
                <thead>
                    <tr>
                        <td colspan="7" class="header-title table-dark"><h1>Reward Points Management</h1></td>
                        <tr class="header-section">
                            <th>Username</th>
                            <th>EarnedPoints</th>
                            <th>Remaining Points</th>
                            <th>Earned Date</th>
                            <th>Expiry Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </tr>
                </thead>
                
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
            <tr class="rp-record">
                <td><%# Eval("Username") %></td>
                <td><%# Eval("Price") %></td>
                <td><%# Eval("PointsRemaining") %></td>
                <td><%# Eval("EarnDate") %></td>
                <td>
                    <asp:Label ID="lblExpiryDate" runat="server" Text='<%# Eval("EarnDate") != DBNull.Value ? ((DateTime)Eval("EarnDate")).AddYears(1).ToString() : "N/A" %>'></asp:Label>
                </td>
                <td><%# Eval("PointsStatus") %></td>
                <td>
                    <asp:Button ID="EditButton" runat="server" Text="Edit" />
                    <asp:Button ID="DeleteButton" runat="server" Text="Delete" />
                </td>
            </tr>
        </ItemTemplate>

        <EmptyDataTemplate>
            <table class="table tableReward">
                <tr>
                <td colspan="7" class="header-title table-dark"><h1>Reward Points Management</h1></td>
            </tr>

            <tr>                                                                
                <td colspan="7" style="font: 50px black;">No Data Available
                    <span style="float: right; text-align:center;"><asp:Button ID="btnInsert" runat="server" Text="Create" CssClass="btn btn-warning" style="width:100px; margin-bottom:10px;"/></span>
                </td>
            </tr>
        </EmptyDataTemplate>
    </asp:ListView>
</asp:Content>
