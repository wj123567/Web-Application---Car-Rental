<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="payment_pg.aspx.cs" Inherits="Assignment.payment_pg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" SelectCommand="SELECT * FROM [PaymentCard]"></asp:SqlDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
    <!--
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    -->

    <!-- Modal Structure -->
<div id="paymentModal" class="modal fade"  data-bs-backdrop="static" tabindex="-1"aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Payment Status</h5>
     
            </div>
            <div class="modal-body">
                <p>Your payment is being processed...</p>
            </div>
            <div class="modal-footer">
                <asp:Button ID="modalOkBtn" runat="server" CssClass="btn btn-primary" Text="Ok" data-bs-dismiss="modal" OnClick="modalOkBtn_Click" />
            </div>
        </div>
    </div>
</div>

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

    
<section class="info_body_container"> 
   
   <div class="left-side">
        <asp:Label ID="lblPaymentText" runat="server" Text=""></asp:Label>
       
      <div class="box_left">
           <div class="paymentpg_container">
        <div class="row">
          <div class=" col-xs-12 payment_left_side" >
           
             
            <div class="shadow-sm bg-white p-4 my-4">
                <h4>Payment Info</h4>
                <div class="existingcard_container">
                <h5>Existing Card</h5>
                <asp:Repeater ID="rptCards" runat="server" >
                    <ItemTemplate>
                <div class="d-flex flex-row align-items-center mt-3 mb-3 pb-1">
          <img class="img-fluid" src="https://img.icons8.com/color/48/000000/mastercard-logo.png" />
          <div class="flex-fill mx-3">
            <div class=" data-mdb-input-init form-outline">
                <table>
                    <td><%# FormatCardNumber(Eval("CardNumber").ToString()) %> </td>
                </table>
                
              <label class="form-label" for="formControlLgXc">Card Number</label>
            </div>
          </div>
                    <asp:Button ID="btnExistCard" runat="server" Text="Button"  CommandArgument='<%# Eval("Id") %>' OnClick="btnExistCard_Click"/>
        </div>
          </ItemTemplate>
         </asp:Repeater>
         </div>               

        
                <div class="col-sm-6 mt-5">
                     
                  <asp:Label ID="lblCardName" runat="server" Text="Cardholder Name" CssClass="label_style"></asp:Label>
                  <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control my-1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ErrorMessage="Card Name is Required" ControlToValidate="txtCardName" ValidationGroup="PaymentValidation"  CssClass="validate"  Display="Static"></asp:RequiredFieldValidator>
                </div>
                <div class="col-sm-8 mt-4">
                  <asp:Label ID="lblCardNumber" runat="server" Text="Card Number" CssClass="label_style"></asp:Label>
                    <asp:Label ID="lblVisaCard" runat="server" Text="" CssClass="fab fa-cc-visa fa-lg"></asp:Label>
                    <asp:Label ID="lblMasterCard" runat="server" Text="" CssClass="fab fa-cc-mastercard fa-lg"></asp:Label>
                    <asp:Label ID="lblAmexCard" runat="server" Text="" CssClass="fab fa-cc-amex fa-lg"></asp:Label>
                  <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control my-1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ErrorMessage="Card Number is Required" ControlToValidate="txtCardNumber" ValidationGroup="PaymentValidation" CssClass="validate"  Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                <div class="row">
                  <div class="col-sm-4 col-xs-6 mt-4">
                    <asp:Label ID="lblExpiry" runat="server" Text="Expiry Date" CssClass="label_style"></asp:Label>
                    <asp:TextBox ID="txtExpiry" runat="server" TextMode="Month" CssClass="form-control my-1"></asp:TextBox>
                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Card Expiry Date is Required" ControlToValidate="txtExpiry" ValidationGroup="PaymentValidation" CssClass="validate"  Display="Dynamic"></asp:RequiredFieldValidator>
                  </div>
                  <div class="col-sm-4 col-xs-6 mt-4">      
                    <asp:Label ID="lblCvv" runat="server" Text="Security Code(CVV)" CssClass="label_style"></asp:Label>
                    <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control my-1"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server"  ErrorMessage="CVV is Required" ControlToValidate="txtCvv" ValidationGroup="PaymentValidation" CssClass="validate"  Display="Dynamic"></asp:RequiredFieldValidator>
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
                     <asp:Button ID="btnPaymentPgPay" runat="server" Text="Pay Now" CssClass="paymentpg_paybtn next-btn w-100"   OnClientClick="return validateForm();"/>
                    </div>
                  </div>
                </div>
    
                
    
    
            </div>
          </div>
            </div>
               </div>
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
            <td class="timeline StartDateSes">123</td>
        </tr>
        <tr>
            <td><i class="ri-circle-line" style="color:green"> </i></td>
            <td class="PickupPointSes">123</td>
        </tr>

        <tr>
            <td></td>
            <td style="padding-bottom:20px;">(Pickup point)</td>
        </tr>
   
        <tr>
            <td></td>
            <td class="timeline StartDateSes" >123</td>
        </tr>
        <tr>
            <td><i class="ri-map-pin-2-line" style="color:red"></i></td>
            <td class="DropoffPointSes">123></td>
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
         <asp:Label ID="lblTotalPrice" runat="server" Text="0.00" CssClass="summary_amt grand_total"></asp:Label>
        
        </div>
    </div>

</div>
    </div>
    </section>
    <script>
        function loadModal() {
            document.addEventListener("DOMContentLoaded", modal);

        }

        function modal() {
            addEventListener("DOMContentLoaded", (event) => {
                $('#paymentModal').modal('toggle');
                return false;
            });
        };


        function validateForm(event) {
            // Trigger ASP.NET validation
            var isValid = Page_ClientValidate('PaymentValidation');
            
            if (!isValid) {
                event.preventDefault(); // Prevent the default action (e.g., modal opening)
                return false; // Prevent showing the modal if the form is not valid
            }
            else {
                $('#paymentModal').modal('show'); // Use 'show' to display the modal
                // Proceed with showing the modal
                return false;
            }
            
        }
    </script>
</asp:Content>
