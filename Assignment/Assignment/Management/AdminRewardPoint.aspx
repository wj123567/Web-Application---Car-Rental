<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRewardPoint.aspx.cs" Inherits="Assignment.AdminRewardPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/AdminRewardpoint.css" rel="stylesheet" />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT ApplicationUser.Username, Booking.Price, Booking.EarnDate, Booking.PointsRemaining, Booking.PointsStatus FROM ApplicationUser INNER JOIN Booking ON ApplicationUser.Id = Booking.UserId"></asp:SqlDataSource>

    <div class="RewardPointContainer container-xl px-4 mt-4">
        <div class="title">
                <h1>Reward Points Management</h1>
            </div>
        <div class="Add">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop">
              Add
            </button>
        </div>
        <asp:ListView ID="RewardPointsListView" runat="server" DataSourceID="SqlDataSource1">
            <LayoutTemplate>
                <table class="table table-bordered tableReward table-striped">
                    <thead>
                        <tr class="header-section">
                            <th>
                                Username
                            </th>
                            <th>
                                EarnedPoints</th>
                            <th>
                                Remaining Points</th>
                            <th>
                                Earned Date</th>
                            <th>
                                Expiry Date</th>
                            <th>
                                Status</th>
                            <th>Actions</th>
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

            </asp:ListView>
        <div>

        </div>
    </div>
    
</asp:Content>
