<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="BookingManagement.aspx.cs" Inherits="Assignment.Management.BookingManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/bookingManagement.css" rel="stylesheet" />
    <link href="../CSS/paging.css" rel="stylesheet" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnBookingId" runat="server" />
    <asp:HiddenField ID="hdnCancelDateCheck" runat="server" />
     <asp:HiddenField ID="hdnFinalPriceInfo" runat="server" />

<div class="modal fade" id="rejectReason" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="rejectReason" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    <asp:UpdatePanel ID="updateReason" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
        <ContentTemplate>
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-black" id="staticBackdropLabel">Reject Reason</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <asp:DropDownList ID="ddlRejectReason" runat="server" CssClass="form-select" AutoPostBack="True" ValidationGroup="rejectGroup" OnSelectedIndexChanged="ddlRejectReason_SelectedIndexChanged">
              <asp:ListItem Value="0">Select Reject Reason</asp:ListItem>
              <asp:ListItem Value="Vehicle Already Dispatched">Vehicle already dispatched</asp:ListItem>
              <asp:ListItem Value="Payment Already Processed">Payment Already Processed</asp:ListItem>
              <asp:ListItem Value="Late Cancellation Request">Late Cancellation Request</asp:ListItem>
              <asp:ListItem Value="Preparation Costs Incurred">Preparation Costs Incurred</asp:ListItem>
              <asp:ListItem >Other</asp:ListItem>
          </asp:DropDownList>
          <asp:RequiredFieldValidator ID="requireReason" runat="server" ErrorMessage="Reject Reason is Required" CssClass="validate" InitialValue="0" ValidationGroup="rejectGroup" ControlToValidate="ddlRejectReason"></asp:RequiredFieldValidator>
          <asp:TextBox ID="txtOtherReason" runat="server" ValidationGroup="rejectGroup" CssClass="form-control mt-1" placeholder="Other Reason" Visible="False"></asp:TextBox>
          <asp:RequiredFieldValidator ID="requireOtherReason" runat="server" ErrorMessage="Other Reason is Required" CssClass="validate" ValidationGroup="rejectGroup" ControlToValidate="txtOtherReason" Enabled="False"></asp:RequiredFieldValidator>
      </div>
        </ContentTemplate>
    </asp:UpdatePanel>
      <div class="modal-footer">
        <asp:Button ID="btnCancelReject" runat="server" Text="Review Again" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reviewBooking" OnClientClick="return false"/>
        <asp:Button ID="btnReject2" runat="server" Text="Reject" CssClass="btn btn-danger" ValidationGroup="rejectGroup" OnClick="btnReject2_Click"/>
      </div>
    </div>
  </div>   
</div>

   
    <div class="modal modal-xl fade" id="reviewBooking" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="reviewDriver" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
      <div class="modal-content">
          <div class="modal-header">
              <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel4">Booking Detail
                  <asp:Label ID="lblBookingId" runat="server" Text=""></asp:Label></h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
              <div class="card-body row">

                  <div class="col-6">
                      <h5 class="text-dark">Time & Location</h5>
                      <hr class="mt-0 mb-4">
                      <div class="mb-3">
                          <h6 class="text-dark mb-1 fw-bold">Pick Up</h6>
                      </div>
                      <div class="row gx-3 mb-3">
                          <div class="col-md-6">
                              <asp:Label ID="Label10" runat="server" CssClass="small mb-1" Text="Pick Up Location"></asp:Label>
                              <asp:TextBox ID="txtPickUpLocation" runat="server" CssClass="form-control" ValidationGroup="reviewGroup" ReadOnly="True"></asp:TextBox>
                          </div>
                          <div class="col-md-6">
                              <asp:Label ID="Label9" runat="server" CssClass="small mb-1" Text="Pick Up Time (dd/MM/yyyy)"></asp:Label>
                              <asp:TextBox ID="txtPickUpTime" runat="server" CssClass="form-control" TextMode="DateTime" ValidationGroup="reviewGroup" ReadOnly="True"></asp:TextBox>
                          </div>
                      </div>
                      <div class="mb-3">
                          <h6 class="text-dark mb-1 fw-bold">Drop Off</h6>
                      </div>
                      <div class="row gx-3 ">
                          <div class="col-md-6">
                              <asp:Label ID="Label8" runat="server" CssClass="small mb-1" Text="Drop off Location"></asp:Label>
                              <asp:TextBox ID="txtDropOffLocation" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                          <div class="col-md-6">
                              <asp:Label ID="Label7" runat="server" CssClass="small mb-1" Text="Drop off Time (dd/MM/yyyy)"></asp:Label>
                              <asp:TextBox ID="txtDropOffTime" runat="server" CssClass="form-control" TextMode="DateTime" ReadOnly="True"></asp:TextBox>
                          </div>
                      </div>
                      <div class="mb-3">
                          <h6 class="text-dark mb-1 fw-bold">Booking Date</h6>
                      </div>
                      <div class="row gx-3 mb-5">
                          <div class="col-md-12">
                              <asp:Label ID="Label6" runat="server" CssClass="small mb-1" Text="Customer Booking Date (dd/MM/yyyy)"></asp:Label>
                              <asp:TextBox ID="txtCustBookDate" runat="server" CssClass="form-control" TextMode="DateTime" ReadOnly="True"></asp:TextBox>

                          </div>

                      </div>
                      <div class="mb-3">
                          <h5 class="text-dark">Additional notes</h5>
                          <hr class="mt-0 mb-4">
                      </div>
                      <div class="row gx-3 mb-3">
                          <div class="col">

                              <asp:TextBox ID="txtAdditionalNotes" runat="server" CssClass="form-control d-block" TextMode="MultiLine" Rows="5" ReadOnly="True"></asp:TextBox>
                          </div>
                      </div>
                  </div>
                  <div class="col-6">
                      <!-- car & rental -->
                      <h5 class="text-dark">Car Info</h5>
                      <hr class="mt-0 mb-4">
                      <div class="row gx-3 mb-3">
                          <div class="col-md-6">
                              <asp:Label ID="Label4" runat="server" CssClass="small mb-1" Text="Car Plate"></asp:Label>
                              <asp:TextBox ID="txtCarPlate" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                          <div class="col-md-6">
                              <asp:Label ID="Label3" runat="server" CssClass="small mb-1" Text="Original Location"></asp:Label>
                              <asp:TextBox ID="txtOriLocation" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                      </div>

                      <!--add on -->
                      <h5 class="text-dark">Add On Info</h5>
                      <hr class="mt-0 mb-4">
                      <div class="table-responsive">
                          <asp:Repeater ID="rptAddOn" runat="server" OnItemDataBound="rptAddOn_ItemDataBound">
                              <HeaderTemplate>
                                  <table class="table table-striped">
                                      <tr>
                                          <th>Type</th>
                                          <th>Quantity</th>
                                          <th>Subtotal (MYR)</th>
                                      </tr>
                              </HeaderTemplate>
                              <ItemTemplate>
                                  <tr>
                                      <td>
                                          <%# Eval("Name") %>

                                      </td>
                                      <td>
                                          <asp:Label ID="lblAddOnQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>


                                      </td>
                                      <td>
                                          <asp:Label ID="lblAddOnSubtotal" runat="server" Text='<%# Eval("SubTotal","{0:F2}") %>'></asp:Label>

                                      </td>
                                  </tr>

                              </ItemTemplate>
                              <FooterTemplate>
                                  <tr>
                                      <td colspan="2" class="fw-bold">Total Price</td>
                                      <td>
                                          <asp:Label ID="lblAddOnTotal" runat="server" Text=""></asp:Label></td>
                                  </tr>
                                  </table>
                              </FooterTemplate>

                          </asp:Repeater>
                      </div>
                      <!-- booking price -->
                      <h5 class="text-dark">Payment Update</h5>
                      <hr class="mt-0 mb-4">
                      <div class="row gx-3 mb-3">
                          <div class="col-md-6">
                              <asp:Label ID="Label2" runat="server" CssClass="small mb-1" Text="Initial Payment Price (MYR)"></asp:Label>
                              <asp:TextBox ID="txtInitBookingPrice" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                          <div class="col-md-6">
                              <asp:Label ID="Label1" runat="server" CssClass="small mb-1" Text="Post-update Charges Amount (MYR)"></asp:Label>
                              <asp:TextBox ID="txtUpdatedBookingPrice" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                      </div>
                      <div class="row gx-3 mb-3">
                          <asp:Label ID="lblFinalPriceInfo" runat="server" CssClass="small mb-1" Text=""></asp:Label>
                          <asp:TextBox ID="txtFinalPriceAmt" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                      </div>
                      <h5 class="text-dark">Reject Reason</h5>
                      <hr class="mt-0 mb-4">
                      <div class="row gx-3 mb-3">

                          <asp:TextBox ID="txtRejectReason" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                      </div>

                  </div>
                  <!-- right col end-->
              </div>
          </div>
          <div class="modal-footer d-flex justify-content-between">
              <div>
                  <button type="button" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#userInfoModal">Back</button>
              </div>
              <div class="ms-auto">
                  <asp:Button ID="btnOk" runat="server" Text="Close" CssClass="btn btn-primary" ValidationGroup="reviewGroup" OnClick="btnOk_Click" />
                  <asp:Button ID="btnApprove" runat="server" Text="Approve Cancellation" CssClass="btn btn-primary" ValidationGroup="reviewGroup" OnClick="btnApprove_Click" />
                  <asp:Button ID="btnReject" runat="server" Text="Reject Cancellation" CssClass="btn btn-danger" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#rejectReason" OnClientClick="return false" />
              </div>
          </div>
      </div>
  </div>   
</div>


       <div class="modal animate__animated animate__slideInLeft animate__faster" id="userInfoModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userInfoModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
      <div class="modal-content">
          <div class="modal-header">
              <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">User Detail</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
              <ul class="nav nav-tabs mb-2 justify-content-center" id="userModalTab">
                  <li class="nav-item" role="presentation">
                      <button class="nav-link active" id="userInfoTab" data-bs-toggle="modal" data-bs-target="#userInfoModal" type="button">User Info</button>
                  </li>
                  <li class="nav-item" role="presentation">
                      <button class="nav-link" id="driverInfoTab" data-bs-toggle="modal" data-bs-target="#userDriverModal" type="button">Driver Info</button>
                  </li>
              </ul>
              <div class="row">
                  <div>
                      <div class="mb-3">
                          <label class="small mb-1">Username</label>
                          <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                      </div>
                      <div class="row gx-3 mb-3">
                          <div class="col-md-6">
                              <label class="small mb-1">Email address</label>
                              <asp:TextBox ID="txtEmailAddress" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                          <div class="col-md-6">
                              <label class="small mb-1">Roles</label>
                              <asp:TextBox ID="txtRoles" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                      </div>
                      <div class="row gx-3 mb-3">
                          <div class="col-md-6">
                              <label class="small mb-1">Birthday</label>
                              <asp:TextBox ID="txtBirthday" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                          <div class="col-md-6">
                              <label class="small mb-1">Member Since</label>
                              <asp:TextBox ID="txtMemberSince" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
          <div class="modal-footer">
              <asp:Button ID="btnUserNext" CssClass="btn btn-primary " runat="server" Text="Next" data-bs-toggle="modal" data-bs-target="#reviewBooking" OnClientClick="return false" />
          </div>
      </div>
    </div>
  </div>  

    <div class="modal animate__animated animate__slideInRight animate__faster" id="userDriverModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userDriverModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel3">Available Driver</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <ul class="nav nav-tabs mb-2 justify-content-center" id="driverModalTab">
          <li class="nav-item" role="presentation">
            <button class="nav-link" id="userInfoTab2" data-bs-toggle="modal" data-bs-target="#userInfoModal" type="button">User Info</button>
          </li>
          <li class="nav-item" role="presentation">
            <button class="nav-link active" id="driverInfoTab2" data-bs-toggle="modal" data-bs-target="#userDriverModal" type="button">Driver Info</button>
          </li>
        </ul>
        <div class="card-body row">
        <asp:Label ID="lblDriverText" runat="server" CssClass="text-dark"></asp:Label>
        <asp:Repeater ID="UserDriverRepeater" runat="server" OnItemDataBound="UserDriverRepeater_ItemDataBound">
            <ItemTemplate>
                <div class="card-body rounded border border-dark px-0 py-2 mb-2 text-dark">
                    <div class="d-flex align-items-center justify-content-between px-4">
                        <div class="d-flex align-items-center">
                             <i class="fa-regular fa-id-card" style="font-size:1.5em;"></i>
                            <div class="mx-4">
                                    <asp:Label ID="lblDriverName" runat="server" Text='<%# Eval("DriverName") %>' CssClass="small d-block" />
                                    <asp:Label ID="lblDriverBdate" runat="server" Text='<%# "Driver Id: " + Eval("DriverID") %>' CssClass="text-xs text-muted d-inline" />
                                <br />
                                    <asp:Label ID="lblReject" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                        </div>
                        <div class="d-flex align-items-center ms-4 small">
                            <asp:Label ID="lblApproval" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>
      <div class="modal-footer">
          <asp:Button ID="btnDriverNext"  CssClass="btn btn-primary " runat="server" Text="Next"  data-bs-toggle="modal" data-bs-target="#reviewBooking" OnClientClick="return false"/>
      </div>
    </div>
    </div>
  </div>





    <asp:UpdatePanel ID="updatebookingRecordTable" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
        <ContentTemplate>
            <div class="container-xl px-3 mt-4">
                <h1 class="text-dark">Car Rental Booking Management</h1>
                <hr class="mt-0 mb-4">

                <div class="row">
                    <div class="col-6 col-md-8 search_style">
                        <div class="form">
                            <i class="fa fa-search"></i>
                            <asp:TextBox ID="txtBookingSearch" CssClass="form-control form-input" runat="server" placeholder="Search.."></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-6 col-md-2">
                        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control statusddl_style" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                            <asp:ListItem Value="All" Text="All Statuses" />
                            <asp:ListItem Value="Pending" Text="Pending" />
                            <asp:ListItem Value="Booked" Text="Booked" />
                            <asp:ListItem Value="Cancelled" Text="Cancelled" />
                            <asp:ListItem Value="Completed" Text="Completed" />
                        </asp:DropDownList>
                    </div>

                </div>

                <div>


                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover mb-2 mt-4 booking_record_table " id="bookingRecordTable">
                            <thead class="bg-secondary" style="line-height: 2;">
                                <tr class="header_row_title">



                                    <th class="booking_id">
                                        <asp:LinkButton ID="btnSortID" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Id" CssClass="text-dark sort-button">
                Booking ID<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                        </asp:LinkButton>
                                        <th class="booking_date">
                                            <asp:LinkButton ID="btnSortBookingDate" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="BookingDate" CssClass="text-dark sort-button">
    Booking Date<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                            </asp:LinkButton>
                                        </th>
                                    </th>
                                    <th class="booking_status">
                                        <asp:LinkButton ID="btnSortStatus" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Status" CssClass="text-dark sort-button">
                 Status 
                                        </asp:LinkButton>
                                        <asp:HiddenField ID="hdnSortDirection" runat="server" Value="" />
                                    </th>

                                    <th class="booking_pickup">
                                        <asp:LinkButton ID="btnSortPickUpLocation" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Pickup_point" CssClass="text-dark  sort-button">
                Pick Up & Drop Off Location <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                        </asp:LinkButton>
                                    </th>
                                    <th class="booking_pickup">
                                        <asp:LinkButton ID="btnSortPickUpTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="StartDate" CssClass="text-dark  sort-button">
                Pick Up Time <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                        </asp:LinkButton>
                                    </th>


                                    <th class="booking_dropoff">
                                        <asp:LinkButton ID="btnSortDropOffTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="EndDate" CssClass="text-dark sort-button">
                Drop Off Time<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                        </asp:LinkButton>
                                    </th>
                                    <th class="booking_cancel">
                                        <asp:LinkButton ID="btnCancelReason" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="CancelReason" CssClass="text-dark sort-button">
                Update Reason<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
                                        </asp:LinkButton>
                                    </th>
                                   

                                    <th class="booking_edit" style="width: 5%; text-align: center;">Action
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="bookingtable_record">

                                <asp:Repeater ID="rptBookingList" runat="server" OnItemDataBound="repeaterBookingList_ItemDataBound" OnItemCreated="repeaterBookingList_ItemCreated">
                                    <ItemTemplate>
                                        <tr class="rows1">
                                            <td>
                                                <div class=" align-items-center">
                                                    <div class="ms-1">

                                                        <p class="fw-bold mb-1"><%# Eval("Id") %></p>
                                                    </div>
                                                </div>
                                            </td>

                                            <td>
                                                <p class="fw-normal mb-1"><%# Eval("BookingDate","{0:dd/MM/yyyy hh:mm tt}") %></p>
                                            </td>

                                            <td>
                                                <span class="status_icon badge <%# GetBadgeClass(Eval("Status").ToString()) %> rounded-pill d-inline">
                                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                                </span>
                                                <asp:HiddenField ID="hdnBookStatus" runat="server" Value='<%# Eval("Status") %>' />
                                            </td>


                                            <td>
                                                <p class="fw-normal mb-1"><%# Eval("Pickup_point") %></p>
                                            </td>

                                            <td>
                                                <p class="text-muted mb-0"><%# Eval("StartDate","{0:dd/MM/yyyy hh:mm tt}") %></p>
                                            </td>



                                            <td>
                                                <p class="text-muted mb-0"><%# Eval("EndDate","{0:dd/MM/yyyy hh:mm tt}") %></p>
                                            </td>
                                            <td>
                                                <p class="text-muted mb-0"><%# Eval("UpdateReason") %></p>
                                            </td>
                                            
                                            <td>
                                                <asp:Button ID="btnView" runat="server" CssClass="btn btn-sm text-primary" Text="View" OnClick="btnView_Click" CommandArgument='<%# Eval("Id") %>' />
                                                <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-sm text-primary" Text="Mark as Done" OnClick="btnUpdate_Click" CommandArgument='<%# Eval("Id") %>' />

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
            
        </Triggers>
    </asp:UpdatePanel>

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        
    <script type="text/javascript" src="../JS/paging.js"></script>


    <script>


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

        function modal() {
            addEventListener("DOMContentLoaded", (event) => {
                $('#userInfoModal').modal('toggle');
                return false;
            });
        }
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


             setupSearchFunctionality(searchBoxId);

            initializePagination(); // Initialize on page load


         });
       
    </script>
    

</asp:Content>
