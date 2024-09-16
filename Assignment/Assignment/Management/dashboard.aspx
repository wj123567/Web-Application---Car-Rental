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
                                            <h5 class="card-title">Sales</h5>
                                        </div>

                                        <div class="col-auto">
                                            <div class="stat text-primary">
                                                <i class="align-middle" data-feather="truck"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3">2.382</h1>
                                    <div class="mb-0">
                                        <span class="text-danger">-3.65%</span>
                                        <span class="text-muted">Since last week</span>
                                    </div>
                                </div>
                            </div>
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Visitors</h5>
                                        </div>

                                        <div class="col-auto">
                                            <div class="stat text-primary">
                                                <i class="align-middle" data-feather="users"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3">38</h1>
                                    <div class="mb-0">
                                        <span class="text-success">5.25%</span>
                                        <span class="text-muted">Since last week</span>
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
                                    <h1 class="mt-1 mb-3">RM 21.30</h1>
                                    <div class="mb-0">
                                        <span class="text-success">6.65%</span>
                                        <span class="text-muted">Since last week</span>
                                    </div>
                                </div>
                            </div>
                            <div class="card" style="margin-bottom: 20px">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col mt-0">
                                            <h5 class="card-title">Orders</h5>
                                        </div>

                                        <div class="col-auto">
                                            <div class="stat text-primary">
                                                <i class="align-middle" data-feather="shopping-cart"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="mt-1 mb-3">64</h1>
                                    <div class="mb-0">
                                        <span class="text-danger">-2.25%</span>
                                        <span class="text-muted">Since last week</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-6 col-xxl-7" style="margin-bottom: 20px">
                <div class="card flex-fill w-100">
                    <div class="card-header">

                        <h5 class="card-title mb-0">Recent Monthly Sales</h5>
                    </div>
                    <%--<img src="../Image/Dashboard/chart.png" />--%>
                    <div class="card mb-3">
                        <div class="card-body p-3">
                            <div class="chart">
                                <canvas id="line-chart" class="chart-canvas" height="300"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- WZ Demo 1 Start-->
        <div class="row">

         <div class="card flex-fill w-100">
         <div class="card-header">
    
             <h5 class="card-title mb-0">Booking</h5>
         </div>
        
         <div class="card mb-3">
             <div class="card-body p-3">
                 <div class="container">
                  <div class="row">
                    <div class="col col-md-4">
                      <div class="form-group">
                         <label for="timeFilter">Select Report Time Range</label>
                        <asp:DropDownList ID="ddlTimeFilter" runat="server" CssClass="form-control" >
                            <asp:ListItem Value="Day" Text="Day"></asp:ListItem>
                            <asp:ListItem Value="Week" Text="Week"></asp:ListItem>
                            <asp:ListItem Value="Month" Text="Month"></asp:ListItem>
                            <asp:ListItem Value="Quarter" Text="Quarter"></asp:ListItem>
                            <asp:ListItem Value="Year" Text="Year"></asp:ListItem>
                            <asp:ListItem Value="Custom" Text="Custom Date"></asp:ListItem>
                        </asp:DropDownList>
                          <asp:Label ID="lblCheck" runat="server" Text="Label"></asp:Label>
                        <asp:HiddenField ID="hdnTimeFilter" runat="server" />
                
                          <!-- Custom Date Pickers (Initially Hidden) -->
                    <div id="customDateFilter" style="display: none;">
                        <label for="startDate">Start Date</label>
                        
                        <asp:TextBox ID="txtStartDate" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                        <label for="endDate">End Date</label>
                        
                        <asp:TextBox ID="txtEndDate" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    </div>
                         </div>
                      <div class="col col-md-4">
                          <asp:Button ID="btnProcessBookRecord" runat="server" Text="Button"  OnClick="btnBookRecord_Click" CssClass="btn btn-primary "/>
                          </div>
                    
                  </div>
                </div>
                 <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                     <ContentTemplate>
                 <div class="chart container-fluid">                  
                      <div class="row">
                        <div class="col-12">
                            <asp:GridView ID="gvBooking" runat="server"></asp:GridView>
                            <asp:PlaceHolder ID="phNoBooking" runat="server" Visible="false">
                                <tr class="text-center" >
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
        </div>
        <!-- WZ Demo 1 End-->
           <!-- WZ Demo 2 Start-->
   <div class="row">
    <div class="card flex-fill w-100">
    <div class="card-header">
    
        <h5 class="card-title mb-0">Top-N Customer on Car Rental Amount Made </h5>
    </div>
   
    <div class="card mb-3">
        <div class="card-body p-3">
             <div class="container">
              <div class="row">
                  
                <div class="col col-md-4">
                  <div class="form-group">
                     <label for="timeFilter">Select Report Time Range</label>
                    <asp:DropDownList ID="ddlTimeFilter_cust" runat="server" CssClass="form-control" >
                        <asp:ListItem Value="Day" Text="Day"></asp:ListItem>
                        <asp:ListItem Value="Week" Text="Week"></asp:ListItem>
                        <asp:ListItem Value="Month" Text="Month"></asp:ListItem>
                        <asp:ListItem Value="Quarter" Text="Quarter"></asp:ListItem>
                        <asp:ListItem Value="Year" Text="Year"></asp:ListItem>
                        <asp:ListItem Value="Custom" Text="Custom Date"></asp:ListItem>
                    </asp:DropDownList>
                      <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>

                      <asp:HiddenField ID="hdnTimeFilter_cust" runat="server" />
                      <!-- Custom Date Pickers (Initially Hidden) -->
                <div id="customDateFilter_cust" style="display: none;">
                    <label for="startDate">Start Date</label>
                    
                    <asp:TextBox ID="txtStartDate_cust" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    <label for="endDate">End Date</label>
                    
                    <asp:TextBox ID="txtEndDate_cust" class="form-control" TextMode="Date" runat="server"></asp:TextBox>
                </div>
                </div>
                     </div>
                  <div class="col col-md-4">
                      <asp:Button ID="btnCustRecord" runat="server" Text="Generate" OnClick="btnCustRecord_Click"  CssClass="btn btn-primary"/>
                      </div>
                
              </div>
            </div>
            <div class="chart">
                <asp:UpdatePanel ID="updateTopCust" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                    <ContentTemplate>
                       <table class="table table-border table-responsive table-hover">
                           <thead>
                               <tr>
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
                                               <asp:Image ID="imgUserProfile" runat="server" ImageUrl ='<%# Eval("ProfilePicture") %>' Width="100px"/>
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
                               <asp:PlaceHolder ID="phNoCustRecord" runat="server" Visible="false">
                               <tr class="text-center" >
                                   <th colspan="5">
                                       <asp:Label ID="lblNoCust" runat="server" Text="No Customer Record 😕" Font-Size="1.3em"></asp:Label>
                                   </th>
                               </tr>
                               </asp:PlaceHolder>
                           </tbody>
                       </table>
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
       
        
        <div class="row" style="margin-bottom: 20px">
            <div class="col-sm-6 col-md-8 col-xl-6 d-flex order-2">
                <div class="card flex-fill w-100">
                    <div class="card-header">

                        <h5 class="card-title mb-0">Recent Bookings</h5>
                    </div>
                    <div class="card-body d-flex w-100">
                        <div class="align-self-center chart chart-lg" style="width: 80%; margin: 0 auto;">
                            <%--<img style="width:100%" src="../Image/Dashboard/booking.png" />--%>
                            <div class="card mb-3">
                                <div class="card-body p-3">
                                    <div class="chart">
                                        <canvas id="bar-chart" class="chart-canvas" height="300"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-6 col-md-4 col-xl-3 d-flex order-1 order-xxl-1">
                <div class="card flex-fill">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Calendar</h5>
                    </div>
                    <div class="card-body d-flex">
                        <div class="align-self-center w-100">
                            <div class="chart">
                                <div id="datetimepicker-dashboard"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- Top Renting -->
            <div class="col-12" style="width: 75%">
                <div class="card overflow-auto" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; border-radius: 15px;">

                    <div class="card-body pb-0">

                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="card-title">Top 5 Rental <span id="topRentalDay" class="text-muted" style="font-size:0.7em">| All Time</span></h5>

                            <div class="filter">
                                <div id="topRentalRange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 200px;">
                                    <i class="fa fa-calendar" style="vertical-align:middle;"></i>&nbsp;
								<span style="vertical-align:middle;"></span>
                                    <i class="fa fa-caret-down float-end" style="vertical-align:middle;"></i>
                                </div>
                                <asp:HiddenField ID="hdnTopRentalStart" runat="server" />
                                <asp:HiddenField ID="hdnTopRentalEnd" runat="server" />
                                <asp:Button ID="btnTopDateFilter" runat="server" Text="Button" Style="display: none" OnClick="btnTopDateFilter_Click" />
                                <asp:Button ID="btnAllTopRental" runat="server" Text="Button" Style="display: none" OnClick="btnAllTopRental_Click"/>
                            </div>
                        </div>
                        <hr />
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table class="table table-border table-responsive table-hover">
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
                                        <tr class="text-center" >
                                            <th colspan="5"><asp:Label ID="Label1" runat="server" Text="No Car Rented :<" Font-Size="1.3em"></asp:Label></th>
                                        </tr>
                                        </asp:PlaceHolder>
                                    </tbody>
                                </table>
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
            <div class="col-12" style="width:25%">
                <!-- Rent Car Type -->
                <div class="card" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; border-radius: 15px;">

                    <div class="card-body pb-0">
                        <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title">Rent Car Type <span id="carTypeDay" class="text-muted" style="font-size:0.6em">| All Time</span></h5>
                        <div id="carCategoryRange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 50px">
                                    <i class="fa fa-calendar"></i>&nbsp;
								<span></span><i class="fa fa-caret-down"></i>
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
                    $('#topRentalRange span').html("All Time" + '   ');
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
                document.getElementById('topRentalDay').textContent = "| "+ label;
            });

            cb(start, end, true);

        });

        $(function () {
            var start = moment().subtract(2, 'days');
            var end = moment().subtract(2, 'days');

            function cb(start, end, isAll) {

                if (isAll) {
                    filterAllCategory();
                } else {
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
    </script>
    <!-- End Date Picker -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <!-- Theme JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
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
    </script>
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
    <script>
        // Initialize Flatpickr in inline mode
        flatpickr("#datetimepicker-dashboard", {
            inline: true, // Display calendar directly
            dateFormat: "Y-m-d", // Format for the selected date
            altInput: false // Do not show an alternative input
        });
    </script>
     
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
        <script>
            function renderBookingRecordChart(lineData,xAxisTitle,categories,title) {
                console.log("Line data: ", lineData);
                console.log("Category: ",categories);
                $('#bookNumChart').highcharts({
                    chart: {
                       type:'spline'
                    },
                    title: {
                        text: "Summary of Booking Record " + title
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
                    plotOptions:{
                        spline:{
                            dataLabels:{
                                enabled: true
                            },
                            enableMouseTracking: false
                        }
                    },
                    series: [{
                        type: 'spline',
                        name: "Summary of Booking Record",
                        data: lineData // Converts the lineData string to a JavaScript array
                    }]
                });
            }
            function renderBookingAmtChart(lineData, xAxisTitle, categories, title) {
                $('#bookAmtChart').highcharts({
                    chart: {
                        type:'column'
                    },
                    title: {
                        text: "Summary of Booking Amount "+title
                    },
                    xAxis: {
                        title: {
                            text: xAxisTitle
                        },
                        categories: categories // Placeholder
                    },
                    yAxis: {
                        title: {
                            text: "Amount Made"
                        }
                    },
                    plotOptions: {
                        spline: {
                            dataLabels: {
                                enabled: true
                            },
                            enableMouseTracking: false
                        }
                    },
                    series: [{
                        type: 'column',
                        name: "Amount Made",
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

                $('#<%= ddlTimeFilter_cust.ClientID %>').change(function (){
                    var selectedValue = $(this).val();
                    $('#<%= hdnTimeFilter_cust.ClientID%>').val(selectedValue);

                    if (selectedValue === 'Custom') {
                        $('#customDateFilter_cust').show();
                    } else {
                        $('#customDateFilter_cust').hide();
                    }


                });
            });
        </script>
</asp:Content>
