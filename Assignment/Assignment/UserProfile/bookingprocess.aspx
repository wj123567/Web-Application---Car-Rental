<%@ Page Title="" Language="C#" MasterPageFile="~/UserProfile/profile.Master" AutoEventWireup="true" CodeBehind="bookingprocess.aspx.cs" Inherits="Assignment.bookingprocess" %>
<asp:Content ID="Content1" ContentPlaceHolderID="main" runat="server">
      <main id="main" class="main">

   

    <section class="section">
      <div class="row">
        <div class="col-lg-12">

          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Datatables</h5>
              <p>Add lightweight datatables to your project with using the <a href="https://github.com/fiduswriter/Simple-DataTables" target="_blank">Simple DataTables</a> library. Just add <code>.datatable</code> class name to any table you wish to conver to a datatable. Check for <a href="https://fiduswriter.github.io/simple-datatables/demos/" target="_blank">more examples</a>.</p>

              <!-- Table with stripped rows -->
              <table class="table datatable" id="example">
                <thead>
                  <tr>
                    <th class="cust_name">
                      <b>C</b>ust. Name
                    </th>
                    
                    <th class="custAddress">Cust. Address</th>
                    <th class="driver_name">Driver name</th>
                    <th data-type="date" data-format="YYYY/MM/DD" class="admin_pickup_date">Pick Up Date</th>
                    <th  class="admin_pickup_loc">Pick Up Location</th>
                    <th class="admin_drop_date">Drop Off Location</th>
                    <th  class="admin_drop_time">Drop Off Time</th>
                    <th class="admin_price">Price</th>
                    <th class="admin_book_status">Book Status</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server">
                              <asp:ListItem Value="Approved">Approved</asp:ListItem>
                              <asp:ListItem Value="Pending">Pending</asp:ListItem>
                              <asp:ListItem Value="Unpaid">Unpaid</asp:ListItem>
                        </asp:DropDownList></td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Bnity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button2" runat="server" Text="View More" /></td>                 
                  </tr>
                  <tr>
                    <td >Cnity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button3" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button4" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button5" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button6" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button7" runat="server" Text="View More" /></td>
                  </tr>
                  <tr >
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button8" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button9" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button10" runat="server" Text="View More" /></td>
                  </tr>
                  <tr>
                    <td >Anity Pugh</td>
                    <td>abcdefg</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td >1234abcd</td>
                    <td>1234abcd</td>
                    <td>123</td>
                    <td>1234abcd</td>
                    <td>
                        <asp:Button ID="Button11" runat="server" Text="View More" /></td>
                  </tr>
                 
                   
                </tbody>
              </table>
              <!-- End Table with stripped rows -->

            </div>
          </div>

        </div>
      </div>
    </section>

  </main><!-- End #main -->


 <script>
    $(document).ready(function() {
        $('#example').DataTable({
            "pageLength": 10,        // Show 10 entries per page
            "order": [],             // Disable initial sorting
            "columnDefs": [
                {
                    "targets": 3,     // Index of Start Date column
                    "type": "date"    // Data type of Start Date column
                }
            ]
        });
    });
</script>
</asp:Content>
