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

    <div class="redemption-container">
        <div class="redemption-container-header">
            <h2>Redeem What You Like?</h2>
        </div>

        <div class="redemption-container-body d-flex flex-row justify-content-around flex-wrap">
            <asp:ListView ID="lvredeemitems" runat="server">
                <%-- layouttemplate is the overall layout wraps the ItemTemplate  --%>
                <LayoutTemplate>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                </LayoutTemplate>

                <%-- ItemTemplate defines how each item should look --%>
                <ItemTemplate>
                    <div class="RItem d-inline-block">
                        <div class="vouchercard p-3 d-flex flex-column justify-content-around">                            
                            <div class="d-flex flex-column justify-content-around" style="width: 90%">
                                <div class="voucher-head" style="flex:1">
                                    <h1 class="ItemName mt-0"><%# Eval("ItemName") %></h1>
                                </div>
                                <div class="image" style="flex:3">
                                    <asp:Image ID="ItemImage" runat="server" ImageUrl='<%# Eval("ItemImage") %>' CssClass="ItemImage" />
                                </div>
                            </div>
        
                            <p><%# Eval("ItemDescription") %> </p>
        
                            <button class="btn btn-danger resize">Redeem</button>
                        </div>
                    </div>
                </ItemTemplate>

            </asp:ListView>
        </div>
    </div>
    
</asp:Content>
