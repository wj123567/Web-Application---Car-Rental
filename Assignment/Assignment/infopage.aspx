<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="infopage.aspx.cs" Inherits="Assignment.infopage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="CSS/stickybar.css" rel="stylesheet" />
    <asp:HiddenField ID="hdnSessionId" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="modal fade" id="infoPgModal" tabindex="-1" aria-labelledby="infoPgModalLabel" data-bs-backdrop="static" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered ">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title mx-auto fs-3 fw-bold text-info">Reminder</h5>
     
            </div>
            <div class="modal-body fs-5 text-dark">
                <p>Login / Register an account before booking a car.</p>
            </div>
            <div class="modal-footer">
                <asp:Button ID="modalOkBtn" runat="server" CssClass="btn btn-primary" Text="Ok" data-bs-dismiss="modal" OnClientClick="redirectToHome(); return false;"/>
            </div>

       </div>
    </div>
</div>

    

        <section class="info_head_container">
 
         <div class="container-fluid">
	<div class="row justify-content-center">
		<div class="col-11 col-sm-9 col-md-7 col-lg-6 col-xl-5 text-center p-0 mt-3 mb-2">
            <div class="card px-0 pt-4 pb-0 mt-3 mb-3">

                    <!-- progressbar -->
                    <ul id="progressbar">
                        <li id="bar_vehicle" class="active">Vehicle</li>
                        <li id="bar_addon" class="active">Add-ons</li>
                        <li id="bar_driver_info">Driver Info</li>
                        <li id="bar_payment">Payment</li>
                    </ul>
                    <br/>

            </div>
        </div>
	</div>
</div>
    </section>

    
    
    <section class="info_banner">
        
            <div class="col_left ">
                <div class="image-frame">
                <asp:Image ID="carImage"  cssclass="header_carimg" runat="server" />
                </div>  
            </div>

            <div class="col_right d-flex flex-column">
                <table class="spec_container">
                    <tr class="car_model">
                    <th class="header_car_model" colspan="4">
                        <asp:Literal ID="headerCarModel" runat="server"></asp:Literal> </th>
                    </tr>
                    <tr class="carPlate_style" >
                        <td colspan="4">Plate Number: <asp:Literal ID="ltrCarPlate" runat="server" Text=""></asp:Literal></td>
                    </tr>

                    <tr class="spec_title">
                        <td colspan="4">Specs</td>
                    </tr>
                    <tr class="spec_icon">
                        <td><i class="ri-roadster-fill"></i></td>
                        <td><i class="ri-sofa-fill"></i></td>                  
                        <td><i class="ri-settings-3-fill"></i></td>
                        <td><i class="ri-flashlight-fill"></i></td>
                    </tr>
                    <tr class="spec_detail">
                        <td><asp:Literal ID="specType" runat="server"></asp:Literal></td>
                        <td><asp:Literal ID="specSeat" runat="server"></asp:Literal></td>   
                        <td><asp:Literal ID="specTransmission" runat="server"></asp:Literal></td>
                        <td><asp:Literal ID="specFuel" runat="server"></asp:Literal></td>

                    </tr>
                </table>

                <%-- you --%>
                <div class="review-container d-flex flex-column">
                    <h1 style="font-weight: 800;">Review &nbsp;
                        <span style="font-size:20px; vertical-align:middle;">
                            <asp:Label ID="lblTotalReview" runat="server" Text=""></asp:Label>
                        </span>
                    </h1>
                    <div class="reviewrow-1  d-flex flex-row">
				        <div class="rating-block">
                            <h2>Average user rating</h2>
                            <h3 class="bold padding-bottom-7">
                                <asp:Label ID="lblAverageRating" runat="server" Text="Label"></asp:Label> <small>/ 5</small>
                            </h3>
                            <div id="star-container">
                                <span class="fa fa-star star"></span>
                                <span class="fa fa-star star"></span>
                                <span class="fa fa-star star"></span>
                                <span class="fa fa-star star"></span>
                                <span class="fa fa-star star"></span>
                            </div>
                        </div>

                        <div class="rating-line">
                            <h2>Rating breakdown</h2>
                            <%-- 5 --%>
                            <div class="rateline d-flex">
                                <div class="left-progress" style="line-height:1;">
                                    <div style="height:9px; margin:5px 5px;">5 
                                        <span class="fa fa-star checked"></span>
                                    </div>
                                </div>
                                <div class="progress" style="width:50%; height: 10px; margin:10px 5px;">
                                    <div class="progress-bar bg-dark" role="progressbar" 
                                         style='<%= "width: " + (ViewState["FiveStarPercentage"] != null ? ViewState["FiveStarPercentage"] + "%" : "0%") %>;'
                                         aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                                <div class="right-progress">
                                    <p style="line-height:1; margin:5px 5px;"><%= ViewState["FiveStarCount"] ?? 0 %></p>
                                </div>
                            </div>
                            <%-- 4 --%>
                            <div class="rateline d-flex">
                                <div class="left-progress" style="line-height:1;">
                                    <div style="height:9px; margin:5px 5px;">4 
                                        <span class="fa fa-star checked"></span>
                                    </div>
                                </div>
                                <div class="progress" style="width:50%; height: 10px; margin:10px 5px;">
                                    <div class="progress-bar bg-dark" role="progressbar" 
                                         style='<%= "width: " + (ViewState["FourStarPercentage"] != null ? ViewState["FourStarPercentage"] + "%" : "0%") %>;'
                                         aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                                <div class="right-progress">
                                    <p style="line-height:1; margin:5px 5px;"><%= ViewState["FourStarCount"] ?? 0 %></p>
                                </div>
                            </div>
                            <%-- 3 --%>
                            <div class="rateline d-flex">
                                <div class="left-progress" style="line-height:1;">
                                    <div style="height:9px; margin:5px 5px;">3 
                                        <span class="fa fa-star checked"></span>
                                    </div>
                                </div>
                                <div class="progress" style="width:50%; height: 10px; margin:10px 5px;">
                                    <div class="progress-bar bg-dark" role="progressbar" 
                                         style='<%= "width: " + (ViewState["ThreeStarPercentage"] != null ? ViewState["ThreeStarPercentage"] + "%" : "0%") %>;'
                                         aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                                <div class="right-progress">
                                    <p style="line-height:1; margin:5px 5px;"><%= ViewState["ThreeStarCount"] ?? 0 %></p>
                                </div>
                            </div>
                            <%-- 2 --%>
                            <div class="rateline d-flex">
                                <div class="left-progress" style="line-height:1;">
                                    <div style="height:9px; margin:5px 5px;">2 
                                        <span class="fa fa-star checked"></span>
                                    </div>
                                </div>
                                <div class="progress" style="width:50%; height: 10px; margin:10px 5px;">
                                    <div class="progress-bar bg-dark" role="progressbar" 
                                         style='<%= "width: " + (ViewState["TwoStarPercentage"] != null ? ViewState["TwoStarPercentage"] + "%" : "0%") %>;'
                                         aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                                <div class="right-progress">
                                    <p style="line-height:1; margin:5px 5px;"><%= ViewState["TwoStarCount"] ?? 0 %></p>
                                </div>
                            </div>
                            <%-- 1 --%>
                            <div class="rateline d-flex">
                                <div class="left-progress" style="line-height:1;">
                                    <div style="height:9px; margin:5px 5px;">1 
                                        <span class="fa fa-star checked"></span>
                                    </div>
                                </div>
                                <div class="progress" style="width:50%; height: 10px; margin:10px 5px;">
                                    <div class="progress-bar bg-dark" role="progressbar" 
                                         style='<%= "width: " + (ViewState["OneStarPercentage"] != null ? ViewState["OneStarPercentage"] + "%" : "0%") %>;'
                                         aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
                                    </div>
                                </div>
                                <div class="right-progress">
                                    <p style="line-height:1; margin:5px 5px;"><%= ViewState["OneStarCount"] ?? 0 %></p>
                                </div>
                            </div>

	                    </div>
                    </div>

                    <asp:UpdatePanel ID="UpdatePanelComments" runat="server">
                        <ContentTemplate>
                            <div class="comment-sort d-flex flex-row justify-content-between align-items-center">
                                <div class="comment-sort1"><b>Product Reviews</b></div>
                                <div class="dropdown comment-sort2">
                                    <asp:DropDownList ID="ddlFilterStar" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterStar_SelectedIndexChanged" CssClass="filterComments">
                                        <asp:ListItem Value="Recent" Text="Most Recent" />
                                        <asp:ListItem Value="HighToLow" Text="Highest Rating" />
                                        <asp:ListItem Value="LowToHigh" Text="Lowest Rating" />
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <asp:ListView ID="lvComments" runat="server">
                                <ItemTemplate>
                                    <div class="comment-user d-flex flex-row">
                                        <div class="card text-center comment-user-left" style="flex: 1;">
                                            <img src='<%# Eval("profilePicture") %>' alt="Profile Picture" class="profilePic"/>
                                            <p style="font-size: clamp(12px, 3vh, 18px); font-weight:bold; margin-top:20px; "><%# Eval("ReviewDate", "{0:dd/MM/yyyy HH:mm}") %></p>
                                        </div>

                                        <div class="d-flex flex-column vh-80" style="margin-left: 15px; flex:3">
                                            <div class="d-flex flex-row justify-content-between mb-3"  style="margin-bottom: 20px">
                                                <div class=""><a href="#" style="font-size: 20px;"><strong><%# Eval("Username") %></strong></a>
                                                </div>
                                                <div>
                                                    <span class="rating">
                                                        <%# GetStarRating((int)Eval("Rating")) %> 
                                                    </span>
                                                </div>                          
                                            </div>
                                            <div class="review-text mb-3">
                                                <p><%# Eval("ReviewText") %></p>
                                            </div>
                                            <div class="align-self-end mt-auto">
                                                <a class="btn text-white btn-danger"> <i class="fa fa-heart"></i> Like</a>
                                            </div>
                                        </div>
                                    </div>

                                </ItemTemplate>

                                <LayoutTemplate>
                                    <%-- customer comment section --%>
                                    <div class="container-md" id="itemPlaceHolder" runat="server">
                                    </div>
                                </LayoutTemplate>
                            </asp:ListView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                 </div>
            </div>
    </section>



    <section class="info_body_container"> 
        <div class="left-side">
            <div class="box_left addon_box">
                 <div class="addon_header" style="margin-bottom:20px;">
                     <i class="ri-add-circle-line"></i><span>Add On</span>
                    </div> 

                <asp:Repeater ID="rptAddOns" runat="server">
                <HeaderTemplate>
                <table class="addon_container">
  
                    <tr class="addon_title" >
                        <th style="width:10%" class="addon_icon_header"></th>
                        <th style="width:50%;padding-left:5%;" class="addon_type_header">Type</th>
                        <th style=" width:20%; text-align:center;" class="addon_price_header">Price</th>
                        <th style=" width:20%; text-align:center; "class="addon_quantity_header">Quantity</th>
                    </tr>
                 </HeaderTemplate>
                  <ItemTemplate>
                    <tr class="addon_list">
                        <td rowspan="2"><asp:Image ID="imgIcon" runat="server" Width="45px" Height="45px" ImageUrl='<%# Eval("Url") %>' /></td>
                        <td class="addon_list_title"><%# Eval("Name") %></td>
                        <td class="text_center" data-price='<%# Eval("Price") %>'> <asp:Label ID="lblAddOnPrice" runat="server" Text='<%# Eval("Price","{0:F2}") %>'></asp:Label></td>
                        
                        <td rowspan="2" style="text-align:center">
                            <asp:TextBox ID="txtAddOnQuantity" runat="server" TextMode="Number" CssClass="quantity_style quantity_input" min="0" max='<%# Eval("MaxQuantity") %>' value="0" ></asp:TextBox>
                             <asp:HiddenField ID="hfAddOnID" runat="server" Value='<%# Eval("Id") %>' />
                        </td>
                    </tr>
                    <tr class="addon_list">
                        <td class="addon_subinfo"><%# Eval("Description") %></td>
                    </tr>
                    <tr class="separator">
                        <td style="visibility:hidden">a</td>
                    </tr>
                   
                    </ItemTemplate>

                     <FooterTemplate>
                    <tr>
                        <td class="end_text" colspan="3">TOTAL(RM)</td>
                        <td class="end_text addon_total">
                            <asp:Label ID="lblTotalAddOn" runat="server" Text="0.00"></asp:Label> 
                           
                        </td>
                    </tr>

                    <tr class="separator">
                       <td style="visibility:hidden">a</td>                 
                    </tr> 
                </table>
                </FooterTemplate>
                </asp:Repeater>
           
        </div>
            <div class="box_left">
                Box 2 - Left

            </div>

            <div class="box_left">
                Box 3 - Left

            </div>

    </div>
        <div class="right-side">
            <div class="box_right">
                <div class="pickup_container" style="margin-bottom:20px;">
                    <h6 class="pickup_title">Pickup & Return</h6>
                </div>

                <table class="pickup_table">

                    <tr >
                        <td></td>
                        <td class="timeline StartDateSes"><%= DateTime.Parse(Session["StartDate"].ToString()) %></td>
                    </tr>
                    <tr>
                        <td><i class="ri-circle-line" style="color:green"> </i></td>
                        <td class="PickupPointSes"><%=Session["Pickup_point"] %></td>
                    </tr>

                    <tr>
                        <td></td>
                        <td style="padding-bottom:20px;">(Pickup point)</td>
                    </tr>
               
                    <tr>
                        <td></td>
                        <td class="timeline StartDateSes" ><%=DateTime.Parse(Session["EndDate"].ToString()) %></td>
                    </tr>
                    <tr>
                        <td><i class="ri-map-pin-2-line" style="color:red"></i></td>
                        <td class="DropoffPointSes"><%=Session["Dropoff_point"] %></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-bottom:20px;">(Drop off point)</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            Rental Period:<asp:Label ID="lblTotalDayRent" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
                
                
            </div>
            <div class="box_right">
                <h6 class="charge_title">Summary of Charges</h6>
                <div class="charges_summary">
                    <div class="charge_item">
                    <p class="summary_title">Rental</p>
                      <asp:Label ID="lblCarRental" runat="server" CssClass="summary_amt rental_amt" Text=""></asp:Label>

                    </div>
                    <hr />
                    <div class="charge_item">
                    <p class="summary_title">Add-ons</p>
                        <asp:Label ID="lblAddOnPrice" runat="server" CssClass="summary_amt summary_add_on" Text="0.00"></asp:Label>
                         <asp:HiddenField ID="hdnTotalAddOn" runat="server" />
                    </div>

                    <hr />
                    <div class="charge_item">
                    <p class="summary_title">Rental</p>
                    <p class ="summary_amt">0.00</p>
                    </div>
                    <hr />
                   
                    <div class="charge_item summary_total">
                    <p class="summary_title">Total (MYR):</p>
                     <asp:Label ID="lblTotalPrice" runat="server" Text="0.00" CssClass="summary_amt grand_total"></asp:Label>
                    <asp:HiddenField ID="hdnTotalPrice" runat="server" />
                    </div>
                </div>

            </div>
            
        </div>
    </section>

<div class="sticky_bar">
    <div class="container-fluid">
        <div class="row align-items-center justify-content-between bar_content">
            
            <!-- Left Side: Previous Button, Car Image, and Car Information -->
            <div class="d-flex col-auto align-items-center">
                <div class="previous_button">
                    <asp:Button ID="previous_btn" runat="server" Text="Previous" cssclass="previous_btn_style btn btn-primary" OnClick="previous_btn_Click" />
                </div>
                <div class="d-flex align-items-center ms-3 selected_car">
                    <div class="selected_car_frame">
                    <asp:Image ID="imgSticky" runat="server" cssclass="sticky_bar_carimg img-fluid me-3"/>
                    </div>
                    <div class="d-flex flex-column">
                        <span class="title_style">Selected Car</span>
                        <asp:Label ID="lblstickyCarModel" CssClass="sticky_car_info" runat="server" Text=""></asp:Label>
                    </div>
                </div>
            </div>
            
            <!-- Right Side: Price Details and Next Button -->
            <div class="d-flex col-auto align-items-center justify-content-end">
                <div class="price_details text-end me-3">
                    <p>Grand Total</p>
                    <asp:Label ID="lblStickyTotalPrice" runat="server" Text="0.00" CssClass="sticky_bar_price"></asp:Label>
                </div>
                <div class="next_button">
                    <asp:Button ID="btnNext" runat="server" Text="Next" cssclass="next_btn_style btn btn-primary" OnClick="btnNext_Click" />
                </div>
            </div>
        </div>
    </div>
</div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            function updateTotal() {
                let total = 0.00;
                const quantities = document.querySelectorAll('.quantity_input');

                quantities.forEach(input => {   //when updateTotal is called, calculate again the total price in this code block
                    const price = parseFloat(input.closest('tr').querySelector('.text_center[data-price]').dataset.price);
                    const quantity = parseInt(input.value);
                    total += price * quantity;      //add on continuously

                });

                document.querySelector('.addon_total').textContent = total.toFixed(2);  //decimal place
                document.getElementById('<%= hdnTotalAddOn.ClientID %>').value = total.toFixed(2);
                // Update the total in the summary_add_on element
                document.querySelector('.summary_add_on').textContent = total.toFixed(2);

                // Static rental amount
                const rentalAmount = parseFloat(document.querySelector('.rental_amt').textContent);
                // Calculate the grand total
                const grandTotal = rentalAmount + total;
                const grandTotalToFixed = grandTotal.toFixed(2);

                document.getElementById('<%= hdnTotalPrice.ClientID %>').value = grandTotal.toFixed(2);

                // Update the grand total in the summary_total element
                document.querySelector('.grand_total').textContent = grandTotalToFixed;

                //save the grandTotal
                localStorage.setItem("grandTotal", grandTotalToFixed);

                var grandTotalSupplier = document.querySelector('.grand_total');
                if (grandTotalSupplier) {
                    localStorage.setItem("grandTotal", grandTotalSupplier.textContent);
                }
                var stickyBarPrice = document.querySelector(".sticky_bar_price");
                if (stickyBarPrice) {
                    var getGrandTotal = localStorage.getItem("grandTotal");
                    stickyBarPrice.textContent = "RM" + getGrandTotal;

                }


            }


            // Add event listeners to quantity inputs
            document.querySelectorAll('.quantity_input').forEach(input => {
                input.addEventListener('input', updateTotal);       //call the updateTotal every time user change on the quantity(fires everytime input change)
            });

            // Initial calculation on page load to set initial total value
            updateTotal();

        });

        
        function updateProgressBar(step) {
            const steps = ['bar_vehicle', 'bar_addon', 'bar_driver_info', 'bar_payment'];
            steps.forEach((id, index) => {
                const element = document.getElementById(id);
                if (index < step) {
                    element.classList.add('active');
                } else {
                    element.classList.remove('active');
                }
            });
        }
        

        document.addEventListener('DOMContentLoaded', function () {
            // Select all quantity inputs
            var quantityInputs = document.querySelectorAll('.quantity_input');

            quantityInputs.forEach(function (input) {
                input.addEventListener('keypress', function (event) {
                    event.preventDefault(); // Prevent typing in the input field
                });
            });
        });

        function loadModal() {
            document.addEventListener("DOMContentLoaded", modal);
           
        }

        function modal() {
            addEventListener("DOMContentLoaded", (event) => {
                $('#infoPgModal').modal('toggle');
                return false;
            });
        };

        function closeModal() {
            var myModal = new bootstrap.Modal(document.getElementById('infoPgModal'));
            myModal.hide();
        }

        function redirectToHome() {
            window.location.href = 'Home.aspx';
        }

        function handleButtonClick() {
            var sessionId = '<%= Session["Id"] %>'.trim(); // Get session id and trim any extra whitespace
            console.log("Session ID:", sessionId); // Debugging line

            if (sessionId === '' || sessionId === 'null') {
                modal(); // Show the modal if session id is empty or 'null'
                return false;

            } else {
                window.location.href = 'bookinfo.aspx'; // Redirect to another page if session id is set
                return false; // Ensure default action is allowed for redirection
            }
        }

        //you
        function updateStarDisplay(averageRating) {
            const stars = document.querySelectorAll('#star-container .star');
            stars.forEach((star, index) => {
                if (index < Math.floor(averageRating)) {
                    star.classList.add('checked'); // Fully filled star
                } else if (index < Math.ceil(averageRating) && averageRating % 1 !== 0) {
                    star.classList.add('half-checked'); // half-filled star
                } else {
                    star.classList.remove('checked'); // Empty star
                }
            });
        }

    </script>
</asp:Content>
