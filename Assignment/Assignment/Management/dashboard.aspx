<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Assignment.Management.dashboard" %>
<asp:Content ID="head" ContentPlaceHolderID="Head" runat="server">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
	<!-- Fonts -->
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <link href="~/CSS/dashboard.css" rel="stylesheet" />
	</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
				<div class="container-fluid p-0">

					<h1 class="text-dark mt-4"><strong>Analytics</strong> Dashboard</h1>
					<hr class="mt-0 mb-4"/>

					<div class="row">
						<div class="col-xl-6 col-xxl-5 d-flex">
							<div class="w-100">
								<div class="row">
									<div class="col-sm-6" >
										<div class="card" style="margin-bottom:20px">
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
										<div class="card" style="margin-bottom:20px">
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
										<div class="card"  style="margin-bottom:20px">
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
										<div class="card" style="margin-bottom:20px">
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

						<div class="col-xl-6 col-xxl-7" style="margin-bottom:20px">
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

					<div class="row" style="margin-bottom: 20px">
						<div class="col-sm-6 col-md-8 col-xl-6 d-flex order-2">
				<div class="card flex-fill w-100">
					<div class="card-header">

						<h5 class="card-title mb-0">Recent Bookings</h5>
					</div>
					<div class="card-body d-flex w-100">
						<div class="align-self-center chart chart-lg" style="width:80%; margin: 0 auto;">
                            <%--<img style="width:100%" src="../Image/Dashboard/booking.png" />--%>
							<div class="card mb-3" >
							  <div class="card-body p-3">
								<div class="chart" >
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
						<div class="col-12 col-lg-8 col-xxl-9 d-flex">
							<div class="card flex-fill"  style="margin-bottom:20px; padding-bottom:10px" >
								<div class="card-header">

									<h5 class="card-title mb-0">Top Customer Booking Lists</h5>
								</div>
								<table class="table table-hover my-0">
									<thead>
										<tr>
											<th>Name</th>
											<th class="d-none d-xl-table-cell">Start Date</th>
											<th class="d-none d-xl-table-cell">End Date</th>
											<th>Booking</th>
											<th class="d-none d-md-table-cell">Quantity</th>
										</tr>
									</thead>
									<tbody class="top-customer">
										<tr>
											<td >Lim Ah Kao</td>
											<td class="d-none d-xl-table-cell">01/01/2023</td>
											<td class="d-none d-xl-table-cell">31/06/2023</td>
											<td><span class="badge bg-success">Top</span></td>
											<td class="d-none d-md-table-cell">30</td>
										</tr>
										<tr>
											<td >Lim Ah Bu</td>
											<td class="d-none d-xl-table-cell">01/01/2023</td>
											<td class="d-none d-xl-table-cell">31/06/2023</td>
											<td><span class="badge bg-success">Second</span></td>
											<td class="d-none d-md-table-cell">28</td>
										</tr>
										<tr>
											<td >Lim Ah Ceh</td>
											<td class="d-none d-xl-table-cell">01/01/2023</td>
											<td class="d-none d-xl-table-cell">31/06/2023</td>
											<td><span class="badge bg-success">Third</span></td>
											<td class="d-none d-md-table-cell">10</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
            <!-- Top Selling -->
            <div class="col-12" style="width:75%">
              <div class="card overflow-auto" style="box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px; border-radius:15px;">

                <div class="card-body pb-0">

				  <div>
                  <h5 class="card-title">Top 5 Rental</h5>

					<div class="filter">
							<div id="reportrange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 200px">
								<i class="fa fa-calendar"></i>&nbsp;
								<span></span> <i class="fa fa-caret-down"></i>
							</div>
						<asp:HiddenField ID="hdnTopRentalStart" runat="server" />
						<asp:HiddenField ID="hdnTopRentalEnd" runat="server" />
						<asp:Button ID="btnTopDateFilter" runat="server" Text="Button" style="display:none" OnClick="btnTopDateFilter_Click"/>
					</div>
					</div>
				<hr />
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
                        <asp:Repeater ID="rptTopRental" runat="server" DataSourceID="TopRental">
                            <ItemTemplate>
                                <tr>
                                    <td scope="col" class="text-center" style="width:250px;">
										<div class="topRentalImageFrame">
										<asp:Image ID="imgCarTopPic" runat="server" ImageUrl='<%# Eval("Image") %>' Width="120px" CssClass="mx-auto" />
										</div>
										</td>

                                    <td scope="col"><asp:Label ID="lblCarName" runat="server" Text='<%# Eval("CarName") %>'/></td>

                                    <td scope="col"><asp:Label ID="lblDayPrice" runat="server" Text='<%# Eval("Price") %>'/></td>

                                    <td scope="col"><asp:Label ID="lblRentalCount" runat="server" Text='<%# Eval("RentalCount") %>'/></td>

                                    <td scope="col"><asp:Label ID="lblTotalRevenue" runat="server" Text='<%# Eval("TotalRevenue") %>'/></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                        <asp:SqlDataSource
                            runat="server"
                            ID="TopRental"
                            ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>'
                            SelectCommand="SELECT TOP 5 
									COUNT(B.CarPlate) AS RentalCount, 
									MAX(C.CarImage) AS Image,
									AVG(C.CarDayPrice) AS Price,
									SUM(B.Price) AS TotalRevenue, 
									(C.CarBrand + ' ' + C.CarName) AS CarName 
								FROM [Car] C 
								JOIN [Booking] B ON C.CarPlate = B.CarPlate 
								GROUP BY C.CarBrand, C.CarName 
								ORDER BY COUNT(B.CarPlate) DESC;"></asp:SqlDataSource>
                    </tbody>
                  </table>

                </div>

              </div>
            </div>
	<!-- End Top Selling -->
				</div>
	<!--Start Date Picker -->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<script type="text/javascript">
		$(function () {

			var start = moment();
			var end = moment();

			function cb(start, end, triggerclick) {
				$('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));

				document.getElementById('<%=hdnTopRentalStart.ClientID %>').value = start.format('YYYY-MM-DD');
				document.getElementById('<%=hdnTopRentalEnd.ClientID %>').value = end.format('YYYY-MM-DD');

				if (triggerclick) {
					document.getElementById('<%=btnTopDateFilter.ClientID %>').click();
				}
			}

			$('#reportrange').daterangepicker({
				startDate: start,
				endDate: end,
				ranges: {
					'Today': [moment(), moment()],
					'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
					'Last 7 Days': [moment().subtract(6, 'days'), moment()],
					'Last 30 Days': [moment().subtract(29, 'days'), moment()],
					'This Month': [moment().startOf('month'), moment().endOf('month')],
					'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
				}
			}, function (start, end) {
                cb(start, end, true);
			});

			cb(start, end, false);

		});
    </script>
	<!-- End Date Picker -->
	<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>    
	<!-- Theme JS -->
	<script src="../argon-dashboard-master/assets/js/argon-dashboard.min.js"></script>
    <script src="../argon-dashboard-master/assets/js/plugins/chartjs.min.js"></script>
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
</asp:Content>
