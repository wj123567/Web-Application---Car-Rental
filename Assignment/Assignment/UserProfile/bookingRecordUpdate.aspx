<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingRecordUpdate.aspx.cs" Inherits="Assignment.bookingRecordUpdate" %>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

     <link href="../CSS/bookingrecordupdate.css" rel="stylesheet" />
    <asp:HiddenField ID="hdnAddOnUpdateChk" runat="server"  />
    <asp:HiddenField ID="hdnDeletingAddOnId" runat="server" />

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
           <!-- Page Content -->
    <main id="page-content" >
      
      <!-- Container fluid -->
      <section class="container-fluid p-4" style="margin-bottom:20px;">
        
        <div class="row justify-content-center" >
          <div class="col-lg-8 col-12" style="border:1px solid gray; ">
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
                                      <asp:TextBox ID="txtNotes" TextMode="MultiLine" runat="server" Rows="5" Columns="100"></asp:TextBox>
                                  </td>
                              </tr>
                              
                          </table>
                      <asp:Label ID="lblDeleteAddOnAmt" runat="server" Text="0.00"></asp:Label>
                      <asp:Label ID="lblCheck2" runat="server" Text="Label"></asp:Label>
                          <table class="booking_price_table">
                              <tr class="booking_price_table_header">
                                  <th colspan="4">ADD ON</th>
                              </tr>

                            <tr class="booking_price_table_title" >
                                <th colspan="2" style="width:60%">Type</th>
                                <th  style="width:20%">Initial Quantity</th>
                                <th  style="width:20%">Edit Quantity</th>
                                <th></th>
                            </tr>

                       <asp:Repeater ID="rptAddOnList" runat="server" OnItemDataBound="rptAddOnList_ItemDataBound">
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
                        </asp:Repeater>  

                          </table>
                      
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

</script>
</asp:Content>
