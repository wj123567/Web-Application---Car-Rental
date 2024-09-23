
<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminReview.aspx.cs" Inherits="Assignment.Management.AdminReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">Review</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div>Booking ID: <asp:Label ID="lblBookingId" runat="server"></asp:Label></div>
                    <div></div>
                    <hr />
                    
                    <div>Review Text: <asp:Label ID="lblReviewText" runat="server"></asp:Label></div>
                    <div>Rating: <asp:Label ID="lblRating" runat="server"></asp:Label></div>
                    <div>Review Date: <asp:Label ID="lblReviewDate" runat="server"></asp:Label></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <div class="Review container-xl px-4 mt-4 container-fluid">
        <div class="title">
            <h1>Review Management</h1>
        </div>

        <div class="d-flex justify-content-start mb-3">
            <asp:DropDownList ID="ddlStarRating" runat="server" CssClass="filterStar" AutoPostBack="true" OnSelectedIndexChanged="ddlStarRating_SelectedIndexChanged">
                <asp:ListItem Text="All Ratings" Value="0"></asp:ListItem>
                <asp:ListItem Text="5 Stars" Value="5"></asp:ListItem>
                <asp:ListItem Text="4 Stars" Value="4"></asp:ListItem>
                <asp:ListItem Text="3 Stars" Value="3"></asp:ListItem>
                <asp:ListItem Text="2 Stars" Value="2"></asp:ListItem>
                <asp:ListItem Text="1 Star" Value="1"></asp:ListItem>
            </asp:DropDownList>
        </div>
        
        <asp:ListView ID="lvReview" runat="server" OnSorting="lvReview_Sorting">
            <LayoutTemplate>
                <table class="table table-striped table-bordered table-responsive">
                    <thead>
                        <tr class="lvReview-header">
                            <th>
                                <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="ReviewId" CssClass="link-button">Review ID
                                    <asp:Literal ID="litReviewIdIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="BookingId" CssClass="link-button">Booking ID
                                    <asp:Literal ID="litBookingIdIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="ReviewText" CssClass="link-button">Review Text
                                    <asp:Literal ID="litReviewTextIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="Rating" CssClass="link-button">Rating
                                    <asp:Literal ID="litRatingIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
                            <th>
                                <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="ReviewDate" CssClass="link-button">Review Date
                                    <asp:Literal ID="litReviewDateIcon" runat="server"></asp:Literal>
                                </asp:LinkButton>
                            </th>
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
                        <asp:LinkButton ID="btnViewReview" 
                                        runat="server" 
                                        CommandArgument='<%# Eval("ReviewId") %>' 
                                        OnClick="btnViewReview_Click">
                            <i class="fa-solid fa-eye" style="color: #003899;"></i>
                        </asp:LinkButton>

                        <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" CommandArgument='<%# Eval("ReviewId") %>' OnClick="DeleteButton_Click" OnClientClick="return confirm('Are you sure you want to delete this review?');">
                            <i class="fa-solid fa-trash-can" style="color: #ff0000;"></i>
                        </asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
