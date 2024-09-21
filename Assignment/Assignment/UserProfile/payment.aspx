<%@ Page Title="" Language="C#" MasterPageFile="~/UserProfile/profile.Master" AutoEventWireup="true" CodeBehind="payment.aspx.cs" Inherits="Assignment.payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:HiddenField ID="hdnCardType" runat="server" />
    <div class="modal fade" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
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
                    <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup" OnClick="btnConfirmDelete_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="container-xl px-4 mt-4">
        <h1>Payment</h1>
        <hr class="mt-0 mb-4">
        <div class="card card-header-actions mb-4 shadow">
            <div class="card-header">
                Payment Methods
            <asp:Button ID="btnAddNewCard" runat="server" Text="Add New Card" CssClass="btn btn-sm btn-primary mx-2 my-auto" ValidationGroup="AddCard" OnClick="btnAddNewCard_Click" />
            </div>
        </div>
        <asp:Label ID="lblPaymentText" runat="server" Text="" CssClass="mb-2"></asp:Label>
        <div class="card-body px-0 mb-2">
            <asp:Repeater ID="paymentRepeater" runat="server" OnItemDataBound="paymentRepeater_ItemDataBound">
                <ItemTemplate>
                    <div class="d-flex align-items-center justify-content-between px-4">
                        <div class="d-flex align-items-center">
                            <asp:Image ID="imgCardType" runat="server" Width="36" CssClass="img-fluid" />
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
                            <asp:Button ID="btnDefault" runat="server" Text="Default" CssClass="btn btn-sm bg-light text-dark me-3" CommandArgument='<%# Eval("Id") %>' OnClick="btnDefault_Click" />
                            <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm text-primary" CommandArgument='<%# Eval("Id") %>' OnClick="btnEdit_Click" />
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
                    <div class="card-header">Card Details</div>
                    <div class="card-body">
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Cardholder Name</label>
                                <asp:TextBox ID="txtCHName" runat="server" CssClass="form-control" placeholder="Cardholder Name" ValidationGroup="uploadCard"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCHName" runat="server" ErrorMessage="Cardholder Name is required" ControlToValidate="txtCHName" CssClass="validate" ValidationGroup="uploadCard"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Card Number</label>
                                <asp:Label ID="lblVisaCard" runat="server" Text="" CssClass="fab fa-cc-visa fa-lg"></asp:Label>
                                <asp:Label ID="lblMasterCard" runat="server" Text="" CssClass="fab fa-cc-mastercard fa-lg"></asp:Label>
                                <asp:Label ID="lblAmexCard" runat="server" Text="" CssClass="fab fa-cc-amex fa-lg"></asp:Label>
                                <asp:TextBox ID="txtCardNum" runat="server" CssClass="form-control" placeholder="0000 0000 0000 0000" ValidationGroup="uploadCard" MaxLength="19" OnKeyUp="formatCardNumber(this)"></asp:TextBox>
                                <asp:CustomValidator ID="validateCard" runat="server" ErrorMessage="Card is Invalid" CssClass="validate" ValidationGroup="uploadCard" ClientValidationFunction="validateCard" ControlToValidate="txtCardNum" ValidateEmptyText="True" Display="Dynamic"></asp:CustomValidator>
                                <asp:CustomValidator ID="validateCardExist" runat="server" ErrorMessage="Card is Exist" CssClass="validate" ValidationGroup="uploadCard" ControlToValidate="txtCardNum" OnServerValidate="validateCard_ServerValidate" Display="Dynamic"></asp:CustomValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Expiry Date</label>
                                <asp:TextBox ID="txtExpDate" runat="server" CssClass="form-control" TextMode="Month" ValidationGroup="uploadCard"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqExpDate" runat="server" ErrorMessage="Expiry Date is required" ControlToValidate="txtExpDate" CssClass="validate" ValidationGroup="uploadCard"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Security Code (CVV)</label>
                                <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control d-block" placeholder="e.g. 123" MaxLength="3" OnKeyUp="formatCVV(this)" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCvv" runat="server" ErrorMessage="CVV is required" ControlToValidate="txtCvv" CssClass="validate" ValidationGroup="uploadCard"></asp:RequiredFieldValidator>
                                <br />
                            </div>
                        </div>
                        <asp:Button ID="btnUploadCard" runat="server" Text="Add Card" CssClass='btn btn-primary' ValidationGroup="uploadCard" OnClick="btnUploadCard_Click" />
                        <asp:Button ID="btnUpdateCard" runat="server" Text="Update" CssClass='btn btn-primary' ValidationGroup="uploadCard" Visible="False" OnClick="btnUpdateCard_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Delete " CssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="False" />
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>

    <script>
        function formatCVV(input) {
            var value = input.value.replace(/\D/g, '');
            input.value = value;
        }

        function formatCardNumber(input) {
            var value = input.value.replace(/\D/g, '');
            var formattedValue = value.replace(/(.{4})/g, '$1 ');
            input.value = formattedValue.trim();

        }

        function validateCard(sender, args) {
            var cardInput = document.getElementById('<%= txtCardNum.ClientID %>');
        var cardNumber = cardInput.value.replace(/\s/g, '');
        var isVisa = false;
        var isMaster = false;
        var isAmex = false;

        isVisa = isVisaCard(cardNumber);
        isMaster = isMasterCard(cardNumber);
        isAmex = isAmexCard(cardNumber);

        console.log(document.getElementById('<%= hdnCardType.ClientID %>').value);

            if (isVisa || isMaster || isAmex) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }

        }

        function isVisaCard(cardNumber) {
            var cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
            if (cardno.test(cardNumber)) {
                var card = document.getElementById('<%= lblVisaCard.ClientID %>');
            card.className = "fab fa-cc-visa fa-lg text-primary";
            document.getElementById('<%= hdnCardType.ClientID %>').value = 'Visa';
            console.log(document.getElementById('<%= hdnCardType.ClientID %>').value);
            return true;
        }
        else {
            var card = document.getElementById('<%= lblVisaCard.ClientID %>');
                card.className = "fab fa-cc-visa fa-lg";
                return false;
            }
        }

        function isMasterCard(cardNumber) {
            var cardno = /^(?:5[1-5][0-9]{14})$/;
            if (cardno.test(cardNumber)) {
                var card = document.getElementById('<%= lblMasterCard.ClientID %>');
            card.className = "fab fa-cc-mastercard fa-lg text-primary";
            document.getElementById('<%= hdnCardType.ClientID %>').value = 'Master';
            console.log(document.getElementById('<%= hdnCardType.ClientID %>').value);
            return true;
        }
        else {
            var card = document.getElementById('<%= lblMasterCard.ClientID %>');
                card.className = "fab fa-cc-mastercard fa-lg";
                return false;
            }
        }

        function isAmexCard(cardNumber) {
            var cardno = /^(?:3[47][0-9]{13})$/;
            if (cardno.test(cardNumber)) {
                var card = document.getElementById('<%= lblAmexCard.ClientID %>');
            card.className = "fab fa-cc-amex fa-lg text-primary";
            document.getElementById('<%= hdnCardType.ClientID %>').value = 'Amex';
            return true;
        }
        else {
            var card = document.getElementById('<%= lblAmexCard.ClientID %>');
                card.className = "fab fa-cc-amex fa-lg";
                return false;
            }
        }
    </script>

</asp:Content>
