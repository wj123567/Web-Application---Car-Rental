<%@ Page Title="" Language="C#" MasterPageFile="~/Management/admin.Master" AutoEventWireup="true" CodeBehind="driverManagement.aspx.cs" Inherits="Assignment.driverManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <link href="../CSS/driverManagement.css" rel="stylesheet" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="modal modal-lg fade" id="imageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="imageModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="btn-close float-end my-2 btn-close-white" aria-label="Close" data-bs-toggle="modal" data-bs-target="#reviewDriver"></button>
                    <asp:Image ID="largeImage" runat="server" Width="100%" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="rejectReason" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="rejectReason" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <asp:UpdatePanel ID="updateReason" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
                    <ContentTemplate>
                        <div class="modal-header">
                            <h1 class="modal-title fs-5 text-black" id="staticBackdropLabel">Reject Reason</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <asp:DropDownList ID="ddlRejectReason" runat="server" CssClass="form-select" AutoPostBack="True" ValidationGroup="rejectGroup" OnSelectedIndexChanged="ddlRejectReason_SelectedIndexChanged">
                                <asp:ListItem Value="0">Select Reject Reason</asp:ListItem>
                                <asp:ListItem>Invalid driving license (expired/illegible)</asp:ListItem>
                                <asp:ListItem>Mismatch in driving license information</asp:ListItem>
                                <asp:ListItem>Expired/invalid passport or ID</asp:ListItem>
                                <asp:ListItem>Mismatch in passport or ID information</asp:ListItem>
                                <asp:ListItem>Unclear document scan or image</asp:ListItem>
                                <asp:ListItem>Selfie does not match documents</asp:ListItem>
                                <asp:ListItem>Unclear selfie quality (poor lighting/visibility)</asp:ListItem>
                                <asp:ListItem>Other</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="requireReason" runat="server" ErrorMessage="Reject Reason is Required" CssClass="validate" InitialValue="0" ValidationGroup="rejectGroup" ControlToValidate="ddlRejectReason"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtOtherReason" runat="server" ValidationGroup="rejectGroup" CssClass="form-control mt-1" placeholder="Other Reason" Visible="False"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="requireOtherReason" runat="server" ErrorMessage="Other Reason is Required" CssClass="validate" ValidationGroup="rejectGroup" ControlToValidate="txtOtherReason" Enabled="False"></asp:RequiredFieldValidator>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="modal-footer">
                    <asp:Button ID="btnCancelReject" runat="server" Text="Review Again" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#reviewDriver" OnClientClick="return false" />
                    <asp:Button ID="btnReject2" runat="server" Text="Reject" CssClass="btn btn-danger" ValidationGroup="rejectGroup" OnClick="btnReject2_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-xl fade" id="reviewDriver" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="reviewDriver" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">Driver Detail</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="card-body row">
                        <div class="col-12 col-lg-6">
                            <h5 class="text-dark">Driver Info</h5>
                            <hr class="mt-0 mb-4">
                            <div class="mb-3">
                                <label class="small mb-1">Driver Name</label>
                                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter driver name" ValidationGroup="reviewGroup" ReadOnly="True"></asp:TextBox>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1">Driver ID/Passport Number</label>
                                    <asp:TextBox ID="txtDriverID" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="reviewGroup" ReadOnly="True"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1">Driver License Number</label>
                                    <asp:TextBox ID="txtDriverLicense" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="reviewGroup" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1">Driver Gender</label>
                                    <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select" ValidationGroup="reviewGroup" Enabled="False">
                                        <asp:ListItem Value="0">Select Gender</asp:ListItem>
                                        <asp:ListItem Value="M">Male</asp:ListItem>
                                        <asp:ListItem Value="F">Female</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1" for="inputBirthday">Driver Birthdate</label>
                                    <asp:TextBox ID="txtBirthdate" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="reviewGroup" ReadOnly="True"></asp:TextBox>
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1 d-block">Driver Phone number</label>
                                    <asp:TextBox ID="txtPhoneNum" runat="server" CssClass="form-control d-block" TextMode="Phone" ReadOnly="True" ValidationGroup="reviewGroup"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-6">
                            <h5 class="text-dark">Driver Document</h5>
                            <hr class="mt-0 mb-4">
                            <div class="row gx-3 mb-3">
                                <div class="col-12 col-md-6">
                                    <label class="small mb-1">Driver ID/Passport Picture</label>
                                    <div class="d-flex flex-column align-items-centers">
                                        <div class="image-frame-driver mx-auto">
                                            <asp:ImageButton ID="imgID" runat="server" CssClass="img-btn mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                                        </div>
                                        <asp:Label ID="lblIdPic" runat="server" CssClass="validate mx-auto"></asp:Label>
                                    </div>
                                </div>
                                <div class="col-12 col-md-6">
                                    <label class="small mb-1">Driver Selfie</label>
                                    <div class="d-flex flex-column align-items-centers">
                                        <div class="image-frame-driver mx-auto">
                                            <asp:ImageButton ID="imgSelfie" runat="server" CssClass="img-btn mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row gx-3 mb-3">
                                <div class="col-md-6">
                                    <label class="small mb-1">Driver License (Front)</label>
                                    <div class="d-flex flex-column align-items-centers">
                                        <div class="image-frame-driver mx-auto">
                                            <asp:ImageButton ID="imgLicenseF" runat="server" CssClass="img-btn mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="small mb-1">Driver License (Back)</label>
                                    <div class="d-flex flex-column align-items-centers">
                                        <div class="image-frame-driver mx-auto">
                                            <asp:ImageButton ID="imgLicenseB" runat="server" CssClass="img-btn mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnApprove" runat="server" Text="Approve" CssClass="btn btn-primary" ValidationGroup="reviewGroup" OnClick="btnApprove_Click" />
                    <asp:Button ID="btnReject" runat="server" Text="Reject" CssClass="btn btn-danger" ValidationGroup="reviewGroup" data-bs-toggle="modal" data-bs-target="#rejectReason" OnClientClick="return false" />
                </div>
            </div>
        </div>
    </div>


    <div class="container-xl px-4 mt-4">
        <h1 class="text-dark">Driver Management</h1>
        <hr class="mt-0 mb-4">
        <div class="d-md-flex justify-content-between">
            <div class="custom-flex mb-2">
                <asp:Button ID="btnAll" runat="server" Text="All" CssClass="btn border border-dark sort-button-group" CommandArgument="All" OnClick="sortCategory" OnClientClick="colorButton(this)" BackColor="#3490DC" ForeColor="White" />
                <asp:Button ID="btnPending" runat="server" Text="Pending" CssClass="btn border border-dark sort-button-group" OnClick="sortCategory" CommandArgument="P" OnClientClick="colorButton(this)" />
                <asp:Button ID="btnRejected" runat="server" Text="Rejected" CssClass="btn border border-dark sort-button-group" OnClick="sortCategory" CommandArgument="R" OnClientClick="colorButton(this)" />
                <asp:Button ID="btnApproved" runat="server" Text="Approved" CssClass="btn border border-dark sort-button-group" OnClick="sortCategory" CommandArgument="A" OnClientClick="colorButton(this)" />
            </div>
            <div>
                <div>
                    <asp:TextBox ID="searchBar" runat="server" CssClass="form-control rounded border-dark" placeholder="Name/Phone/Id/Passport/LicenseNo" ValidationGroup="searchBar" onkeypress="triggerButtonClick(event)"></asp:TextBox>
                    <asp:Button ID="hiddenBtn" runat="server" Text="Button" OnClick="hiddenBtn_Click" ValidationGroup="searchBar" Style="display: none;" />
                </div>
            </div>
        </div>
        <div>
            <asp:UpdatePanel ID="updateDriverTable" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="table-responsive">
                    <table id="driverTable" class="table table-striped table-bordered table-hover mb-2">
                        <thead>
                            <tr style="text-align: center;">
                                <th scope="col">
                                    <asp:LinkButton ID="btnSortDriverName" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DriverName" CssClass="text-dark">Name</asp:LinkButton>
                                </th>
                                <th scope="col">
                                    <asp:LinkButton ID="btnSortDriverBdate" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DriverBdate" CssClass="text-dark">Birth Date</asp:LinkButton></th>
                                <th scope="col">
                                    <asp:LinkButton ID="btnSortDateApply" runat="server" OnClick="btnSort_Click" CommandArgument="DESC" CommandName="DateApply" CssClass="text-dark">Date Apply</asp:LinkButton></th>
                                <th scope="col">
                                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DriverPno" CssClass="text-dark">Phone no</asp:LinkButton></th>
                                <th scope="col">
                                    <asp:LinkButton ID="btnSortDriverLicense" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DriverLicense" CssClass="text-dark">License No</asp:LinkButton></th>
                                <th scope="col">
                                    <asp:LinkButton ID="btnSortDriverId" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="DriverId" CssClass="text-dark">Id/Passport No</asp:LinkButton></th>
                                <th scope="col">
                                    <asp:LinkButton ID="btnSortApproval" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="Approval" CssClass="text-dark">Approval</asp:LinkButton></th>
                                <th scope="col">
                                    <asp:LinkButton ID="btnSortRejectReason" runat="server" OnClick="btnSort_Click" CommandArgument="ASC" CommandName="RejectReason" CssClass="text-dark">Reject Reason</asp:LinkButton></th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="DriverReapeter" runat="server" OnItemDataBound="DriverReapeter_ItemDataBound" OnItemCreated="DriverReapeter_ItemCreated">
                                <ItemTemplate>
                                    <tr style="text-align: center;">
                                        <td scope="col"><%# Eval("DriverName") %></td>
                                        <td scope="col">
                                            <asp:Label ID="lblBdate" runat="server"></asp:Label>
                                        </td>
                                        <td scope="col">
                                            <asp:Label ID="lblDateApply" runat="server"></asp:Label>
                                        </td>
                                        <td scope="col"><%# Eval("DriverPno") %></td>
                                        <td scope="col"><%# Eval("DriverLicense") %></td>
                                        <td scope="col"><%# Eval("DriverId") %></td>
                                        <td scope="col">
                                            <asp:Label ID="lblApproval" runat="server"></asp:Label>
                                        </td>
                                        <td scope="col">
                                            <asp:Label ID="lblReject" runat="server"></asp:Label>
                                        </td>
                                        <td scope="col">
                                            <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-primary" CommandArgument='<%# Eval("Id") %>' OnClick="btnView_Click" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                    </div>
                    <div>
                        <div class="float-start">
                            <asp:Button ID="btnPrevious" runat="server" Text="Previous" OnClick="btnPrevious_Click" Enabled="False" CssClass="btn btn-primary btn-sm" />
                            <asp:Label ID="lblPageInfo" runat="server" Text="" CssClass="text-dark mx-2"></asp:Label>
                            <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn btn-primary btn-sm" />
                        </div>
                        <asp:Label ID="lblTotalRecord" runat="server" Text="" CssClass="float-end text-muted span-totalRecord"></asp:Label>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAll" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnApproved" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnPending" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnRejected" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="hiddenBtn" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>

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

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }

        function loadModal() {
            document.addEventListener("DOMContentLoaded", modal);
        }

        function colorButton(button) {
            var buttonGroup = document.querySelectorAll(".sort-button-group");

            buttonGroup.forEach(function (btn) {
                btn.style.backgroundColor = "";
                btn.style.color = "";
            });

            button.style.backgroundColor = "#3490dc";
            button.style.color = "#fff";
        }

        function showSortDirection(buttonID, sort) {

            var button = document.getElementById(buttonID);

            if (sort == "ASC") {
                button.innerHTML = button.innerHTML + " ▲";
            } else {
                button.innerHTML = button.innerHTML + " ▼";
            }
        }

        function addDateApply() {

            document.getElementById('<%= btnSortDateApply.ClientID %>').innerHTML = document.getElementById('<%= btnSortDateApply.ClientID %>').innerHTML + " ▲";
        }


        function modal() {
            $('#reviewDriver').modal('toggle');
            return false;
        };

        function triggerButtonClick(event) {
            if (event.keyCode == 13) {
                event.preventDefault();
                document.getElementById('<%= hiddenBtn.ClientID %>').click();
            }
        }

        function ShowImageModal(image) {
            document.getElementById('<%= largeImage.ClientID %>').src = image.src;
            $('#reviewDriver').modal('hide');
            $('#imageModal').modal('show');            
            console.log("Im in");
            return false;
        }
    </script>




</asp:Content>
