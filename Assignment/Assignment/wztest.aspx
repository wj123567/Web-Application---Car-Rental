<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="wztest.aspx.cs" Inherits="Assignment.wztest" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <asp:TextBox ID="txtDpTime" runat="server" CssClass="control_style"  ReadOnly="true"   ></asp:TextBox>
    <asp:TextBox ID="txtTest" runat="server"></asp:TextBox>
    <asp:Label ID="lblCheck" runat="server" Text="Label"></asp:Label>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.min.css">
     <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            var lastSelectedValue = "";  // To store the last selected datetime value

            // Initialize datetimepicker
            $('#<%= txtDpTime.ClientID %>').datetimepicker({
                format: 'd/m/Y h:i A',
                minTime: '08:00',
                maxTime: '21:00',
                onSelectDate: function (dp, $input) {  // Trigger only on manual selection
                    var currentValue = $input.val();

                    // Only proceed if the value actually changed
                    if (currentValue !== lastSelectedValue) {
                        lastSelectedValue = currentValue;  // Update the last selected value

                        console.log("Selected Time (Before Adjustment):", currentValue);

                        var parsedDate = dp instanceof Date ? dp : new Date(dp);


                        console.log("Time:", parsedDate.getHours() + ":" + parsedDate.getMinutes());
                    }
                },
                onClose: function (current_time, $input) {  // Trigger only when the picker closes
                    console.log("Picker Closed. Current Time:", $input.val());
                    if ($input.val() != "") {
                        $('#<%= lblCheck.ClientID %>').text($input.val());
                        $('#<%= txtTest.ClientID %>').val($input.val());
                        
                        console.log("Textbox Value After Setting:", $('#<%= txtDpTime.ClientID %>').val());
                    } else {
                        $input.val($('#<%= lblCheck.ClientID %>').text());
                    }

                    // Ensure the displayed value remains consistent and is not altered
                    $input.val(lastSelectedValue);  // Reset the value if changed unexpectedly
                }
            });
        });
</script>


</asp:Content>
    