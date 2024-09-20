<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingrecorddetail.aspx.cs" Inherits="Assignment.bookingrecorddetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
        <link href="../CSS/bookingrecorddetail.css" rel="stylesheet" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div id="cancelModal" class="modal fade"  data-bs-backdrop="static" tabindex="-1" aria-labelledby="cancelModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered " role="document">
        <div class="modal-content">
             <asp:UpdatePanel ID="updateReason" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
            <ContentTemplate>
            <div class="modal-header">
                <h5 class="modal-title">Booking Cancellation</h5>
     
            </div>
            <div class="modal-body">
                <asp:DropDownList ID="ddlCancelReason" runat="server" CssClass="form-select" AutoPostBack="True" ValidationGroup="rejectGroup" OnSelectedIndexChanged="ddlCancelReason_SelectedIndexChanged">
                    <asp:ListItem Value="0">Select Reject Reason</asp:ListItem>
                    <asp:ListItem>Change of Plans</asp:ListItem>
                    <asp:ListItem>Found a Better Deal</asp:ListItem>
                    <asp:ListItem>Vehicle No Longer Needed</asp:ListItem>
                    <asp:ListItem>Booking Mistake</asp:ListItem>
                    <asp:ListItem>Unexpected Emergency</asp:ListItem>
                    <asp:ListItem>Other</asp:ListItem>

                </asp:DropDownList>

                 <asp:RequiredFieldValidator ID="requireReason" runat="server" ErrorMessage="Cancel Reason is Required" CssClass="validate" InitialValue="0" ValidationGroup="rejectGroup" ControlToValidate="ddlCancelReason"></asp:RequiredFieldValidator>
                 <asp:TextBox ID="txtOtherReason" runat="server" ValidationGroup="rejectGroup" CssClass="form-control mt-1" placeholder="Other Reason" Visible="False"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="requireOtherReason" runat="server" ErrorMessage="Other Reason is Required" CssClass="validate" ValidationGroup="rejectGroup" ControlToValidate="txtOtherReason" Enabled="False"></asp:RequiredFieldValidator>
            </div>
            </ContentTemplate>
            </asp:UpdatePanel>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <asp:Button ID="modalYesBtn" runat="server" CssClass="btn btn-primary" Text="Ok" data-bs-dismiss="modal" ValidationGroup="rejectGroup" OnClick="modalYesBtn_Click" />
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
              <div class="row">
                <div class="col-8">
                  <!-- heading -->
                  <h3 class="mb-0">Booking ID: <asp:Label ID="lblBookingNumber" runat="server" Text=""></asp:Label></h3>
                    </div>
                   <div class=" col-2 ">
                         <asp:Button ID="btnEdit" CssClass="booking_edit_btn" runat="server" Text="Edit" OnClick="btnEdit_Click" />
                   </div>
                    <div class="col-2">
                         <asp:Button ID="btnDelete" CssClass="booking_delete_btn" runat="server" Text="Cancel" OnClick="btnDelete_Click"/>
                    </div>
            </div>          
     
    
                <div>
                  
                  <!-- row -->
                  <div class="row justify-content-between booking_record">
                      <div class="d-flex flex-row flex-wrap">
                          <div style="flex:1;"><asp:Image ID="img_car" runat="server" /></div>
                          <div style="flex:3;">
                              <div class="rating-container" style="border:1px solid lightgray;">
                                  <div class="rate-first-row">
                                    <h5 style="display: inline-block; font-size: clamp(18px, 3vh, 33px)">
                                        <strong>Rate Here: </strong>
                                    </h5>
                                    <div class="rating d-inline-block" style="flex:1">
                                        <asp:LinkButton ID="btnStar1" runat="server"><i class="fa-solid fa-star checked"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnStar2" runat="server"><i class="fa-solid fa-star checked"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnStar3" runat="server"><i class="fa-solid fa-star checked"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnStar4" runat="server"><i class="fa-solid fa-star checked"></i></asp:LinkButton>
                                        <asp:LinkButton ID="btnStar5" runat="server"><i class="fa-solid fa-star checked"></i></asp:LinkButton>
                                    </div>
                                  </div>
                                  <div class="rate-second-row">
                                      <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5" Columns="100" CssClass="txtComment"></asp:TextBox>
                                  </div>
                                  <br />
                                  <div class="">
                                      <asp:LinkButton ID="submit" runat="server" CssClass="btn btn-success" data-bs-toggle="modal" data-bs-target="#submitComment">Submit</asp:LinkButton></div>
                              </div>
                          </div>
                      </div>


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
                                  <th>
                                      Notes
                                  </th>
                                  <td>
                                      <asp:Label ID="lblNotes" runat="server" Text="Label"></asp:Label>
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



 </div>
<div class="mt-4 text_center invoice_container">
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info invoice_style">
    <i class="ri-file-download-line"> Download Invoice</i>
</asp:LinkButton>
</div>
                
          </div>
             
        </div>
            </div>
      </section>

       <%-- you Modal --%>
        <!-- Modal -->
        <div class="modal fade" id="submitComment" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel"></h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                Submit Successful!
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>
    </main>



       

<script>

    function loadModal() {
    document.addEventListener("DOMContentLoaded", modal);
   
}

    function modal() {
    addEventListener("DOMContentLoaded", (event) => {
        $('#cancelModal').modal('toggle');
        return false;
    });
    };

</script>
</asp:Content>
