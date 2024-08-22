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
                <div class="col-6 col-md-4">
                   <asp:DropDownList ID="ddlStatusFilter" runat="server" cssclass="form-control statusddl_style" AutoPostBack="True" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                        <asp:ListItem Value="All" Text="All Statuses" />
                        <asp:ListItem Value="Pending" Text="Pending" />
                        <asp:ListItem Value="Booked" Text="Booked" />
                        <asp:ListItem Value="Cancelled" Text="Cancelled" />
                   </asp:DropDownList>
                </div>
               
                <div class="row mt-4">
                     <div class ="col">
                        <asp:Button ID="btnToReview" runat="server" Text="All" CssClass="btn btn-lg border border-dark sort-button-group" OnClick="sortReview" OnClientClick="colorButton(this)" BackColor="#3490DC" ForeColor="White" />
                         <asp:Button ID="btnReviewed" runat="server" Text="Pending" CssClass="btn btn-lg border border-dark sort-button-group" OnClick="sortReview" OnClientClick="colorButton(this)"/>
                        
                     </div>
                    
                </div>
        </div>
      

        <asp:UpdatePanel ID="updatebookingRecordTable" class="bookingRecordTablePanel" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
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
            <th class="booking_price">
                <asp:LinkButton ID="btnSortPrice" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Price" CssClass="text-dark  sort-button">
                Price<i class="sort-icon ri-arrow-up-s-fill" style="margin-right:10px"></i>
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
      
        <td class="carplate_data">
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

        <td class="price_data">
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
