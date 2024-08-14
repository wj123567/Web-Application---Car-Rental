<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="infopage.aspx.cs" Inherits="Assignment.infopage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

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
        
            <div class="col_left">
                <asp:Image ID="carImage"  cssclass="header_carimg" runat="server" />
            </div>

            <div class="col_right">
                <table class="spec_container">
                    <tr class="car_model">
                    <th class="header_car_model" colspan="4">
                        <asp:Literal ID="headerCarModel" runat="server"></asp:Literal> </th>
                    </tr>
                    <tr class="carPlate_style" >
                        <td colspan="4"><asp:Literal ID="ltrCarPlate" runat="server"></asp:Literal></td>
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
 

                <asp:Repeater ID="rptAddOns" runat="server">
                <HeaderTemplate>
                <table class="addon_container">
  
                    <tr class="addon_title">
                        <th style="width:10%"></th>
                        <th style="width:50%"></th>
                        <th style=" width:20%; text-align:center; ">Price</th>
                        <th style=" width:20%; text-align:center; ">Quantity</th>
                    </tr>
                 </HeaderTemplate>
                  <ItemTemplate>
                    <tr class="addon_list">
                        <td rowspan="2"><asp:Image ID="imgIcon" runat="server" Width="30px" Height="30px" ImageUrl='<%# Eval("Url") %>' /></td>
                        <td class="addon_list_title"><%# Eval("Name") %></td>
                        <td class="text_center" data-price='<%# Eval("Price") %>'><%# Eval("Price","{0:F2}") %></td>
                        <td rowspan="2" style="text-align:center">
                            <asp:TextBox ID="txtAddOnQuantity" runat="server" TextMode="Number" CssClass="quantity_style quantity_input" min="0" max='<%# Eval("MaxQuantity") %>' value="0"></asp:TextBox>

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
                            <asp:Label ID="lblAddOnPrice" runat="server" Text="0.00"></asp:Label></td>
                    </tr>

                    <tr class="separator">
                       <td style="visibility:hidden">a</td>                 
                    </tr> 
                </table>
                </FooterTemplate>
                </asp:Repeater>
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
                            <asp:Label ID="lblTotalDayRent" runat="server" Text=""></asp:Label></td>
                    </tr>
                </table>
                
                
            </div>
            <div class="box_right">
                <h6 class="charge_title">Summary of Charges</h6>
                <div class="charges_summary">
                    <div class="charge_item">
                    <p class="summary_title">Rental</p>
                    <asp:Literal ID="carRental" runat="server"></asp:Literal>

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
        <asp:Image ID="imgSticky" runat="server" cssclass="sticky_bar_carimg" />
            
            <div >
                <span class="title_style">Selected Car</span>
                <asp:Label ID="lblstickyCarModel" CssClass="sticky_car_info" runat="server" Text=""></asp:Label>
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
