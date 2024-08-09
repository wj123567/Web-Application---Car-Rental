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
                <asp:Label ID="lblDeparture" runat="server" Text="Pick Up" CssClass="home_label_style"></asp:Label>
                <asp:TextBox ID="txtDepartureDate" runat="server" TextMode="Date" CssClass="control_style"></asp:TextBox>
                <asp:TextBox ID="txtDepartureTime" runat="server" TextMode="Time" CssClass="control_style"></asp:TextBox>
                <asp:RequiredFieldValidator ID="requireDepartDate" runat="server" ErrorMessage="Pick Up Date is Required" ControlToValidate="txtDepartureDate" CssClass="validate" ValidationGroup="filter" Display="Dynamic"></asp:RequiredFieldValidator>
                <br />
                <asp:RequiredFieldValidator ID="requireDepartTime" runat="server" ErrorMessage="Pick Up Time is Required" ControlToValidate="txtDepartureTime" CssClass="validate" ValidationGroup="filter" Display="Dynamic"></asp:RequiredFieldValidator>
                <br />
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
                <asp:TextBox ID="txtReturnTime" runat="server" TextMode="Time" CssClass="control_style"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="requireReturnDate" runat="server" ErrorMessage="Drop Off Date is Required" ControlToValidate="txtReturnDate" CssClass="validate" ValidationGroup="filter" Display="Dynamic"></asp:RequiredFieldValidator>
                 <br />
                 <asp:RequiredFieldValidator ID="requireReturnTime" runat="server" ErrorMessage="Drop Off Time is Required" ControlToValidate="txtReturnTime" CssClass="validate" ValidationGroup="filter" Display="Dynamic"></asp:RequiredFieldValidator>
                 <br />
                 <asp:CompareValidator ID="compareStartEnd" runat="server" ErrorMessage="End Time Must After Start Time" ControlToCompare="txtReturnDate" ControlToValidate="txtDepartureDate" CssClass="validate" Operator="LessThan" ValidationGroup="filter" Display="Dynamic"></asp:CompareValidator>
            </div>
        <p>Add Date</p>
         </div>
         </div>
        <!-- -->
        </div>
            </div>
             <asp:Button ID="btnSearch" runat="server" Text="🔍Search" CssClass="search_btn_style" OnClick="btnSearch_Click" />
        
       
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