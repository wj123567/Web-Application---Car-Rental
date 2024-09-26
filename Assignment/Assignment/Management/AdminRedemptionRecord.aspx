<%@ Page Title="" Language="C#" MasterPageFile="~/Management/Admin.Master" AutoEventWireup="true" CodeBehind="AdminRedemptionRecord.aspx.cs" Inherits="Assignment.Management.AdminRedemptionRecord" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">


<div class="Redemption container-xl px-4 mt-4 container-fluid">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>

    <div class="title">
        <h1>Redemption Management</h1>
    </div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:ListView ID="lvRedemption" runat="server"
                        OnSorting="lvRedemption_Sorting" 
                        OnPagePropertiesChanging="lvRedemption_PagePropertiesChanging"
                        OnItemDataBound="lvRedemption_ItemDataBound" >
                <LayoutTemplate>
                    <table class="table table-striped table-bordered table-responsive redeemTable">
                        <thead>
                            <tr class="">
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="UserName" CssClass="link-button">
                                        UserName
                                        <asp:Literal ID="litUserNameIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="ItemName" CssClass="link-button">
                                        ItemName
                                        <asp:Literal ID="litItemNameIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="ItemPoints" CssClass="link-button">
                                        ItemPoints
                                        <asp:Literal ID="litItemPointsIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="RedeemDate" CssClass="link-button">
                                        RedeemDate
                                        <asp:Literal ID="litRedeemDateIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton runat="server" CommandName="Sort" CommandArgument="Status" CssClass="link-button">
                                        Status
                                        <asp:Literal ID="litStatusIcon" runat="server"></asp:Literal>
                                    </asp:LinkButton>
                                </th>

                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr id="itemPlaceHolder" runat="server"></tr>
                        </tbody>

                        <tr>
                            <td colspan="6" class="asd">
                                <div class="d-flex justify-content-center">
                                    <asp:DataPager ID="ReviewsPager" runat="server" PageSize="6">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Link" ShowPreviousPageButton="true" ShowNextPageButton="false"/>
                                            <asp:NumericPagerField ButtonType="Link" />
                                            <asp:NextPreviousPagerField ButtonType="Link" ShowNextPageButton="true" ShowPreviousPageButton="false"/>
                                        </Fields>
                                    </asp:DataPager>
                                </div>
                            </td>
                        </tr>
                
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("UserName") %></td>
                        <td><%# Eval("ItemName") %></td>
                        <td><%# Eval("ItemPoints") %></td>
                        <td><%# Eval("RedeemDate") %></td>
                        <td>
                            <asp:HiddenField ID="hfRedeemItemId" runat="server" Value='<%# Eval("RedeemItemId") %>' />
                            <asp:HiddenField ID="hfUserId" runat="server" Value='<%# Eval("UserId") %>' />
                            <asp:HiddenField ID="hfRedeemDate" runat="server" Value='<%# Eval("RedeemDate", "{0:yyyy-MM-dd}") %>' />

                            <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true" 
                                OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                <asp:ListItem Text="Active" Value="True"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="False"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        
                        <td >
                            <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" CommandArgument='<%# Eval("RedeemItemId") + "|" + Eval("UserId") + "|" + Eval("RedeemDate", "{0:yyyy-MM-dd}") %>'  >
                                <i class="fa-solid fa-trash-can" style="color: #ff0000;"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </ContentTemplate>
    </asp:UpdatePanel>
    
</div>


</asp:Content>
