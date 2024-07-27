<%@ Page Title="" Language="C#" MasterPageFile="~/profile.Master" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="Assignment.payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">


<div class="modal fade" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Card Detail</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <h5>Are you sure you want to delete?</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup"/>
      </div>
    </div>
  </div>   
</div>

<div class="container-xl px-4 mt-4">
    <h1>Payment</h1>
    <hr class="mt-0 mb-4">
    <!-- Payment methods card-->
    <div class="card card-header-actions mb-4 shadow">
        <div class="card-header">
            Payment Methods
        </div>
    </div>
       <asp:Label ID="lblPaymentText" runat="server" Text=""></asp:Label>
        <div class="card-body px-0">
            <!-- Payment method 1-->
            <asp:Repeater ID="paymentRepeater" runat="server" OnItemDataBound="paymentRepeater_ItemDataBound">
             <ItemTemplate>
            <div class="d-flex align-items-center justify-content-between px-4">
                <div class="d-flex align-items-center">
                    <asp:Label ID="Label1" runat="server" Text="" CssClass="fab fa-cc-visa fa-2x cc-color-visa"></asp:Label>
                    <div class="ms-4">
                    <div class="d-block">
                    <span class="d-inline">Card ending in</span>
                    <asp:Label ID="lblCardNumber" runat="server" Text='<%# Eval("CardNumber") %>' CssClass="d-inline" />
                    </div>
                    <div class="d-block">
                        <span class="text-xs text-muted">Expires</span>
                        <asp:Label ID="lblExp" runat="server" Text='<%# Eval("ExpDate") %>' CssClass="text-xs text-muted" />
                    </div>
                    </div>
                </div>
                <div class="ms-4 small">
                    <asp:Button ID="btnDefault" runat="server" Text="Default" CssClass="btn btn-sm bg-light text-dark me-3" CommandArgument='<%# Eval("ExpDate") %>' />
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm text-primary" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="btn btn-sm text-danger" CommandArgument='<%# Eval("ExpDate") %>' />
                </div>
            </div>                  
            <hr>
                    </ItemTemplate>
                </asp:Repeater>
        </div>
    <h1>Add/Edit Card Info</h1>
    <hr class="mt-0 mb-4">
        <div class="col-xl-8 mb-5 mx-auto">
            <asp:Panel ID="Panel1" runat="server">
            <div class="card mb-4">
                <div class="card-header">Driver Details</div>
                <div class="card-body">
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Cardholder Name</label>
                                <asp:TextBox ID="txtCHName" runat="server" CssClass="form-control" placeholder="Cardholder Name" ValidationGroup="uploadCard"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCHName" runat="server" ErrorMessage="Cardholder Name is required" ControlToValidate="txtCHName" CssClass="validate" ValidationGroup="uploadCard"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Card Number</label>
                                <asp:TextBox ID="txtCardNum" runat="server" CssClass="form-control" placeholder="0000 0000 0000 0000" ValidationGroup="uploadCard" MaxLength="12"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCardNum" runat="server" ErrorMessage="Card Number is required" ControlToValidate="txtCardNum" CssClass="validate" ValidationGroup="uploadCard"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Expiry Date</label>
                                <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control" TextMode="Month" ValidationGroup="uploadCard" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqExpDate" runat="server" ErrorMessage="Expiry Date is required" ControlToValidate="txtExpDate" CssClass="validate" ValidationGroup="uploadCard"></asp:RequiredFieldValidator>
                  </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Security Code (CVV)</label>
                                <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control d-block" TextMode="Password" placeholder="e.g. 123" MaxLength="3"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCvv" runat="server" ErrorMessage="CVV is required" ControlToValidate="txtCvv" CssClass="validate" ValidationGroup="uploadCard"></asp:RequiredFieldValidator>
                       <br />
                            </div>
                        </div>
                    <asp:Button ID="btnUploadDoc" runat="server" Text="Add New Card" CssClass='btn btn-primary' ValidationGroup="uploadCard"/>
                    <asp:Button ID="btnUpdateDoc" runat="server" Text="Update" CssClass='btn btn-primary' ValidationGroup="uploadCard" Visible="False"/>
                    <asp:Button ID="btnDelete" runat="server" Text="Delete " cssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="False"/>
                </div>
            </div>
            </asp:Panel>
        </div>
</div>

</asp:Content>
