<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="BookingManagement.aspx.cs" Inherits="Assignment.Management.BookingManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/bookingManagement.css" rel="stylesheet" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnUserStatus" runat="server" />



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
                    <div class="Userprofile-image-frame mx-auto">
                    <asp:Image ID="userProfilePic" runat="server" CssClass="img-account-profile rounded-circle mb-2 mx-auto" Width="100px"/>
                    </div>
                    
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
       <asp:Button ID="btnUserNext" CssClass="btn btn-primary" runat="server" Text="Next" />
      </div>
    </div>
    </div>
  </div>


     <div class="modal animate__animated animate__slideInRight animate__faster" id="userDriverModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="userDriverModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
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
        <asp:Repeater ID="UserDriverReapeter" runat="server" OnItemDataBound="UserDriverReapeter_ItemDataBound">
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
          <asp:Button ID="btnDriverNext" CssClass="btn btn-primary" runat="server" Text="Next" />
    </div>
    </div>
    </div>
  </div>



      <div class="container-xl px-4 mt-4">
  <h1 class="text-dark">Car Rental Booking Management</h1>
  <hr class="mt-0 mb-4">

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
                <asp:ListItem Value="Processing" Text="Processing" />
                <asp:ListItem Value="Booked" Text="Booked" />
                <asp:ListItem Value="Cancelled" Text="Cancelled" />
           </asp:DropDownList>
        </div>
        <div class="col-6 col-md-2 text-end">
            
            <asp:Button ID="btnFilter" runat="server"   cssclass="btn btn-secondary filter_btn" Text="Filter" />
           <i class="ri-filter-fill"></i>

    </div>
</div>

  <div>

<asp:UpdatePanel ID="updatebookingRecordTable" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
    <ContentTemplate>
<table class="table align-middle mb-0 booking_record_table datatable" id="bookingRecordTable">
    <thead class="bg-secondary" style=" line-height:2;">
      <tr class="header_row_title" >

         

        <th class="booking_id">
            <asp:LinkButton ID="btnSortID" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Id" CssClass="text-dark  sort-button">
            Booking ID<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
            </asp:LinkButton>
            
        </th>
         <th class="booking_status">
             <asp:LinkButton ID="btnSortStatus" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Status" CssClass="text-dark sort-button">
             Status 
            </asp:LinkButton>
             <asp:HiddenField ID="hdnSortDirection" runat="server" Value="" />
         </th>
        <th class="booking_vehicle">
            <asp:LinkButton ID="btnSortVehicle" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="CarPlate" CssClass="text-dark sort-button">
            Vehicle Plate No. 
            </asp:LinkButton>
        </th>
        <th class="booking_pickup">
            <asp:LinkButton ID="btnSortPickUpLocation" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Pickup_point" CssClass="text-dark  sort-button">
            Pick Up Location <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
            </asp:LinkButton>
        </th>            
         <th class="booking_pickup">
            <asp:LinkButton ID="btnSortPickUpTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="StartDate" CssClass="text-dark  sort-button">
            Pick Up Time <i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
            </asp:LinkButton>
        </th>

        <th class="booking_dropoff">
            <asp:LinkButton ID="btnSortDropOffLocation" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Dropoff_point" CssClass="text-dark sort-button">
            Drop Off Location<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
            </asp:LinkButton>
        </th>            
         <th class="booking_dropoff">
            <asp:LinkButton ID="btnSortDropOffTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="EndDate" CssClass="text-dark sort-button">
            Drop Off Time<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
            </asp:LinkButton>
        </th>
         <th class="booking_reject">
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="EndDate" CssClass="text-dark sort-button">
            Reject Reason<i class="sort-icon ri-arrow-down-s-fill" style="margin-right:10px"></i>
            </asp:LinkButton>
        </th>

         <th class="booking_edit" style="width:5%;text-align:center;">
             Action
         </th>
      </tr>
    </thead>
    <tbody id="bookingtable_record">

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
             <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
               
      </td>
  
    <td>
    <p class="fw-normal mb-1"><%# Eval("CarPlate") %></p>
    </td>

    <td>
      <p class="fw-normal mb-1"><%# Eval("Pickup_point") %></p>

    </td>

    <td>
      <p class="text-muted mb-0"><%# Eval("StartDate") %></p>
    </td>

    <td>
        <p class="fw-normal mb-1"><%# Eval("Dropoff_point") %></p>
    </td>
    
    <td>
          <p class="text-muted mb-0"><%# Eval("EndDate") %></p>
    </td>
     
    <td>
          <asp:Button ID="btnView" runat="server" CSSclass="edit_btn_style" Text="View" OnClick="btnView_Click" CommandArgument='<%# Eval("Id") %>'/>
    </td>
  </tr>
  </ItemTemplate>
 </asp:Repeater>  
       
    </tbody>
   
  </table>
       
</ContentTemplate>


</asp:UpdatePanel>
       
  </div>
  </div>   

    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

     <script>
         $(document).ready(function () {
             var searchBoxId = "#" + '<%= txtBookingSearch.ClientID %>';

  
     $(searchBoxId).on("keyup", function () {
         var value = $(this).val().toLowerCase();
         $("#bookingtable_record tr").filter(function () {
             $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
         });
     });

     function initializePagination() {
         $('#bookingRecordTable').paging({ limit: 10 });
     }

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


     if (window.history.replaceState) {
         window.history.replaceState(null, null, window.location.href);
     }

     function loadModal() {
         document.addEventListener("DOMContentLoaded", modal);
         document.addEventListener("DOMContentLoaded", showhideButton);
     }

     function showhideButton() {
         var hdnUserStatus = document.getElementById('<%= hdnUserStatus.ClientID %>').value;
         var buttonGroup = document.querySelectorAll(".btn-both");
         var button = null;

         buttonGroup.forEach(function (btn) {
             btn.style.display = "none";
         });

         if (hdnUserStatus == "0") {
             button = document.querySelectorAll(".btn-ban");
         } else {
             button = document.querySelectorAll(".btn-unban");
         }

         button.forEach(function (btn) {
             btn.style.display = "block";
         });
     }


     function modal() {
         addEventListener("DOMContentLoaded", (event) => {
         $('#userInfoModal').modal('toggle');
         showhideButton();
         return false;
         });
     };

     function modalDel() {
         addEventListener("DOMContentLoaded", (event) => {
             $('#ConfirmDelete').modal('toggle');
             showhideButton();
             return false;
         });
     };


     </script>

</asp:Content>
