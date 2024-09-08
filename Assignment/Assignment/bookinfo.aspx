<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookinfo.aspx.cs" Inherits="Assignment.bookinfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="CSS/stickybar.css" rel="stylesheet" />
    <link href="CSS/bookinfo.css" rel="stylesheet" />

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
                            <asp:TextBox ID="txtName" runat="server" CssClass="input_left" ReadOnly="true"></asp:TextBox>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Please Enter [Name]." CssClass="validate" ControlToValidate="txtName" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
    
    
                        <div class="inputbox_left">
                            <asp:Label ID="lblEmail" runat="server" Text="Email Address : " CssClass="label_left"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="input_left" TextMode="Email" ReadOnly="true"></asp:TextBox>
                            <br />
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Enter [Email Address]." CssClass="validate" ControlToValidate="txtEmail" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>
    
                        
                    </div>
    
     

                    <div class="inputbox_full">
                        <asp:Label ID="lblNote" runat="server" Text="Note :" CssClass="label_left"></asp:Label>
                       
                        <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" CSSClass="input_full"></asp:TextBox>
                    </div>
                        
                   

                    </div> <!--row end-->

                </div>

                <div class="book_right-side">
                    
                    <div class="book_box_right ">
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


                <div class="book_box_right ">
                    <h6 class="charge_title">Summary of Charges</h6>
                    <div class="charges_summary">
                        <div class="charge_item">
                        <p class="summary_title">Rental</p>
                         <asp:Label ID="lblCarRental" runat="server" CssClass="summary_amt rental_amt" Text=""></asp:Label>
                        </div>
                        <hr />
                        <div class="charge_item">
                        <p class="summary_title">Add-ons</p>
                        <asp:Label ID="lblAddOnPrice" runat="server" CssClass="summary_amt summary_add_on" Text=""></asp:Label>
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

 
            
            <div class="driver_section">
                <div class="driver_container">
                    <div class="row">
                    
                   <div class="col">
                       <h3 class="title">Driver Info</h3>

                       <div class="check_driver">
                        <asp:Label ID="lblNoDriver" runat="server" Text="Unfortunately. No driver record is found." cssclass="lblNoDriver_style alert alert-warning" Enabled="false"></asp:Label>
                        <asp:Button ID="btnRegisterDriver" runat="server" CssClass="btn btn-primary" Text="Register a Driver" OnClick="btnRegisterDriver_Click"/>

                       <asp:CheckBox ID="chkDriver" runat="server" cssclass="driver_checkbox_style" />
                       <asp:Label ID="lblDriver" runat="server" Text="Driver has already been registered" CSSClass="driver_check_label"></asp:Label>     
                       </div>


                       <div id="driverFieldsLeft">
                       <div class="inputbox_left">
                            <asp:Label ID="lblDriverName" runat="server" Text="Driver Name :" CssClass="label_left"></asp:Label>
                            <asp:TextBox ID="txtDriverName" runat="server" CssClass="input_left" placeholder="Enter Driver Name" ReadOnly="true"></asp:TextBox>
                             <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Please Enter [Driver Name]." CssClass="validate driver_validate" ControlToValidate="txtDriverName" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                        </div>
                        <div class="inputbox_left">
                            <asp:Label ID="lblDriverGender" runat="server" Text="Driver Gender :" CssClass="label_left"></asp:Label> 
                            <asp:DropDownList ID="ddlDriverGender" runat="server" CssClass="input_left" enabled="false">
                                <asp:ListItem Value="0">Select Gender</asp:ListItem>
                                <asp:ListItem Value="M">Male</asp:ListItem>
                                <asp:ListItem Value="F">Female</asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Please Select [Driver Gender]." CssClass="validate driver_validate" ControlToValidate="ddlDriverGender" InitialValue="0" Display="Dynamic" Enabled="false"></asp:RequiredFieldValidator>
                        </div> 
                        <div class="inputbox_left">
                           <asp:Label ID="lblDriverID" runat="server" Text="Driver ID :" CssClass="label_left"></asp:Label>
                               <asp:TextBox ID="txtDriverID" runat="server" CssClass="input_left" placeholder="e.g. 543210987654" ReadOnly="true"> </asp:TextBox>
                             <br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Please Enter [Driver ID]." CssClass="validate driver_validate" ControlToValidate="txtDriverID" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                        </div> 
                       
                    </div>

                   </div>

                    <div class="col" >
                        <!--
                        <asp:Label ID="lblExistingDriver" runat="server" Text="Existing Driver"  CssClass="label_right"></asp:Label>

                        <asp:DropDownList ID="ddlExistingDriver" CssClass="input_left existDriver_ddl_style"  runat="server">
                         
                        </asp:DropDownList>

                        -->
                        
                        

                        <div id="driverFieldsRight">
                             <div class="inputbox_right">
                               <asp:Label ID="lblDriverLicenseNum" runat="server" Text="Driver License Number" CssClass="label_right"></asp:Label>
                                   <asp:TextBox ID="txtDriverLicenseNum" runat="server" CssClass="input_right" placeholder="e.g. 543210987654" ReadOnly="true"></asp:TextBox>
                               <br />
                               <asp:RequiredFieldValidator ID="rqDriverLicenseNum" runat="server" ErrorMessage="Please Enter [Driver License Num]." CssClass="validate driver_validate" ControlToValidate="txtDriverLicenseNum" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                            </div>   

                            <div class="inputbox_right"  >
                                <asp:Label ID="lblDriverBirth" runat="server" Text="Driver Birth Date"  CssClass="label_right"></asp:Label>
                                <asp:TextBox ID="txtDriverBirth" runat="server" TextMode="Date" CssClass="input_right" ReadOnly="true"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rqDriverBirth" runat="server" ErrorMessage="Please Select [Driver Birth Date]." CssClass="validate driver_validate" ControlToValidate="txtDriverBirth" Display="Dynamic"  Enabled="false"></asp:RequiredFieldValidator>
                            </div>                             
 
                             <div class="inputbox_right">
                                <asp:Label ID="lblDriverPhoneNum" runat="server" Text="Driver Phone Number :" CssClass="label_left"></asp:Label>
                                   <asp:TextBox ID="txtDriverPhoneNum" runat="server" TextMode="Phone" CssClass="input_right" ReadOnly="true" ></asp:TextBox>
                                 <br />
                                <asp:RequiredFieldValidator ID="rqDriverPhoneNum" runat="server" ErrorMessage="Please Enter [Driver Phone Number]." CssClass="validate driver_validate" ControlToValidate="txtDriverPhoneNum" Display="Dynamic" ValidationGroup="DriverValidation" Enabled="false"></asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="validPhoneNum" runat="server" ErrorMessage="Invalid Phone Number" ClientValidationFunction="validatePhone" ControlToValidate="txtDriverPhoneNum"  CssClass="validate" ValidateEmptyText="True" Enabled="false"></asp:CustomValidator>
                            </div>
                        </div>


                     </div>
                    
                </div> <!-- row end-->
                  </div>
                </div>
            </div>
    <div class="container">
        <div class="photo_container" id="photoField">
            <div class="row">
                <div class="col">
                    <h3>Photo Attachment</h3>
                    <div class="inputbox_left">
                        <h5>Quick Snap Using WebCam</h5>
                        <asp:Button ID="btnActivate" runat="server" Text="Button" OnClientClick="showWebcam(); return false;"/>
                         <div class="webcamSection">
                         <div class="webcamContainer" id="webcamContainer" style="display:none">
                             <i class="ri-close-line webcamClose" style="font-size:40px;color:white;background-color:red;" onclick="closeWebcam();"></i>
                          <table id="webcamTable" class="webcamTable" border="0" cellpadding="0" cellspacing="0" >
                             <tr>
                                 <th style="text-align:center" class="webcamTitle">Live Camera</th>
                                 <th style="text-align:center" class="webcamTitle">Captured Picture</th>
                             </tr>
                             <tr>
                                 <td class="webcamOutput"><div id="webcam"></div></td>
                                 <td class="webcamOutput"><img id="imgCapture" /></td>
                             </tr>
                             <tr>
                                 <td align="center" class="webcamExecute">
                                     <asp:Button ID="btnCapture" runat="server"  Text="Capture" Cssclass="btnCapture"/>
                                     
                                 </td>
                                 <td align="center" class="webcamExecute" >
                                     <asp:Button ID="btnUpload" runat="server"  Text="Upload" Cssclass="btnUpload"/>
                                    
                                 </td>
                             </tr>
                         </table>
                         </div>
                        </div>
                    </div>
                </div>
                 
                <div class="col">
                    <div class="inputbox_right" style="padding-top:40px;">
                        <h5>Import from File</h5>
                    </div>
                </div>
            </div>
        
   
  </div>  <!-- p section-->
        </div>

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
                        <asp:Image ID="imgSticky" runat="server" cssclass="sticky_bar_carimg img-fluid me-3" />
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
    

        <script type="text/javascript">
        function showWebcam() {
            // Display the table
            document.getElementById('webcamContainer').style.display = 'block';
        }

        function closeWebcam() {
            var container = document.getElementById('webcamContainer');
            // Toggle display between 'none' and 'block'
            if (container.style.display === 'block') {
                container.style.display = 'none';
            } else {
                container.style.display = 'block';
            }
        }

            $(function () {
                Webcam.set({
                    width: 300,
                    height: 240,
                    image_format: 'jpeg',
                    jpeg_quality: 90
                });
                Webcam.attach('#webcam');

                // Adjust CSS styles
                $('#webcam').css('margin', 'auto'); // Adjust the value as needed

                $("#main_btnCapture").click(function (event) {
                    event.preventDefault(); // Prevent default behavior (postback)

                    Webcam.snap(function (data_uri) {
                        $("#imgCapture")[0].src = data_uri;
                        $("#main_btnUpload").prop("disabled", false);
                    });
                });

                $("#main_btnUpload").click(function (event) {
                    event.preventDefault(); // Prevent default behavior (postback)

                    $.ajax({
                        type: "POST",
                        url: "bookinfo.aspx/SaveCapturedImage", //send to backend
                        data: "{data: '" + $("#imgCapture")[0].src + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            alert("Image uploaded successfully."); // Notify the user on success
                        },
                    });
                });
            });
        </script>

    <script src="https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/intlTelInput.min.js"></script>

    <script>
        const input = document.querySelector("#<%= txtDriverPhoneNum.ClientID %>");
        const iti = window.intlTelInput(input, {
            initialCountry: "auto",
            geoIpLookup: callback => {
                fetch("https://ipapi.co/json")
                    .then(res => res.json())
                    .then(data => callback(data.country_code))
                    .catch(() => callback("us"));
            },
            utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/utils.js",
        });

        function validatePhone(sender, args) {
            args.IsValid = iti.isValidNumber();
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

        document.addEventListener('DOMContentLoaded', function () {
           
            const chkDriver = document.getElementById('<%= chkDriver.ClientID %>');
            const lblDriver = document.getElementById('<%= lblDriver.ClientID %>');

            const lblNoDriver = document.getElementById('<%= lblNoDriver.ClientID %>');
            const registerDriver = document.getElementById('<%= btnRegisterDriver.ClientID %>');
            
            const driverFieldsLeft = document.getElementById('driverFieldsLeft');
            const driverFieldsRight = document.getElementById('driverFieldsRight');
            const photoFields = document.getElementById('photoField');

            const btnNext = document.getElementById('<%= btnNext.ClientID %>');

            function toggleDriverFields() {

                if (chkDriver.checked) { 
                    driverFieldsLeft.style.display = 'block';
                    driverFieldsRight.style.display = 'block';
                    photoFields.style.display = 'block';
                    lblNoDriver.style.display = 'none';
                    registerDriver.style.display = 'none';
                    enableDriverValidation(true);
                } else {
                    driverFieldsLeft.style.display = 'none';
                    driverFieldsRight.style.display = 'none';
                    photoFields.style.display = 'none';

                    chkDriver.style.display = 'none';
                    lblDriver.style.display = 'none';
                    lblNoDriver.style.display = 'block';

                    btnNext.disabled = true;
                    enableDriverValidation(false);
                }
            }

            function enableDriverValidation(enable) {
                const validators = document.querySelectorAll('.driver_validate');
                validators.forEach(function (validator) {
                    ValidatorEnable(validator, enable);
                });

            }

            // Attach the event listener to the checkbox
            chkDriver.addEventListener('change', toggleDriverFields);


            // Initial check on page load
            toggleDriverFields();
        });
    </script>

</asp:Content>
