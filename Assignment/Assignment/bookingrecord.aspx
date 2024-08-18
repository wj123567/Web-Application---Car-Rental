<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingrecord.aspx.cs" Inherits="Assignment.bookingrecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
    <div class="booking_container">
        <p class="booking_title">Car Rental Booking</p>

        <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
    <asp:ListItem Value="All" Text="All Statuses" />
    <asp:ListItem Value="Processing" Text="Processing" />
    <asp:ListItem Value="Booked" Text="Booked" />
    <asp:ListItem Value="Cancelled" Text="Cancelled" />
        </asp:DropDownList>

        <asp:UpdatePanel ID="updatebookingRecordTable" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
        <ContentTemplate>
    <table class="table align-middle mb-0 bg-white booking_record_table datatable" id="bookingRecordTable">
        <thead class="bg-light">
          <tr class="header_row_title">
            <th class="booking_id">
                <asp:LinkButton ID="btnSortID" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Id" CssClass="text-dark">
                Booking ID
                </asp:LinkButton>
                
            </th>
             <th class="booking_status">
                 <asp:LinkButton ID="btnSortStatus" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Status" CssClass="text-dark">
                 Status
                </asp:LinkButton>
             </th>
            <th class="booking_vehicle">
                <asp:LinkButton ID="btnSortVehicle" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="CarPlate" CssClass="text-dark">
                Vehicle
                </asp:LinkButton>
            </th>
            <th class="booking_pickup">
                <asp:LinkButton ID="btnSortPickUp" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="PickUp" CssClass="text-dark">
                Pick Up 
                </asp:LinkButton>
            </th>
            <th class="booking_dropoff">
                <asp:LinkButton ID="btnSortDropOff" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DropOff" CssClass="text-dark">
                Drop Off 
                </asp:LinkButton>
            </th>
            <th class="booking_price">
                <asp:LinkButton ID="btnSortPrice" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Price" CssClass="text-dark">
                Price
                </asp:LinkButton>
            </th>
             <th class="booking_edit" style="width:5%;"></th>
          </tr>
        </thead>
        <tbody>

    <asp:Repeater ID="rptBookingList" runat="server">
    <ItemTemplate>
          <tr>
        <td>
          <div class=" align-items-center">    
            <div class="ms-1">
              <p class="fw-bold mb-1"><%# Eval("Id") %></p>
            </div>
          </div>
        </td>
      
           <td>         
               <span class="status_icon badge <%# GetBadgeClass(Eval("Status").ToString()) %> rounded-pill d-inline">
                   <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                   
               </span>
          </td>
      
        <td>
        <p class="fw-normal mb-1"><%# Eval("CarPlate") %></p>
      
        </td>

              <!-- car type maybe-->

        <td>
          <p class="fw-normal mb-1"><%# Eval("Pickup_point") %></p>
          <p class="text-muted mb-0"><%# Eval("StartDate") %></p>
      
        </td>
        <td>
            <p class="fw-normal mb-1"><%# Eval("Dropoff_point") %></p>
            <p class="text-muted mb-0"><%# Eval("EndDate") %></p>
        </td>
          <td>
              <p class="fw-normal mb-1"><%# Eval("Price") %></p>
          </td>
         
          <td>
              <asp:Button ID="btnEdit1" runat="server" CSSclass="edit_btn_style" Text="Edit" />
          </td>
      </tr>
      </ItemTemplate>
     </asp:Repeater>  
         
          
        </tbody>
      </table>
    </ContentTemplate>


    </asp:UpdatePanel>
      </div>
      

        <h4>Test Retrieve</h4>
        <asp:GridView ID="gvBook" runat="server" CellPadding="10">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="CustomerName" DataNavigateUrlFormatString="bookingrecorddetail.aspx?CustomerName={0}" ShowHeader="False" Text="View More" />
            </Columns>
        </asp:GridView>
 
    <!-- jQuery -->
<script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- DataTables CSS -->
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
<!-- DataTables JS -->
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>

    <script>
     $(document).ready(function() {
         $('#bookingRecordTable').DataTable({
         "pageLength": 10,        // Show 10 entries per page
         "order": [],             // Disable initial sorting
         "columnDefs": [
             {
                 "targets": 3,     // Index of Start Date column
                 "type": "date"    // Data type of Start Date column
             }
         ]
     });
     });
    </script>
</asp:Content>
