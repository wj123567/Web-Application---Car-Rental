<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="bookingrecord.aspx.cs" Inherits="Assignment.bookingrecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="booking_container">
        <p class="booking_title">Car Rental Booking</p>
    <table class="table align-middle mb-0 bg-white">
  <thead class="bg-light">
    <tr class="header_row_title">
      <th class="booking_id">Booking ID</th>
       <th class="booking_status">Status</th>
      <th class="booking_vehicle">Vehicle</th>
      <th class="booking_pickup">Pick Up </th>
      <th class="booking_dropoff">Drop Off </th>
      <th class="booking_price">Price</th>
       <th class="booking_edit"></th>
    </tr>
  </thead>
  <tbody>
    <tr>
  <td>
    <div class=" align-items-center">    
      <div class="ms-1">
        <p class="fw-bold mb-1">John Doe</p>
      </div>
    </div>
  </td>

     <td>         
         <span class="status_icon badge bg-secondary rounded-pill d-inline">Pending for payment</span>
    </td>

  <td>
    <p class="fw-normal mb-1">abcde</p>

  </td>
  
  <td>
    <p class="fw-normal mb-1">place</p>
    <p class="text-muted mb-0">time</p>

  </td>
  <td>
      <p class="fw-normal mb-1">place</p>
      <p class="text-muted mb-0">time</p>
  </td>
    <td>
        <p class="fw-normal mb-1">123</p>
    </td>
   
    <td>
        <asp:Button ID="btnEdit1" runat="server" CSSclass="edit_btn_style" Text="Edit" />
    </td>
</tr>
   
      <!-- -->
      <tr>
  <td>
    <div class=" align-items-center">    
      <div class="ms-1">
        <p class="fw-bold mb-1">John Doe</p>
      </div>
    </div>
  </td>

     <td>         
         <span class="status_icon badge bg-success rounded-pill d-inline">Active</span>
    </td>

  <td>
    <p class="fw-normal mb-1">abcde</p>

  </td>
  
  <td>
    <p class="fw-normal mb-1">place</p>
    <p class="text-muted mb-0">time</p>

  </td>
  <td>
      <p class="fw-normal mb-1">place</p>
      <p class="text-muted mb-0">time</p>
  </td>
    <td>
        <p class="fw-normal mb-1">123</p>
    </td>
   
    <td>
        <asp:Button ID="btnEdit2" runat="server" CSSclass="edit_btn_style" Text="Edit" />
    </td>
</tr>
      <!-- -->
    <tr>
  <td>
    <div class=" align-items-center">    
      <div class="ms-1">
        <p class="fw-bold mb-1">John Doe</p>
      </div>
    </div>
  </td>

     <td>         
         <span class="status_icon badge bg-primary rounded-pill d-inline">Processing</span>
    </td>

  <td>
    <p class="fw-normal mb-1">abcde</p>

  </td>
  
  <td>
    <p class="fw-normal mb-1">place</p>
    <p class="text-muted mb-0">time</p>

  </td>
  <td>
      <p class="fw-normal mb-1">place</p>
      <p class="text-muted mb-0">time</p>
  </td>
    <td>
        <p class="fw-normal mb-1">123</p>
    </td>
   
    <td>
        <asp:Button ID="btnEdit3" runat="server" CSSclass="edit_btn_style" Text="Edit" />
    </td>
</tr>
      <!-- -->
      <tr>
  <td>
    <div class=" align-items-center">    
      <div class="ms-1">
        <p class="fw-bold mb-1">John Doe</p>
      </div>
    </div>
  </td>

     <td>         
         <span class="status_icon badge bg-warning rounded-pill d-inline">Booked</span>
    </td>

  <td>
    <p class="fw-normal mb-1">abcde</p>

  </td>
  
  <td>
    <p class="fw-normal mb-1">place</p>
    <p class="text-muted mb-0">time</p>

  </td>
  <td>
      <p class="fw-normal mb-1">place</p>
      <p class="text-muted mb-0">time</p>
  </td>
    <td>
        <p class="fw-normal mb-1">123</p>
    </td>
   
    <td>
        <asp:Button ID="btnEdit4" runat="server" CSSclass="edit_btn_style" Text="Edit" />
    </td>
</tr>
  </tbody>
</table>
        </div>
</asp:Content>
