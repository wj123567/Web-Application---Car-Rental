<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingrecord.aspx.cs" Inherits="Assignment.bookingrecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="CSS/bookingrecord.css" rel="stylesheet" />

    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
    <div class="booking_container">
        <p class="booking_title">Car Rental Booking</p>
        
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
             <th class="booking_status" style="border:1px solid green">
                 <asp:LinkButton ID="btnSortStatus" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Status" CssClass="text-dark">
                 <span style="border:1px solid red">Status <i class="ri-arrow-up-s-fill" style="margin-right:10px;"></i></span>
                </asp:LinkButton>
             </th>
            <th class="booking_vehicle">
                <asp:LinkButton ID="btnSortVehicle" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="CarPlate" CssClass="text-dark">
                Vehicle Plate No.
                </asp:LinkButton>
            </th>
            <th class="booking_pickup">
                <asp:LinkButton ID="btnSortPickUpLocation" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="PickUp" CssClass="text-dark">
                Pick Up Location
                </asp:LinkButton>
            </th>            
             <th class="booking_pickup">
                <asp:LinkButton ID="btnSortPickUpTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="PickUp" CssClass="text-dark">
                Pick Up Time
                </asp:LinkButton>
            </th>

            <th class="booking_dropoff">
                <asp:LinkButton ID="btnSortDropOffLocation" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DropOff" CssClass="text-dark">
                Drop Off Location
                </asp:LinkButton>
            </th>            
             <th class="booking_dropoff">
                <asp:LinkButton ID="btnSortDropOffTime" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DropOff" CssClass="text-dark">
                Drop Off Time
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
               <span class="status_icon badge <%# GetBadgeClass(Eval("Status").ToString()) %> rounded-pill d-inline">
                   <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                   
               </span>
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
              <p class="fw-normal mb-1"><%# Eval("Price") %></p>
        </td>
         
        <td>
              <asp:Button ID="btnView" runat="server" CSSclass="edit_btn_style" Text="View" OnClick="btnView_Click"  CommandArgument='<%# Eval("Id") %>'/>
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

        <h4>Test Retrieve</h4>
        <asp:GridView ID="gvBook" runat="server" CellPadding="10">
            <Columns>
                <asp:HyperLinkField DataNavigateUrlFields="CustomerName" DataNavigateUrlFormatString="bookingrecorddetail.aspx?CustomerName={0}" ShowHeader="False" Text="View More" />
            </Columns>
        </asp:GridView>
 


     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

      <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

	
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
        
    <script type="text/javascript" src="JS/paging.js"></script>

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

    </script>
 
</asp:Content>
