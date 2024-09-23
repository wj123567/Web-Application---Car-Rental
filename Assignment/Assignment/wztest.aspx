<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="wztest.aspx.cs" Inherits="Assignment.wztest" %>

<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">

    <asp:TextBox ID="txtDpTime" runat="server" CssClass="control_style"  ReadOnly="true"   ></asp:TextBox>
    <asp:TextBox ID="txtTest" runat="server"></asp:TextBox>
    <asp:Label ID="lblCheck" runat="server" Text="Label"></asp:Label>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script type="text/javascript">
        var today = new Date();

        // Define minimum and maximum dates for departure
        var minDateDpt = new Date();
        minDateDpt.setDate(today.getDate() + 1);
        var maxDateDpt = new Date();
        maxDateDpt.setMonth(today.getMonth() + 3);

        // Flatpickr configuration with default time set to 08:00 AM, but not pre-filled in the textbox
        var config1 = {
            
            altInput: true,
            altFormat: "d/m/Y ",
            allowInput: false,
            minuteIncrement: 15,
            minDate: minDateDpt,
            maxDate: maxDateDpt,        
        };

        var config2 = {
            enableTime: true,
            noCalendar: true,
            altInput: true,
            altFormat: "h:i K",
            allowInput: false,
            minuteIncrement: 15,
            minDate: minDateDpt,
            maxDate: maxDateDpt,
            minTime: "08:00",
            maxTime: "22:00",
            defaultHour: 8,     // Set default hour to 08:00 AM
            defaultMinute: 0,   // Set default minute to 00
            defaultDate: minDateDpt.setHours(8, 0, 0)
        };

        // Initialize flatpickr on the input field
        flatpickr("#<%= txtDpTime.ClientID %>", config1);
        flatpickr("#<%= txtTest.ClientID %>", config2);
        
</script>

    
</asp:Content>
    