<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRedemption.aspx.cs" Inherits="Assignment.Management.AdminRedemption" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <%-- add modal --%>
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Add New Redeem Item</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="txtItemName" class="fs-6"><b>Item Name</b></label>
                        <asp:TextBox ID="txtItemName" runat="server" CssClass="form-control mb-2" placeholder="Enter Item Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemName" runat="server" ControlToValidate="txtItemName" 
        ErrorMessage="Item Name is required." CssClass="text-warning" Display="Dynamic" ValidationGroup="AddItem" />
                    </div>
                    <div class="form-group">
                        <label for="txtItemPoints" class="fs-6"><b>Item Points</b></label>
                        <asp:TextBox ID="txtItemPoints" runat="server" CssClass="form-control mb-2" placeholder="Enter Item Points"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemPoints" runat="server" ControlToValidate="txtItemPoints" 
        ErrorMessage="Item Points are required." CssClass="text-warning" Display="Dynamic" ValidationGroup="AddItem" />
                        <asp:RegularExpressionValidator ID="revItemPoints" runat="server" ControlToValidate="txtItemPoints" 
                            ErrorMessage="Item Points must be a number." CssClass="text-warning" 
                            ValidationExpression="^\d+$" Display="Dynamic" ValidationGroup="AddItem" />
                    </div>
                    <div class="form-group">
                        <label for="txtItemDescription" class="fs-6"><b>Item Description</b></label>
                        <asp:TextBox ID="txtItemDescription" runat="server" CssClass="mb-2 form-control txtItemDescription " TextMode="MultiLine" Rows="3" Columns="100" placeholder="Enter Item Description"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvItemDescription" runat="server" ControlToValidate="txtItemDescription" 
        ErrorMessage="Item Description is required." CssClass="text-warning" Display="Dynamic" ValidationGroup="AddItem" />
                    </div>
                    <div class="form-group">
                        <label for="ddlStatus" class="fs-6"><b>Status</b></label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control mb-2">
                            <asp:ListItem Value="Available" Text="Available"></asp:ListItem>
                            <asp:ListItem Value="Unavailable" Text="Unavailable"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <label for="fuItemImage" class="fs-6"><b>Item Image</b></label>
                        <asp:FileUpload ID="fuItemImage" runat="server" CssClass="form-control-file mb-2" />
                        <asp:CustomValidator ID="cvFileUpload" runat="server" 
                            ErrorMessage="Only .jpg, .jpeg, or .png files are allowed." 
                            CssClass="text-warning" 
                            ClientValidationFunction="validateFileUpload" 
                            Display="Dynamic" ValidationGroup="AddItem" />
                        <asp:Label ID="lblMessage" runat="server" Text="" Visible="false" CssClass="text-success"></asp:Label>
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnSaveItem" runat="server" CssClass="btn btn-primary" Text="Save" OnClick="btnSaveItem_Click" OnClientClick="return validateForm();" CausesValidation="true" ValidationGroup="AddItem" />
                </div>
            </div>
        </div>
    </div>


    <div class="Redemption container-xl px-4 mt-4 container-fluid">
    <div class="title">
        <h1>Redemption Management</h1>
    </div>
    <div class="RedeemItemAdd">
        <asp:LinkButton ID="btnAddReviewItem" 
                        runat="server"
                        CssClass="btn btn-primary"
                        OnClientClick="openModal(); return false;">
            Add New Redeem Item
        </asp:LinkButton>
    </div>

        <asp:ListView ID="lvRedeemItems" runat="server">
            <LayoutTemplate>
                <table class="table table-striped table-bordered table-responsive redeemTable">
                    <thead>
                        <tr class="">
                            <th>ItemName</th>
                            <th>ItemPoints</th>
                            <th>ItemDescription</th>
                            <th>Status</th>
                            <th>ItemImage</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr id="itemPlaceHolder" runat="server"></tr>
                    </tbody>
                    
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Eval("ItemName") %></td>
                    <td><%# Eval("ItemPoints") %></td>
                    <td><%# Eval("ItemDescription") %></td>
                    <td><%# Eval("Status") %></td>
                    <td>
                        <img src='<%# ResolveUrl("~/Image/RedeemItem/" + Eval("ItemImage")) %>' alt="<%# Eval("ItemName") %>" style="width: 100px; height: auto;" class="" />
                    </td>
                    <td >

                        <asp:LinkButton ID="btnEditRedeemItem" 
                                        runat="server" 
                                        CommandArgument='<%# Eval("RedeemItemId") %>' 
                                        OnClick="btnEditRedeemItem_Click">
                            <i class="fas fa-edit" style="color: #ffbb00;"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" CommandArgument='<%# Eval("RedeemItemId") %>' OnClick="DeleteButton_Click" OnClientClick="return confirm('Are you sure you want to delete this Redeem Item?');">
                            <i class="fa-solid fa-trash-can" style="color: #ff0000;"></i>
                        </asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <script>
        function validateFileUpload(sender, args) {
            var fileUpload = document.getElementById('<%= fuItemImage.ClientID %>');
            if (fileUpload.files.length > 0) {
                var fileName = fileUpload.files[0].name;
                var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
                args.IsValid = allowedExtensions.exec(fileName) !== null;
            } else {
                args.IsValid = true; // No file selected is valid
            }
        }

        function openModal() {
            $('#staticBackdrop').modal('show');
        }

        function validateForm() {
            let isValid = true;

            // Check for required fields
            $('#staticBackdrop .form-control').each(function () {
                if ($(this).val().trim() === '') {
                    isValid = false;
                    alert($(this).attr('placeholder') + ' is required.');
                }
            });

            return isValid; // If all required fields are filled, return true
        }


    </script>



</asp:Content>
