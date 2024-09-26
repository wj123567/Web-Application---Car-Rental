<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRewardPoint.aspx.cs" Inherits="Assignment.AdminRewardPoint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <!-- Points Management Modal -->
    <div class="modal fade" id="pointsManagementModal" tabindex="-1" aria-labelledby="pointsManagementModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="pointsManagementModalLabel">Manage Reward Points</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" id="add-tab" data-bs-toggle="tab" href="#addPoints" role="tab" aria-controls="addPoints" aria-selected="true">Add Points</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" id="deduct-tab" data-bs-toggle="tab" href="#deductPoints" role="tab" aria-controls="deductPoints" aria-selected="false">Deduct Points</a>
                        </li>
                    </ul>
                    <!-- Tab content -->
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="addPoints" role="tabpanel" aria-labelledby="add-tab">
                            <div class="mb-3">
                                <label for="txtPointsToAdd" class="form-label mt-2 ms-1">Points to Add</label>
                                <asp:TextBox ID="txtPointsToAdd" runat="server" CssClass="form-control" placeholder="Enter points to add"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvPointsToAdd" runat="server" ControlToValidate="txtPointsToAdd"
                                    ErrorMessage="Points are required." CssClass="text-danger" Display="Dynamic" ValidationGroup="addPoints" />
        
                                <asp:RegularExpressionValidator ID="revPointsToAdd" runat="server" ControlToValidate="txtPointsToAdd"
                                    ErrorMessage="Please enter a valid number." CssClass="text-danger" Display="Dynamic"
                                    ValidationExpression="^\d+$" ValidationGroup="addPoints"/>

                            </div>
                        </div>
                        <div class="tab-pane fade" id="deductPoints" role="tabpanel" aria-labelledby="deduct-tab">
                            <div class="mb-3">
                                <label for="txtPointsToDeduct" class="form-label mt-2 ms-1">Points to Deduct</label>
                                <asp:TextBox ID="txtPointsToDeduct" runat="server" CssClass="form-control" placeholder="Enter points to deduct"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="rfvPointsToDeduct" runat="server" ControlToValidate="txtPointsToDeduct"
                                    ErrorMessage="Points are required." CssClass="text-danger" Display="Dynamic" ValidationGroup="deductPoints" />
        
                                <asp:RegularExpressionValidator ID="revPointsToDeduct" runat="server" ControlToValidate="txtPointsToDeduct"
                                    ErrorMessage="Please enter a valid number." CssClass="text-danger" Display="Dynamic"
                                    ValidationExpression="^\d+$" ValidationGroup="deductPoints" />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <asp:Button ID="btnConfirmAddPoints" runat="server" Text="Add Points" CssClass="btn btn-primary" OnClick="btnConfirmAddPoints_Click" ValidationGroup="addPoints" />
                    <asp:Button ID="btnConfirmDeductPoints" runat="server" Text="Deduct Points" CssClass="btn btn-danger" OnClick="btnConfirmDeductPoints_Click" ValidationGroup="deductPoints" />
                </div>
            </div>
        </div>
    </div>


    <div class="RewardPointContainer container-xl px-4 mt-4">
        <div class="title">
                <h1>Reward Points Management</h1>
            </div>
        <div class="Add">

        </div>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:ListView ID="RewardPointsListView" runat="server" OnSorting="RewardPointsListView_Sorting" OnPagePropertiesChanging="RewardPointsListView_PagePropertiesChanging">
                    <LayoutTemplate>
                    <table class="table table-bordered tableReward table-striped">
                        <thead>
                            <tr class="header-section">
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="Username" CssClass="link-button">Username
                                        <asp:Literal ID="litUsernameIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="Email" CssClass="link-button">Email
                                        <asp:Literal ID="litEmailIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="Reward Points" CssClass="link-button">Reward Points
                                        <asp:Literal ID="litRewardPointsIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>
                                <th>Actions</th>
                            </tr>
                        </thead>
        
                        <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />

                            <tr>
                                <td colspan="4" class="asd">
                                    <asp:DataPager ID="RewardPointsPager" runat="server" PageSize="6">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Link" ShowPreviousPageButton="true" ShowNextPageButton="false"/>
                                            <asp:NumericPagerField ButtonType="Link" />
                                            <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowPreviousPageButton="false"/>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>

                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("Username") %></td>
                            <td><%# Eval("Email") %></td>
                            <td><%# Eval("RewardPoints") %></td>
                       
                            <td>
                                <asp:LinkButton ID="btnAddRewardPoints" 
                                                runat="server" 
                                                CommandArgument='<%# Eval("Id") %>' 
                                                OnClick="btnAddRewardPoints_Click"
                                                CssClass="text-warning pe-1">
                                    <i class="fa-regular fa-square-plus"></i>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDeductRewardPoints" 
                                                runat="server" 
                                                CommandArgument='<%# Eval("Id") %>' 
                                                OnClick="btnDeductRewardPoints_Click"
                                                CssClass="text-danger">
                                    <i class="fa-solid fa-trash-can"></i>
                                </asp:LinkButton>

                            </td>
                        </tr>
                    </ItemTemplate>

                </asp:ListView>
            </ContentTemplate>
        </asp:UpdatePanel>

    </div>


    <script>
        $(document).ready(function () {
            // When the modal is shown, check which tab is active and disable the buttons
            $('#pointsManagementModal').on('shown.bs.modal', function (e) {
                // Check if Add Points tab is active by default
                if ($('#add-tab').hasClass('active')) {
                    $('#<%= btnConfirmDeductPoints.ClientID %>').attr('disabled', true);  
                    $('#<%= btnConfirmAddPoints.ClientID %>').attr('disabled', false);    
                } else if ($('#deduct-tab').hasClass('active')) {
                    $('#<%= btnConfirmAddPoints.ClientID %>').attr('disabled', true);    
                    $('#<%= btnConfirmDeductPoints.ClientID %>').attr('disabled', false);
                }
            });

            $('#add-tab').on('shown.bs.tab', function (e) {
                $('#<%= btnConfirmDeductPoints.ClientID %>').attr('disabled', true).addClass('disabled'); 
                $('#<%= btnConfirmAddPoints.ClientID %>').attr('disabled', false).removeClass('disabled');
            });

            $('#deduct-tab').on('shown.bs.tab', function (e) {
                $('#<%= btnConfirmAddPoints.ClientID %>').attr('disabled', true).addClass('disabled');  
                $('#<%= btnConfirmDeductPoints.ClientID %>').attr('disabled', false).removeClass('disabled'); 
            });
        });


    </script>
    
</asp:Content>
