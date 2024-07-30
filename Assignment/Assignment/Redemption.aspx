<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Redemption.aspx.cs" Inherits="Assignment.Redemption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    
    <script type="text/javascript">
        
    </script>

    <div class="BG">
        <div class="Top">
            <h1 style="font-size: 42px; font-family: serif; color: black; font-weight: bolder;">Welcome to,</h1>
        </div>
        <div class="Middle">
            <h2 style="font-family: Arial, sans-serif; font-size: 36px; color: #002ED1;  font-weight: bolder; margin-bottom: -5px;">Reward Points</h2>
            <p style="font-size: 18px;">[User#000001] expired at [date]</p>
            <asp:Literal ID="Literal1" runat="server">1000 pts</asp:Literal>
        </div>
    </div>
    
</asp:Content>
