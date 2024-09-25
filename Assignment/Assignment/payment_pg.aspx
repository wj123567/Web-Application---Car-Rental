<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="payment_pg.aspx.cs" Inherits="Assignment.payment_pg" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="CSS/payment_pg.css" rel="stylesheet" />
    <link href="CSS/tracking.css" rel="stylesheet" />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DatabaseConnectionString %>" SelectCommand="SELECT * FROM [PaymentCard]"></asp:SqlDataSource>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnCardType" runat="server" />
    <asp:HiddenField ID="hdnCardCheck" runat="server" />
    <asp:HiddenField ID="hdnNewCardId" runat="server" />
    <!--
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
    -->

    <!-- Modal Structure -->
<div id="paymentModal" class="modal fade"  data-bs-backdrop="static" tabindex="-1"aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Booking Confirmation</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to book</p>
            </div>
            <div class="modal-footer">
               
                <asp:Button ID="modalNextBtn" runat="server" CssClass="btn btn-primary" Text="Confirm" data-bs-dismiss="modal"  OnClick="btnBookingConfirm_Click" />
                 
            </div>
        </div>
    </div>
</div>


    <asp:Label ID="lblCheck" runat="server" Text="Label"></asp:Label>
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

             <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
     <ContentTemplate>
                <div class="chkApplyCard">
                <asp:CheckBox ID="chkApplyCard" runat="server"   CssClass="chkboxApply" AutoPostBack="true" OnCheckedChanged="chkApplyCard_CheckedChanged"/>
                <asp:Label ID="lblApplyCard" runat="server" CssClass="text-primary fw-bold" Text="Apply Existing Card"></asp:Label>
                </div>
               

           <div class="accordion" id="cardAccordion" style="display:none;">
               <div class="accordion-item">
                   <h2 class="accordion-header" id="headingExistingCard"> 
                       <button class="accordion-button accordion_btn_style" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                       View Existing Cards
                       </button>
                   </h2>
                   <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingExistingCard" data-bs-parent="#cardAccordion">
                       <div class="accordion-body">
          <div class="existingcard_container">
                <h5>Existing Card</h5>       

          <asp:Repeater ID="rptCards" runat="server" >
          <ItemTemplate>
            <div class="container-fluid">
          <div class="d-flex flex-row align-items-center mt-3 mb-3 pb-1">
              <div class="col-3 col-md-2">
              <asp:Image ID="imgCard" runat="server" CssClass="img-fluid" src='<%# getCardsPhoto(Eval("CardType").ToString()) %>'/>
              </div>
          <div class="col-6 col-md-7">
            <div class=" data-mdb-input-init form-outline">
                <table>
                    <tr>
                    <td><%# FormatCardNumber(Eval("CardNumber").ToString()) %> </td>
                       
                    </tr>
                </table>
                
              <label class="form-label" for="formControlLgXc">Card Number</label>
            </div>
          </div>
              <div class="col-3 col-md-3 text-end">
                  <span class="status_icon badge <%# GetDefaultBadge(Eval("IsDefault").ToString()) %> rounded-pill d-inline me-2">
                  <asp:Label ID="lblDefaultCard" runat="server" CssClass="text-dark" Text='<%# CheckCardDefault(Eval("IsDefault").ToString()) %>'></asp:Label>
                  </span>
              <asp:Button ID="btnExistCard" runat="server" Text="Apply"  CssClass="btn btn-dark" CommandArgument='<%# Eval("Id") %>' OnClick="btnExistCard_Click" />
                  </div>
        </div>
                </div>
          </ItemTemplate>
         </asp:Repeater>

         </div>   
          </div>
          </div>
         </div>
        </div>
               
                    <div class="col-sm-6 mt-5">
                        <asp:Label ID="lblCardName" runat="server" Text="Cardholder Name" CssClass="label_style"></asp:Label>
                        <asp:TextBox ID="txtCardName" runat="server" CssClass="form-control my-1" ValidationGroup="PaymentValidation"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Card Name is Required" ControlToValidate="txtCardName" ValidationGroup="PaymentValidation" CssClass="validate" Display="Static"></asp:RequiredFieldValidator>
                    </div>
                    <div class="col-sm-8 mt-4">
                        <asp:Label ID="lblCardNumber" runat="server" Text="Card Number" CssClass="label_style"></asp:Label>
                        <asp:Label ID="lblVisaCard" runat="server" Text="" CssClass="fab fa-cc-visa fa-lg"></asp:Label>
                        <asp:Label ID="lblMasterCard" runat="server" Text="" CssClass="fab fa-cc-mastercard fa-lg"></asp:Label>
                        <asp:Label ID="lblAmexCard" runat="server" Text="" CssClass="fab fa-cc-amex fa-lg"></asp:Label>

                        <asp:HiddenField ID="hdnUsedCardId" runat="server" />

                        <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control my-1" placeholder="0000 0000 0000 0000" MaxLength="19" ValidationGroup="PaymentValidation"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Card Number is Required." ControlToValidate="txtCardNumber" ValidationGroup="PaymentValidation" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="validateCard" runat="server" ErrorMessage="Card is Invalid." CssClass="validate" ValidationGroup="PaymentValidation" ClientValidationFunction="validateCard" ControlToValidate="txtCardNumber" ValidateEmptyText="True" Display="Dynamic"></asp:CustomValidator>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 col-xs-6 mt-4">
                            <asp:Label ID="lblExpiry" runat="server" Text="Expiry Date" CssClass="label_style"></asp:Label>
                            <asp:TextBox ID="txtExpiry" runat="server" TextMode="Month" CssClass="form-control my-1" ValidationGroup="PaymentValidation"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Card Expiry Date is Required" ControlToValidate="txtExpiry" ValidationGroup="PaymentValidation" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="cvExpiry" runat="server" ErrorMessage="Expiry date must be greater than the current month."  ControlToValidate="txtExpiry" ValidationGroup="PaymentValidation" CssClass="validate" ClientValidationFunction="validateExpiryDate"  Display="Dynamic" ></asp:CustomValidator>
                        </div>
                        <div class="col-sm-4 col-xs-6 mt-4">
                            <asp:Label ID="lblCvv" runat="server" Text="Security Code(CVV)" CssClass="label_style"></asp:Label>
                            <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control my-1" ValidationGroup="PaymentValidation"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rqCvv" runat="server" ErrorMessage="CVV is Required" ControlToValidate="txtCvv" ValidationGroup="PaymentValidation" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="my-3">
                        <small class="text-secondary">I authorize some insurance company to charge my debit / credit card for the total amount of xxx.xx</small>
                    </div>
                    <div class="mt-5 mb-3">
                        <div class="row paymentbtn_row">
                            <div class="col">
                                <asp:Button ID="btnPaymentPgBack" runat="server" Text="Go Back" CssClass="paymentpg_backbtn prev_btn w-100" OnClick="btnPaymentPgBack_Click" />
                            </div>
                            <div class="col">
                                <asp:Button ID="btnPaymentPgPay" runat="server" Text="Pay Now" CssClass="paymentpg_paybtn next-btn w-100" OnClientClick="return validateForm();" />
                            </div>
                        </div>
                    </div>
                    
                             </ContentTemplate>
                 <Triggers>
        <asp:AsyncPostBackTrigger ControlID="chkApplyCard" EventName="CheckedChanged" />
    </Triggers>
</asp:UpdatePanel>
                
    
                
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
        Rental Period: <asp:Label ID="lblTotalDayRent" runat="server" Text=""></asp:Label></td>
</tr>
    </table>
    
    
</div>
<div class="box_right charge_box_right">
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
            <p class="summary_title">Discount</p>
            <asp:Label ID="lblDiscount" runat="server" CssClass="summary_amt summary_Discount" Text="0.00"></asp:Label>
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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

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

        function toggleAccordion() {
            var checkbox = document.getElementById("<%= chkApplyCard.ClientID %>");
            const txtCardName = document.getElementById("<%= txtCardName.ClientID %>");
            const txtCardNumber = document.getElementById("<%= txtCardNumber.ClientID %>");
            const txtExpiry = document.getElementById("<%= txtExpiry.ClientID %>");
            const lblCvv = document.getElementById("<%= lblCvv.ClientID %>");
            const txtCvv = document.getElementById("<%= txtCvv.ClientID %>");
            const hdnCardCheck = document.getElementById("<%= hdnCardCheck.ClientID %>");
            var CVV_validator = document.getElementById("<%= rqCvv.ClientID %>");
            
            var accordion = document.getElementById('cardAccordion');
            if (checkbox.checked) {
                accordion.style.display = 'block';  // Show accordion
                txtCardName.disabled   = true;
                txtCardNumber.disabled = true;
                txtExpiry.disabled = true;
                lblCvv.style.display = 'none';
                txtCvv.style.display = 'none';         
                hdnCardCheck.value = "";
                lblCheck.innerText = hdnCardCheck.value;
                
            } else {
                accordion.style.display = 'none';   // Hide accordion
                txtCardName.disabled = false;
                txtCardName.value = "";
                txtCardNumber.disabled = false;
                txtCardNumber.value = "";
                txtExpiry.disabled = false;
                txtExpiry.value = "";
                lblCvv.style.display = 'block';
                txtCvv.style.display = 'block';
                txtCvv.value = "";              
                hdnCardCheck.value = "NewAdded";
                lblCheck.innerText = hdnCardCheck.value;
            }
        }

        function validateForm(event) {
            // Trigger ASP.NET validation
            var checkbox = document.getElementById("<%= chkApplyCard.ClientID %>");

            var CVV_validator = document.getElementById("<%= rqCvv.ClientID %>");
            if (checkbox.checked) {
                ValidatorEnable(CVV_validator, false);
            } else {
                ValidatorEnable(CVV_validator, true);
            }
            var isValid = Page_ClientValidate('PaymentValidation');
            
            if (!isValid) {
               
                return false; // Prevent showing the modal if the form is not valid
            }
            else {
                $('#paymentModal').modal('show'); // Use 'show' to display the modal
                // Proceed with showing the modal
                return false;
            }
            
        }

        // JavaScript to handle form submission after modal action
        function submitFormAfterModal() {
            // Trigger the server-side click event by submitting the form
            document.getElementById('<%= btnPaymentPgPay.ClientID %>').click();
        }

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

        function validateExpiryDate(sender, args) {
            var today = new Date();
            var currentMonth = today.getMonth() + 1; // JavaScript months are 0-11, so we add 1
            var currentYear = today.getFullYear();

            var expiryDate = document.getElementById('<%= txtExpiry.ClientID %>').value;

            // Check if expiryDate is in "yyyy-mm" format
            if (expiryDate) {
                var expiryYear = parseInt(expiryDate.split('-')[0]);
                var expiryMonth = parseInt(expiryDate.split('-')[1]);

               
                if (expiryYear > currentYear) {
                    args.IsValid = true; // Valid
                }
                
                else if (expiryYear === currentYear && expiryMonth > currentMonth) {
                    args.IsValid = true; // Valid
                }
                else {
                    args.IsValid = false; // Invalid
                }
            } else {
                args.IsValid = false; // Invalid if the field is empty
            }
        }

        function validateCard(sender, args) {
            var cardInput = document.getElementById('<%= txtCardNumber.ClientID %>');
            var cardNumber = cardInput.value.replace(/\s/g, '');
            var isVisa = false;
            var isMaster = false;
            var isAmex = false;

            isVisa = isVisaCard(cardNumber);
            isMaster = isMasterCard(cardNumber);
            isAmex = isAmexCard(cardNumber);


            if (isVisa || isMaster || isAmex) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }

        }

        function isVisaCard(cardNumber) {
            var cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
            if (cardno.test(cardNumber)) {
                var card = document.getElementById('<%= lblVisaCard.ClientID %>');
        card.className = "fab fa-cc-visa fa-lg text-primary";
        document.getElementById('<%= hdnCardType.ClientID %>').value = 'Visa';
        console.log(document.getElementById('<%= hdnCardType.ClientID %>').value);
        return true;
            }
        else {
        var card = document.getElementById('<%= lblVisaCard.ClientID %>');
                card.className = "fab fa-cc-visa fa-lg";
                return false;
            }
        }

        function isMasterCard(cardNumber) {
            var cardno = /^(?:5[1-5][0-9]{14})$/;
            if (cardno.test(cardNumber)) {
                var card = document.getElementById('<%= lblMasterCard.ClientID %>');
        card.className = "fab fa-cc-mastercard fa-lg text-primary";
        document.getElementById('<%= hdnCardType.ClientID %>').value = 'Master';
        console.log(document.getElementById('<%= hdnCardType.ClientID %>').value);
        return true;
            }
            else {
        var card = document.getElementById('<%= lblMasterCard.ClientID %>');
        card.className = "fab fa-cc-mastercard fa-lg";
        return false;
            }
        }

    function isAmexCard(cardNumber) {
    var cardno = /^(?:3[47][0-9]{13})$/;
    if (cardno.test(cardNumber)) {
        var card = document.getElementById('<%= lblAmexCard.ClientID %>');
        card.className = "fab fa-cc-amex fa-lg text-primary";
        document.getElementById('<%= hdnCardType.ClientID %>').value = 'Amex';
        return true;
    }
    else {
        var card = document.getElementById('<%= lblAmexCard.ClientID %>');
        card.className = "fab fa-cc-amex fa-lg";
        return false;
    }
        }

        
        function triggerSweetAlert() {
            swal({
                title: "Congratulation!",
                text: "You have successfully rented your desired car.",
                icon: "success",
                buttons: true,
            }).then((willDelete) => {
                if (willDelete) {
                    // Do something on confirmation, e.g., redirect
                    window.location.href = 'Home.aspx'; // Example action
                }
            });
        }

        window.onload = function () {
            var checkbox = document.getElementById("<%= chkApplyCard.ClientID %>");
            console.log("Page loaded, checkbox checked:", checkbox.checked); // Debugging
             toggleAccordion(checkbox);
         };
    </script>
</asp:Content>
