<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingrecorddetail.aspx.cs" Inherits="Assignment.bookingrecorddetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
        <link href="CSS/bookingrecorddetail.css" rel="stylesheet" />

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
                  <h2 class="mb-0">Thank you for your booking</h2>
                  <p class="mb-0">We appreciate your booking, were currently processing it. So hard tight and we will send
                    you confirmation very soon!</p>
                </div>
                <div>
                  
                  <!-- row -->
                  <div class="row justify-content-between booking_record">
                      <asp:Image ID="img_car" runat="server" />
                          <table class="booking_car_table">
                              <caption style="caption-side:top">
                                  Booking Number:
                                  <asp:Label ID="lblBookingNumber" runat="server" Text=""></asp:Label>
                              </caption>

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
                      Done
                    </p>
                    <p class="mb-0 text-dark">
                      Ending with 1243
                    </p>
                    <p class="mb-0">Expires 21/23</p>
                    
                  </div>
                  <div class="col-md-6 col-12">
                    <!-- text -->
                    <h4 class="mb-3">Booking Status</h4> 
                     <p>
                        Done
                     </p>
                  </div>
                    <div class="mt-4 text_center invoice_container">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info invoice_style">
                        <i class="ri-file-download-line"> Download Invoice</i>
                    </asp:LinkButton>
                    </div>
                </div>
              </div>
            </div>

              

          </div>
        </div>
      </section>
    </main>
           
</asp:Content>
