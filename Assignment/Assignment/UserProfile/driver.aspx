﻿    <%@ Page Title="" Language="C#" MasterPageFile="~/UserProfile/profile.Master" AutoEventWireup="true" CodeBehind="driver.aspx.cs" Inherits="Assignment.driver" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:HiddenField ID="hdnCountryCode" runat="server" />

    <div class="modal modal-lg fade" id="imageModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="imageModal" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-body">
                    <button type="button" class="btn-close float-end my-2 btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    <asp:Image ID="largeImage" runat="server" Width="100%"/>
                </div>
            </div>
        </div>
    </div>

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
        <asp:Button ID="btnConfirmDelete" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" ValidationGroup="deleteGroup" OnClick="btnConfirmDelete_Click" />
      </div>
    </div>
  </div>   
</div>

<div class="modal modal-lg fade" id="addDriver" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="addDriver" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5 text-dark" id="staticBackdropLabel2">Driver Detail</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">              
            <asp:Panel ID="Panel1" runat="server">
                <div class="card-body">
                    
                        <div class="mb-3">
                            <label class="small mb-1">Driver Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter driver name" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver ID/Passport Number</label>
                                <asp:TextBox ID="txtDriverID" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqId" runat="server" ErrorMessage="Driver ID/Passport Number is required" ControlToValidate="txtDriverID" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License Number</label>
                                <asp:TextBox ID="txtDriverLicense" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqDriverLicense" runat="server" ErrorMessage="Driver License Number is required" ControlToValidate="txtDriverLicense" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Gender</label>
                                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select" ValidationGroup="uploadDoc">
                                    <asp:ListItem Value="0">Select Gender</asp:ListItem>
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="reqGender" runat="server" ErrorMessage="Gender is required" ControlToValidate="ddlGender" CssClass="validate" ValidationGroup="uploadDoc" InitialValue="0"></asp:RequiredFieldValidator>
                             </div>
                            <div class="col-md-6">
                                <label class="small mb-1" for="inputBirthday">Driver Birthdate</label>
                                <asp:TextBox ID="txtBirthdate" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="uploadDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqBirthDate" runat="server" ErrorMessage="Driver Birthdate is required" ControlToValidate="txtBirthdate" CssClass="validate" ValidationGroup="uploadDoc"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1 d-block">Driver Phone number</label>
                                <asp:TextBox ID="txtPhoneNum" runat="server" CssClass="form-control d-block" TextMode="Phone" ></asp:TextBox>
                        <asp:CustomValidator ID="validPhoneNum" runat="server" ErrorMessage="Invalid Phone Number" ClientValidationFunction="validatePhone" ControlToValidate="txtPhoneNum" ValidationGroup="uploadDoc" CssClass="validate" ValidateEmptyText="True"></asp:CustomValidator>
                            </div>
                        </div>
                        <h5>Driver Document</h5>
                        <hr class="mt-0 mb-4">
                     <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver ID/Passport Picture</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgID" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                   <asp:CustomValidator ID="validateIDpic" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuID" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <asp:Label ID="lblIdPic" runat="server" CssClass="validate mx-auto"></asp:Label>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuID" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewID(event)"/>
                                <asp:Button ID="btnIdPic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto"  OnClientClick="return fileUploadID()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Selfie</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgSelfie" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                   <asp:CustomValidator ID="validateSelfiePic" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateSelfieFile" ControlToValidate="fuSelfie" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuSelfie" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewSelfie(event)"/>
                                <div class="mx-auto">
                                <asp:Button ID="btnSelfiePic" runat="server" Text="Upload from PC" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadSelfie()" ValidationGroup="uploadPic"/>
                                <!-- wz start -->
                                <asp:Button ID="btnActivate" runat="server" Text="Selfie with Webcam" CssClass="btn btn-primary mx-auto" OnClientClick="showWebcamModal(); return false;"/>   
                                </div>
                                 <!-- wz end -->
                            </div>
                            </div>
                        </div>                     
                    <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License (Front)</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgLicenseF" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                                <asp:CustomValidator ID="validateLicenseF" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuLicenseF" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuLicenseF" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewLicenseF(event)"/>
                                <asp:Button ID="btnLicenseFpic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadLicenseF()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License (Back)</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:Image ID="imgLicenseB" runat="server" CssClass="mb-2 mx-auto" Width="150px" ImageUrl="~/Image/no-img.jpg" />
                             </div>
                    <asp:CustomValidator ID="validateLicenseB" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuLicenseB" ValidateEmptyText="True" ValidationGroup="uploadDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuLicenseB" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewLicenseB(event)"/>
                                <asp:Button ID="btnLicenseBpic" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadLicenseB()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                        </div>
                </div>
            </asp:Panel>
      </div>
      <div class="modal-footer">
                    <asp:Button ID="btnUploadDoc" runat="server" Text="Add Driver" CssClass='btn btn-primary' ValidationGroup="uploadDoc" OnClientClick="getCountryCode()" OnClick="btnUploadDoc_Click" />
                    <asp:Button ID="btnUpdateDoc" runat="server" Text="Update" CssClass='btn btn-primary' ValidationGroup="uploadDoc" OnClick="btnUpdateDoc_Click" OnClientClick="getCountryCode()" Visible="False"/>            
      </div>
    </div>
  </div>   
</div>


        <!-- Modal Structure -->
<div class="modal fade" id="webcamModal"  tabindex="-1" aria-labelledby="webcamModal" aria-hidden="true">
  <div class="modal-dialog modal-lg"> 
    <div class="modal-content">
      
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title" id="webcamModalLabel">Live Camera and Capture</h5>
        <button type="button" class="btn-close" data-bs-toggle="modal" data-bs-target="#addDriver" ></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        <div class="webcamSection">
          <div class="webcamContainer" id="webcamContainer">
            <table id="webcamTable" class="webcamTable table table-bordered" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <th style="text-align:center" class="webcamTitle">Live Camera</th>
                <th style="text-align:center" class="webcamTitle">Captured Picture</th>
              </tr>
              <tr>
                <td class="webcamOutput"><div id="webcam"></div></td>
                <td class="webcamOutput"><img id="imgCapture" /></td>
                <asp:HiddenField ID="hdnCapturedSelfie" runat="server" />
              </tr>
              <tr>
                <td align="center" class="webcamExecute">
                  <asp:Button ID="btnCapture" runat="server" Text="Capture" CssClass="btnCapture btn btn-primary"/>
                </td>
                <td align="center" class="webcamExecute">
                  <asp:Button ID="btnUpload" runat="server" Text="Upload" CssClass="btnUpload btn btn-success" data-bs-toggle="modal" data-bs-target="#addDriver"/>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
      
    </div>
  </div>
</div>
    
 <div class="modal fade" id="webcamModal2"  tabindex="-1" aria-labelledby="webcamModal" aria-hidden="true">
  <div class="modal-dialog modal-lg"> 
    <div class="modal-content">
      
      <!-- Modal Header -->
      <div class="modal-header">
        <h5 class="modal-title" id="webcamModalLabel2">Live Camera and Capture</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      
      <!-- Modal Body -->
      <div class="modal-body">
        <div class="webcamSection">
          <div class="webcamContainer" id="webcamContainer2">
            <table id="webcamTable2" class="webcamTable table table-bordered" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <th style="text-align:center" class="webcamTitle">Live Camera</th>
                <th style="text-align:center" class="webcamTitle">Captured Picture</th>
              </tr>
              <tr>
                <td class="webcamOutput"><div id="webcam2"></div></td>
                <td class="webcamOutput"><img id="imgCapture2" /></td>
                <asp:HiddenField ID="hdnCapturedSelfie2" runat="server" />
              </tr>
              <tr>
                <td align="center" class="webcamExecute">
                  <asp:Button ID="btnCapture2" runat="server" Text="Capture" CssClass="btnCapture btn btn-primary"/>
                </td>
                <td align="center" class="webcamExecute">
                  <asp:Button ID="btnUpload2" runat="server" Text="Upload" CssClass="btnUpload btn btn-success" data-bs-dismiss="modal"/>
                </td>
              </tr>
            </table>
          </div>
        </div>
      </div>
      
    </div>
  </div>
</div>

    <div class="container-fluid px-4 mt-4">
    <div class="mb-1">
    <h1 class="d-inline">Driver Info</h1>
    <div class="d-inline">
    <asp:Button ID="btnEditDriver" runat="server" Text="Edit" CssClass="btn btn-sm btn-primary mb-1" OnClick="btnEdit_Click" />
    <asp:Button ID="btnDeleteDriver" runat="server" Text="Delete" CssClass="btn btn-sm btn-danger mb-1" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="False" />
    </div>
    </div>
    <hr class="mt-0 mb-4">
    
    <div class="card-container mb-3">
        <asp:LinkButton ID="btnAddNew" runat="server" Visible="True"  data-bs-toggle="modal" data-bs-target="#addDriver">
               <div class="card-body rounded border border-dark px-0 py-2 mb-3" Style="background-color:#effaf6">
                   <div class="d-flex align-items-center px-4">
                   <h5 class="mx-auto my-auto text-muted">Add Driver</h5>
                   </div>
               </div>
        </asp:LinkButton>
        <div class="col-xl-8 mb-5 mx-auto">
            <asp:Panel ID="editPanel" runat="server">
            <div class="card mb-2 px-1 py-1">
                <div class="d-inline">
                <span class="d-inline">Approval Status: </span>
                <asp:Label ID="lblApproval" runat="server" Text="3dwqdq" CssClass="d-inline"></asp:Label>
                </div>
                <asp:Label ID="lblReject" runat="server" Text="" CssClass="validate mt-1"></asp:Label>
                
            </div>
            <div class="card mb-4">
                <div class="card-body">
                        <div class="mb-3">
                            <label class="small mb-1">Driver Name</label>
                            <asp:TextBox ID="txtName2" runat="server" CssClass="form-control" placeholder="Enter driver name" ValidationGroup="updateDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName2" CssClass="validate" ValidationGroup="updateDoc"></asp:RequiredFieldValidator>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver ID/Passport Number</label>
                                <asp:TextBox ID="txtDriverID2" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="updateDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Driver ID/Passport Number is required" ControlToValidate="txtDriverID2" CssClass="validate" ValidationGroup="updateDoc"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License Number</label>
                                <asp:TextBox ID="txtDriverLicense2" runat="server" CssClass="form-control" placeholder="e.g. 543210987654" ValidationGroup="updateDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Driver License Number is required" ControlToValidate="txtDriverLicense2" CssClass="validate" ValidationGroup="updateDoc"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Gender</label>
                                <asp:DropDownList ID="ddlGender2" runat="server" CssClass="form-select" ValidationGroup="updateDoc">
                                    <asp:ListItem Value="0">Select Gender</asp:ListItem>
                                    <asp:ListItem Value="M">Male</asp:ListItem>
                                    <asp:ListItem Value="F">Female</asp:ListItem>
                                </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Gender is required" ControlToValidate="ddlGender2" CssClass="validate" ValidationGroup="updateDoc" InitialValue="0"></asp:RequiredFieldValidator>
                             </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Birthdate</label>
                                <asp:TextBox ID="txtBirthdate2" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="updateDoc"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Driver Birthdate is required" ControlToValidate="txtBirthdate2" CssClass="validate" ValidationGroup="updateDoc"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1 d-block">Driver Phone number</label>
                                <asp:TextBox ID="txtPhoneNum2" runat="server" CssClass="form-control d-block" TextMode="Phone" ValidationGroup="updateDoc"></asp:TextBox>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Invalid Phone Number" ClientValidationFunction="validatePhone2" ControlToValidate="txtPhoneNum2" ValidationGroup="updateDoc" CssClass="validate" ValidateEmptyText="True"></asp:CustomValidator>
                            </div>
                        </div>
                        <h5>Driver Document</h5>
                        <hr class="mt-0 mb-4">
                     <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver ID/Passport Picture</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:ImageButton ID="imgID2" runat="server" CssClass="img mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                             </div>
                   <asp:CustomValidator ID="validateIDpic2" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuID2" ValidateEmptyText="True" ValidationGroup="updateDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <asp:Label ID="Label1" runat="server" CssClass="validate mx-auto"></asp:Label>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuID2" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewID2(event)"/>
                                <asp:Button ID="btnUploadID" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto"  OnClientClick="return fileUploadID2()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver Selfie</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:ImageButton ID="imgSelfie2" runat="server" CssClass="img mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                             </div>
                   <asp:CustomValidator ID="validateSelfiePic2" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateSelfieFile" ControlToValidate="fuSelfie2" ValidateEmptyText="True" ValidationGroup="updateDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuSelfie2" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewSelfie2(event)"/>
                                <div class="mx-auto">
                                <asp:Button ID="btnUploadSelfie" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadSelfie2()" ValidationGroup="uploadPic"/>
                                <!-- wz start -->
                                <asp:Button ID="btnUserSelfie2" runat="server" Text="Selfie with Webcam" CssClass="btn btn-primary mx-auto" OnClientClick="showWebcamModal2(); return false;"/>   
                                </div>
                                 <!-- wz end -->
                            </div>
                            </div>
                        </div>                     
                    <div class="row gx-3 mb-3">
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License (Front)</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:ImageButton ID="imgLicenseF2" runat="server" CssClass="img mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                             </div>
                                <asp:CustomValidator ID="validateLicenseF2" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuLicenseF2" ValidateEmptyText="True" ValidationGroup="updateDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuLicenseF2" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewLicenseF2(event)"/>
                                <asp:Button ID="btnUploadLicenseF" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadLicenseF2()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                            <div class="col-md-6">
                                <label class="small mb-1">Driver License (Back)</label>
                            <div class="d-flex flex-column align-items-centers">
                            <div class="image-frame mx-auto">
                                <asp:ImageButton ID="imgLicenseB2" runat="server" CssClass="img mb-2 mx-auto" Width="200px" ImageUrl="~/Image/no-img.jpg" OnClientClick="return ShowImageModal(this)"/>
                             </div>
                    <asp:CustomValidator ID="validateLicenseB2" runat="server" ErrorMessage="Picture is invalid type or size is too large" ClientValidationFunction="validateFile" ControlToValidate="fuLicenseB2" ValidateEmptyText="True" ValidationGroup="updateDoc" CssClass="validate mx-auto"></asp:CustomValidator>
                                <span class="small text-muted mb-2 mx-auto">JPG or PNG no larger than 2 MB</span>
                                <asp:FileUpload ID="fuLicenseB2" runat="server" CssClass="uploadPicture mx-auto" onchange="ShowPreviewLicenseB2(event)"/>
                                <asp:Button ID="btnUploadLicenseB" runat="server" Text="Upload new image" CssClass="btn btn-primary mx-auto" OnClientClick="return fileUploadLicenseB2()" ValidationGroup="uploadPic"/>
                            </div>
                            </div>
                        </div>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass='btn btn-primary' ValidationGroup="updateDoc" OnClick="btnUpdateDoc_Click" OnClientClick="getCountryCode()" Visible="False" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete " cssClass="btn btn-danger" data-bs-toggle="modal" data-bs-target="#ConfirmDelete" OnClientClick="return false" Visible="True"/>
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel " cssClass="btn btn-secondary float-end" OnClick="btnCancel_Click"/>
                </div>
            </div>
            </asp:Panel>
        </div>

    </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/intlTelInput.min.js"></script>
    <script>
        //wz start

        let webcamUsed = false; // Flag to track if the webcam was used
        let webcamStream = null;

        function showWebcamModal() {
            // Try to access the webcam only when the modal is shown
            navigator.mediaDevices.getUserMedia({ video: true })
                .then(function (stream) {
                    // Webcam is available, display the webcam
                    webcamStream = stream;
                    Webcam.set({
                        width: 300,
                        height: 240,
                        image_format: 'jpeg',
                        jpeg_quality: 90
                    });
                    Webcam.attach('#webcam');
                    $('#webcam').css('margin', 'auto'); // Adjust CSS styles
                    $('#addDriver').modal('hide')
                    $('#webcamModal').modal('show')
                })
                .catch(function (err) {
                    // No webcam available or permission denied, handle accordingly
                    alert("Webcam access denied or not available. Please use file upload instead.");
                });
        }

        $(function () {
            const btnUpload = document.getElementById('<%= btnUpload.ClientID %>');
            const imgSelfie = document.getElementById('<%= imgSelfie.ClientID %>');

            $("#main_btnCapture").click(function (event) {
                event.preventDefault(); // Prevent default behavior (postback)

                Webcam.snap(function (data_uri) {
                    console.log("Captured Image Data URI: ", data_uri); // Check the format
                    $("#imgCapture")[0].src = data_uri;
                    $("#main_btnUpload").prop("disabled", false);
                });
            });

            $("#main_btnUpload").click(function (event) {
                event.preventDefault(); // Prevent default behavior (postback)
                webcamUsed = true; // Mark that the webcam was used (for validation)
                var hdnCapturedSelfie = "<%= hdnCapturedSelfie.ClientID %>";

                // Get the captured image data URI from the modal
                var capturedImage = $("#imgCapture")[0].src;

                // Simulate the ShowPreviewSelfie behavior by updating the imgSelfie element
                imgSelfie.src = capturedImage;

                if (capturedImage) {
                    $("#" + hdnCapturedSelfie).val(capturedImage); // Populate hidden field
                } else {
                    alert("No image captured. Please capture a selfie first.");
                    webcamUsed = false;
                }

                // Notify the user
                alert("Image preview updated successfully!");
            });
        });

        //second modal

        function showWebcamModal2() {
            webcamUsed = false; // Reset the flag
            document.getElementById('<%= validateSelfiePic2.ClientID %>').enabled = true;
            // Try to access the webcam only when the modal is shown
            navigator.mediaDevices.getUserMedia({ video: true })
                .then(function (stream) {
                    // Webcam is available, display the webcam
                    webcamStream = stream;
                    Webcam.set({
                        width: 300,
                        height: 240,
                        image_format: 'jpeg',
                        jpeg_quality: 90
                    });
                    Webcam.attach('#webcam2');
                    $('#webcam2').css('margin', 'auto'); // Adjust CSS styles
                    $('#webcamModal2').modal('show')
                })
                .catch(function (err) {
                    // No webcam available or permission denied, handle accordingly
                    alert("Webcam access denied or not available. Please use file upload instead.");
                });
        }

        $(function () {
            const btnUpload = document.getElementById('<%= btnUpload2.ClientID %>');
            const imgSelfie = document.getElementById('<%= imgSelfie2.ClientID %>');

            $("#main_btnCapture2").click(function (event) {
                event.preventDefault(); // Prevent default behavior (postback)

                Webcam.snap(function (data_uri) {
                    console.log("Captured Image Data URI: ", data_uri); // Check the format
                    $("#imgCapture2")[0].src = data_uri;
                    $("#main_btnUpload2").prop("disabled", false);
                });
            });

            $("#main_btnUpload2").click(function (event) {
                event.preventDefault(); // Prevent default behavior (postback)
                webcamUsed = true; // Mark that the webcam was used (for validation)
                var hdnCapturedSelfie = "<%= hdnCapturedSelfie2.ClientID %>";

                // Get the captured image data URI from the modal
                var capturedImage = $("#imgCapture2")[0].src;

                // Simulate the ShowPreviewSelfie behavior by updating the imgSelfie element
                imgSelfie.src = capturedImage;

                if (capturedImage) {
                    $("#" + hdnCapturedSelfie).val(capturedImage); // Populate hidden field
                } else {
                    alert("No image captured. Please capture a selfie first.");
                    webcamUsed = false;
                }

                // Notify the user
                alert("Image preview updated successfully!");
            });
        });

        function closeWebcam() {
            if (webcamStream) {
                let tracks = webcamStream.getTracks(); // Get all the tracks (audio/video)
                tracks.forEach(track => track.stop());  // Stop each track
                Webcam.reset(); // Detach the webcam feed from the element
                webcamStream = null; // Clear the stream
            }
        }

        // When the modal is closed, stop the webcam
        $('#webcamModal').on('hidden.bs.modal', function () {
            closeWebcam();
        });

        // When the modal is closed, stop the webcam
        $('#webcamModal2').on('hidden.bs.modal', function () {
            closeWebcam();
        });

        //WZ End


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

        function getCountryCode() {
            document.getElementById('<%= hdnCountryCode.ClientID %>').value = iti.getSelectedCountryData().dialCode;
        }

        function validatePhone(sender, args) {
            args.IsValid = iti.isValidNumber();
        }

        const input2 = document.querySelector("#<%= txtPhoneNum2.ClientID %>");
        const iti2 = window.intlTelInput(input2, {
            initialCountry: "auto",
            geoIpLookup: callback => {
                fetch("https://ipapi.co/json")
                    .then(res => res.json())
                    .then(data => callback(data.country_code))
                    .catch(() => callback("us"));
            },
            utilsScript: "https://cdn.jsdelivr.net/npm/intl-tel-input@23.7.3/build/js/utils.js",
        });

        function getCountryCode2() {
            document.getElementById('<%= hdnCountryCode.ClientID %>').value = iti2.getSelectedCountryData().dialCode;
        }

        function validatePhone2(sender, args) {
            args.IsValid = iti2.isValidNumber();
        }

        function fileUploadID() {
        document.getElementById('<%= fuID.ClientID %>').click();

        return false;
        }

        function fileUploadSelfie() {
        document.getElementById('<%= fuSelfie.ClientID %>').click();

        return false;
        }

        function fileUploadLicenseF() {
        document.getElementById('<%= fuLicenseF.ClientID %>').click();

        return false;
        }

        function fileUploadLicenseB() {
        document.getElementById('<%= fuLicenseB.ClientID %>').click();

        return false;
        }

        function fileUploadID2() {
        document.getElementById('<%= validateIDpic2.ClientID %>').enabled = true;
        document.getElementById('<%= fuID2.ClientID %>').click();

        return false;
        }

        function fileUploadSelfie2() {
        document.getElementById('<%= validateSelfiePic2.ClientID %>').enabled = true;
        document.getElementById('<%= fuSelfie2.ClientID %>').click();

        return false;
        }

        function fileUploadLicenseF2() {
        document.getElementById('<%= validateLicenseF2.ClientID %>').enabled = true;
        document.getElementById('<%= fuLicenseF2.ClientID %>').click();

        return false;
        }

        function fileUploadLicenseB2() {
        document.getElementById('<%= validateLicenseB2.ClientID %>').enabled = true;
        document.getElementById('<%= fuLicenseB2.ClientID %>').click();

        return false;
        }

        function ShowPreviewID(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgID.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewSelfie(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgSelfie.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewLicenseF(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgLicenseF.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewLicenseB(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgLicenseB.ClientID %>');
            image.src = ImageDir.result;
        } 
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewID2(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgID2.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewSelfie2(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgSelfie2.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewLicenseF2(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgLicenseF2.ClientID %>');
            image.src = ImageDir.result;
        };
        //get file and convert to data url to use in img src = ""
        ImageDir.readAsDataURL(event.target.files[0]);
        }

        function ShowPreviewLicenseB2(event) {
            //read content of the file
        var ImageDir = new FileReader();
        //when file read update the image element
        ImageDir.onload = function () {
            var image = document.getElementById('<%= imgLicenseB2.ClientID %>');
            image.src = ImageDir.result;
        } 
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
                    fileUpload.value = "";
                    return;
                }

                if (fileUpload.files[0].size > maxSize) {
                    args.IsValid = false;
                    fileUpload.value = "";
                    return;
                }

                args.IsValid = true;
        }

        function validateSelfieFile(sender, args) {
            if (webcamUsed) {
                // Skip validation if the webcam was used
                args.IsValid = true;
                return;
            }

            var fileUpload = document.getElementById(sender.controltovalidate);
            var fileName = fileUpload.value;
            var allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;
            var maxSize = 2097152;

            if (!allowedExtensions.test(fileName)) {
                args.IsValid = false;
                fileUpload.value = "";
                return;
            }

            if (fileUpload.files[0].size > maxSize) {
                args.IsValid = false;
                fileUpload.value = "";
                return;
            }

            args.IsValid = true;
        }

        function ShowImageModal(image) {
            document.getElementById('<%= largeImage.ClientID %>').src = image.src;
            $('#imageModal').modal('show');
            console.log("Im in");
            return false;
        }

    </script>




</asp:Content>
