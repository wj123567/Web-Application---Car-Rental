<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingRecordUpdate.aspx.cs" Inherits="Assignment.bookingRecordUpdate" %>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

     <link href="CSS/bookingrecordupdate.css" rel="stylesheet" />

<div id="confirmModal" class="modal fade"  data-bs-backdrop="static" tabindex="-1"aria-labelledby="paymentModalLabel" aria-hidden="true">
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
           <!-- Page Content -->
    <main id="page-content" >
      
      <!-- Container fluid -->
      <section class="container-fluid p-4">
        
        <!-- row -->
        <div class="row justify-content-center" >
          <div class="col-lg-8 col-12" style="border:1px solid gray; ">
            <!-- card -->
            <div class="card">
              <!-- card body -->
              <div class="card-body">
                <div class="mb-6">
                  <!-- heading -->
                  <h2 class="mb-0">Update for Booking ID: <asp:Label ID="lblBookingNumber" runat="server" Text=""></asp:Label></h2>
                </div>
                <div>
                  
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
                                       <asp:TextBox ID="txtPickUpTime" TextMode="DateTimeLocal" runat="server"></asp:TextBox>
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
                                       <asp:TextBox ID="txtDropOffTime" TextMode="DateTimeLocal" runat="server"></asp:TextBox>
                                   </td>
                               </tr>
                              
                          </table>
                         
                          <table class="booking_price_table">
                              <tr class="booking_price_table_header">
                                  <th colspan="4">ADD on</th>
                              </tr>

                            <tr class="booking_price_table_title" >
                                <th colspan="2" style="width:60%">Type</th>
                                <th  style="width:20%">Initial Quantity</th>
                                <th  style="width:20%">New Quantity</th>
                            </tr>

                       <asp:Repeater ID="rptAddOnList" runat="server" OnItemDataBound="rptAddOnList_ItemDataBound">
                       <ItemTemplate>
                              <tr class="booking_price_table_info">
                                  <td colspan="2">
                                     <%# Eval("Name").ToString() == "No Record Found" ? "No Record Found" : Eval("Name") %>
                                  </td>  
                                  <td >
                                      <%# Eval("Name").ToString() == "No Record Found" ? "" : Eval("Quantity") %>
                                  </td>
                                  <td>
                                      <asp:DropDownList ID="ddlNewQuantity" CssClass="btn btn-light ddlQuantity_style" runat="server" Visible='<%# Eval("Name").ToString() != "No Record Found" %>'>

                                      </asp:DropDownList>
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
                    <asp:Button ID="btnConfirm" runat="server" CssClass="confirm_btn_style" Text="Confirm" OnClick="btnConfirm_Click" />
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
                 <!-- card -->
 <div class="card mt-4">
   <!-- card body -->
   <div class="card-body">
    
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

</script>
</asp:Content>
