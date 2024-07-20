<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="productListing.aspx.cs" Inherits="Assignment.productListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

  
<div class="container-fluid d-flex justify-content-center pt-5 mx-auto" style="width:100%">
    <div class="row">
        <asp:Label ID="lblSearchFail" runat="server"></asp:Label>  
        <asp:Repeater ID="productRepeater" runat="server">
            <ItemTemplate>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                    <div class="card h-100">
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("CarImage") %>' CssClass="img-fluid card-img-top" />
                        <div class="card-body pt-0 px-3">
                            <div class="d-flex flex-row justify-content-between mb-0">
                                <div>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("CarBrand") %>'/>
                                    <asp:Label ID="lblCarName" runat="server" Text='<%# Eval("CarName") %>'/>
                                </div>
                                <div class="d-flex flex-row align-items-start text-center">
                                    <span>Rm&nbsp;</span>
                                    <asp:Label ID="lblCarHourPrice" runat="server" Text='<%# Eval("CarHourPrice") %>'/>
                                    <span>&nbsp;/ hour</span>
                                </div>
                            </div>
                            <hr class="mt-2">
                            <p class="text-muted mb-0">Feature</p>
                            <div class="flex flex-wrap d-flex flex-row justify-content-between mt-3 mid">
                                <div class="flex flex-col items-start justify-between align-items-center text-center mx-1">
                                    <i class="fa-solid fa-car" style="width:35px; height:25px;"></i>
                                    <asp:Label ID="lblCarType" runat="server" Text='<%# Eval("CType") %>' CssClass="d-block" />
                                </div>
                                <div class="flex flex-col items-start justify-between align-items-center text-center mx-1">
                                    <i class="fa-solid fa-gear" style="width:35px; height:25px;"></i>
                                    <asp:Label ID="lblCarTransmission" runat="server" Text='<%# Eval("CarTransmission") %>' CssClass="d-block" />
                                </div>
                                <div class="flex flex-col items-start justify-between align-items-center text-center mx-1">
                                    <i class="fa-solid fa-couch" style="width:35px; height:25px;"></i>
                                    <div class="d-flex flex-row align-items-start text-center">
                                        <asp:Label ID="lblCarSeat" runat="server" Text='<%# Eval("CarSeat") %>' CssClass="d-block" />
                                        <span>&nbsp;Seats</span>
                                    </div>
                                </div>
                                <div class="dflex flex-col items-start justify-between align-items-center text-center mx-1">
                                    <i class="fa-solid fa-bolt" style="width:35px; height:25px;"></i>
                                    <asp:Label ID="lblCarEnergy" runat="server" Text='<%# Eval("CarEnergy") %>' CssClass="d-block" />
                                </div>
                            </div>
                        </div>
                        <div class="mx-3 mb-3">
                            <asp:Button ID="btnProductRent" runat="server" Text="Rent" CssClass="btn btn-block" style="background-color:#3490dc;"/>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
</asp:Content>
