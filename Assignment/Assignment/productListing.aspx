<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="productListing.aspx.cs" Inherits="Assignment.productListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="dsCarType" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT * FROM [CarType]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="CarLocation" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT [Id], [LocationName] FROM [Location]"></asp:SqlDataSource>

<div>
    <div class="float-start mx-2 mt-4">
    <asp:LinkButton ID="btnA2Z" runat="server" CssClass="text-dark mx-2" OnClick="btnA2Z_Click">
        <i class="fa-solid fa-arrow-up-a-z fa-xl"></i>
    </asp:LinkButton>    

    <asp:LinkButton ID="btnZ2A" runat="server" CssClass="text-dark mx-2" OnClick="btnZ2A_Click" Visible="False">
        <i class="fa-solid fa-arrow-down-z-a fa-xl"></i>
    </asp:LinkButton>
    </div>

<div class="btn float-end mt-3 mx-3" data-bs-toggle="offcanvas" data-bs-target="#offcanvas">
    <span class="text-lg">Filter</span>
    <i class="fa-solid fa-filter fa-xl" data-bs-toggle="offcanvas" data-bs-target="#offcanvas"></i>
</div>
</div>

<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvas" data-bs-keyboard="false" data-bs-backdrop="false">
    <div class="offcanvas-header">
        <h6 class="offcanvas-title d-sm-block" id="offcanvasHeader">Filter</h6>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body px-0">
        <ul class="nav nav-pills flex-column mb-sm-auto mb-0 align-items-start" id="menu">
          <li class="nav-item">
                <a href="#" class="nav-link text-black">
                    <span class="text-muted">Location:</span>
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-select" DataSourceID="CarLocation" DataTextField="LocationName" DataValueField="Id" Width="225px" ValidationGroup="filter" OnDataBound="ddlLocation_DataBound"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Location is Required" ControlToValidate="ddlLocation" CssClass="validate" InitialValue="0" ValidationGroup="filter"></asp:RequiredFieldValidator>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link text-black">
                    <span class="text-muted d-block">Date Time:</span>
                    <span>Start :&nbsp;</span>
                    <asp:TextBox ID="txtStartTime" runat="server" TextMode="DateTimeLocal" CssClass="form-control d-inline" Width="180px"></asp:TextBox>
                    <br />
                    <span class="mt-2">End &nbsp; :&nbsp;</span>
                    <asp:TextBox ID="txtEndTime" runat="server" TextMode="DateTimeLocal" CssClass="form-control d-inline mt-2" Width="180px"></asp:TextBox>
                    <br />
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="End Time Must After Start Time" ControlToCompare="txtEndTime" ControlToValidate="txtStartTime" CssClass="validate" Operator="LessThan" ValidationGroup="filter"></asp:CompareValidator>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link text-black">
                    <span class="text-muted">Car Brand:</span>
                    <asp:CheckBoxList ID="cblCarBrand" runat="server"></asp:CheckBoxList>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link text-black">
                    <span class="text-muted">Car Type:</span>
                    <asp:CheckBoxList ID="cblCarType" runat="server" DataSourceID="dsCarType" DataTextField="CType" DataValueField="CType" ValidationGroup="filter"></asp:CheckBoxList>
                </a>
            </li>

            <li class="nav-item">
                <a href="#" class="nav-link text-black">
                    <span class="text-muted d-block">Price Range:</span>
                    <div class="justify-content-between">
                    <asp:TextBox ID="txtMinPrice" runat="server" TextMode="Number" placeholder="Min" Width="100px" min="1" ValidationGroup="filter" CssClass="form-control d-inline"></asp:TextBox>
                    <span>-</span>
                    <asp:TextBox ID="txtMaxPrice" runat="server" TextMode="Number" placeholder="Max" Width="100px" min="1" ValidationGroup="filter" CssClass="form-control d-inline"></asp:TextBox>
                    </div>
                    <asp:CompareValidator ID="cprMaxMinPrice" runat="server" ErrorMessage="Max Price Must Greater than Min Price" ControlToCompare="txtMinPrice" ControlToValidate="txtMaxPrice" CssClass="validate" Operator="GreaterThan" ValidationGroup="filter"></asp:CompareValidator>
                    <br />
                </a>
                
            </li>
        </ul>
        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-block float-end mx-3 text-white" style="background-color:#3490dc;" OnClick="btnFilter_Click" ValidationGroup="filter"/>
    </div>
</div>
  
<div class="container-fluid d-flex justify-content-center pt-5 mx-auto" style="width:100%">
    <div class="row">
        <asp:Label ID="lblSearchFail" runat="server"></asp:Label>  
        <asp:Repeater ID="productRepeater" runat="server">
            <ItemTemplate>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4 shadow-sm" style="background-color:#effaf6;">
                    <div class="card h-100" style="background-color:#f0f9f5;">
                        <div class="image-frame mx-auto">
                        <asp:Image ID="CarImage" runat="server" ImageUrl='<%# Eval("CarImage") %>' CssClass="img-fluid card-img-top" />
                       </div>
                        <div class="card-body pt-0 px-3">
                            <div class="d-flex flex-row justify-content-between mb-0">
                                <div>
                                    <asp:Label ID="lblCarBrand" runat="server" Text='<%# Eval("CarBrand") %>'/>
                                    <asp:Label ID="lblCarName" runat="server" Text='<%# Eval("CarName") %>'/>
                                    <asp:Label ID="lblCarPlate" runat="server" Text='<%# Eval("CarPlate") %>' CssClass="text-muted d-block" Font-Size="0.9em" />
                                </div>
                                <div>
                                    <span>Rm </span>
                                    <asp:Label ID="lblCarDayPrice" runat="server" Text='<%# Eval("CarDayPrice") %>'/>
                                    <span class="text-muted d-block" style="font-size:0.9em">per day</span>
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
                            <asp:Button ID="btnProductRent" runat="server" Text="Rent" CssClass="btn btn-block text-white" style="background-color:#3490dc;" CommandArgument='<%# Eval("CarPlate") %>' OnClick="btnProductRent_Click" />
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
                                
</div>

<script>
    if (window.history.replaceState) {
        window.history.replaceState(null, null, window.location.href);
    }
</script>
</asp:Content>
