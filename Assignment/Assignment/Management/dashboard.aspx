<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Assignment.Management.dashboard" %>

<asp:Content ID="head" ContentPlaceHolderID="Head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <link href="../CSS/dashboard.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container-fluid p-0">

        <h1 class="text-dark mt-4"><strong>Analytics</strong> Dashboard</h1>
        <hr class="mt-0 mb-4" />

        <div class="row">
            <div class="col-xl-6 col-xxl-5 d-flex">
                <div class="w-100">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Booking</h5>
                                        </div>

                                        <div class="col-auto">
                                            <div class="stat text-primary">
                                                <i class="align-middle" data-feather="truck"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3"><asp:Label ID="lblSales" runat="server" Text=""></asp:Label></h1>
                                    <div class="mb-0">
                                            <asp:Label ID="lblLastSales" runat="server" Text="Last Booking: " CssClass="text-muted"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Today Visitors</h5>
                                        </div>

                                        <div class="col-auto">
                                            <div class="stat text-primary">
                                                <i class="align-middle" data-feather="users"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3">
                                        <asp:Label ID="lblVisitor" runat="server" Text=""></asp:Label></h1>
                                    <div class="mb-0">
                                        <asp:Label ID="lblVisitorDate" runat="server" Text="Last Update: " CssClass="text-muted"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Earnings</h5>
                                        </div>

                                        <div class="col-auto">
                                            <div class="stat text-primary">
                                                <i class="align-middle" data-feather="dollar-sign"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3">
                                        <asp:Label ID="lblEarning" runat="server" Text="RM "></asp:Label></h1>
                                    <div class="mb-0">
                                            <asp:Label ID="lblEarningLast" runat="server" Text="Last Booking: " CssClass="text-muted"></asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Active Users</h5>
                                        </div>

                                        <div class="col-auto">
                                            <div class="stat text-primary">
                                                <i class="align-middle" data-feather="shopping-cart"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3"><asp:Label ID="lblActiveUser" runat="server" Text=""></asp:Label></h1>
                                    <div class="mb-0">
                                            <asp:Label ID="lblActiveDate" runat="server" Text="Last Update: " CssClass="text-muted"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-6 col-xxl-7" style="margin-bottom: 20px"> 
                    <div class="card mb-3">
                        <div class="card-header">
                            <h5 class="card-title m-2">
                                <b>Top 5 Users Points Earned</b>
                            </h5>
                        </div>
                        <div class="card-body p-3">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <div class="list-group">
                                            <asp:ListView ID="lvTopFiveUser" runat="server">
                                                <LayoutTemplate>
                                                    <table class="table table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th class="fs-6">User ID </th>
                                                                <th class="fs-6">Total Points Earned </th>
                                                            </tr>
                                                        </thead>

                                                        <tbody>
                                                                <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                                        </tbody>
                                                    </table>
                                                </LayoutTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td class="fs-6"><%# Eval("Username") %></td>
                                                        <td class="fs-6"><%# Eval("RewardPoints") %></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:ListView>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                    </div>
                </div>
        </div>
        <!-- WZ Demo 1 Start-->
        <div class="row my-2">
            <div class="col-12">
                <div class="card overflow-auto mb-2" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; border-radius: 15px;">
                    <div class="card-body p-3">
                        <div class="d-flex justify-content-between">
                        <h5 class="card-title flex-grow-3 mb-0">Summary Report On Car Booking(Rented)</h5>
                                                    <div class="filter flex-shrink-0 mx-2">
                                <div id="carBookingRpt" class="d-flex align-items-center justify-content-between" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 200px;">
                                    <div>
                                        <i class="fa fa-calendar me-2"></i>
                                        <span></span>
                                    </div>
                                    <i class="fa fa-caret-down"></i>
                                </div>
                                </div>
                                                        <asp:HiddenField ID="hdnTimeFilter" runat="server" />
                                                        <asp:TextBox ID="txtStartDate" class="form-control" TextMode="Date" runat="server" style="display:none"></asp:TextBox>
                                                        <asp:TextBox ID="txtEndDate" class="form-control" TextMode="Date" runat="server" style="display:none"></asp:TextBox>
                                                        <asp:Button ID="btnProcessBookRecord" runat="server" Text="Generate" OnClick="btnBookRecord_Click" CssClass="btn btn-primary " style="display:none"/>
                            </div>
                        <hr />
                        <div class="container" style="display:none;">
                            <div class="row">
                                <div class="col col-md-4">
                                    <div class="form-group">
                                        <label for="timeFilter">Select Report Time Range</label>
                                        <asp:DropDownList ID="ddlTimeFilter" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="Today" Text="Today"></asp:ListItem>
                                            <asp:ListItem Value="Yesterday" Text="Yesterday"></asp:ListItem>
                                            <asp:ListItem Value="This Week" Text="This Week"></asp:ListItem>
                                            <asp:ListItem Value="Last Week" Text="Last Week"></asp:ListItem>
                                            <asp:ListItem Value="This Month" Text="This Month"></asp:ListItem>
                                            <asp:ListItem Value="Last Month" Text="Last Month"></asp:ListItem>
                                            <asp:ListItem Value="Quarter" Text="Quarter"></asp:ListItem>
                                            <asp:ListItem Value="This Year" Text="This Year"></asp:ListItem>
                                            <asp:ListItem Value="3 Year" Text="Recent Three Years"></asp:ListItem>
                                            <asp:ListItem Value="Custom" Text="Custom Date"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Label ID="lblCheck" runat="server" Text="Label"></asp:Label>
                                        

                                        <!-- Custom Date Pickers (Initially Hidden) -->
                                        <div id="customDateFilter" style="display: none;">
                                            <label for="startDate">Start Date</label>

                                            
                                            <label for="endDate">End Date</label>

                                            
                                        </div>
                                    </div>
                                </div>
                                <div class="col col-md-4">
                                    
                                </div>

                            </div>
                        </div>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="chart container">
                                    <div class="row">
                                        <div class="col-12">
                                            <asp:GridView ID="gvBooking" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                                                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                                <SortedDescendingHeaderStyle BackColor="#242121" />
                                            </asp:GridView>
                                            <asp:PlaceHolder ID="phNoBooking" runat="server" Visible="false">
                                                <tr class="text-center">
                                                    <th colspan="5">
                                                        <asp:Label ID="Label3" runat="server" Text="No Booking Record Found 😕" Font-Size="1.3em"></asp:Label>
                                                    </th>
                                                </tr>
                                            </asp:PlaceHolder>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div id="bookNumChart"></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-12">
                                            <div id="bookAmtChart"></div>
                                        </div>
                                    </div>

                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnProcessBookRecord" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
            <!-- WZ Demo 1 End-->
            <!-- WZ Demo 2 Start-->
            <div class="col-12">
                <div class="card overflow-auto" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; border-radius: 15px;">
                    <div class="card-body p-3">
                        <div class="d-flex justify-content-between">
                            <h5 class="card-title flex-grow-3mb-0">Exception Report on Car Rental Amount Made by Customers</h5>
                            <div class="filter flex-shrink-0 mx-2">
                                <div id="carRentalAmt" class="d-flex align-items-center justify-content-between" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 200px;">
                                    <div>
                                        <i class="fa fa-calendar me-2"></i>
                                        <span></span>
                                    </div>
                                    <i class="fa fa-caret-down"></i>
                                </div>
                                <asp:HiddenField ID="hdnTimeFilter_cust" runat="server" />
                                <asp:TextBox ID="txtStartDate_cust" class="form-control" TextMode="Date" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:TextBox ID="txtEndDate_cust" class="form-control" TextMode="Date" runat="server" Style="display: none;"></asp:TextBox>
                                <asp:Button ID="btnCustRecord" runat="server" Text="Generate" OnClick="btnCustRecord_Click" CssClass="btn btn-primary" ValidationGroup="custQuarter" Style="display: none" />
                            </div>
                        </div>
                        <hr />
                        <%--<div class="container" style="display:none">
                            <div class="row">

                                <div class="col col-md-4">
                                    <div class="form-group">
                                        <label for="timeFilter">Select Report Time Range</label>
                                        <asp:DropDownList ID="ddlTimeFilter_cust" runat="server" CssClass="form-control">
                                            <asp:ListItem Value="Today" Text="Today"></asp:ListItem>
                                            <asp:ListItem Value="Yesterday" Text="Yesterday"></asp:ListItem>
                                            <asp:ListItem Value="This Week" Text="This Week"></asp:ListItem>
                                            <asp:ListItem Value="Last Week" Text="Last Week"></asp:ListItem>
                                            <asp:ListItem Value="This Month" Text="This Month"></asp:ListItem>
                                            <asp:ListItem Value="Last Month" Text="Last Month"></asp:ListItem>
                                            <asp:ListItem Value="Quarter" Text="Quarter"></asp:ListItem>
                                            <asp:ListItem Value="This Year" Text="This Year"></asp:ListItem>
                                            <asp:ListItem Value="All Time" Text="All Time"></asp:ListItem>
                                            <asp:ListItem Value="Custom" Text="Custom Date"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Label ID="lblChecking" runat="server" Text="Label"></asp:Label>
                                        <!-- Custom Date Pickers (Initially Hidden) -->
                                        <div id="customDateFilter_cust" style="display: none;">
                                            <asp:Label ID="lblStartDate" runat="server" Text="Start Date"></asp:Label>

                                            <asp:Label ID="lblEndDate" runat="server" Text="End Date"></asp:Label>

                                        </div>
                                        <!-- Custom Quarter Pickers (Initially Hidden) -->
                                        <div id="customQuarterFilter_cust" style="display: none">
                                            <asp:Label ID="lblQuarter" runat="server" Text="Choose Quarter"></asp:Label>
                                            <asp:DropDownList ID="ddlQuarterFilter_cust" runat="server" CssClass="form-control">
                                                <asp:ListItem Value="default" Text="Please pick specific quarter"></asp:ListItem>
                                                <asp:ListItem Value="Quarter1" Text="Quarter 1"></asp:ListItem>
                                                <asp:ListItem Value="Quarter2" Text="Quarter 2"></asp:ListItem>
                                                <asp:ListItem Value="Quarter3" Text="Quarter 3"></asp:ListItem>
                                                <asp:ListItem Value="Quarter4" Text="Quarter 4"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="hdnQuarterFilter" runat="server" />
                                            <asp:RequiredFieldValidator ID="rqQuarterFilter" runat="server" ControlToValidate="ddlQuarterFilter_cust" ErrorMessage="Please choose Quarter Filter Option" Enabled="false" InitialValue="default" ForeColor="Red" ValidationGroup="custQuarter" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>--%>
                        <div class="chart">
                            <asp:UpdatePanel ID="updateTopCust" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div class="table-responsive">
                                        <table class="table table-border table-hover table-striped">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center" colspan="4">
                                                        <asp:Label ID="lblTopCust" CssClass="lblTopCust_style" runat="server"></asp:Label>
                                                    </th>
                                                </tr>
                                                <tr style="font-size: 16px;">
                                                    <th scope="col">User Profile</th>
                                                    <th scope="col">User Name</th>
                                                    <th scope="col">Email</th>
                                                    <th scope="col">Total Rent Made(MYR)</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <asp:Repeater ID="rptTopCustRental" runat="server">
                                                    <ItemTemplate>
                                                        <tr>
                                                            <td scope="col">
                                                                <div class="img-fluid">
                                                                    <asp:Image ID="imgUserProfile" runat="server" ImageUrl='<%# Eval("ProfilePicture") %>' Width="50px" />
                                                                </div>
                                                            </td>

                                                            <td scope="col">
                                                                <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("Username") %>' />
                                                            </td>

                                                            <td scope="col">
                                                                <asp:Label ID="lblUserEmail" runat="server" Text='<%# Eval("Email") %>' />
                                                            </td>

                                                            <td scope="col">
                                                                <asp:Label ID="lblRentAmount" runat="server" Text='<%# Eval("TotalPrice","{0:F2}") %>' />
                                                            </td>

                                                        </tr>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                                <asp:PlaceHolder ID="phLackCustRecord" runat="server" Visible="false">
                                                    <tr class="text-center">
                                                        <th colspan="5" style="background-color: rgb(210, 180, 140);">
                                                            <asp:Label ID="lblLackCustRecord" runat="server" Font-Size="1.3em"></asp:Label>
                                                        </th>
                                                    </tr>
                                                </asp:PlaceHolder>
                                                <asp:PlaceHolder ID="phNoCustRecord" runat="server" Visible="false">
                                                    <tr class="text-center">
                                                        <th colspan="5" style="background-color: rgb(233, 116, 81);">
                                                            <asp:Label ID="lblNoCust" runat="server" Text="No Customer Rental Record 😕" Font-Size="1.3em"></asp:Label>
                                                        </th>
                                                    </tr>
                                                </asp:PlaceHolder>
                                            </tbody>
                                        </table>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnCustRecord" EventName="Click" />

                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- WZ Demo 2 End-->

        <div class="row">
            <!-- Top Renting -->
            <div class="col-12 col-lg-9 mb-2">
                <div class="card overflow-auto" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; border-radius: 15px;">

                    <div class="card-body pb-0">

                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title flex-grow-3">Top 5 Rented <span id="topRentalDay" class="text-muted" style="font-size: 0.7em">| All Time</span></h5>

                            <div class="filter flex-shrink-0 mx-2">
                                <div id="topRentalRange" class="d-flex align-items-center justify-content-between" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 200px;">
                                    <div>
                                        <i class="fa fa-calendar me-2"></i>
                                        <span></span>
                                    </div>
                                    <i class="fa fa-caret-down"></i>
                                </div>
                                <asp:HiddenField ID="hdnTopRentalStart" runat="server" />
                                <asp:HiddenField ID="hdnTopRentalEnd" runat="server" />
                                <asp:Button ID="btnTopDateFilter" runat="server" Text="Button" Style="display: none" OnClick="btnTopDateFilter_Click" />
                                <asp:Button ID="btnAllTopRental" runat="server" Text="Button" Style="display: none" OnClick="btnAllTopRental_Click" />
                            </div>
                        </div>
                        <hr />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div class="table-responsive">
                                    <table class="table table-border table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">Car Image</th>
                                                <th scope="col">Car Name</th>
                                                <th scope="col">Day Price</th>
                                                <th scope="col">Rent</th>
                                                <th scope="col">Revenue</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <asp:Repeater ID="rptTopRental" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <td scope="col" class="text-center" style="width: 250px;">
                                                            <div class="topRentalImageFrame">
                                                                <asp:Image ID="imgCarTopPic" runat="server" ImageUrl='<%# Eval("Image") %>' Width="120px" CssClass="mx-auto" />
                                                            </div>
                                                        </td>

                                                        <td scope="col">
                                                            <asp:Label ID="lblCarName" runat="server" Text='<%# Eval("CarName") %>' /></td>

                                                        <td scope="col">
                                                            <asp:Label ID="lblDayPrice" runat="server" Text='<%# Eval("Price","{0:F2}") %>' /></td>

                                                        <td scope="col">
                                                            <asp:Label ID="lblRentalCount" runat="server" Text='<%# Eval("RentalCount") %>' /></td>

                                                        <td scope="col">
                                                            <asp:Label ID="lblTotalRevenue" runat="server" Text='<%# Eval("TotalRevenue","{0:F2}") %>' /></td>
                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                            <asp:PlaceHolder ID="noCarPlaceholder" runat="server" Visible="false">
                                                <tr class="text-center">
                                                    <th colspan="5">
                                                        <asp:Label ID="Label1" runat="server" Text="No Car Rented :<" Font-Size="1.3em"></asp:Label></th>
                                                </tr>
                                            </asp:PlaceHolder>
                                        </tbody>
                                    </table>
                                </div>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnTopDateFilter" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnAllTopRental" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>

                </div>
            </div>
            <!-- Top Renting -->
            <div class="col-12 col-lg-3 mb-2">
                <!-- Rent Car Type -->
                <div class="card" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; border-radius: 15px;">

                    <div class="card-body pb-0">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title flex-grow-3">Rented Car Type <span id="carTypeDay" class="text-muted" style="font-size: 0.6em">| All Time</span></h5>
                            <div id="carCategoryRange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;" class="flex-shrink-0 d-flex align-content-center justify-content-between custom-type-range">
                                <div>
                                    <i class="fa fa-calendar"></i>
                                    <span class="custom-type-span">HIHI</span>
                                </div>
                                <i class="fa fa-caret-down"></i>
                            </div>
                            <asp:HiddenField ID="hdnCarCategoryStart" runat="server" />
                            <asp:HiddenField ID="hdnCarCategoryEnd" runat="server" />
                        </div>
                        <hr />
                        <div id="rentTypeChart" style="min-height: 465px;" class="echart"></div>
                        <script src="
				https://cdn.jsdelivr.net/npm/echarts@5.5.1/dist/echarts.min.js
				"></script>
                        <script>
                            function filterAllCategory() {
                                $.ajax({
                                    type: "POST",
                                    url: "dashboard.aspx/getCarCategory", // Ensure this URL points to the correct server method
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        // Parse the response to get the car type and count data
                                        var data = JSON.parse(response.d);

                                        var chartdata = [];
                                        for (var i = 0; i < data.length; i++) {
                                            chartdata.push({
                                                value: data[i].CarCount,
                                                name: data[i].CarType
                                            });
                                        }

                                        echarts.init(document.querySelector("#rentTypeChart")).setOption({
                                            tooltip: {
                                                trigger: 'item'
                                            },
                                            legend: {
                                                top: '5%',
                                                left: 'center'
                                            },
                                            series: [{
                                                name: 'Car Type',
                                                type: 'pie',
                                                radius: ['40%', '70%'],
                                                avoidLabelOverlap: false,
                                                label: {
                                                    show: false,
                                                    position: 'center'
                                                },
                                                emphasis: {
                                                    label: {
                                                        show: true,
                                                        fontSize: '18',
                                                        fontWeight: 'bold'
                                                    }
                                                },
                                                labelLine: {
                                                    show: false
                                                },
                                                color: [
                                                    '#90e0ef',
                                                    '#48cae4',
                                                    '#00b4d8',
                                                    '#0077b6',
                                                ],
                                                data: chartdata
                                            }]
                                        });
                                    },
                                    error: function (error) {
                                        console.log(error);
                                    }
                                });
                            };

                            function filterCarCategory() {
                                var hdnCarCategoryStart = document.getElementById('<%= hdnCarCategoryStart.ClientID %>').value;
                                var hdnCarCategoryEnd = document.getElementById('<%= hdnCarCategoryEnd.ClientID %>').value;
                                $.ajax({
                                    type: "POST",
                                    url: "dashboard.aspx/filterCategory", // Ensure this URL points to the correct server method
                                    data: JSON.stringify({ start: hdnCarCategoryStart, end: hdnCarCategoryEnd }), // Pass the hidden field value as parameter
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (response) {
                                        // Parse the response to get the car type and count data
                                        var data = JSON.parse(response.d);

                                        var chartdata = [];
                                        for (var i = 0; i < data.length; i++) {
                                            chartdata.push({
                                                value: data[i].CarCount,
                                                name: data[i].CarType
                                            });
                                        }

                                        echarts.init(document.querySelector("#rentTypeChart")).setOption({
                                            tooltip: {
                                                trigger: 'item'
                                            },
                                            legend: {
                                                top: '5%',
                                                left: 'center'
                                            },
                                            series: [{
                                                name: 'Car Type',
                                                type: 'pie',
                                                radius: ['40%', '70%'],
                                                avoidLabelOverlap: false,
                                                label: {
                                                    show: false,
                                                    position: 'center'
                                                },
                                                emphasis: {
                                                    label: {
                                                        show: true,
                                                        fontSize: '18',
                                                        fontWeight: 'bold'
                                                    }
                                                },
                                                labelLine: {
                                                    show: false
                                                },
                                                color: [
                                                    '#90e0ef',
                                                    '#48cae4',
                                                    '#00b4d8',
                                                    '#0077b6',
                                                ],
                                                data: chartdata
                                            }]
                                        });
                                    },
                                    error: function (error) {
                                        console.log(error);
                                    }
                                });
                            };
                        </script>


                    </div>
                </div>
                <!-- Rent Car Type-->
            </div>
        </div>
    </div>
    <!--Start Date Picker -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <script type="text/javascript">
        $(function () {

            var start = moment().subtract(2, 'days');
            var end = moment().subtract(2, 'days');

            function cb(start, end, isAll) {

                if (isAll) {
                    $('#topRentalRange span').html("All Time");
                    document.getElementById('<%=btnAllTopRental.ClientID %>').click();
                } else {
                    $('#topRentalRange span').html(start.format('DD-MM-YYYY') + ' - ' + end.format('DD-MM-YYYY') + '  ');

                    document.getElementById('<%=hdnTopRentalStart.ClientID %>').value = start.format('YYYY-MM-DD');
                    document.getElementById('<%=hdnTopRentalEnd.ClientID %>').value = end.format('YYYY-MM-DD');
                    document.getElementById('<%=btnTopDateFilter.ClientID %>').click();
                }
            }

            $('#topRentalRange').daterangepicker({
                startDate: start,
                endDate: end,
                autoApply: true,
                opens: "left",
                ranges: {
                    'All Time': [moment().subtract(2, 'days'), moment().subtract(2, 'days')],
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                }
            }, function (start, end, label) {
                if (label == 'All Time') {
                    cb(start, end, true);
                } else {
                    cb(start, end, false);
                }
                document.getElementById('topRentalDay').textContent = "| " + label;
            });

            cb(start, end, true);

        });

        $(function () {
            var start = moment().subtract(2, 'days');
            var end = moment().subtract(2, 'days');

            function cb(start, end, isAll) {

                if (isAll) {
                    $('#carCategoryRange span').html("All Time");
                    filterAllCategory();
                } else {
                    $('#carCategoryRange span').html(start.format('DD-MM-YYYY') + ' - ' + end.format('DD-MM-YYYY') + '  ');
                    document.getElementById('<%=hdnCarCategoryStart.ClientID %>').value = start.format('YYYY-MM-DD');
                    document.getElementById('<%=hdnCarCategoryEnd.ClientID %>').value = end.format('YYYY-MM-DD');
                    filterCarCategory();
                }
            }

            $('#carCategoryRange').daterangepicker({
                startDate: start,
                endDate: end,
                autoApply: true,
                opens: "left",
                ranges: {
                    'All Time': [moment().subtract(2, 'days'), moment().subtract(2, 'days')],
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'Last 7 Days': [moment().subtract(6, 'days'), moment()],
                    'Last 30 Days': [moment().subtract(29, 'days'), moment()],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
                },
            }, function (start, end, label) {
                if (label == 'All Time') {
                    cb(start, end, true);
                } else {
                    cb(start, end, false);
                }
                document.getElementById('carTypeDay').textContent = "| " + label;

            });

            cb(start, end, true);

        });

        $(function () {

            var start = moment().subtract(2, 'days');
            var end = moment().subtract(2, 'days');

            function cb(start, end, isClick) {                
                document.getElementById('<%=txtStartDate_cust.ClientID %>').value = start.format('YYYY-MM-DD');
                document.getElementById('<%=txtEndDate_cust.ClientID %>').value = end.format('YYYY-MM-DD');
                if (isClick) {
                    document.getElementById('<%=btnCustRecord.ClientID %>').click();
                }
            }

            $('#carRentalAmt').daterangepicker({
                startDate: start,
                endDate: end,
                autoApply: true,
                opens: "left",
                ranges: {
                    'All Time': [moment().subtract(2, 'days'), moment().subtract(2, 'days')],
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'This Week': [moment().subtract(6, 'days'), moment()],
                    'Last Week': [moment().subtract(1, 'week').startOf('week'), moment().subtract(1, 'week').endOf('week')],
                    'This Month': [moment().startOf('month'), moment().endOf('month')], 'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
                    'This Year': [moment().startOf('year'), moment().endOf('year')],
                }
            }, function (start, end, label) {
                if (label != "Custom Range") {
                    document.getElementById('<%=hdnTimeFilter_cust.ClientID %>').value = label;
                    $('#carRentalAmt span').html(label);
                } else {
                    document.getElementById('<%=hdnTimeFilter_cust.ClientID %>').value = "Custom";
                    $('#carRentalAmt span').html(start.format('DD-MM-YYYY') + ' - ' + end.format('DD-MM-YYYY') + '  ');
                }
                cb(start, end, true);
                console.log(label);
            });

            cb(start, end, false);

        });

        $(function () {

            var start = moment();
            var end = moment();

            function cb(start, end, isClick) {
                document.getElementById('<%=txtStartDate.ClientID %>').value = start.format('YYYY-MM-DD');
                document.getElementById('<%=txtEndDate.ClientID %>').value = end.format('YYYY-MM-DD');
                if (isClick) {
                    document.getElementById('<%=btnProcessBookRecord.ClientID %>').click();
                }
            }

            $('#carBookingRpt').daterangepicker({
                startDate: start,
                endDate: end,
                autoApply: true,
                opens: "left",
                ranges: {
                    'Today': [moment(), moment()],
                    'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
                    'This Week': [moment().subtract(6, 'days'), moment()],
                    'Last Week': [moment().subtract(1, 'week').startOf('week'), moment().subtract(1, 'week').endOf('week')],
                    'This Month': [moment().startOf('month'), moment().endOf('month')],
                    'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
                    'Quarter': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
                    'This Year': [moment().startOf('year'), moment().endOf('year')],
                    '3 Year': [moment().subtract(3,"year").startOf('year'), moment().endOf('year')],
                }
            }, function (start, end, label) {
                if (label != "Custom Range") {
                    document.getElementById('<%=hdnTimeFilter.ClientID %>').value = label;
                    $('#carBookingRpt span').html(label);
                } else {
                    document.getElementById('<%=hdnTimeFilter.ClientID %>').value = "Custom";
                    $('#carBookingRpt span').html(start.format('DD-MM-YYYY') + ' - ' + end.format('DD-MM-YYYY') + '  ');
                }
                cb(start, end, true);
                console.log(label);
            });

                    cb(start, end, false);

                });
    </script>
    <!-- End Date Picker -->
    <!-- Theme JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <%--<script>
        document.addEventListener('DOMContentLoaded', function () {
            // Function to generate random sales data
            function generateRandomSales() {
                return Array.from({ length: 12 }, () => Math.floor(Math.random() * 1000));
            }

            // Month labels
            const months = [
                'January', 'February', 'March', 'April', 'May', 'June',
                'July', 'August', 'September', 'October', 'November', 'December'
            ];

            // Generate random sales data
            const salesData = generateRandomSales();

            // Get the canvas context
            const ctxLine = document.getElementById('line-chart').getContext('2d');

            // Initialize the chart
            new Chart(ctxLine, {
                type: 'line',
                data: {
                    labels: months,
                    datasets: [{
                        label: 'Monthly Sales',
                        data: salesData,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        fill: true,
                        tension: 0.1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    return `Sales: $${tooltipItem.raw}`;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            beginAtZero: true
                        },
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>--%>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Function to generate random booking numbers
            function generateRandomBookings() {
                return Array.from({ length: 12 }, () => Math.floor(Math.random() * 500));
            }

            // Month labels
            const months = [
                'January', 'February', 'March', 'April', 'May', 'June',
                'July', 'August', 'September', 'October', 'November', 'December'
            ];

            // Generate random booking numbers
            const bookingData = generateRandomBookings();

            // Get the canvas context
            const ctxBar = document.getElementById('bar-chart').getContext('2d');

            // Initialize the bar chart
            new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: months,
                    datasets: [{
                        label: 'Monthly Bookings',
                        data: bookingData,
                        backgroundColor: 'rgba(54, 162, 235, 0.2)',
                        borderColor: 'rgba(54, 162, 235, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top'
                        },
                        tooltip: {
                            callbacks: {
                                label: function (tooltipItem) {
                                    return `Bookings: ${tooltipItem.raw}`;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Month'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: true,
                                text: 'Number of Bookings'
                            }
                        }
                    }
                }
            });
        });
    </script>
    <!-- Theme JS -->

    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script>
        function renderBookingRecordChart(lineData, xAxisTitle, categories, title) {
            console.log("Line data: ", lineData);
            console.log("Category: ", categories);
            $('#bookNumChart').highcharts({
                chart: {
                    type: 'spline'
                },
                title: {
                    text: "Summary of Booking Record Made " + title
                },
                xAxis: {
                    title: {
                        text: xAxisTitle
                    },
                    categories: categories // Placeholder
                },
                yAxis: {
                    title: {
                        text: "Count"
                    }
                },
                plotOptions: {
                    spline: {
                        dataLabels: {
                            enabled: true
                        },
                        enableMouseTracking: true
                    }
                },
                series: [{
                    type: 'spline',
                    name: "Booking Record Count",
                    data: lineData // Converts the lineData string to a JavaScript array
                }]
            });
        }
        function renderBookingAmtChart(lineData, xAxisTitle, categories, title) {
            $('#bookAmtChart').highcharts({
                chart: {
                    type: 'column'
                },
                title: {
                    text: "Summary of Booking Amount Made " + title
                },
                xAxis: {
                    title: {
                        text: xAxisTitle
                    },
                    categories: categories // Placeholder
                },
                yAxis: {
                    title: {
                        text: "Amount Made(MYR)"
                    }
                },
                plotOptions: {
                    column: {
                        dataLabels: {
                            enabled: true
                        },
                        enableMouseTracking: true
                    }
                },
                series: [{
                    type: 'column',
                    name: "Amount Made(MYR)",
                    data: lineData // Converts the lineData string to a JavaScript array
                }]
            });
        }
        console.log("Chart rendered");
        $(document).ready(function () {

            // When dropdown value changes
            $('#<%= ddlTimeFilter.ClientID %>').change(function () {
                var selectedValue = $(this).val();
                $('#<%= hdnTimeFilter.ClientID %>').val(selectedValue);

                // If "Custom Date" is selected, show the date pickers
                if (selectedValue === 'Custom') {
                    $('#customDateFilter').show();
                } else {
                    $('#customDateFilter').hide();
                }
            });

<%--            $('#<%= ddlTimeFilter_cust.ClientID %>').change(function () {
                var selectedValue = $(this).val();
                $('#<%= hdnTimeFilter_cust.ClientID%>').val(selectedValue);

                    if (selectedValue === 'Custom') {
                        $('#customDateFilter_cust').show();
                        $('#customQuarterFilter_cust').hide();
                        ValidatorEnable(document.getElementById('<%= rqQuarterFilter.ClientID %>'), false);
                    } else if (selectedValue === 'Quarter') {
                        $('#customDateFilter_cust').hide();
                        $('#customQuarterFilter_cust').show();
                        ValidatorEnable(document.getElementById('<%= rqQuarterFilter.ClientID %>'), true);
                    }
                    else {
                        $('#customDateFilter_cust').hide();
                        $('#customQuarterFilter_cust').hide();
                        ValidatorEnable(document.getElementById('<%= rqQuarterFilter.ClientID %>'), false);
                    }



                });

            $('#<%= ddlQuarterFilter_cust.ClientID %>').change(function () {
                var selectedQuarter = $(this).val;
                $('#<%=hdnQuarterFilter.ClientID %>').val(selectedQuarter);

                });--%>
        });
    </script>
</asp:Content>
