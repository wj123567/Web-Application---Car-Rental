<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookinfo.aspx.cs" Inherits="Assignment.bookinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

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

    <div class="payment_section">
            <div class="payment_container">
                
                <div class="row">
    
                    <div class="col">
                        <h3 class="title">CUSTOMER DETAIL</h3>
    
    
                        <div class="inputbox_left">
                            <asp:Label ID="lblName" runat="server" Text="Name :" CssClass="label_left"></asp:Label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="input_left"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter [Name]." CssClass="validate" ControlToValidate="txtName" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
    
    
                        <div class="inputbox_left">
                            <asp:Label ID="lblEmail" runat="server" Text="Email Address : " CssClass="label_left"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="input_left" TextMode="Email"></asp:TextBox>
                            <br />
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter [Email Address]." CssClass="validate" ControlToValidate="txtEmail" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
    
    
                        <div class="inputbox_left">
                            <asp:Label ID="lblAddress" runat="server" Text="Residential Address :" CssClass="label_left"></asp:Label>
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" CssClass="input_full"></asp:TextBox>
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Please Enter [Residential Address]." CssClass="validate" ControlToValidate="txtAddress" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>
    
                    <div class="col">

                        <div class="inputbox_right" style="padding-top:60px;">
                            <asp:Label ID="lblCountryOrigin" runat="server" Text="Country of Origin : " CssClass="label_right"></asp:Label>
                            <asp:DropDownList ID="ddlCountry" runat="server" CssClass="input_right">
                                <asp:ListItem Value="default" Selected="true" disabled="True">Please Select a Country</asp:ListItem>
                                <asp:ListItem Value="ZW">Zimbabwe</asp:ListItem>

                            </asp:DropDownList>
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Please Select [Country]." CssClass="validate" ControlToValidate="ddlCountry" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
    
                        <div class="inputbox_select">
                            <asp:Label ID="lblPhoneNum" runat="server" Text="Phone Number : " CssClass="label_right"></asp:Label>
                                <asp:TextBox ID="txtPhoneNum" runat="server" CssClass="input_right"></asp:TextBox>
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter [Phone Number]." CssClass="validate" ControlToValidate="txtPhoneNum" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
    
                        <div class="inputbox_right">
                            <asp:Label ID="lblDestination" runat="server" Text="Destination in Malaysia: " CssClass="label_right"></asp:Label>
                            <asp:DropDownList ID="ddlDestination" runat="server" CssClass="input_right">
                                <asp:ListItem Value="default" Selected="True" disabled="True">Select your Destination</asp:ListItem>
                                <asp:ListItem Value="PNG">Penang</asp:ListItem>
                                <asp:ListItem Value="KDH">Kedah</asp:ListItem>
                                <asp:ListItem Value="TRG">Terengganu</asp:ListItem>
                                <asp:ListItem Value="JHR">Johor</asp:ListItem>
                                <asp:ListItem Value="NSN">Negeri Sembilan</asp:ListItem>
                                <asp:ListItem Value="MLK">Melaka</asp:ListItem>
                                <asp:ListItem Value="PHG">Pahang</asp:ListItem>
                                <asp:ListItem Value="KTN">Kelantan</asp:ListItem>
                                <asp:ListItem Value="PRK">Perak</asp:ListItem>
                                <asp:ListItem Value="PLS">Perlis</asp:ListItem>
                                <asp:ListItem Value="SBH">Sabah</asp:ListItem>
                                <asp:ListItem Value="SWK">Sarawak</asp:ListItem>
                                <asp:ListItem Value="SGR">Selangor</asp:ListItem>
                            </asp:DropDownList> 
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Select [Destination State]." CssClass="validate" ControlToValidate="ddlDestination" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                      </div>

                    <div class="inputbox_full">
                        <asp:Label ID="lblNote" runat="server" Text="Note :" CssClass="label_left"></asp:Label>
                       
                        <asp:TextBox ID="TxtNote" runat="server" TextMode="MultiLine" CSSClass="input_full"></asp:TextBox>
                    </div>
                        
                   

                    </div> <!--row end-->

                </div>

                <div class="book_right-side">
                    <div class="right_stickybox">
                    <div class="book_box_right ">
                <div class="pickup_container">
                    <h6 class="pickup_title">Pickup & Return</h6>
                </div>

                <table class="pickup_table">
                    <tr >
                        <td></td>
                        <td class="timeline">Tue, Jul 23 · 10:00 AM</td>
                    </tr>
                    <tr>
                        <td><i class="ri-circle-line" style="color:green"> </i></td>
                        <td style="padding-top:20px;">Sungai Nibong Express Bus Terminal</td>
                    </tr>

                    <tr>
                        <td></td>
                        <td style="padding-bottom:20px;">(Pickup point)</td>
                    </tr>
   

                    <tr>
                        <td></td>
                        <td class="timeline">Wed, Jul 23 · 10:00 AM</td>
                    </tr>
                    <tr>
                        <td><i class="ri-map-pin-2-line" style="color:red"></i></td>
                        <td style="padding-top:20px;">Sungai Nibong Express Bus Terminal</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-bottom:20px;">(Drop off point)</td>
                    </tr>
   
                    <tr>
                        <td><i class="ri-time-line" style="color:blue"></i></td>
                        <td> 1 day 0 hour 0 minute</td>
                    </tr>
                </table>
                    
                    </div>


                <div class="book_box_right ">
                    <h6 class="charge_title">Summary of Charges</h6>
                    <div class="charges_summary">
                        <div class="charge_item">
                        <p class="summary_title">Rental</p>
                        <p class ="summary_amt rental_amt">0.00</p>
                        </div>
                        <hr />
                        <div class="charge_item">
                        <p class="summary_title">Rental</p>
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
                        <p class="summary_title">Total Price(MYR):</p>
                        <p class="summary_amt grand_total"><span><sub>approx</sub></span>0.00</p>
                        </div>
                    </div>
                
                </div>
                    </div>
                </div>


            
            <div class="driver_section">
                <div class="driver_container">
                    <div class="row">
                    
                   <div class="col">
                       <h3 class="title">Driver Info</h3>

                       <div class="check_driver">
                       <asp:CheckBox ID="chkDriver" runat="server" cssclass="driver_checkbox_style" />
                       <asp:Label ID="lblDriver" runat="server" Text="I am making this reservation for someone else." CSSClass="driver_check_label"></asp:Label>
                       </div>

                       <div id="driverFieldsLeft">
                       <div class="inputbox_left">
                            <asp:Label ID="lblDriverName" runat="server" Text="Driver Name :" CssClass="label_left"></asp:Label>
                            <asp:TextBox ID="txtDriverName" runat="server" CssClass="input_left"></asp:TextBox>
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter [Driver Name]." CssClass="validate driver_validate" ControlToValidate="txtDriverName" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                        </div>
                        <div class="inputbox_left">
                            <asp:Label ID="lblDriverGender" runat="server" Text="Driver Gender :" CssClass="label_left"></asp:Label>
                                 <asp:RadioButtonList ID="rblDriverGender" runat="server" CssClass="input_left radio_btn_style" RepeatDirection="Horizontal">
                                      <asp:ListItem Value="M" Style=";margin-right:80px;">Male</asp:ListItem>
                                      <asp:ListItem Value="F" >Female</asp:ListItem>
                                 </asp:RadioButtonList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Select [Driver Gender]." CssClass="validate driver_validate" ControlToValidate="rblDriverGender" Display="Dynamic" ValidationGroup="DriverValidation" Enabled="false"></asp:RequiredFieldValidator>
                        </div> 
                        <div class="inputbox_left">
                           <asp:Label ID="lblDriverID" runat="server" Text="Driver ID :" CssClass="label_left"></asp:Label>
                               <asp:TextBox ID="txtDriverID" runat="server" CssClass="input_left"> </asp:TextBox>
                             <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter [Driver ID]." CssClass="validate driver_validate" ControlToValidate="txtDriverID" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                        </div> 
                        <div class="inputbox_left">
                           <asp:Label ID="lblDriverPhoneNum" runat="server" Text="Driver Phone Number :" CssClass="label_left"></asp:Label>
                               <asp:TextBox ID="txtDriverPhoneNum" runat="server" CssClass="input_left"></asp:TextBox>
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Please Enter [Driver Phone Number]." CssClass="validate driver_validate" ControlToValidate="txtDriverPhoneNum" Display="Dynamic" ValidationGroup="DriverValidation" Enabled="false"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                   </div>
                    <div class="col" >
                        <div id="driverFieldsRight">
                            <div class="inputbox_right" style="padding-top:80px;">
                                <asp:Label ID="lblDriverAge" runat="server" Text="Driver Age" CssClass="label_right"></asp:Label>
                                <asp:DropDownList ID="ddlDriverAge" runat="server" CssClass="input_right">
                                    <asp:ListItem Value="default" Selected="True">Please Select</asp:ListItem>
                                    <asp:ListItem Value="23">23</asp:ListItem>
                                    <asp:ListItem Value="24">24</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Please Select [Driver Age]." CssClass="validate driver_validate" ControlToValidate="ddlDriverAge" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                            </div>    
                            <div class="inputbox_right">
                                <asp:Label ID="lblDriverRace" runat="server" Text="Driver Race" CssClass="label_right"></asp:Label>
                                    <asp:DropDownList ID="ddlDriverRace" runat="server" CssClass="input_right">
                                        <asp:ListItem Value="default" Selected="True">Please Select</asp:ListItem>
                                        <asp:ListItem Value="Malay">Malay</asp:ListItem>
                                        <asp:ListItem Value="Chinese">Chinese</asp:ListItem>
                                        <asp:ListItem Value="Indian">Indian</asp:ListItem>
                                        <asp:ListItem Value="Others">Others</asp:ListItem>
                                    </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Please Select [Driver Race]." CssClass="validate driver_validate" ControlToValidate="ddlDriverRace" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                             </div>   
                            <div class="inputbox_right">
                                <asp:Label ID="lblDriverLicenseNum" runat="server" Text="Driver License Number" CssClass="label_right"></asp:Label>
                                    <asp:TextBox ID="txtDriverLicenseNum" runat="server" CssClass="input_right"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Please Enter [Driver License Num]." CssClass="validate driver_validate" ControlToValidate="txtDriverLicenseNum" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                             </div>   
                            <div class="inputbox_right">
                                <asp:Label ID="lblRentalPurpse" runat="server" Text="Purpose of Rental" CssClass="label_right"></asp:Label>
                                    <asp:DropDownList ID="ddlRentalPurpose" runat="server" CssClass="input_right">
                                        <asp:ListItem Value="default" Selected="True">Please Select</asp:ListItem>
                                        <asp:ListItem Value="Leisure" >Leisure</asp:ListItem>
                                        <asp:ListItem Value="Business" >Business</asp:ListItem>
                                    </asp:DropDownList> 
                            </div>
                        </div>
                     </div>
                    
                </div> <!-- row end-->
                    
                </div>
            </div>

  </div>  <!-- p section-->

         <div class="sticky_bar">

         <div class="bar_content">
              <div class="previous_button">
    <asp:Button ID="previous_btn" runat="server" Text="Previous" cssclass="previous_btn_style prev_btn" OnClick="previous_btn_Click"/>
</div>
        <div class="selected_car">
            <img src="photo/pexels-peng-liu-45946-169677.jpg" alt="Selected Car">
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
            <asp:Button ID="btnNext2" runat="server" Text="Next" cssclass="next_btn_style next_btn" OnClick="btnNext_Click"/>
        </div>
    </div>
</div>
    
</asp:Content>
