<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="RewardPoint.aspx.cs" Inherits="Assignment.RewardPoint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div style="width: 80%; margin: 20px auto;">
        <div class="fs-5 text-center" style="font: 60px black; padding-top:55px;">
            <h1>Welcome to,</h1>
            <p style="font-size: 55px; margin-bottom: -10px;">Reward Point</p>

        </div>

        <div style="text-align: right;"><a href="#" class="fs-4" style="padding-right:60px;">Point History</a></div>
        
        <div>
            <table style="margin: 20px auto" class="user-reward-info">
                <tr>
                    <td style="padding: 0px 30px; width:1200px;">Hi, <asp:Label ID="Label1" runat="server" Text="[Username]"></asp:Label></td>
                </tr>
                <tr>
                    <td style="font-size: 20px">Expired Date: <asp:Label ID="Label3" runat="server" Text="[Date expire point]"></asp:Label></td>
                </tr>
                <tr>
                    <td>OnlyCars Rewards</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="[Points]"> Points</asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <br />
        <div style="padding-left: 209px"><asp:Button ID="btnUserRegister" runat="server" Text="UserRegister" Width="150px" Height="60px" CssClass="btnUserRegister" OnClick="btnUserRegister_Click" />
            <asp:Button ID="Button1" runat="server" Text="Button" />
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" SelectCommand="SELECT * FROM [RewardPoint]"></asp:SqlDataSource>
    </div>
    
</asp:Content>
