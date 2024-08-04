<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="payment_pg.aspx.cs" Inherits="Assignment.payment_pg" %>
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


    <div class="bg-light py-4 paymentpg_body">
      <div class="paymentpg_container">
        <div class="row">
          <div class="col-lg-9 col-md-8 col-sm-6 col-xs-12 payment_left_side" >
            <h4>Payment Info</h4>
            <div class="shadow-sm bg-white p-4 my-4">
                <div class="col-sm-6 mt-5">
                  <asp:Label ID="lblCardName" runat="server" Text="Name on the card" CssClass="label_style"></asp:Label>
                  <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control my-1"></asp:TextBox>
                </div>
                <div class="col-sm-8 mt-4">
                  <asp:Label ID="lblCardNumber" runat="server" Text="Card Number" CssClass="label_style"></asp:Label>
                  <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control my-1"></asp:TextBox>
                </div>
                <div class="row">
                  <div class="col-sm-3 col-xs-6 mt-4">
                    <asp:Label ID="lblExpiry" runat="server" Text="Card Expiry (mm/yy)" CssClass="label_style"></asp:Label>
                    <asp:TextBox ID="txtExpiry" runat="server" TextMode="Date" CssClass="form-control my-1"></asp:TextBox>
                  </div>
                  <div class="col-sm-3 col-xs-6 mt-4">      
                    <asp:Label ID="lblCvv" runat="server" Text="CVV" CssClass="label_style"></asp:Label>
                    <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control my-1"></asp:TextBox>
                  </div>
                </div>
                <div class="row">
                  <div class="col-sm-4 col-xs-12 mt-4">
                    <asp:Label ID="lblTerm" runat="server" Text="Choose term" CssClass="label_style"></asp:Label>
                    <asp:DropDownList ID="ddlTerm" runat="server" CssClass="form-control my-1">
                        <asp:ListItem Value="1Year">1 Year</asp:ListItem>
                        <asp:ListItem Value="3Year">3 Year</asp:ListItem>
                        <asp:ListItem Value="5Year">5 Year</asp:ListItem>
                    </asp:DropDownList>
                     
                  </div>
                  <div class="col-sm-4 col-xs-6 mt-4">                  
                    <asp:Label ID="lblSchedule" runat="server" Text="Payment Schedule" CssClass="label_style"></asp:Label>
                    <asp:DropDownList ID="ddlSchedule" runat="server" CssClass="form-control my-1">
                        <asp:ListItem Value="Quarterly">Quarterly</asp:ListItem>
                        <asp:ListItem Value="Half Yearly">Half Yearly</asp:ListItem>
                        <asp:ListItem Value="Full">Full</asp:ListItem>
                    </asp:DropDownList>
                    
                  </div>
                  
                </div>
                <div class="my-3">
                  <small class="text-secondary">I authorize some insurance company to charge my debit / credit card for the total amount of xxx.xx</small>
                </div>
                <div class="mt-5 mb-3">
                  <div class="row">
                    <div class="col">    
                      <asp:Button ID="btnPaymentPgBack" runat="server" Text="Go Back" CssClass="paymentpg_backbtn prev_btn w-100" OnClick="btnPaymentPgBack_Click"/>
                    </div>
                    <div class="col">
                     <asp:Button ID="btnPaymentPgPay" runat="server" Text="Pay Now" CssClass="paymentpg_paybtn next-btn w-100" OnClick="btnPaymentPgPay_Click"/>
                    </div>
                  </div>
                </div>
    
                <asp:GridView ID="GridView1" runat="server" Width="643px"></asp:GridView>
    
    
            </div>
          </div>

            
             <div class="payment_right_side">
            <div class="box_right">
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
     <div class="box_right">
         <h6 class="charge_title">Summary of Charges</h6>
         <div class="charges_summary">
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
             <p class="summary_amt"><span><sub>approx</sub></span>0.00</p>
             </div>
         </div>

     </div>
    
     </div>

        </div>
      </div>

    </div>


</asp:Content>
