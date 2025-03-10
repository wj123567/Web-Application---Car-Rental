﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingrecord.aspx.cs" Inherits="Assignment.bookingrecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/bookingrecord.css" rel="stylesheet" />
    <link href="../CSS/paging.css" rel="stylesheet" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updatebookingRecordTable" class="bookingRecordTablePanel" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
        <ContentTemplate>
    <div class="booking_container">
       
        <p class="booking_title">Car Rental Booking Record</p>

      
        <div class="container">
            <div class="container">
            <div class="row">
                <div class="col-6 col-md-8 search_style">
                    <div class="form">
                    <i class="fa fa-search"></i>
                    <asp:TextBox ID="txtBookingSearch" cssclass="form-control form-input" runat="server"  placeholder="Search.."></asp:TextBox>
                    </div>
                </div>
                <div class="col-6 col-md-2">
                   <asp:DropDownList ID="ddlStatusFilter" runat="server" cssclass="form-control statusddl_style" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                        <asp:ListItem Value="All" Text="All Statuses" />
                        <asp:ListItem Value="Pending" Text="Pending" />
                        <asp:ListItem Value="Booked" Text="Booked" />
                        <asp:ListItem Value="Cancelled" Text="Cancelled" />
                        <asp:ListItem Value="Completed" Text="Completed" />
                   </asp:DropDownList>
                </div>
                </div>

                 <asp:Label ID="lblFilterTitle" runat="server" CssClass="fw-bold fs-4" Text="Filter Record By Date"></asp:Label>
                <asp:Label ID="Label3" runat="server" CssClass="small mb-1"  Text="(select same date to filter record(s) on certain day)"></asp:Label>
                <asp:Button ID="btnClearFilter" runat="server" CssClass="btn btn-danger" Text="Clear Filter" ValidationGroup="Filter" OnClick="btnClearFilter_Click"/>

                <div class="row mt-3">
                    <div class=" col-md-3">
                        <asp:Label ID="lblFilterStartDate" runat="server" CssClass="small mb-1"  Text="Start Date (inclusive)"></asp:Label>
                        <asp:TextBox ID="txtFilterStartDate" runat="server" CssClass="form-control" TextMode="Date" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqFilterStartDate" runat="server" ErrorMessage="Please Select Filter Start Date" ControlToValidate="txtFilterStartDate" CssClass="validate" ValidationGroup="Filter"  Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class=" col-md-3">
                        <asp:Label ID="lblFilterEndDate" runat="server" CssClass="small mb-1"  Text="End Date (inclusive)"></asp:Label>
                        <asp:TextBox ID="txtFilterEndDate" runat="server" CssClass="form-control " TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqFilterEndDate" runat="server" ErrorMessage="Please Select Filter End Date" ControlToValidate="txtFilterEndDate" ValidationGroup="Filter" CssClass="validate"  Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>
                    <div class=" col-md-3 d-flex align-items-center justify-content-center">
                        <asp:Button ID="btnFilterBookingDate" runat="server" CssClass="btn btn-primary" Text="Filter By Booking Date"  ValidationGroup="Filter" CommandName="BookingDate" OnClick="btnFilterBookingDate_Click"/>
                    </div>
                    <div class="col-md-3 d-flex align-items-center justify-content-center" >
                        <asp:Button ID="btnFilterPickUpDate" runat="server" CssClass="btn btn-secondary" Text="Filter By Pickup Date" ValidationGroup="Filter" CommandName="PickUpDate" OnClick="btnFilterPickUpDate_Click"/>
                    </div>
                   
                </div>
                </div>
              
        
                
            

        
            <div class="table-responsive">
    <table class="table table-striped align-middle mb-0 booking_record_table datatable" id="bookingRecordTable">
        <thead class="table-info bg-secondary" style=" line-height:2;text-align:center">
          <tr class="header_row_title" >

              <th class="booking_id">
                  <asp:LinkButton ID="btnSortID" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Id" CssClass="text-dark  sort-button">
                Booking ID<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                  </asp:LinkButton>

              </th>
              <th class="booking_dropoff">
                  <asp:LinkButton ID="btnSortBookingDate" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="BookingDate" CssClass="text-dark sort-button">
    Booking Date<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                  </asp:LinkButton>
              </th>
              <th class="booking_status">
                  <asp:LinkButton ID="btnSortStatus" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Status" CssClass="text-dark sort-button">
                 Status <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                  </asp:LinkButton>
                  <asp:HiddenField ID="hdnSortDirection" runat="server" Value="" />
              </th>

              <th class="booking_vehicle">
                  <asp:LinkButton ID="btnSortVehicle" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="CarPlate" CssClass="text-dark sort-button">
                Vehicle Plate <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                  </asp:LinkButton>
            </th>
            <th class="booking_pickup">
                <asp:LinkButton ID="btnSortPickUpLocation" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Pickup_point" CssClass="text-dark  sort-button">
                Pick Up & Drop Off Location <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                </asp:LinkButton>
            </th>            
             <th class="booking_pickup">
                <asp:LinkButton ID="btnSortPickUpTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="StartDate" CssClass="text-dark sort-button">
                Pick Up Time <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                </asp:LinkButton>
            </th>
           
             <th class="booking_dropoff">
                <asp:LinkButton ID="btnSortDropOffTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="EndDate" CssClass="text-dark sort-button">
                Drop Off Time<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                </asp:LinkButton>
            </th>
            <th class="booking_price">
                <asp:LinkButton ID="btnSortPrice" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Price" CssClass="text-dark  sort-button">
                Price(MYR)<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                </asp:LinkButton>
            </th>
             <th class="booking_edit" style="width:5%;"></th>
          </tr>
        </thead>
        <tbody id="bookingtable_record" style="text-align:center">

    <asp:Repeater ID="rptBookingList" runat="server" >
    <ItemTemplate>
        <tr class="rows1">
            <td>
                <div class=" align-items-center">
                    <div class="ms-1">
                        <asp:HiddenField ID="hdnBookingId" runat="server" />
                        <p class="fw-bold mb-1"><%# Eval("Id") %></p>
                    </div>
                </div>
            </td>

            <td>
                <p class="fw-normal mb-1"><%# Eval("BookingDate", "{0:dd-MMM-yyyy hh:mm tt}") %></p>
            </td>
            <td>
                <span class="status_icon badge <%# GetBadgeClass(Eval("Status").ToString()) %> rounded-pill d-inline">
                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>

                </span>
            </td>

            <td class="carplate_data">
                <p class="fw-normal mb-1"><%# Eval("CarPlate") %></p>
            </td>

            <td>
                <p class="fw-normal mb-1"><%# Eval("Pickup_point") %></p>

            </td>

            <td>
                <p class="text-muted mb-0"><%# Eval("StartDate","{0:dd-MMM-yyyy hh:mm tt}") %></p>
            </td>

            <td>
                <p class="text-muted mb-0"><%# Eval("EndDate","{0:dd-MMM-yyyy hh:mm tt}") %></p>
            </td>

            <td class="price_data">
                <p class="fw-normal mb-1"><%#Eval("Price") %></p>
            </td>

            <td>
                <asp:Button ID="btnView" runat="server" CssClass="edit_btn_style" Text="View" OnClick="btnView_Click" CommandArgument='<%# Eval("Id") %>' />
            </td>
        </tr>
      </ItemTemplate>
     </asp:Repeater>  
           
        </tbody>
        <asp:Label ID="lblTotalRecord" runat="server" Text="" CssClass="float-end text-muted"></asp:Label>
      </table>
           </div>
   

      </div>
  </div>
     </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlStatusFilter" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="btnFilterBookingDate" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnFilterPickUpDate" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnClearFilter" EventName="Click" />
                </Triggers>

 </asp:UpdatePanel>


     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        
    <script type="text/javascript" src="../JS/paging.js"></script>

    <script>
        function initializePagination() {
            $('#bookingRecordTable').paging({ limit: 10 });
        }

        function setupSearchFunctionality(searchBoxId) {
            
            $(searchBoxId).on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#bookingtable_record tr").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
        }

        $(document).ready(function () {
            var searchBoxId = "#" + '<%= txtBookingSearch.ClientID %>';

            setupSearchFunctionality(searchBoxId) 
           
            initializePagination(); // Initialize on page load

            
        });

        

        function updateSortIcons() {
            // Get the current sort direction from the HiddenField
            var sortDirection = document.getElementById('<%= hdnSortDirection.ClientID %>').value;

            // Update icon classes based on the current sort direction
            document.querySelectorAll('.sort-button').forEach(function (button) {
                var icon = button.querySelector('.sort-icon');
                if (icon) {
                    if (sortDirection === 'ASC') {
                        icon.classList.remove('ri-arrow-up-s-fill');
                        icon.classList.add('ri-arrow-down-s-fill');
                    } else {
                        icon.classList.remove('ri-arrow-down-s-fill');
                        icon.classList.add('ri-arrow-up-s-fill');
                    }
                }
            });
        }

        function colorButton(button) {
            var buttonGroup = document.querySelectorAll(".sort-button-group");

            buttonGroup.forEach(function (btn) {
                btn.style.backgroundColor = "";
                btn.style.color = "";
            });

            button.style.backgroundColor = "#3490dc";
            button.style.color = "#fff";
        }


    </script>
 
</asp:Content>
