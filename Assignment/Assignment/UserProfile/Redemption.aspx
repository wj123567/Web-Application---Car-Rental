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

        <div class="redemption-container-body d-flex flex-row justify-content-around flex-wrap">
            <asp:ListView ID="lvredeemitems" runat="server" DataSourceID="SqlDataSource1">
                <%-- layouttemplate is the overall layout wraps the ItemTemplate  --%>
                <LayoutTemplate>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server">
                    </asp:PlaceHolder>
                </LayoutTemplate>

                <%-- ItemTemplate defines how each item should look --%>
                <ItemTemplate>
                    <div class="height d-inline-block">
    
                        <div class="card p-3">
        
                            <div class="d-flex justify-content-between align-items-center" style="flex:280px">
                                <div class="mt-2">
                                    <div class="mt-5">
                                        <h1 class="main-heading mt-0"><%# Eval("ItemName") %></h1>
                                        <div class="d-flex flex-row user-ratings">
                                            <div class="ratings">
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            <i class="fa fa-star"></i>
                                            </div>
                                            <h6 class="text-muted ml-1">4/5</h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="image">
                                    <asp:Image ID="ItemImage" runat="server" ImageUrl='<%# ResolveUrl(Eval("ItemImage").ToString()) %>' Width="100px" Height="150px" />
                                </div>
                            </div>
        
                            <p><%# Eval("ItemDescription") %> </p>
        
                            <button class="btn btn-danger">Add to cart</button>
                        </div>
    
                    </div>
                </ItemTemplate>

            </asp:ListView>
        </div>
    </div>
    
</asp:Content>
