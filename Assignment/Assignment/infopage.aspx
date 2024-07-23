<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="infopage.aspx.cs" Inherits="Assignment.infopage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
     <section class="info_head_container">
  
     <div class="header">
         <div class="location">
             <div class="infopg_pickup">
                 <h3>Penang Downtown</h3>
                 <p>Tue, Jul 23, 2024, 10:00</p>
             </div>
             <div class="arrow">&gt;</div>
             <div class="infopg_dropoff">
                 <h3>Penang Downtown</h3>
                 <p>Fri, Jul 26, 2024, 10:00</p>
             </div>
         </div>
         <div class="info">
             <i class="ri-info-i"> You’ll need to pick up your car at 10:00</i>
         </div>
         <div class="edit">
              <asp:Button ID="btnEdit" runat="server" Text="Edit" CSSClass="edit-button"/>
         </div>
     </div>
 
 </section>
 <section class="info_body_container"> 
     <div class="left-side">
         <div class="box">Box 1 - Left</div>
         <div class="box">Box 2 - Left</div>
         <div class="box">Box 3 - Left</div>
     </div>
     <div class="right-side">
         <div class="box">
             <div class="pickup_info">
             <h5>Pickup</h5>
             <i class="ri-circle-line"> Tue, Jul 23 · 10:00 AM</i>
             <br />
             <span class="pickup_pos">Penang</span>
             </div>
             <hr />
             <div class="return_info">
             <h5> Return</h5>
             <i class="ri-circle-line">Wed, Jul 23 · 10:00 AM</i> 
             <br />
             <span class="return_pos">Penang</span>
             </div>
         </div>
         <div class="box">
             <h6>Summary of Charges</h6>
             <div class="charges_summary">
                 <div class="charge_item">
                 <p class="summary_title">Rental</p>
                 <p class ="summary_amt">0.00</p>
                 </div>
                 <hr />
                 <div class="charge_item">
                 <p class="summary_title">Rental</p>
                 <p class ="summary_amt">0.00</p>
                 </div>
                 <hr />
                 <div class="charge_item">
                 <p class="summary_title">Rental</p>
                 <p class ="summary_amt">0.00</p>
                 </div>
                 <hr />
                 <div class="charge_item">
                 <p class="summary_title">Rental</p>
                 <p class ="summary_amt">0.00</p>
                 </div>
                 <hr />
                 <div class="charge_item summary_total">
                 <p class="summary_title">Total Price(MYR):</p>
                 <p class="summary_amt"><span><sub>approx</sub></span>0.00</p>
                 </div>
             </div>

         </div>
         <div class="box">Box 3 - Right</div>
     </div>
 </section>
</asp:Content>
