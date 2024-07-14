<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="Assignment.UserManagement" %>
<asp:Content ID="adminUser" ContentPlaceHolderID="main" runat="server">
    <div>
        <table>
            <tr style="margin-left: 80px">
                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="Id" DataSourceID="UserRegistrationData" ForeColor="#333333" GridLines="None">
                     <AlternatingRowStyle BackColor="White" />
                     <Columns>
                         <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
                         <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                         <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
                         <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
                         <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" />
                         <asp:BoundField DataField="Roles" HeaderText="Roles" SortExpression="Roles" />
                     </Columns>
                     <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                     <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                     <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                     <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                     <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                     <SortedAscendingCellStyle BackColor="#FDF5AC" />
                     <SortedAscendingHeaderStyle BackColor="#4D0000" />
                     <SortedDescendingCellStyle BackColor="#FCF6C0" />
                     <SortedDescendingHeaderStyle BackColor="#820000" />
                 </asp:GridView>
                 <asp:SqlDataSource ID="UserRegistrationData" runat="server" ConnectionString="<%$ ConnectionStrings:UserRegistrationConnectionString %>" ProviderName="<%$ ConnectionStrings:UserRegistrationConnectionString.ProviderName %>" SelectCommand="SELECT * FROM [UserRegistration]"></asp:SqlDataSource>
            </tr>
        </table>


    </div>
</asp:Content>
