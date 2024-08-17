<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="testModel.aspx.cs" Inherits="Assignment.Management.testModel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ListView ID="lstAU" runat="server">
        <ItemTemplate>
            <div>
                <p><%# Eval("Username") %></p>
                <p><%# Eval("RewardPoints") %></p>
                <p><%# Eval("Price") %></p>
            </div>
        </ItemTemplate>
    </asp:ListView>
</asp:Content>
