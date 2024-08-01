<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Assignment.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
     <div class="bg_cover">
    <header class="section_container header_container">
        <h1 class="section_header">Find and Book Your Car <br/> A Great Experience</h1>
    </header>


    <section class="section_container booking_container">
        <div class="content_container">
<!--
        <div class="booking_nav">
            <span>Car 1</span>
            <span>Car 2</span>
            <span>Car 3</span>
        </div>
-->
        <div class="form_container">
        <div class="form_group">
            <span style="margin-left:20px;"><i class="ri-map-pin-2-line"></i></span>
            <div class="input_content">
                <div class="input_group">
                   <asp:Label ID="lblLocation" runat="server" Text="Location" CssClass="home_label_style"></asp:Label>
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="control_style">
                         
                    </asp:DropDownList>
                </div>
                <p>Where to pick up?</p>
            </div>
        </div>
        
        <div class="form_group">
        <span><i class="ri-calendar-line"></i></span>
        <div class="input_content">
            <div class="input_group">
                <asp:Label ID="lblDeparture" runat="server" Text="PickUp" CssClass="home_label_style"></asp:Label>
                <asp:TextBox ID="txtDepartureDate" runat="server" TextMode="Date" CssClass="control_style"></asp:TextBox>
                <asp:DropDownList ID="ddlDepartureTime" runat="server" CssClass="control_style">
                    <asp:ListItem Value="00:00" data-depart="00:00">00:00</asp:ListItem>
                    <asp:ListItem Value="00:30" data-depart="00:30">00:30</asp:ListItem>
                    <asp:ListItem Value="01:00" data-depart="01:00">01:00</asp:ListItem>
                    <asp:ListItem Value="01:30" data-depart="01:30">01:30</asp:ListItem>
                    <asp:ListItem Value="02:00" data-depart="02:00">02:00</asp:ListItem>
                    <asp:ListItem Value="02:30" data-depart="02:30">02:30</asp:ListItem>
                    <asp:ListItem Value="03:00" data-depart="03:00">03:00</asp:ListItem>
                    <asp:ListItem Value="03:30" data-depart="03:30">03:30</asp:ListItem>
                    <asp:ListItem Value="04:00" data-depart="04:00">04:00</asp:ListItem>
                    <asp:ListItem Value="04:30" data-depart="04:30">04:30</asp:ListItem>
                    <asp:ListItem Value="05:00" data-depart="05:00">05:00</asp:ListItem>
                    <asp:ListItem Value="05:30" data-depart="05:30">05:30</asp:ListItem>
                    <asp:ListItem Value="06:00" data-depart="06:00">06:00</asp:ListItem>
                    <asp:ListItem Value="06:30" data-depart="06:30">06:30</asp:ListItem>
                    <asp:ListItem Value="07:00" data-depart="07:00">07:00</asp:ListItem>
                    <asp:ListItem Value="07:30" data-depart="07:30">07:30</asp:ListItem>
                    <asp:ListItem Value="08:00" data-depart="08:00">08:00</asp:ListItem>
                    <asp:ListItem Value="08:30" data-depart="08:30">08:30</asp:ListItem>
                    <asp:ListItem Value="09:00" data-depart="09:00">09:00</asp:ListItem>
                    <asp:ListItem Value="09:30" data-depart="09:30">09:30</asp:ListItem>
                    <asp:ListItem Value="10:00" data-depart="10:00">10:00</asp:ListItem>
                    <asp:ListItem Value="10:30" data-depart="10:30">10:30</asp:ListItem>
                    <asp:ListItem Value="11:00" data-depart="11:00">11:00</asp:ListItem>
                    <asp:ListItem Value="11:30" data-depart="11:30">11:30</asp:ListItem>
                    <asp:ListItem Value="12:00" data-depart="12:00">12:00</asp:ListItem>
                    <asp:ListItem Value="12:30" data-depart="12:30">12:30</asp:ListItem>
                    <asp:ListItem Value="13:00" data-depart="13:00">13:00</asp:ListItem>
                    <asp:ListItem Value="13:30" data-depart="13:30">13:30</asp:ListItem>
                    <asp:ListItem Value="14:00" data-depart="14:00">14:00</asp:ListItem>
                    <asp:ListItem Value="14:30" data-depart="14:30">14:30</asp:ListItem>
                    <asp:ListItem Value="15:00" data-depart="15:00">15:00</asp:ListItem>
                    <asp:ListItem Value="15:30" data-depart="15:30">15:30</asp:ListItem>
                    <asp:ListItem Value="16:00" data-depart="16:00">16:00</asp:ListItem>
                    <asp:ListItem Value="16:30" data-depart="16:30">16:30</asp:ListItem>
                    <asp:ListItem Value="17:00" data-depart="17:00">17:00</asp:ListItem>
                    <asp:ListItem Value="17:30" data-depart="17:30">17:30</asp:ListItem>
                    <asp:ListItem Value="18:00" data-depart="18:00">18:00</asp:ListItem>
                    <asp:ListItem Value="18:30" data-depart="18:30">18:30</asp:ListItem>
                    <asp:ListItem Value="19:00" data-depart="19:00">19:00</asp:ListItem>
                    <asp:ListItem Value="19:30" data-depart="19:30">19:30</asp:ListItem>
                    <asp:ListItem Value="20:00" data-depart="20:00">20:00</asp:ListItem>
                    <asp:ListItem Value="20:30" data-depart="20:30">20:30</asp:ListItem>
                    <asp:ListItem Value="21:00" data-depart="21:00">21:00</asp:ListItem>
                    <asp:ListItem Value="21:30" data-depart="21:30">21:30</asp:ListItem>
                    <asp:ListItem Value="22:00" data-depart="22:00">22:00</asp:ListItem>
                    <asp:ListItem Value="22:30" data-depart="22:30">22:30</asp:ListItem>
                    <asp:ListItem Value="23:00" data-depart="23:00">23:00</asp:ListItem>
                    <asp:ListItem Value="23:30" data-depart="23:30">23:30</asp:ListItem>
                </asp:DropDownList>
                
                   
        </div>
        <p>Add Date</p>
            </div>
        </div>
        <!-- -->
        <div class="form_group">
        <span><i class="ri-calendar-line"></i></span>
        <div class="input_content">
            <div class="input_group">
                <asp:Label ID="lblReturn" runat="server" Text="Drop Off" CssClass="home_label_style"></asp:Label>
                <asp:TextBox ID="txtReturnDate" runat="server" TextMode="Date" CssClass="control_style "></asp:TextBox>
                <asp:DropDownList ID="ddlReturnTime" runat="server" CssClass="control_style ">
                    <asp:ListItem Value="00:00" data-depart="00:00">00:00</asp:ListItem>
                    <asp:ListItem Value="00:30" data-depart="00:30">00:30</asp:ListItem>
                    <asp:ListItem Value="01:00" data-depart="01:00">01:00</asp:ListItem>
                    <asp:ListItem Value="01:30" data-depart="01:30">01:30</asp:ListItem>
                    <asp:ListItem Value="02:00" data-depart="02:00">02:00</asp:ListItem>
                    <asp:ListItem Value="02:30" data-depart="02:30">02:30</asp:ListItem>
                    <asp:ListItem Value="03:00" data-depart="03:00">03:00</asp:ListItem>
                    <asp:ListItem Value="03:30" data-depart="03:30">03:30</asp:ListItem>
                    <asp:ListItem Value="04:00" data-depart="04:00">04:00</asp:ListItem>
                    <asp:ListItem Value="04:30" data-depart="04:30">04:30</asp:ListItem>
                    <asp:ListItem Value="05:00" data-depart="05:00">05:00</asp:ListItem>
                    <asp:ListItem Value="05:30" data-depart="05:30">05:30</asp:ListItem>
                    <asp:ListItem Value="06:00" data-depart="06:00">06:00</asp:ListItem>
                    <asp:ListItem Value="06:30" data-depart="06:30">06:30</asp:ListItem>
                    <asp:ListItem Value="07:00" data-depart="07:00">07:00</asp:ListItem>
                    <asp:ListItem Value="07:30" data-depart="07:30">07:30</asp:ListItem>
                    <asp:ListItem Value="08:00" data-depart="08:00">08:00</asp:ListItem>
                    <asp:ListItem Value="08:30" data-depart="08:30">08:30</asp:ListItem>
                    <asp:ListItem Value="09:00" data-depart="09:00">09:00</asp:ListItem>
                    <asp:ListItem Value="09:30" data-depart="09:30">09:30</asp:ListItem>
                    <asp:ListItem Value="10:00" data-depart="10:00">10:00</asp:ListItem>
                    <asp:ListItem Value="10:30" data-depart="10:30">10:30</asp:ListItem>
                    <asp:ListItem Value="11:00" data-depart="11:00">11:00</asp:ListItem>
                    <asp:ListItem Value="11:30" data-depart="11:30">11:30</asp:ListItem>
                    <asp:ListItem Value="12:00" data-depart="12:00">12:00</asp:ListItem>
                    <asp:ListItem Value="12:30" data-depart="12:30">12:30</asp:ListItem>
                    <asp:ListItem Value="13:00" data-depart="13:00">13:00</asp:ListItem>
                    <asp:ListItem Value="13:30" data-depart="13:30">13:30</asp:ListItem>
                    <asp:ListItem Value="14:00" data-depart="14:00">14:00</asp:ListItem>
                    <asp:ListItem Value="14:30" data-depart="14:30">14:30</asp:ListItem>
                    <asp:ListItem Value="15:00" data-depart="15:00">15:00</asp:ListItem>
                    <asp:ListItem Value="15:30" data-depart="15:30">15:30</asp:ListItem>
                    <asp:ListItem Value="16:00" data-depart="16:00">16:00</asp:ListItem>
                    <asp:ListItem Value="16:30" data-depart="16:30">16:30</asp:ListItem>
                    <asp:ListItem Value="17:00" data-depart="17:00">17:00</asp:ListItem>
                    <asp:ListItem Value="17:30" data-depart="17:30">17:30</asp:ListItem>
                    <asp:ListItem Value="18:00" data-depart="18:00">18:00</asp:ListItem>
                    <asp:ListItem Value="18:30" data-depart="18:30">18:30</asp:ListItem>
                    <asp:ListItem Value="19:00" data-depart="19:00">19:00</asp:ListItem>
                    <asp:ListItem Value="19:30" data-depart="19:30">19:30</asp:ListItem>
                    <asp:ListItem Value="20:00" data-depart="20:00">20:00</asp:ListItem>
                    <asp:ListItem Value="20:30" data-depart="20:30">20:30</asp:ListItem>
                    <asp:ListItem Value="21:00" data-depart="21:00">21:00</asp:ListItem>
                    <asp:ListItem Value="21:30" data-depart="21:30">21:30</asp:ListItem>
                    <asp:ListItem Value="22:00" data-depart="22:00">22:00</asp:ListItem>
                    <asp:ListItem Value="22:30" data-depart="22:30">22:30</asp:ListItem>
                    <asp:ListItem Value="23:00" data-depart="23:00">23:00</asp:ListItem>
                    <asp:ListItem Value="23:30" data-depart="23:30">23:30</asp:ListItem>
                </asp:DropDownList>
            </div>
        <p>Add Date</p>
         </div>
         </div>
        <!-- -->
        </div>
            </div>
             <asp:Button ID="btnSearch" runat="server" Text="🔍Search" CssClass="search_btn_style" />
        
       
    </section>
</div>

     <section class=" plan_container">
 <p class="subheader">RENT INFORMATION</p>
 <h2 class="section_header">Plan your rent with confidence</h2>
 <p class="description">
     Find help with your booking and renting plans, and see what to expect along your journey
 </p>
 <div class="plan_grid">
     <div class="plan_content">
         <span class="number">01</span>
         <h4>Search & Explore </h4>
         <p>Find a vehicle that suits your budget and travel style, and get a quote online.
         </p>
         <!-- -->
         <span class="number">02</span>
         <h4>Book & Pay </h4>
         <p>Select your car hire dates, choose your car pick-up and drop-off points, and book securely.
         </p>
         <!-- -->
         <span class="number">03</span>
         <h4>Travel & Enjoy </h4>
         <p> Collect your car and live like a local anywhere in Malaysia.
         </p>
      </div>
     <div class="plan_image">
         <img src="Image/WZ/homeimg2.jpg" alt="Alternate Text" style=" height:250px"/>
         <img src="Image/WZ/homeimg1.jpg" alt="Alternate Text" style=" height:300px"/>
         <img src="Image/WZ/homeimg3.jpg" alt="Alternate Text" style=" height:250px"/>
     </div>
 </div>
</section>
</asp:Content>