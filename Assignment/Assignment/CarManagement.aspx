<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="CarManagement.aspx.cs" Inherits="Assignment.CarManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:SqlDataSource ID="carType" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT [CType] FROM [CarType]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="carLocation" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT [Id], [LocationName] FROM [Location]"></asp:SqlDataSource>

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
    <h1 class="text-dark">Car Management</h1>
    <hr class="mt-0 mb-4">
<asp:UpdatePanel ID="updateCarForm" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
    <ContentTemplate>
<asp:Panel ID="carPanel" runat="server">
    <div class="row">
     <div class="col-xl-4">
            <div class="card mb-0 mb-xl-0">
                <div class="card-header">Car Picture</div>
                <div class="card-body text-center">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="car-pic-wrapper image-frame mx-auto" OnClientClick="return fileUpload()">
                     <span class="upload-text">Upload</span>
                    <asp:Image ID="imgCarPic" runat="server" CssClass="img-car-pic mb-2" Width="300px" ImageUrl="~/Image/no-img -long.png" />
                    </asp:LinkButton>
                    <div class="small font-italic text-muted">JPG or PNG no larger than 2 MB</div>
                    <asp:CustomValidator ID="validateCarPic" runat="server" ControlToValidate="fuCarPic" CssClass="validate" ValidationGroup="uploadCar" ValidateEmptyText="True" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile"></asp:CustomValidator>
                    <asp:FileUpload ID="fuCarPic" runat="server" CssClass="uploadPicture" onchange="ShowPreview(event)"/>
                    <br />
                </div>
            </div>
        </div>
        <div class="col-xl-8 mb-5">
            <div class="card mb-4">
                <div class="card-header">Add/Edit Car</div>
                <asp:UpdatePanel ID="Updateform" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                    <ContentTemplate>
                <div class="card-body">
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Car Plate</label>
                                <asp:TextBox ID="txtCarPlate" runat="server" CssClass="form-control" placeholder="Car Plate" ValidationGroup="uploadCar"></asp:TextBox>
                                <asp:CustomValidator ID="validateCarPlate" runat="server" ErrorMessage="Car Plate is invalid" ControlToValidate="txtCarPlate" CssClass="validate" ValidationGroup="uploadCar" OnServerValidate="validateCarPlate_ServerValidate" ValidateEmptyText="True"></asp:CustomValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Car Brand</label>
                                <asp:DropDownList ID="ddlCarBrand" runat="server" ValidationGroup="uploadCar" CssClass="form-select"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqCarBrand" runat="server" ErrorMessage="Car Brand is required" ControlToValidate="ddlCarBrand" CssClass="validate" ValidationGroup="uploadCar" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Car Name</label>
                                <asp:TextBox ID="txtCarName" runat="server" CssClass="form-control" placeholder="Car Name" ValidationGroup="uploadCar" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCarName" runat="server" ErrorMessage="Car Name is required" ControlToValidate="txtCarName" CssClass="validate" ValidationGroup="uploadCar"></asp:RequiredFieldValidator>
                  </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Car Type</label>
                                <asp:DropDownList ID="ddlCarType" runat="server" CssClass="form-select" ValidationGroup="uploadCar" DataSourceID="carType" DataTextField="CType" DataValueField="CType" OnDataBound="ddlCarType_DataBound"></asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqCarType" runat="server" ErrorMessage="Car Type is required" ControlToValidate="ddlCarType" CssClass="validate" ValidationGroup="uploadCar" InitialValue="0"></asp:RequiredFieldValidator>
                       <br />
                            </div>
                        </div>
                    <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Car Description</label>
                                <asp:TextBox ID="txtCarDesc" runat="server" CssClass="form-control" placeholder="Car Description" ValidationGroup="uploadCar" ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCarDesc" runat="server" ErrorMessage="Car Name is required" ControlToValidate="txtCarDesc" CssClass="validate" ValidationGroup="uploadCar"></asp:RequiredFieldValidator>
                  </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Car Day Price</label>
                                <asp:TextBox ID="txtCarPrice" runat="server" CssClass="form-control" ValidationGroup="uploadCar" placeholder="MYR 0.00"></asp:TextBox>
                                <asp:CustomValidator ID="validatePrice" runat="server" ErrorMessage="CustomValidator" ClientValidationFunction="checkPrice" ControlToValidate="txtCarPrice" Text="Invalid Price" ValidationGroup="uploadCar" CssClass="validate" ValidateEmptyText="True"></asp:CustomValidator>
                       <br />
                            </div>
                        </div>
                    <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Car Seat</label>
                                <asp:TextBox ID="txtCarSeat" runat="server" CssClass="form-control" ValidationGroup="uploadCar" TextMode="Number" Max="10" Min="2"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqCarSeat" runat="server" ErrorMessage="Car Seat is required" ControlToValidate="txtCarSeat" CssClass="validate" ValidationGroup="uploadCar"></asp:RequiredFieldValidator>
                  </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Car Transmission</label>
                                <asp:DropDownList ID="ddlCarTransmission" runat="server" CssClass="form-select" ValidationGroup="uploadCar">
                                    <asp:ListItem Value="0">Select Car Transmission</asp:ListItem>
                                    <asp:ListItem>Automatic</asp:ListItem>
                                    <asp:ListItem>Manual</asp:ListItem>
                                </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqCarTransmission" runat="server" ErrorMessage="Car Transmission is required" ControlToValidate="ddlCarTransmission" CssClass="validate" ValidationGroup="uploadCar" InitialValue="0"></asp:RequiredFieldValidator>
                       <br />
                            </div>
                        </div>
                    <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Car Energy</label>
                                <asp:DropDownList ID="ddlCarEnergy" runat="server" CssClass="form-select" ValidationGroup="uploadCar">
                                    <asp:ListItem Value="0">Select Car Energy</asp:ListItem>
                                    <asp:ListItem>Gasoline</asp:ListItem>
                                    <asp:ListItem>Electric</asp:ListItem>
                                </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqCarEnergy" runat="server" ErrorMessage="Car Energy is required" ControlToValidate="ddlCarEnergy" CssClass="validate" ValidationGroup="uploadCar" InitialValue="0"></asp:RequiredFieldValidator>
                  </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Car Location</label>
                                <asp:DropDownList ID="ddlCarLocation" runat="server" CssClass="form-select" ValidationGroup="uploadCar" DataSourceID="carLocation" DataTextField="LocationName" DataValueField="Id" OnDataBound="ddlCarLocation_DataBound"></asp:DropDownList>
                                <asp:RequiredFieldValidator ID="reqCarLocation" runat="server" ErrorMessage="Car Location is required" ControlToValidate="ddlCarLocation" CssClass="validate" ValidationGroup="uploadCar" InitialValue="0"></asp:RequiredFieldValidator>
                       <br />
                            </div>
                        </div>
                    <asp:Button ID="btnUploadCar" runat="server" Text="Add Car" CssClass='btn btn-primary' ValidationGroup="uploadCar" OnClick="btnUploadCar_Click"/>
                    <asp:Button ID="btnUpdateCar" runat="server" Text="Update" CssClass='btn btn-primary' ValidationGroup="uploadCar" Visible="False" OnClick="btnUpdateCar_Click"/>
                    <asp:Button ID="btnDelete" runat="server" Text="Delete " cssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="False"/>
                </div>
                     </ContentTemplate>
                </asp:UpdatePanel>
            </div>            
        </div> 
    </div>       
</asp:Panel>  
    </ContentTemplate>
</asp:UpdatePanel>        

    <h1 class="text-dark">Car Detail</h1>
    <hr class="mt-0 mb-4">
        <div>
           <asp:UpdatePanel ID="updateCarTable" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
              <ContentTemplate>
            <table id="carTable" class="table table-striped table-bordered table-hover table-responsive">
            <thead>
                <tr class="table-primary" style="text-align: center;">
                    <th scope="col">
                        <asp:LinkButton ID="btnSortCarPlate" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarPlate" CssClass="text-dark">Car Plate</asp:LinkButton>
                     </th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarBrand" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarBrand" CssClass="text-dark">Car Brand</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarName" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarName" CssClass="text-dark">Car Name</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarType" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarType" CssClass="text-dark">Car Type</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarDayPrice" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarDayPrice" CssClass="text-dark">Car Day Price</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarTransmission" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarTransmission" CssClass="text-dark">Car Transmission</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarEnergy" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarEnergy" CssClass="text-dark">Car Energy</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarLocation" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="LocationName" CssClass="text-dark">Location Name</asp:LinkButton></th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="repeaterCarTable" runat="server">
                <ItemTemplate>
                <tr style="text-align: center;">
                    <td scope="col"><%# Eval("CarPlate") %></td>
                    <td scope="col"><%# Eval("CarBrand") %></td>
                    <td scope="col"><%# Eval("CarName") %></td>
                    <td scope="col"><%# Eval("CType") %></td>
                    <td scope="col"><%# Eval("CarDayPrice") %></td>
                    <td scope="col"><%# Eval("CarTransmission") %></td>
                    <td scope="col"><%# Eval("CarEnergy") %></td>
                    <td scope="col"><%# Eval("LocationName") %></td>
                    <td scope="col">
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm text-primary" OnClick="btnEditCar_Click" CommandArgument='<%# Eval("CarPlate") %>' OnClientClick="Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);" />
                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-primary" OnClick="btnViewCar_Click" CommandArgument='<%# Eval("CarPlate") %>' OnClientClick="Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);" />
                    </td>
                </tr>
                </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
         </ContentTemplate>
</asp:UpdatePanel>
        <div>
            <button type="button" class="btn btn-primary" id="btnPrev" runat="server">Previous</button>
            <button type="button" class="btn btn-primary" id="btnNext" runat="server">Next</button>
        </div>
    </div>

    </div>
    <script>
        function EndRequestHandler(sender, args) {
            scrollTo(0, 0);
        }

        function fileUpload() {
            document.getElementById('<%= validateCarPic.ClientID %>').enabled = true;
            document.getElementById('<%= fuCarPic.ClientID %>').click();

            return false;
        }

        function ShowPreview(event) {           
            //read content of the file
            var ImageDir = new FileReader();
            //when file read update the image element
            ImageDir.onload = function () {
                var image = document.getElementById('<%= imgCarPic.ClientID %>');
                image.src = ImageDir.result;
            };
            //get file and convert to data url to use in img src = ""
            ImageDir.readAsDataURL(event.target.files[0]);
        } 

        function validateFile(sender, args) {
            var fileUpload = document.getElementById(sender.controltovalidate);
            var fileName = fileUpload.value;
            var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
            var maxSize = 2097152;

            if (!allowedExtensions.test(fileName)) {
                args.IsValid = false;
                return;
            }

            if (fileUpload.files[0].size > maxSize) {
                args.IsValid = false;
                return;
            }

            args.IsValid = true;
            
        }

        var currencyInput = document.getElementById('<%= txtCarPrice.ClientID %>');
        var currency = 'MYR' 

        // format inital value
        onBlur({ target: currencyInput })

        // bind event listeners
        currencyInput.addEventListener('focus', onFocus)
        currencyInput.addEventListener('blur', onBlur)


        function localStringToNumber(s) {
            return Number(String(s).replace(/[^0-9.,-]+/g, ""))
        }

        function onFocus(e) {
            var value = e.target.value;
            e.target.value = value ? localStringToNumber(value) : ''
        }

        function onBlur(e) {
            var value = e.target.value

            var options = {
                maximumFractionDigits: 2,
                currency: currency,
                style: "currency",
                currencyDisplay: "symbol"
            }

            e.target.value = (value || value === 0)
                ? localStringToNumber(value).toLocaleString(undefined, options)
                : ''
        }

        function checkPrice(sender, args) {
            var priceInput = document.getElementById(sender.controltovalidate).value;
            priceInput = priceInput.replace("MYR ", "");
            var price = parseFloat(priceInput);

            if (price > 0 && price <= 1000) {
                args.IsValid = true;
            } else {
                args.IsValid = false;
            }
        }

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>

</asp:Content>
