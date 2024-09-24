<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Assignment.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnBookingId" runat="server" />

     <div class="bg_cover">
    <header class="section_container header_container">
        <h1 class="section_header">Find and Book Your Car <br/> A Great Experience</h1>
    </header>

         <div class="container">
          
    <section class="section_container booking_container">
   <div class="d-flex justify-content-center mb-3">
    <asp:Label ID="lblerrortext" runat="server" Text="Please Select Location and Time" CssClass="validate" Visible="False"></asp:Label>
</div>
      

     <div class="container booking_selection">
  <div class="row">
    <div class="col text-center ">
      <asp:Label ID="lblLocation" runat="server" Text="Pick Up & Drop Off Location" CssClass="home_label_style justify-content-center"></asp:Label> 
    </div>
  
  </div>
  <div class="row">
    <div class="col text-center">
      <asp:TextBox ID="txtDepartureLocation" runat="server" CssClass="control_style" ReadOnly="true" placeholder="Pick a Location😁"></asp:TextBox>
       
    </div>
    <asp:RequiredFieldValidator ID="requireDepartureLocation" runat="server" ErrorMessage="Location is Required" ControlToValidate="txtDepartureLocation"  CssClass="validate text-center"  Display="Dynamic"></asp:RequiredFieldValidator>
  </div>
</div>
          
                   
        <div class="content_container">

        <div class="form_container">            
            
        <div class="form_group">            
           
            <h5 class="home_pickup">Pick Up</h5>
            <span class="home_icon" style="margin-left:20px;"><i class="ri-map-pin-2-line"></i></span>
            <div class="input_content">
                <div class="input_group">                    
                  
                    <!-- handle viewstate prob bcs location assign thru client-side -->
                     <asp:HiddenField ID="hdnLocation" runat="server" />
                    <asp:HiddenField ID="hdnState" runat="server" />
                    
                    <br />

                 <asp:Label ID="lblDepartureDateTime" runat="server" Text="Date & Time" CssClass="home_label_style"></asp:Label>     
                    <div class="row">
                    <div class="col-8" >
                        <!--OnTextChanged="txtDepartureDateTime_TextChanged" -->

                         <asp:TextBox ID="txtDepartureDate" runat="server"  CssClass="control_style" ReadOnly="false" ></asp:TextBox>
                        <asp:Label ID="lblCalIcon" runat="server" Text="📅"></asp:Label>
                    </div>
                    <div class="col-4" style="padding-left:0px;" > 
                        <asp:TextBox ID="txtDepartureTime" runat="server" CssClass="control_style"  ReadOnly="false" ></asp:TextBox>
                        <asp:Label ID="Label2" runat="server" Text="🕐"></asp:Label>
                    </div>
                    </div>
                    
                <asp:RequiredFieldValidator ID="requireDepartDate" runat="server" ErrorMessage="Pick Up Date is Required" ControlToValidate="txtDepartureDate" CssClass="validate"  Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
               
            </div>
        </div>
        
        <!-- -->
            
        <div class="form_group">
            <h5 class="home_dropoff" >Drop Off</h5>
        <span class="home_icon"  style="margin-left:20px;"><i class="ri-map-pin-2-line"></i></span>
        <div class="input_content">
            <div class="input_group">                               
              
                <br />
              
                <asp:Label ID="lblReturnDateTime" runat="server" Text="Date & Time" CssClass="home_label_style" ></asp:Label>   
                 <div class="row">
                    <div class="col-8" >
                        <asp:HiddenField ID="hdnReturnDate" runat="server" />
                         <asp:TextBox ID="txtReturnDate" runat="server"  CssClass="control_style"   ReadOnly="false"></asp:TextBox>
                        <asp:Label ID="Label3" runat="server" Text="📅"></asp:Label>
                    </div>
                    <div class="col-4" style="padding-left:0px;" > 
                        <asp:TextBox ID="txtReturnTime" runat="server" CssClass="control_style"    ReadOnly="false" ></asp:TextBox>
                        <asp:Label ID="Label4" runat="server" Text="🕐"></asp:Label>
                    </div>
                </div>

                <asp:RequiredFieldValidator ID="requireReturnDate" runat="server" ErrorMessage="Drop Off Date is Required" ControlToValidate="txtReturnDate"  CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                 <asp:CustomValidator ID="customDateValidator" runat="server" ErrorMessage="End Time Must After Start Time"  ControlToValidate="txtReturnDate" CssClass="validate" Display="Dynamic" ClientValidationFunction="validateDateTime"></asp:CustomValidator>
            </div>
        
         </div>
         </div>
        <!-- -->
        </div>

            </div>
             <asp:Button ID="btnSearch" runat="server" Text="🔍Search" CssClass="search_btn_style" OnClick="btnSearch_Click" UseSubmitBehavior="True" />
    </section>
</div> 
</div>
    
<div id="locationModal" class="modal ">
        <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" id="modal-content">
        <span class="close" id="modal_close">&times;</span>
        <h2>Select Location</h2>
        <hr/>
        <div class="modal-body">
            <div class="grid-container">
                <div class="region">
                    <h5>Region</h5>
                    <ul id="RegionListPlaceholder" runat="server"></ul>
                </div>

                <!-- Popular Points Section for Penang -->
                <div id="PopularPointsPlaceholder" runat="server">
                    
                </div>

            </div>
        </div>
        <asp:Button ID="modalOkBtn" runat="server" Text="Ok" cssclass="modalbtn_style" Enabled="false"/>
    </div>
    </div>
</div>

   
     <section class=" plan_container">
 <p class="subheader">RENT INFORMATION</p>
 <h2 class="section_header">Plan your rent with confidence</h2>
 <p class="description">
     Find help with your booking and renting plans, and see what to expect along your journey
 </p>
 <div class="plan_grid">
     <div class="plan_content">
         <span class="number">01</span>
         <h4>Search & Explore </h4>
         <p>Find a vehicle that suits your budget and travel style, and get a quote online.
         </p>
         <!-- -->
         <span class="number">02</span>
         <h4>Book & Pay </h4>
         <p>Select your car hire dates, choose your car pick-up and drop-off points, and book securely.
         </p>
         <!-- -->
         <span class="number">03</span>
         <h4>Travel & Enjoy </h4>
         <p> Collect your car and live like a local anywhere in Malaysia.
         </p>
      </div>
     <div class="plan_image">
         <img src="Image/WZ/homeimg2.jpg" alt="Alternate Text" style=" height:250px"/>
         <img src="Image/WZ/homeimg1.jpg" alt="Alternate Text" style=" height:300px"/>
         <img src="Image/WZ/homeimg3.jpg" alt="Alternate Text" style=" height:250px"/>
     </div>
 </div>
</section>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script type="text/javascript">
        function initialiseFlatpickr(){
            var today = new Date();

            // Define minimum and maximum dates for departure
            var minDateDpt = new Date();
            minDateDpt.setDate(today.getDate() + 1);
            var maxDateDpt = new Date();
            maxDateDpt.setMonth(today.getMonth() + 3);

            var minDateRtn = new Date();
            minDateRtn.setDate(today.getDate() + 2);
            var maxDateRtn = new Date()
            maxDateRtn.setMonth(today.getMonth() + 4);

            // Flatpickr configuration with default time set to 08:00 AM, but not pre-filled in the textbox
            var dptDateConfig = {
                altInput: true,
                altFormat: "d/m/Y ",
                minuteIncrement: 15,
                minDate: minDateDpt,
                maxDate: maxDateDpt,
            };

            var dptTimeConfig = {
                enableTime: true,
                noCalendar: true,
                altInput: true,
                altFormat: "h:i K",
                minuteIncrement: 15,
                minDate: minDateDpt,
                maxDate: maxDateDpt,
                minTime: "08:00 ",
                maxTime: "22:00 ",
                defaultDate: minDateDpt.setHours(8, 0, 0)
            };

            var rtnDateConfig = {
                altInput: true,
                altFormat: "d/m/Y ",
                minuteIncrement: 15,
                minDate: minDateRtn,
                maxDate: maxDateRtn,
            };

            var rtnTimeConfig = {
                enableTime: true,
                noCalendar: true,
                altInput: true,
                altFormat: "h:i K",

                minuteIncrement: 15,
                minDate: minDateDpt,
                maxDate: maxDateDpt,
                minTime: "08:00",
                maxTime: "22:00",
                defaultDate: minDateDpt.setHours(8, 0, 0)
            };
            // Initialize flatpickr on the input field
            flatpickr("#<%= txtDepartureDate.ClientID %>", dptDateConfig);
            flatpickr("#<%= txtDepartureTime.ClientID %>", dptTimeConfig);
            flatpickr("#<%= txtReturnDate.ClientID %>", rtnDateConfig);
            flatpickr("#<%= txtReturnTime.ClientID %>", rtnTimeConfig);

        }

        function validateDateTime(source, args) {
            var txtDepartureDate = document.getElementById('<%= txtDepartureDate.ClientID %>').value;
            var txtDepartureTime = document.getElementById('<%= txtDepartureTime.ClientID %>').value;

            var txtReturnDate = document.getElementById('<%= txtReturnDate.ClientID %>').value;
            var txtReturnTime = document.getElementById('<%= txtReturnTime.ClientID %>').value;

            // Combine date and time for departure and return
            var departureDate= new Date(txtDepartureDate);
            var returnDate = new Date(txtReturnDate);

            

            // Check if return datetime is on or after departure datetime
            if (returnDate > departureDate) {
                args.IsValid = true;
                
            } else if (returnDate.getTime() === departureDate.getTime()) {
                // If dates are equal, compare times
                var departureTime = new Date("1970-01-01T" + txtDepartureTime); // Create time-only Date object
                var returnTime = new Date("1970-01-01T" + txtReturnTime);       // Time-only Date object

                if (returnTime > departureTime) {
                    // If return time is greater, it's valid
                    args.IsValid = true;
                } else {
                    // If return time is not greater, it's invalid
                    args.IsValid = false;
                }
            } else {
                args.IsValid = false;
            }
      
        }

    document.addEventListener("DOMContentLoaded", function () {
        // Get the modal
        var modal = document.getElementById("locationModal");

        // Get the inputs that open the modal
        var departureInput = document.getElementById('<%= txtDepartureLocation.ClientID %>');


        // Get the <span> element that closes the modal
        var span = document.getElementById("modal_close");

        // Get the OK button
        var okButton = document.getElementById("<%= modalOkBtn.ClientID %>");

        // Variable to store the currently active textbox
        var activeInput = null;

        // Variable to store the selected value
        var selectedPoint = "";
        var selectedRegion = "";

        // Open the modal when input is clicked
        departureInput.onclick = function () {
            activeInput = departureInput;
            modal.style.display = "block";
        }


        // Close the modal when the user clicks on <span> (x)
        span.onclick = function () {
            modal.style.display = "none";
        }

        function initializeEventListeners() {
            // Handle region click
            var regionItems = document.querySelectorAll('.region li');
            regionItems.forEach(function (item) {
                item.onclick = function () {
                    clearRegionSelection(); // Clear any previous selection
                    selectedRegion = this.textContent; // Capture the selected region
                    var region = this.getAttribute("data-region");
                    this.classList.add('selected-region'); // Highlight the selected region
                    showPopularPoints(region);

                    // Reset the selected point and disable the button
                    selectedPoint = "";
                    disableOkButton();
                }
            });
        }
       
        
        // Handle popular points item click
        var selectableItems = document.querySelectorAll('.selectable-item');
        selectableItems.forEach(function (item) {
            item.onclick = function () {
                clearPointSelection(); // Clear any previous selection
                selectedPoint = this.textContent;
                this.classList.add('selected-point'); // Highlight the selected point
                checkSelections(); // Call to check if both region and point are selected
            }
        });

        // Check if both region and popular point are selected
        function checkSelections() {
            if (selectedRegion !== "" && selectedPoint !== "") {
                enableOkButton();  // Enable OK button if both are selected
            } else {
                disableOkButton(); // Disable OK button if either is missing
            }
        }

        // Enable the OK button
        function enableOkButton() {
            okButton.removeAttribute('disabled');
        }

        // Disable the OK button
        function disableOkButton() {
            okButton.setAttribute('disabled', 'true');
        }


        // Handle OK button click
        if (okButton) {
            okButton.onclick = function (event) {
                event.preventDefault(); // Prevent the default form submission(no refresh!)

                // Combine selected point and region
                var combinedValue = selectedPoint + ', ' + selectedRegion;
                console.log("OK button clicked, combined value:", combinedValue);

                if (activeInput) {
                    // Update the active textbox with the selected value
                    activeInput.value = combinedValue;
                    // Set the hidden field value based on which input is active
                    if (activeInput === departureInput) {
                        document.getElementById('<%= hdnLocation.ClientID %>').value = selectedPoint;
                        document.getElementById('<%= hdnState.ClientID %>').value = selectedRegion;
                    } 
                }

                // Close the modal
                modal.style.display = "none";
            }
        }

        //------modal-----
        // Variable to store all popular-points sections


        var popularPointsSections = document.querySelectorAll('.popular-points');

        // Function to hide all popular points
        function hideAllPopularPoints() {
            popularPointsSections.forEach(function (section) {
                section.style.display = "none";
            });
        }

        // Function to show the popular points for a specific region
        function showPopularPoints(region) {
            hideAllPopularPoints();
            var targetSection = document.getElementById(region + "-points");
            if (targetSection) {
                targetSection.style.display = "block";
            }
        }

        // Initially hide all popular points sections
        hideAllPopularPoints();


        // Remove 'selected-region' class from all regions
        function clearRegionSelection() {
            var regionItems = document.querySelectorAll('.region li');
            regionItems.forEach(function (item) {
                item.classList.remove('selected-region');
            });
        }

        // Remove 'selected-point' class from all points
        function clearPointSelection() {
            var selectableItems = document.querySelectorAll('.selectable-item');
            selectableItems.forEach(function (item) {
                item.classList.remove('selected-point');
            });
        }

        // Handle region click
        var regionItems = document.querySelectorAll('.region li');
        regionItems.forEach(function (item) {
            item.onclick = function () {
                clearRegionSelection(); // Clear any previous selection
                selectedRegion = this.textContent; // Capture the selected region
                var region = this.getAttribute("data-region");
                this.classList.add('selected-region'); // Highlight the selected region
                showPopularPoints(region);
            }
        });

        
    });
    </script>
</asp:Content>