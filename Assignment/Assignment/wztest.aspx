<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="wztest.aspx.cs" Inherits="Assignment.wztest" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <asp:TextBox ID="txtDpTime" runat="server" CssClass="control_style" ReadOnly="true"  ></asp:TextBox>

         <link rel="stylesheet" type="text/css" href="/jquery.datetimepicker.css"/ >
<script src="/jquery.js"></script>
<script src="/build/jquery.datetimepicker.full.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            // Get today's date
            var today = new Date();

            // Timezone offset in minutes
            var offset = new Date().getTimezoneOffset();

            // Adjusted today's date to avoid timezone issues
            var adjustedToday = new Date(today.getTime() - offset * 60000);


            // Define minimum and maximum dates for departure and return
            var minDateDpt = new Date();
            minDateDpt.setDate(today.getDate() + 1);
            var maxDateDpt = new Date();
            maxDateDpt.setMonth(today.getMonth() + 3);

            var minDateRtn = new Date();
            minDateRtn.setDate(today.getDate() + 2);
            var maxDateRtn = new Date();
            maxDateRtn.setMonth(today.getMonth() + 4);

            // Initialize datetimepicker with 12-hour format
            $('#<%= txtDpTime.ClientID %>').datetimepicker({
                format: 'd/m/Y h:i A',  // Display format
                minTime: '08:00',  // Earliest time allowed
                maxTime: '21:00',  // Latest time allowed
                
                minDate: minDateDpt,
                maxDate: maxDateDpt,
                startDate: minDateDpt,
                useStrict: true,
                onSelectTime: function (ct) {
                    // Adjust selected time based on the timezone offset
                    var adjustedTime = new Date(ct.getTime() - (offset * 60000));
                    this.setOptions({
                        value: adjustedTime
                    });
                }
            });
        });
    </script>
</asp:Content>
    