<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="driverManagement.aspx.cs" Inherits="Assignment.driverManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:HiddenField ID="hdnCountryCode" runat="server" />
    <div class="modal fade" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Delete Confirmation</h1>
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
    
<div class="modal modal-xl fade" id="reviewDriver" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="reviewDriver" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">Driver Detail</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
    <asp:Panel ID="Panel1" runat="server">
        <div class="card-body row">
            <div class="col">
                <h5 class="text-dark">Driver Info</h5>
                <hr class="mt-0 mb-4">
                <div class="mb-3">
                    <label class="small mb-1">Driver Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter driver name" ValidationGroup="reviewGroup" ReadOnly="True"></asp:TextBox>
                </div>
                <div class="row gx-3 mb-3">
                    <div class="col-md-6">
                        <label class="small mb-1">Driver ID/Passport Number</label>
                        <asp:TextBox ID="txtDriverID" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="uploadDoc" ReadOnly="True"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label class="small mb-1">Driver License Number</label>
                        <asp:TextBox ID="txtDriverLicense" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="uploadDoc" ReadOnly="True"></asp:TextBox>
                    </div>
                </div>
                <div class="row gx-3 mb-3">
                    <div class="col-md-6">
                        <label class="small mb-1">Driver Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select" ValidationGroup="uploadDoc" Enabled="False">
                            <asp:ListItem Value="0">Select Gender</asp:ListItem>
                            <asp:ListItem Value="M">Male</asp:ListItem>
                            <asp:ListItem Value="F">Female</asp:ListItem>
                        </asp:DropDownList>
                     </div>
                    <div class="col-md-6">
                        <label class="small mb-1" for="inputBirthday">Driver Birthdate</label>
                        <asp:TextBox ID="txtBirthdate" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="uploadDoc" ReadOnly="True"></asp:TextBox>
                    </div>
                </div>
                <div class="row gx-3 mb-3">
                    <div class="col-md-6">
                        <label class="small mb-1 d-block">Driver Phone number</label>
                        <asp:TextBox ID="txtPhoneNum" runat="server" CssClass="form-control d-block" TextMode="Phone" ReadOnly="True"></asp:TextBox>
                    </div>
                </div>
                </div>
            <div class="col">
                <h5 class="text-dark">Driver Document</h5>
                <hr class="mt-0 mb-4">
             <div class="row gx-3 mb-3">
                    <div class="col-md-6">
                        <label class="small mb-1">Driver ID/Passport Picture</label>
                    <div class="d-flex flex-column align-items-centers">
                    <div class="image-frame-driver mx-auto">
                        <asp:Image ID="imgID" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                     </div>
                        <asp:Label ID="lblIdPic" runat="server" CssClass="validate mx-auto"></asp:Label>
                    </div>
                    </div>
                    <div class="col-md-6">
                        <label class="small mb-1">Driver Selfie</label>
                    <div class="d-flex flex-column align-items-centers">
                    <div class="image-frame-driver mx-auto">
                        <asp:Image ID="imgSelfie" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                     </div>
                    </div>
                    </div>
                </div>                     
            <div class="row gx-3 mb-3">
                    <div class="col-md-6">
                        <label class="small mb-1">Driver License (Front)</label>
                    <div class="d-flex flex-column align-items-centers">
                    <div class="image-frame-driver mx-auto">
                        <asp:Image ID="imgLicenseF" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                     </div>
                    </div>
                    </div>
                    <div class="col-md-6">
                        <label class="small mb-1">Driver License (Back)</label>
                    <div class="d-flex flex-column align-items-centers">
                    <div class="image-frame-driver mx-auto">
                        <asp:Image ID="imgLicenseB" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                     </div>
                    </div>
                    </div>
                </div>
                </div>
    </div>
    </asp:Panel>
</div>
      <div class="modal-footer">
        <asp:Button ID="btnApprove" runat="server" Text="Approve" CssClass="btn btn-primary" ValidationGroup="reviewGroup"/>
        <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn btn-danger" ValidationGroup="reviewGroup"/>
      </div>
    </div>
  </div>   
</div>

    <div class="container-xl px-4 mt-4">
    <h1 class="text-dark">Driver Management</h1>
    <hr class="mt-0 mb-4">
    <div class="card-container mb-3">
        <asp:Label ID="lblDriverText" runat="server"></asp:Label>
        <asp:Repeater ID="DriverReapeter" runat="server" OnItemDataBound="DriverReapeter_ItemDataBound">
            <ItemTemplate>
                <div class="card-body rounded border border-dark px-0 py-2 mb-3" Style="background-color:#effaf6">
                    
                    <div class="d-flex align-items-center justify-content-between px-4">
                        <div class="d-flex align-items-center">
                             <i class="fa-regular fa-id-card" style="font-size:1.5em;"></i>
                            <div class="mx-4">
                                    <asp:Label ID="lblDriverName" runat="server" Text='<%# Eval("DriverName") %>' CssClass="small d-block" />
                                    <asp:Label ID="lblDriverBdate" runat="server" Text='<%# Eval("DriverID") %>' CssClass="text-xs text-muted d-inline" />
                                <br />
                                    <asp:Label ID="lblReject" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                        </div>
                        <div class="d-flex align-items-center ms-4 small">
                            <asp:Label ID="lblApproval" runat="server"></asp:Label>
                        <div>
                            <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-muted" CommandArgument='<%# Eval("Id") %>' OnClick="btnView_Click" />
                        </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/intlTelInput.min.js"></script>
    <script>

        const input = document.querySelector("#<%= txtPhoneNum.ClientID %>");
        const iti = window.intlTelInput(input, {
            initialCountry: "auto",
            geoIpLookup: callback => {
                fetch("https://ipapi.co/json")
                    .then(res => res.json())
                    .then(data => callback(data.country_code))
                    .catch(() => callback("us"));
            },
            utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/utils.js",
        });

        function validatePhone(sender, args) {          
            args.IsValid = iti.isValidNumber();
        }

        function getCountryCode() {
            document.getElementById('<%= hdnCountryCode.ClientID %>').value = iti.getSelectedCountryData().dialCode;
        }

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

        function loadModal() {
            document.addEventListener("DOMContentLoaded", modal);
        }


        function modal() {
            $('#reviewDriver').modal('toggle');
            return false;
        };

    </script>




</asp:Content>
