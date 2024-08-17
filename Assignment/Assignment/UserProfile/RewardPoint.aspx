<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="RewardPoint.aspx.cs" Inherits="Assignment.RewardPoint" %>
<asp:Content ID="rewardPoint" ContentPlaceHolderID="main" runat="server">
    <%--<div style="min-height: 50px; overflow:auto; width:100%"></div>--%>
    <div class="RP d-flex flex-wrap">
        <div class="RP-left" style="flex:1;">
            <div class="RPHeader">
                <h2>Welcome to 
                <br /><span class="RPHeader-1">Reward Point</span>
                </h2>
            </div>
            <div class="RPHeader-Bottom" style="flex: 1;">
                <p>
                    Hi, 
                    
                <asp:Label ID="lblUsername" runat="server" Text="[Username]"></asp:Label>
                </p>

                <p class="ex-1">
                    <asp:Label ID="lblExpiryPoints" runat="server" Text="[Points]" CssClass="ex-2"></asp:Label> Points will be expired at <asp:Label ID="lblExpiryDate" runat="server" Text="[Expriy Date]" CssClass="ex-3"></asp:Label>
                </p>

                <p>
                    <asp:Label ID="lblTotalPoints" runat="server" Text="[Total Points]"></asp:Label>
                </p>

                <asp:Button ID="btnRedeem" runat="server" Text="Redeem" CssClass="btn btn-success" OnClick="btnRedeem_Click"/>
            </div>
        </div>

        <div class="RP-right";>
            <div class="right-upperside">
                <a href="#">Points History</a>
            </div>
            <div class="right-lowerside-1">
                <div class="right-lowerside-2">
                    <img src="../Image/RewardPoint/bg-5.png" class="RPImage" />
                </div>
            </div>
           
        </div>
    </div>

</asp:Content>
