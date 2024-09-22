<%@ Page Title="" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="testDate.aspx.cs" Inherits="Assignment.testDate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="main" runat="server">
    <style>
        /*// This will hide the first 8 items so that 8 hours is the first option shown.*/
        .hourselect option:nth-child(-n+8), .hourselect option:nth-child(n+22) {
            display: none;
        }
    </style>
    <div class="d-flex">
        <div id="demo" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc;"class="d-flex rounded">
        <i class="fa fa-calendar"></i>&nbsp;
		<span></span><i class="fa fa-caret-down"></i>
    <asp:HiddenField ID="hdnStart" runat="server" />
    <asp:HiddenField ID="hdnEnd" runat="server" />
    </div>
    </div>

    <script>

        var hdnstart = document.getElementById('<%=hdnStart.ClientID %>').value;
        var hdnend = document.getElementById('<%=hdnEnd.ClientID %>').value;
        var startDate = moment(hdnstart, 'DD-MM-YYYY HH:mm');
        var endDate = moment(hdnend, 'DD-MM-YYYY HH:mm');

        function cb(start, end) {
            $('#demo span').html(start.format('DD-MM-YYYY HH:mm') + ' - ' + end.format('DD-MM-YYYY HH:mm') + '  ');
            hdnstart.text = start.format('DD-MM-YYYY HH:mm');
            hdnend.text = end.format('DD-MM-YYYY HH:mm');
        }


        $('#demo').daterangepicker({
            "timePicker": true,
            "timePicker24Hour": true,
            "timePickerIncrement": 15,
            "startDate": hdnstart,
            "endDate": hdnend,
            "autoApply": true,
            "minDate": moment().startOf('day').add(1, 'day'),
            "maxDate": moment().add(30, 'days'),
            "locale": {
                "format": "DD-MM-YYYY HH:mm",
            },

        }, function (start, end, label) {
            cb(start, end);
        });

        cb(startDate, endDate);
    </script>
</asp:Content>
