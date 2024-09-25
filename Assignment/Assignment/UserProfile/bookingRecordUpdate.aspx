<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingRecordUpdate.aspx.cs" Inherits="Assignment.bookingRecordUpdate" %>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

     <link href="../CSS/bookingrecordupdate.css" rel="stylesheet" />
    <asp:HiddenField ID="hdnAddOnUpdateChk" runat="server"  />
    <asp:HiddenField ID="hdnDeletingAddOnId" runat="server" />
    <asp:HiddenField ID="hdnExtraAddOnCheck" runat="server" />

<div id="confirmModal" class="modal fade"  data-bs-backdrop="static" tabindex="-1" aria-labelledby="updateModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Save Update Changes</h5>
     
            </div>
            <div class="modal-body">
                <p>Are you sure you want to update those changes?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <asp:Button ID="modalYesBtn" runat="server" CssClass="btn btn-primary" Text="Ok" data-bs-dismiss="modal" OnClick="modalYesBtn_Click" />
            </div>
        </div>
    </div>
</div>

    <div id="clearAddOnModal" class="modal fade"  data-bs-backdrop="static" tabindex="-1" aria-labelledby="deleteAddOnModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Delete Add On</h5>
     
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete this add on selection?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <asp:Button ID="btnClear" runat="server" CssClass="btn btn-primary" Text="Ok"   OnClick="modalAddOnClearBtn_Click" />
            </div>
        </div>
    </div>
</div>

<div class="modal animate__animated animate__slideInLeft animate__faster" id="addOnModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addOnModal" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">Add On</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <asp:Repeater ID="rptAddOns" runat="server">
<HeaderTemplate>
<table class="addon_container">
  
    <tr class="addon_title" >
        <th style="width:10%" class="addon_icon_header"></th>
        <th style="width:50%;padding-left:5%;" class="addon_type_header">Type</th>
        <th style=" width:20%; text-align:center;" class="addon_price_header">Price</th>
        <th style=" width:20%; text-align:center; "class="addon_quantity_header">Quantity</th>
    </tr>
 </HeaderTemplate>
  <ItemTemplate>
    <tr class="addon_list">
        <td rowspan="2"><asp:Image ID="imgIcon" runat="server" Width="45px" Height="45px" ImageUrl='<%# Eval("Url") %>' /></td>
        <td class="addon_list_title"><%# Eval("Name") %></td>
        <td class="text_center" data-price='<%# Eval("Price") %>'> <asp:Label ID="lblAddOnPrice" runat="server" Text='<%# Eval("Price","{0:F2}") %>'></asp:Label></td>
        
        <td rowspan="2" style="text-align:center">
            <asp:TextBox ID="txtAddOnQuantity" runat="server" TextMode="Number" CssClass="quantity_style quantity_input" min="0" max='<%# Eval("MaxQuantity") %>' value="0" ></asp:TextBox>
             <asp:HiddenField ID="hfAddOnID" runat="server" Value='<%# Eval("Id") %>' />
        </td>
    </tr>
    <tr class="addon_list">
        <td class="addon_subinfo"><%# Eval("Description") %></td>
    </tr>
    <tr class="separator">
        <td style="visibility:hidden">a</td>
    </tr>
   
    </ItemTemplate>

     <FooterTemplate>
    <tr>
        <td class="end_text" colspan="3">TOTAL(RM)</td>
        <td class="end_text addon_total">
            <asp:Label ID="lblTotalAddOn" runat="server" Text="0.00"></asp:Label> 
           
        </td>
    </tr>

    <tr class="separator">
       <td style="visibility:hidden">a</td>                 
    </tr> 
</table>
</FooterTemplate>
</asp:Repeater>
        
    </div>
      <div class="modal-footer">
          <asp:Button ID="btnConfirmNewAddOn"  CssClass="btn btn-primary " runat="server" Text="Confirm Add"   OnClick="btnConfirmNewAddOn_Click"/>
      </div>
    </div>
    </div>
  </div>  


           <!-- Page Content -->
    <main id="page-content" >
      
      <!-- Container fluid -->
      <section class="container-fluid p-4" style="margin-bottom:20px;">
        
        <div class="row justify-content-center" >
          <div class="col-lg-8 col-12">
            <div class="card">
              <div class="card-body">
                  <div class ="row">
                      <div class="col-1">
     <div>
         <asp:LinkButton ID="lkbtnBack" runat="server" CssClass="btn btn-lg text-center back_btn" OnClick="lkbtnBack_Click"><i class="fa fa-arrow-left fa-2x"></i></asp:LinkButton>                        
     </div>
</div>
                      <div class="col-11 mb-6">
                           <h2 class="mb-0">Update for Booking ID: <asp:Label ID="lblBookingNumber" runat="server" Text=""></asp:Label></h2>
                      </div>
                  </div>
                  
               
                
                  <!-- row -->
                  <div class="row justify-content-between booking_record">
                      
                          <table class="booking_car_table">

                              <tr class="booking_car_table_header">
                                  <th colspan="5">
                                      CAR RENTAL INFO
                                  </th>
                              </tr>
   
                              <tr class="booking_car_table_info">
                                  <th style="width:30%">Plate Number:</th>
                                  <td style="width:70%">
                                      <asp:Label ID="lblPlateNum" runat="server" Text="Label"></asp:Label>

                                  </td>
                              </tr>
                               <tr class="booking_car_table_info">
                                   <th style="width:30%">Pick Up Location</th>
                                   <td style="width:70%">
                                       <asp:Label ID="lblPickUpLocation" runat="server" Text="Label"></asp:Label>
                                   </td>
                               </tr>
                               <tr class="booking_car_table_info">
                                   <th style="width:30%">Pick Up Time</th>
                                   <td style="width:70%">    
                                       <asp:Label ID="lblPickUpTime" runat="server" Text="Label"></asp:Label>
                                   </td>
                               </tr>
                               <tr class="booking_car_table_info">
                                   <th style="width:30%">Drop Off Location</th>
                                   <td style="width:70%">
                                       <asp:Label ID="lblDropOffLocation" runat="server" Text="Label"></asp:Label>
                                   </td>
                               </tr>
                               <tr class="booking_car_table_info">
                                   <th style="width:30%">Drop Off Time</th>
                                   <td style="width:70%">                         
                                       <asp:Label ID="lblDropOffTime" runat="server" Text="Label"></asp:Label>
                                   </td>
                               </tr>
                              <tr class="booking_car_table_info">
                                  <th>Notes</th>
                                  <td>
                                      <asp:TextBox ID="txtNotes" TextMode="MultiLine" runat="server" Rows="5" Columns="100" CssClass="note_multilineText"></asp:TextBox>
                                  </td>
                              </tr>
                              
                          </table>


                      <asp:Repeater ID="rptAddOnList" runat="server" OnItemDataBound="rptAddOnList_ItemDataBound">
                          <HeaderTemplate>
                          <table class="booking_price_table">
                              <tr class="booking_price_table_header">
                                  <th colspan="5" style="text-align:center">ADD ON </th>
                                  
                              </tr>

                            <tr class="booking_price_table_title" >
                                <th colspan="2" style="width:60%">Type</th>
                                <th  style="width:20%">Initial Quantity</th>
                                <th  style="width:20%">Edit Quantity</th>
                                <th></th>
                            </tr>

                       </HeaderTemplate>
                       <ItemTemplate>
                           
                              <tr class="booking_price_table_info">
                                  <td colspan="2">
                                      <asp:HiddenField ID="hdnAddOnId" runat="server"  Value='<%# Eval("AddOnId").ToString() %>'/>
                                      <asp:Label ID="lblAddOnName" runat="server" Text=' <%# Eval("Name").ToString() == "No Record Found" ? "No Record Found" : Eval("Name") %>'>
                                      </asp:Label>                                  
                                  </td>  
                                  <td >
                                      <asp:Label ID="lblAddOnQuantity" runat="server" Text=' <%# Eval("Name").ToString() == "No Record Found" ? "" : Eval("Quantity") %>'>
                                      </asp:Label>                                    
                                  </td>
                                  <td>
                                      <asp:DropDownList ID="ddlNewQuantity" CssClass="btn btn-light ddlQuantity_style" runat="server" Visible='<%# Eval("Name").ToString() != "No Record Found" %>'>
                                      </asp:DropDownList>    
                                  </td>
                                  <td>
                                      <asp:Button ID="btnAddOnClear" runat="server" Text="Remove" CssClass="btn btn-danger" Visible='<%# Eval("Name").ToString() != "No Record Found" %>' CommandArgument='<%# Eval("AddOnId").ToString() %>' OnClick="btnClear_Click" />
                                  </td>
                                  
                              </tr>
                           
                         </ItemTemplate>
                          <FooterTemplate>
                              </table>
                          </FooterTemplate>
                          </asp:Repeater>  
                               
                                  
                             <div class="container mt-2">
                                 <div class="row">
                                     <asp:Button ID="btnAddOn" runat="server" Text="Go for Extra Add On"  CssClass="btn btn-success" OnClick="btnAddOn_Click"/>
                                     
                                 </div>
                             </div>
         
   

                            
                         
                            

                        
                             
                      
                  </div>

                    <!--confirm btn-->
                    <div class="container">
                    <div class="row justify-content-end">
                        <div class="col-auto">
                    <asp:Button ID="btnConfirm" runat="server" CssClass="confirm_btn_style" Text="Confirm Edit" OnClick="btnConfirm_Click" />
                        </div>
                    </div>
                  </div>

                  <div class="booking_summary_container">
                    <!-- list -->
                    <ul class="list-unstyled mb-0">
                      <li class="d-flex justify-content-between mb-2">
                        <span>Subtotal</span>
                        <span class="text-dark fw-medium">128.00</span>
                      </li>
                      <li class="d-flex justify-content-between mb-2">
                        <span>Shipping</span>
                        <span class="text-dark fw-medium">0.00</span>
                      </li>
                      <li class="d-flex justify-content-between mb-2">
                        <span>Discount</span>
                        <span class="text-dark fw-medium">0.00</span>
                      </li>
                      <li class="d-flex justify-content-between mb-2">
                        <span>Tax</span>
                        <span class="text-dark fw-medium">0.00</span>
                      </li>
                      <li class="border-top my-2"></li>
                      <li class="d-flex justify-content-between mb-2">
                        <span class="fw-medium text-dark">Grand Total(RM)</span>
                        <span class="fw-medium text-dark">128.00</span>
                      </li>
                    </ul>
                  </div>
                </div>
              </div>
              

                
          </div>
             
        </div>
      </section>
    </main>


<script>
    function loadModal() {
    document.addEventListener("DOMContentLoaded", modal);
   
}

    function modal() {
    addEventListener("DOMContentLoaded", (event) => {
        $('#confirmModal').modal('toggle');
        return false;
    });
    };

    function addOnmodal() {
        addEventListener("DOMContentLoaded", (event) => {
            $('#clearAddOnModal').modal('toggle');
            return false;
        });
    };

    function addExtraAddOnModal() {
        addEventListener("DOMContentLoaded", (event) => {
            $('#addOnModal').modal('toggle');
            return false;
        });
    }

    document.addEventListener('DOMContentLoaded', function () {
        function updateTotal() {
            let total = 0.00;
            const quantities = document.querySelectorAll('.quantity_input');

            quantities.forEach(input => {   //when updateTotal is called, calculate again the total price in this code block
                const price = parseFloat(input.closest('tr').querySelector('.text_center[data-price]').dataset.price);
                const quantity = parseInt(input.value);
                total += price * quantity;      //add on continuously

            });

            document.querySelector('.addon_total').textContent = total.toFixed(2);  //decimal place
        }

        // Add event listeners to quantity inputs
        document.querySelectorAll('.quantity_input').forEach(input => {
            input.addEventListener('input', updateTotal);       //call the updateTotal every time user change on the quantity(fires everytime input change)
        });

        // Initial calculation on page load to set initial total value
        updateTotal();

       
    });

</script>
</asp:Content>
