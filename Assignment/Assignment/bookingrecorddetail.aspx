<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingrecorddetail.aspx.cs" Inherits="Assignment.bookingrecorddetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
        <link href="CSS/bookingrecorddetail.css" rel="stylesheet" />

    <div id="deleteModal" class="modal fade"  data-bs-backdrop="static" tabindex="-1"aria-labelledby="paymentModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Booking Cancellation</h5>
     
            </div>
            <div class="modal-body">
                <p>Are you sure you want to cancel the booking</p>
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
                  <h2 class="mb-0">Booking ID: <asp:Label ID="lblBookingNumber" runat="server" Text=""></asp:Label></h2>
                </div>
                <div>
                  
                  <!-- row -->
                  <div class="row justify-content-between booking_record">
                      <asp:Image ID="img_car" runat="server" />
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
                              
                          </table>
                         
                          <table class="booking_price_table">
                              <tr class="booking_price_table_header">
                                  <th colspan="4">Charges Detail</th>
                              </tr>

                            <tr class="booking_price_table_title" >
                                <th colspan="2" style="width:50%">Type</th>
                                <th colspan="2" style="border-right:none;width:50%">Price(RM)</th>
                            </tr>
                              <tr class="booking_price_table_info">
                                  <td colspan="2">Rental</td>  
                                  <td colspan="2" style="border-right:none">
                                      <asp:Label ID="lblRental" runat="server" Text="Label"></asp:Label>
                                  </td>
                              </tr>
                              
                              <tr class="booking_price_table_info">
                                  <td colspan="2" style="border-bottom: 2px solid gray">
                                      Add on
                                      <br />
                                      <span class="addon_description">
                                          <asp:Label ID="lblAddOnDesc" runat="server" Text="Label"></asp:Label>
                                      </span>
                                  </td>
                                  <td colspan="2" style="border-right:none; border-bottom: 2px solid gray">
                                      <asp:Label ID="lblAddOnPrice" runat="server" Text="Label"></asp:Label>
                                  </td>
                              </tr>
                              

                          </table>

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
    
     <div class="row">
       <div class="col-md-6 col-12">
         <!-- address -->
         <h4>Payment Status</h4>
         <p>
           <span class=" badge bg-success">Paid</span>
         </p>
         <p class="mb-0 text-dark">
           Ending with <asp:Label ID="lblCardNumberEnd" runat="server" Text="Label"></asp:Label>
         </p>
         <p class="mb-0">Expires 21/23</p>
         
       </div>
       <div class="col-md-6 col-12">
         <!-- text -->
         <h4 class="mb-3">Booking Status</h4> 
          <p>
             <asp:Label ID="lblBookStatus" CssClass="badge"  runat="server" Text="Label"></asp:Label>
          </p>
       </div>
        
   </div>
 </div>

<div class="container">
     <div class="row justify-content-end">
           <div class="col-auto">
               <asp:Button ID="btnEdit" CssClass="booking_edit_btn" runat="server" Text="Edit" />
               </div>
           <div class="col-auto">
               <asp:Button ID="btnDelete" CssClass="booking_delete_btn" runat="server" Text="Delete" OnClick="btnDelete_Click"/>
               </div>
      </div>
</div>

 </div>
<div class="mt-4 text_center invoice_container">
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info invoice_style">
    <i class="ri-file-download-line"> Download Invoice</i>
</asp:LinkButton>
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
        $('#deleteModal').modal('toggle');
        return false;
    });
    };

       
    </script>
</asp:Content>
