<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="CarManagement.aspx.cs" Inherits="Assignment.CarManagement" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:SqlDataSource ID="carBrand" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT [BrandName] FROM [CarBrand] ORDER BY [BrandName]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="carLocation" runat="server" ConnectionString='<%$ ConnectionStrings:DatabaseConnectionString %>' SelectCommand="SELECT [Id], [LocationName] FROM [Location]"></asp:SqlDataSource>

    <div class="modal fade" id="ConfirmDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="ConfirmDelete" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel">Car Detail</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <h5 class="text-dark">Are you sure you want to delete?</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup" OnClick="btnConfirmDelete_Click"/>
      </div>
    </div>
  </div>   
</div>

    <div class="modal fade" id="addBrand" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addLocation" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
    <asp:UpdatePanel ID="updateAddBrand" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">Add/Remove Brand</h1>
          <asp:DropDownList ID="ddlCarNewCarbrand" runat="server" CssClass="form-select form-select-sm mx-2 w-auto" DataSourceID="carBrand" DataTextField="BrandName" DataValueField="BrandName" AutoPostBack="True" OnDataBound="ddlCarNewCarbrand_DataBound" OnSelectedIndexChanged="ddlCarNewCarbrand_SelectedIndexChanged"></asp:DropDownList>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <span>Car Brand:</span>
          <asp:TextBox ID="txtBrand" runat="server" CssClass="form-control" placeholder="Car Brand" ValidationGroup="addBrand" MaxLength="15"></asp:TextBox>
          <asp:CustomValidator ID="cvBrand" runat="server" ErrorMessage="Car Brand Exist" CssClass="validate" ControlToValidate="txtBrand" ValidationGroup="addBrand" Display="Dynamic" OnServerValidate="cvBrand_ServerValidate"></asp:CustomValidator>
          <asp:RequiredFieldValidator ID="reqBrand" runat="server" ErrorMessage="Car Brand is required" ValidationGroup="addBrand" ControlToValidate="txtBrand" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnDeleteBrand" runat="server" Text="Delete" CssClass="btn btn-danger" ValidationGroup="delBrand" OnClick="btnDeleteBrand_Click" Visible="False" />
        <asp:Button ID="btnUploadBrand" runat="server" Text="Add Brand" CssClass="btn btn-primary" ValidationGroup="addBrand" OnClick="btnUploadBrand_Click" />
        <asp:Button ID="btnUpdateBrand" runat="server" Text="Update Brand" CssClass="btn btn-primary" ValidationGroup="addBrand" OnClick="btnUpdateBrand_Click" Visible="False" />
        
      </div>
      </ContentTemplate>
      </asp:UpdatePanel>
    </div>
  </div>   
</div>
    
    <div class="modal modal-lg fade" id="addLocation" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addLocation" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
    <asp:UpdatePanel ID="updateAddLocation" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
    <ContentTemplate>
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel3">Add/Remove Location</h1>
          <asp:DropDownList ID="ddlChooseLocation" runat="server" CssClass="form-select form-select-sm mx-2 w-auto" OnSelectedIndexChanged="ddlChooseLocation_SelectedIndexChanged" DataSourceID="carLocation" DataTextField="LocationName" DataValueField="Id" OnDataBound="ddlChooseLocation_DataBound" AutoPostBack="True"></asp:DropDownList>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                              <span>Location Name:</span>
                              <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="Location Name" ValidationGroup="deleteGroup" TextMode="SingleLine"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="reqLocation" runat="server" ErrorMessage="Password is required" ValidationGroup="addLocation" ControlToValidate="txtLocation" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                              <span>Location State:</span>
                                <asp:DropDownList ID="ddlState" runat="server" ValidationGroup="addLocation" CssClass="form-select">
                                    <asp:ListItem Value="0">Select State</asp:ListItem>
                                    <asp:ListItem>Johor</asp:ListItem>
                                    <asp:ListItem>Kedah</asp:ListItem>
                                    <asp:ListItem>Kelantan</asp:ListItem>
                                    <asp:ListItem>Malacca</asp:ListItem>
                                    <asp:ListItem>Negeri Sembilan</asp:ListItem>
                                    <asp:ListItem>Pahang</asp:ListItem>
                                    <asp:ListItem>Penang</asp:ListItem>
                                    <asp:ListItem>Perak</asp:ListItem>
                                    <asp:ListItem>Perlis</asp:ListItem>
                                    <asp:ListItem>Sabah</asp:ListItem>
                                    <asp:ListItem>Sarawak</asp:ListItem>
                                    <asp:ListItem>Selangor</asp:ListItem>
                                    <asp:ListItem>Terengganu</asp:ListItem>
                                </asp:DropDownList>                    
                              <asp:RequiredFieldValidator ID="requireState" runat="server" ErrorMessage="State is required" ValidationGroup="addLocation" ControlToValidate="ddlState" CssClass="validate" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                              <span>Location Postcode:</span>
                              <asp:TextBox ID="txtPostcode" runat="server" CssClass="form-control" placeholder="Postcode" ValidationGroup="deleteGroup" TextMode="SingleLine"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="requirePostcode" runat="server" ErrorMessage="Postcode is required" ValidationGroup="addLocation" ControlToValidate="txtPostcode" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexPostcode" runat="server" ErrorMessage="Invalid Postcode" ControlToValidate="txtPostcode" CssClass="validate" Display="Dynamic" ValidationExpression="^(0[1-9]|[1-9][0-9])\d{3}$"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col-md-6">
                              <span>Location Address:</span>
                              <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Address" ValidationGroup="addLocation" TextMode="MultiLine" Rows="3" Columns="20" style="resize:none;"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="requireAddress" runat="server" ErrorMessage="Address is required" ValidationGroup="addLocation" ControlToValidate="txtAddress" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                        </div>
      </div>
      <div class="modal-footer">
        <asp:Button ID="btnDeleteLocation" runat="server" Text="Delete" CssClass="btn btn-danger" validationGroup="delLocation" OnClick="btnDeleteLocation_Click" Visible="False" />
        <asp:Button ID="btnUploadLocation" runat="server" Text="Add Location" CssClass="btn btn-primary" validationGroup="addLocation" OnClick="btnUploadLocation_Click" />
        <asp:Button ID="btnUpdateLocation" runat="server" Text="Update Location" CssClass="btn btn-primary" ValidationGroup="addLocation" OnClick="btnUpdateLocation_Click" Visible="False" />
      </div>
      </ContentTemplate>
        <Triggers>
           <asp:PostBackTrigger ControlID="btnUploadLocation" />
           <asp:PostBackTrigger ControlID="btnUpdateLocation" />
            <asp:PostBackTrigger ControlID="btnDeleteLocation" />
        </Triggers>
      </asp:UpdatePanel>
    </div>
  </div>   
</div>

    <div class="container-xl px-4 mt-4">
    <h1 class="text-dark">Car Management</h1>
    <hr class="mt-0 mb-4">

<asp:Panel ID="carPanel" runat="server">
    <div class="row">
     <div class="col-xl-4">
            <div class="card mb-0 mb-xl-0">
                <div class="card-header">Car Picture</div>
                <div class="card-body text-center">
                    <asp:LinkButton ID="btnUploadPic" runat="server" CssClass="car-pic-wrapper image-frame mx-auto" OnClientClick="return fileUpload()">
                     <span class="upload-text">Upload</span>
                    <asp:Image ID="imgCarPic" runat="server" CssClass="img-car-pic mb-2" Width="300px" ImageUrl="~/Image/no-img -long.png" />
                    </asp:LinkButton>
                    <div id="img-warning-text" class="small font-italic text-muted">JPG or PNG no larger than 2 MB</div>
                    <asp:CustomValidator ID="validateCarPic" runat="server" ControlToValidate="fuCarPic" CssClass="validate" ValidationGroup="uploadCar" ValidateEmptyText="True" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile"></asp:CustomValidator>
                    <asp:FileUpload ID="fuCarPic" runat="server" CssClass="uploadPicture" onchange="ShowPreview(event)"/>
                    <br />
                </div>
            </div>
        </div>
        <div class="col-xl-8 mb-5">
            <div class="card mb-4">
                <div class="card-header">Add/Edit Car</div>
                <div class="card-body">
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Car Plate</label>
                                <asp:TextBox ID="txtCarPlate" runat="server" CssClass="form-control" placeholder="Car Plate" ValidationGroup="uploadCar"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="requireCarPlate" runat="server" ErrorMessage="Car Plate is required" ControlToValidate="txtCarPlate" CssClass="validate" ValidationGroup="uploadCar" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="regexCarPlate" runat="server" ErrorMessage="Invalid Car Plate" Display="Dynamic" CssClass="validate" ValidationGroup="uploadCar" ControlToValidate="txtCarPlate" ValidationExpression="[A-Z]{3}\d{1,4}"></asp:RegularExpressionValidator>
                                <asp:CustomValidator ID="validateCarPlate" runat="server" ErrorMessage="Car Plate is Exist" ControlToValidate="txtCarPlate" CssClass="validate" ValidationGroup="uploadCar" OnServerValidate="validateCarPlate_ServerValidate" ValidateEmptyText="False" Display="Dynamic"></asp:CustomValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Car Brand</label>
                            <div class="d-flex justify-content-between align-items-center">             <asp:DropDownList ID="ddlCarBrand" runat="server" ValidationGroup="uploadCar" CssClass="form-select" DataSourceID="carBrand" DataTextField="BrandName" DataValueField="BrandName" OnDataBound="ddlCarBrand_DataBound"></asp:DropDownList>                               
                                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="border border-gray mx-1 px-3 py-2 rounded" data-bs-toggle="modal" data-bs-target="#addBrand" OnClientClick="return false"><i class="fa-solid fa-plus-minus fa-lg" style="color: #000000;"></i></asp:LinkButton> 
                            </div> 

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
                                <asp:DropDownList ID="ddlCarType" runat="server" CssClass="form-select" ValidationGroup="uploadCar">
                                    <asp:ListItem Value="0" Selected="False">Select Car Type</asp:ListItem>
                                    <asp:ListItem>Hatchback</asp:ListItem>
                                    <asp:ListItem>MPV</asp:ListItem>
                                    <asp:ListItem>Sedan</asp:ListItem>
                                    <asp:ListItem>SUV</asp:ListItem>
                                </asp:DropDownList>
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
                                <asp:TextBox ID="hiddenCarPrice" runat="server" Visible="True" style="display:none;"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="requirePrice" runat="server" ErrorMessage="Price is Require" ControlToValidate="txtCarPrice" ValidationGroup="uploadCar" CssClass="validate" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid Price Range (MYR 1 - MYR 1000)" MaximumValue="1000.00" MinimumValue="1.00" ControlToValidate="hiddenCarPrice" ValidationGroup="uploadCar" CssClass="validate" Display="Dynamic" CultureInvariantValues="False" Type="Double"></asp:RangeValidator>
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
                            <div class="d-flex justify-content-between align-items-center">                                
                                <asp:DropDownList ID="ddlCarLocation" runat="server" CssClass="form-select d-inline" ValidationGroup="uploadCar" DataSourceID="carLocation" DataTextField="LocationName" DataValueField="Id" OnDataBound="ddlCarLocation_DataBound"></asp:DropDownList>
                                <asp:LinkButton ID="btnAddLocation" runat="server" CssClass="border border-gray mx-1 px-3 py-2 rounded" data-bs-toggle="modal" data-bs-target="#addLocation" OnClientClick="return false"><i class="fa-solid fa-plus-minus fa-lg" style="color: #000000;"></i></asp:LinkButton> 
                            </div>    

                                <asp:RequiredFieldValidator ID="reqCarLocation" runat="server" ErrorMessage="Car Location is required" ControlToValidate="ddlCarLocation" CssClass="validate" ValidationGroup="uploadCar" InitialValue="0"></asp:RequiredFieldValidator>
                       <br />
                            </div>
                        </div>                    
                    <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Car State</label>
                                <asp:DropDownList ID="ddlCarState" runat="server" CssClass="form-select" ValidationGroup="uploadCar">
                                    <asp:ListItem Value="1">Delisted</asp:ListItem>
                                    <asp:ListItem Value="0" Selected="True">Listed</asp:ListItem>
                                </asp:DropDownList>
                  </div>
                        </div>
                    <asp:Button ID="btnUploadCar" runat="server" Text="Add Car" CssClass='btn btn-primary' ValidationGroup="uploadCar" OnClick="btnUploadCar_Click"/>
                    <asp:Button ID="btnUpdateCar" runat="server" Text="Update" CssClass='btn btn-primary' ValidationGroup="uploadCar" Visible="False" OnClick="btnUpdateCar_Click"/>
                    <asp:Button ID="btnDelete" runat="server" Text="Delete " cssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="False"/>                                      
                </div>
            </div>            
        </div> 
    </div>        
</asp:Panel>      

    <h1 class="text-dark d-inline">Car Detail</h1>
    <asp:Button ID="btnAddNewCar" runat="server" Text="Add New Car" CssClass="btn btn-primary btn-sm mx-2 mb-2" OnClick="btnAddNewCar_Click" />
    <hr class="mt-0 mb-4">
        <div>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="False" UpdateMode="Conditional">
                <ContentTemplate>
            <table id="carTable" class="table table-striped table-bordered table-hover table-responsive">
            <thead>
                <tr style="text-align: center;">
                    <th scope="col">
                        <asp:LinkButton ID="btnSortCarPlate" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarPlate" CssClass="text-dark">Car Plate</asp:LinkButton>
                     </th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarBrand" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarBrand" CssClass="text-dark">Car Brand</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarName" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarName" CssClass="text-dark">Car Name</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarType" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CType" CssClass="text-dark">Car Type</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarDayPrice" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarDayPrice" CssClass="text-dark">Car Day Price</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarTransmission" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarTransmission" CssClass="text-dark">Car Transmission</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarEnergy" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="CarEnergy" CssClass="text-dark">Car Energy</asp:LinkButton></th>
                    <th scope="col">                        
                        <asp:LinkButton ID="btnSortCarLocation" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="LocationName" CssClass="text-dark">Location Name</asp:LinkButton></th>
                     <th scope="col">
                        <asp:LinkButton ID="btnSortCarState" runat="server" OnClick="btnSortCarPlate_Click" CommandArgument="ASC" CommandName="IsDelisted" CssClass="text-dark">Car Stated</asp:LinkButton></th>
                    <th scope="col">Actions</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="repeaterCarTable" runat="server" OnItemCreated="repeaterCarTable_ItemCreated" OnItemDataBound="repeaterCarTable_ItemDataBound">
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
                        <asp:Label ID="lblCarState" runat="server"></asp:Label></td>
                    <td scope="col">
                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btn btn-sm text-primary" OnClick="btnEditCar_Click" CommandArgument='<%# Eval("CarPlate") %>'/>
                    <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm text-primary" OnClick="btnViewCar_Click" CommandArgument='<%# Eval("CarPlate") %>'/>
                    </td>
                </tr>
                </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
                </ContentTemplate>
                </asp:UpdatePanel>
        <div>
        </div>
    </div>

    </div>
    <script>
        function fileUpload() {
            document.getElementById('<%= validateCarPic.ClientID %>').enabled = true;
            document.getElementById('<%= fuCarPic.ClientID %>').click();
            

            return false;
        }

        function disableUpload() {
            linkButton = document.getElementById('<%= btnUploadPic.ClientID %>');

                linkButton.onclick = function (event) {
                event.preventDefault();

            };

            linkButton.classList.remove('car-pic-wrapper');
            linkButton.classList.remove('car-pic-wrapper-no-hover');
            linkButton.style.pointerEvents = 'none';
            document.getElementById('img-warning-text').style.display = 'none';
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
        var hiddenCarPrice = document.getElementById('<%= hiddenCarPrice.ClientID %>');
        var currency = 'MYR' 

        // format inital value
        onBlur({ target: currencyInput })

        // bind event listeners
        currencyInput.addEventListener('focus', onFocus)
        currencyInput.addEventListener('blur', onBlur)


        function localStringToNumber(s) {
            hiddenCarPrice.value = String(s).replace(/[^0-9.,-]+/g, "");
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

        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>

</asp:Content>
