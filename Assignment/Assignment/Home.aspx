<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Assignment.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
     <header class="section_container header_container">
     <h1 class="section_header">Find and Book Your Car <br/> A Great Experience</h1>
     <img src="photo/44mbziylcv6c1.jpeg" alt="headerimg" />
 </header>

 <section class="section_container booking_container" >
     
     <div class="booking_nav">
         <span>Car 1</span>
         <span>Car 2</span>
         <span>Car 3</span>
     </div>
     <div class="form_container">
     <div class="form_group">
         <span><i class="ri-map-pin-2-line"></i></span>
         <div class="input_content">
             <div class="input_group">
                 <asp:TextBox ID="txtLocation" runat="server" CssClass="control_style"></asp:TextBox>
                 <label>Location</label>
             </div>
             <p>Where are you going?</p>
         </div>
     </div>
     <!-- -->
     <div class="form_group">
     <span><i class="ri-user-3-line"></i></span>
     <div class="input_content">
         <div class="input_group">
             <asp:TextBox ID="txtTraveller" runat="server" CssClass="control_style" ></asp:TextBox>
             <label>Travellers</label>
         </div>
         <p>Add Guest</p>
      </div>
     </div>
     <!-- -->
     <div class="form_group">
     <span><i class="ri-calendar-line"></i></span>
     <div class="input_content">
         <div class="input_group">
             <asp:TextBox ID="txtDeparture" runat="server" CssClass="control_style" TextMode="DateTime"></asp:TextBox>
             <label>Departure</label>
     </div>
     <p>Add Date</p>
         </div>
     </div>
     <!-- -->
     <div class="form_group">
     <span><i class="ri-calendar-line"></i></span>
     <div class="input_content">
         <div class="input_group">
             <asp:Label ID="lblReturn" runat="server" Text="Return"></asp:Label>
             <asp:TextBox ID="txtReturn" runat="server" CssClass="control_style" TextMode="Date"></asp:TextBox>  
             
         </div>
     <p>Add Date</p>
      </div>
      </div>
     <!-- -->
     </div>
     
     <asp:Button ID="btnSearch" runat="server" Text="🔍Search" CssClass="search_btn_style"/>
 </section>

 <section class="section_container plan_container">
 <p class="subheader">RENT INFORMATION</p>
 <h2 class="section_header">Plan your rent with confidence</h2>
 <p class="description">
     Find help with your booking and renting plans, and see what to expect along your journey
 </p>
 <div class="plan_grid">
     <div class="plan_content">
         <span class="number">01</span>
         <h4>Rental Requirement </h4>
         <p>Renting a car has never been easier with our car rental app. Get started on your journey today with just a few taps!
         </p>
         <!-- -->
         <span class="number">02</span>
         <h4>Rental Requirement </h4>
         <p>Renting a car has never been easier with our car rental app. Get started on your journey today with just a few taps!
         </p>
         <!-- -->
         <span class="number">03</span>
         <h4>Rental Requirement </h4>
         <p>Renting a car has never been easier with our car rental app. Get started on your journey today with just a few taps!
         </p>
      </div>
     <div class="plan_image">
         <img src="photo/slide_2.jpg" alt="Alternate Text" style="width:300px; height:300px"/>
         <img src="photo/pexels-peng-liu-45946-169677.jpg" alt="Alternate Text" style="width:300px; height:300px"/>
         <img src="photo/koenigsegg-gemera.jpg" alt="Alternate Text" style="width:300px; height:300px"/>
     </div>
 </div>
</section>
</asp:Content>