<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Redemption.aspx.cs" Inherits="Assignment.Redemption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    
    <script type="text/javascript">
        function showText(labelID) {
            var label = document.getElementById(labelID);
            if (label) {
                var text = label.innerText || label.textContent;
                alert(text);
            }
        }
    </script>

    <ul class="list-group">
        <li class="list-group-item">An item</li>
        <li class="list-group-item">A second item</li>
        <li class="list-group-item">A third item</li>
        <li class="list-group-item">A fourth item</li>
        <li class="list-group-item">And a fifth one</li>
    </ul>
    <asp:Label ID="Label1" runat="server" Text="Hover over me" ClientIDMode="Static">Hello</asp:Label>
    
</asp:Content>
