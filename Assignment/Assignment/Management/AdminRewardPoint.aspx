<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRewardPoint.aspx.cs" Inherits="Assignment.AdminRewardPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">


    <div class="RewardPointContainer container-xl px-4 mt-4">
        <div class="title">
                <h1>Reward Points Management</h1>
            </div>
        <div class="Add">

        </div>

        <asp:ListView ID="RewardPointsListView" runat="server">
            <LayoutTemplate>
                <table class="table table-bordered tableReward table-striped">
                    <thead>
                        <tr class="header-section">
                            <th>Username</th>
                            <th>Email</th>
                            <th>Reward Points</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
        
                    <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />

                        <tr>
                            <td colspan="7" class="asd">
                                <asp:DataPager ID="RewardPointsPager" runat="server" PageSize="6">
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
                    
                </ItemTemplate>

            </asp:ListView>
        <div>

        </div>
    </div>
    
</asp:Content>
