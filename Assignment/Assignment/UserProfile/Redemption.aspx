<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="Redemption.aspx.cs" Inherits="Assignment.Redemption" %>

<asp:Content ID="Redemption" ContentPlaceHolderID="main" runat="server">
    <!-- Redeem -->
    <div class="modal fade" id="Redeem" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="staticBackdropLabel">Redeem Confimation</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            Are you sure you want to redeem VoucherProMax?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <button id="confirmRedeem" type="button" class="btn btn-primary" data-bs-dismiss="modal">Confirm Redeem</button>
          </div>
        </div>
      </div>
    </div>

    <div class="redemption-container">
        <div class="redemption-container-header">
            <h2>Redeem What You Like?</h2>
        </div>

        <div class="redemption-container-body d-flex flex-row justify-content-around flex-wrap">
            <asp:ListView ID="lvredeemitems" runat="server">
                <%-- layouttemplate is the overall layout wraps the ItemTemplate  --%>
                <LayoutTemplate>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                </LayoutTemplate>

                <%-- ItemTemplate defines how each item should look --%>
                <ItemTemplate>
                    <div class="RItem d-inline-block">
                        <div class="vouchercard p-3 d-flex flex-column justify-content-around">                            
                            <div class="d-flex flex-column justify-content-around" style="width: 90%">
                                <div class="voucher-head" style="flex:1">
                                    <h1 class="ItemName mt-0"><%# Eval("ItemName") %></h1>
                                </div>
                                <div class="image" style="flex:3">
                                    <img src='<%# ResolveUrl("~/Image/RedeemItem/" + Eval("ItemImage")) %>' alt="<%# Eval("ItemName") %>" class="ItemImage" />
                                </div>
                            </div>
        
                            <p><%# Eval("ItemDescription") %> </p>
                            <span class="d-inline-block d-flex justify-content-center" style="width: 100%" tabindex="0" 
                                  data-bs-toggle="tooltip" 
                                  title='<%# (bool)Eval("IsRedeemed") ? "Already Redeemed Today" : (bool)Eval("IsUnavailable") ? "Item Unavailable" : "" %>' 
                                  data-bs-placement="top">
                                <asp:LinkButton ID="btnRedeem" runat="server" 
                                    CssClass='<%# (bool)Eval("IsRedeemed") || (bool)Eval("IsUnavailable") ? "btn btn-danger resize disabled-btn" : "btn btn-danger resize" %>'
                                    CommandArgument='<%# Eval("RedeemItemId") %>' 
                                    OnClick="btnRedeem_Click">
                                    Redeem
                                </asp:LinkButton>
                            </span>
                        </div>
                    </div>
                </ItemTemplate>

            </asp:ListView>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            // Initialize Bootstrap tooltips
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });

    </script>
    
    
</asp:Content>
