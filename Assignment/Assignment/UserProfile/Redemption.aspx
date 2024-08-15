<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Redemption.aspx.cs" Inherits="Assignment.Redemption" %>
<asp:Content ID="RedemptionHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"   
 crossorigin="anonymous">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js"   
 integrity="sha384-ogbw9D3nTbior7kPJkRoyDqiy58zaSyEyXuVxPoVgwmTJMKEu1exv0j4ovwIwEM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</asp:Content>

<asp:Content ID="Redemption" ContentPlaceHolderID="main" runat="server">
    <%-- connect sql data source --%>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT ItemName, ItemPoints, ItemDescription, ItemImage FROM RedeemItem WHERE (Status = @Status)">
        <SelectParameters>
            <asp:Parameter DefaultValue="active" Name="Status" Type="String"></asp:Parameter>
        </SelectParameters>
    </asp:SqlDataSource>

    <div class="redemption-container">
        <div class="redemption-container-header">
            <h2>Redeem What You Like?</h2>
        </div>

        <div class="redemption-container-body">
            <asp:ListView ID="lvredeemitems" runat="server">
                <%-- layouttemplate is the overall layout wraps the ItemTemplate  --%>
                <LayoutTemplate>
                    <ul>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server">
                    </asp:PlaceHolder>
                    </ul>
                    
                </LayoutTemplate>

                <%-- ItemTemplate defines how each item should look --%>
                <ItemTemplate>
                    <li>
                        <div style="border: 1px solid #ccc; padding: 10px; margin-bottom: 10px;">
                            <img src='<%# Eval("ItemImage") %>' alt='<%# Eval("ItemName") %>' style="width: 100px; height: 100px; float: left; margin-right: 10px;" />
                            <h3><%# Eval("ItemName") %></h3>
                            <p>Points Required: <%# Eval("ItemPoints") %></p>
                            <p><%# Eval("ItemDescription") %></p>
                            <p>Status: <%# Eval("Status") %></p>
                        </div>
                    </li>
                </ItemTemplate>

            </asp:ListView>
        </div>
    </div>
    
</asp:Content>
