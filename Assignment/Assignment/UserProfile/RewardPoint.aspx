﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="RewardPoint.aspx.cs" Inherits="Assignment.RewardPoint" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="rp-info" style="width: 80%; margin: 20px auto;">
        <div class="fs-5 text-center">
            <h1 style="padding-top: 30px">Welcome to, <br />
                <span style="font-size: 60px;">Reward Point</span>
            </h1>
        </div>

        <div style="text-align: right;"><a href="#" class="fs-5 " style="padding-right:60px;">Point History</a></div>
        
        <div>
            <table style="margin: 20px auto; width:1200px" class="user-reward-info">
                <tr>
                    <td>
                        Hi, <asp:Label ID="Label1" runat="server" Text="[Username]" Font-Size="Larger"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>Expired Date: <asp:Label ID="Label3" runat="server" Text="[Date expire point]"></asp:Label></td>
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
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" SelectCommand="SELECT * FROM [RewardPoint]"></asp:SqlDataSource>
    </div>
    
</asp:Content>
