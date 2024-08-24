<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRedemption.aspx.cs" Inherits="Assignment.Management.AdminRedemption" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
    <div class="Redemption container-xl px-4 mt-4 container-fluid">
    <div class="title">
        <h1>Redemption Management</h1>
    </div>
    <div class="Add">
        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#staticBackdrop">
          Add New Redeem Item
        </button>
    </div>
    <%-- ListView --%>
        <%-- DataKeyNames - Specifies PK --%>
        <asp:ListView ID="lvRedeemItems" runat="server" DataKeyNames="RedeemItemId" OnItemEditing="lvRedeemItems_ItemEditing" OnItemUpdating="lvRedeemItems_ItemUpdating" OnItemCanceling="lvRedeemItems_ItemCanceling" >
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
                    <td><%# Eval("ItemImage") %></td>
                    <td>
                        <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit">
                            <i class="fas fa-edit" style="color: #ffbb00;"></i>
                        </asp:LinkButton>

                        </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><asp:TextBox ID="txtItemName" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtItemPoints" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtItemDescription" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtStatus" runat="server"></asp:TextBox></td>
                    <td><asp:TextBox ID="txtItemImage" runat="server"></asp:TextBox></td>
                    <td>
                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="Update" CssClass="btn btn-warning"></asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger"></asp:LinkButton>
                    </td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>
    </div>
</asp:Content>
