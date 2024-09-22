
<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminReview.aspx.cs" Inherits="Assignment.Management.AdminReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Review Edit</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>Booking ID: <asp:Label ID="lblBookingId" runat="server"></asp:Label></div>
                    <div>Review Text: <asp:Label ID="lblReviewText" runat="server"></asp:Label></div>
                    <div>Rating: <asp:Label ID="lblRating" runat="server"></asp:Label></div>
                    <div>Review Date: <asp:Label ID="lblReviewDate" runat="server"></asp:Label></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Update</button>
                </div>
            </div>
        </div>
    </div>

    <div class="Review container-xl px-4 mt-4 container-fluid">
        <div class="title">
            <h1>Review Management</h1>
        </div>

        
        <asp:ListView ID="lvReview" runat="server">
            <LayoutTemplate>
                <table class="table table-striped table-bordered table-responsive">
                    <thead>
                        <tr class="">
                            <th>Review ID</th>
                            <th>Booking ID</th>
                            <th>Review Text</th>
                            <th>Rating</th>
                            <th>Review Date</th>
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
                    <td><%# Eval("ReviewId") %></td>
                    <td><%# Eval("BookingId") %></td>
                    <td><%# Eval("ReviewText") %></td>
                    <td><%# Eval("Rating") %></td>
                    <td><%# Eval("ReviewDate") %></td>
                    <td>
                        <asp:LinkButton ID="btnEditReview" 
                                        runat="server" 
                                        CommandArgument='<%# Eval("ReviewId") %>' 
                                        OnClick="btnEditReview_Click">
                            <i class="fas fa-edit" style="color: #ffbb00;"></i>
                        </asp:LinkButton>

                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ReviewId") %>'>
                            <i class="fa-solid fa-trash-can" style="color: #ff0000;"></i>
                        </asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
