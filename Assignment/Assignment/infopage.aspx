<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="infopage.aspx.cs" Inherits="Assignment.infopage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

        <section class="info_head_container">
  <!--   
        <div class="header">
            <div class="location">
                <div class="infopg_pickup">
                    <h3 >Penang Downtown</h3>
                    <p class="StartDateSes"><%=Session["bookingID"] %></p>
                </div>
                <div class="arrow">&gt;</div>
                <div class="infopg_dropoff">
                    <h3>Penang Downtown</h3>
                    <p>Fri, Jul 26, 2024, 10:00</p>
                </div>
            </div>
            <div class="info">
                <i class="ri-info-i"> You’ll need to pick up your car at 10:00</i>
            </div>
            <div class="edit">
                 <asp:Button ID="btnEdit" runat="server" Text="Edit" CSSClass="edit-button" />
            </div>
        </div>
    -->    
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
        
            <div class="col_left">
                <img src="Image/WZ/pexels-mikebirdy-170811.jpg" class="header_carimg" alt="" />
            </div>

            <div class="col_right">
                <table class="spec_container">
                    <tr class="car_model">
                    <th class="header_car_model" colspan="7">Perodua Alza (2nd Gen) 1.5 (A)</th>
                    </tr>

                    <tr class="spec_title">
                        <td colspan="7">Specs</td>
                    </tr>
                    <tr class="spec_icon">
                        <td><i class="ri-group-line"></i></td>
                        <td><i class="ri-luggage-deposit-line"></i></td>
                        <td><img width="20" height="20" src="https://img.icons8.com/ios/50/speed--v1.png" alt="speed--v1" style="display:block; margin:auto;"/></td>
                        <td><i class="ri-snowflake-line"></i></td>
                        <td><img width="20" height="20" src="https://img.icons8.com/external-solid-design-circle/64/external-Car-Gear-car-parts-solid-design-circle.png" alt="car gear"/ style=" display:block; margin:auto;"></td>
                        <td><img width="20" height="20" src="https://img.icons8.com/ios/50/gas-station.png" alt="gas station" style=" display:block; margin:auto;"/></td>
                        <td><i class="ri-oil-line"></i></td>
                    </tr>
                    <tr class="spec_detail">
                        <td>7 People</td>
                        <td>2 Luggage</td>
                        <td>Unlimited Mileage</td>
                        <td>Yes</td>
                        <td>Auto</td>
                        <td>Full Tank</td>
                        <td>Petrol</td>

                    </tr>
                </table>

                <table class="review_container">
                    <tr>
                        <th>Review</th>
                    </tr>
                </table>
            </div>
       
    </section>

    <section class="info_body_container"> 
        <div class="left-side">
            <div class="box_left">
                 <div class="addon_header">
                     <i class="ri-add-circle-line"></i><span>Add On</span>
 
                <table class="addon_container">
                    
                   
                    <tr class="addon_title">
                        <th style="width:10%"></th>
                        <th style="width:50%"></th>
                        <th style=" width:20%; text-align:center; ">Price</th>
                        <th style=" width:20%; text-align:center; ">Quantity</th>
                    </tr>
                    <tr class="addon_list">
                        <td rowspan="2"><img width="30" height="30" src="https://img.icons8.com/ios/50/car-crash.png" alt="car-crash"/></td>
                        <td class="addon_list_title">Liability Reduction Option (LRO)</td>
                        <td class="text_center" data-price="20.00">20.00</td>
                        <td rowspan="2" style="text-align:center">
                            <asp:TextBox ID="txtQuantity1" runat="server" TextMode="Number" CssClass="quantity_style quantity_input" min="0" max="1" value="0"></asp:TextBox>

                        </td>
                    </tr>
                    <tr class="addon_list">
                        <td class="addon_subinfo">Recommended to reduce an excess and liability for major accident or vehicle loss</td>
                    </tr>
                    <tr class="separator">
                        <td style="visibility:hidden">a</td>
                    </tr>
                    <!-- next -->
                     <tr class="addon_list">
                        <td rowspan="2"><i class="ri-group-line" style="text-align:center;vertical-align:middle;height:100%"></i></td>
                        <td class="addon_list_title">Additional Driver</td>
                        <td class="text_center" data-price="20.00">20.00</td>
                        <td rowspan="2" style="text-align:center">
                            <asp:TextBox ID="txtQuantity2" runat="server" TextMode="Number" CssClass="quantity_style quantity_input" min="0" max="3" step="1" value="0"></asp:TextBox>
                            
                        </td>
                     </tr>
                     <tr class="addon_list">
                         <td class="addon_subinfo">Mandatory to purchase for second driver and above</td>
                     </tr>
                     <tr class="separator">
                        <td style="visibility:hidden">a</td>                 
                     </tr> 
                   
                    <!-- next -->
                    <tr class="addon_list">
                       <td rowspan="2"><img width="30" height="30" src="https://img.icons8.com/windows/32/baby-car-seat.png" alt="baby-car-seat"/></td>
                       <td class="addon_list_title">Child Seat (Non-Isofix)</td>
                       <td class="text_center" data-price="15.00">15.00</td>
                       <td rowspan="2" style="text-align:center">
                           <asp:TextBox ID="txtQuantity3" runat="server" TextMode="Number" CssClass="quantity_style quantity_input" min="0" max="2" step="1" value="0">

                           </asp:TextBox></td>
                    </tr>
                    <tr class="addon_list">
                        <td class="addon_subinfo">*Subject to availability - Age 1~3y with max. 15kg.</td>
                    </tr>
                    <tr class="separator">
                       <td style="visibility:hidden">a</td>                 
                    </tr> 
                    
                    <tr>
                        <td class="end_text" colspan="3">TOTAL(RM)</td>
                        <td class="end_text addon_total">0.00</td>
                    </tr>

                    <tr class="separator">
                       <td style="visibility:hidden">a</td>                 
                    </tr> 
                </table>

        </div>    
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
                        <td class="timeline StartDateSes"><%=Session["StartDate"] %></td>
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
                        <td class="timeline StartDateSes" ><%=Session["EndDate"] %></td>
                    </tr>
                    <tr>
                        <td><i class="ri-map-pin-2-line" style="color:red"></i></td>
                        <td class="DropoffPointSes"><%=Session["Dropoff_point"] %></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-bottom:20px;">(Drop off point)</td>
                    </tr>
               
                </table>
                
                
            </div>
            <div class="box_right">
                <h6 class="charge_title">Summary of Charges</h6>
                <div class="charges_summary">
                    <div class="charge_item">
                    <p class="summary_title">Rental</p>
                    <p class ="summary_amt rental_amt" >300.00</p>
                    </div>
                    <hr />
                    <div class="charge_item">
                    <p class="summary_title">Add-ons</p>
                    <p class ="summary_amt summary_add_on">0.00</p>
                    </div>
                    <hr />
                    <div class="charge_item">
                    <p class="summary_title">Rental</p>
                    <p class ="summary_amt">0.00</p>
                    </div>
                    <hr />
                    <div class="charge_item">
                    <p class="summary_title">Rental</p>
                    <p class ="summary_amt">0.00</p>
                    </div>
                    <hr />
                    <div class="charge_item summary_total">
                    <p class="summary_title">Total Price(RM):</p>
                    <p class="summary_amt grand_total"><span><sub>approx</sub></span>0.00</p>
                    </div>
                </div>

            </div>
            <div class="box_right">Box 3 - Right</div>
        </div>
    </section>

    <div class="sticky_bar">

         <div class="bar_content">
              <div class="previous_button">
    <asp:Button ID="previous_btn" runat="server" Text="Previous" cssclass="previous_btn_style prev_btn" OnClick="previous_btn_Click" />
</div>
        <div class="selected_car">
            <img src="" class="sticky_bar_carimg" alt="Selected Car">
            <div>
                <span>Selected Car</span>
                <h4 class="sticky_bar_car_model"></h4>
            </div>
        </div>
        <div class="price_details">
            <div>
                <p>Grand Total</p>
                
            </div>
            <div>
                <span class="sticky_bar_price"></span>
            </div>
        </div>
        <div class="next_button">
            <asp:Button ID="btnNext" runat="server" Text="Next" cssclass="next_btn_style next_btn" OnClick="btnNext_Click"/>
        </div>
    </div>
</div>

</asp:Content>
