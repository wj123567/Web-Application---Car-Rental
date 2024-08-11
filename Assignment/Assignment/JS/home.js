//for location
/*document.addEventListener("DOMContentLoaded", function () {

    // Get the modal
    var modal = document.getElementById("locationModal");

    // Get the button that opens the modal
    var departureInput = document.getElementById('main_txtDepartureLocation');
    var returnInput = document.getElementById('main_txtReturnLocation');

    // Get the <span> element that closes the modal
    var span = document.getElementById("modal_close");
    var okButton = document.getElementById("<%= modalOkBtn.ClientID %>");

    // Open the modal when input is clicked
    departureInput.onclick = function () {
        modal.style.display = "block";
    }

    returnInput.onclick = function () {
        modal.style.display = "block";
    }

    // Close the modal when the user clicks on <span> (x)
    span.onclick = function () {
        console.log("close btn clicked");
        modal.style.display = "none";
    }

    // Close the modal when the user clicks on the OK button
    if (okButton) {
        okButton.onclick = function () {
            modal.style.display = "none";
        }
    }

    // Close the modal when the user clicks anywhere outside of the modal
    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    }

});*/









//for linking departure and arrival time
/*function updateReturnDateTime() {
    var depDateInput = document.getElementById('main_txtDepartureDate');
    var depTimeDropDown = document.getElementById('main_ddlDepartureTime');
    var returnDateInput = document.getElementById('main_txtReturnDate');
    var returnTimeDropDown = document.getElementById('main_ddlReturnTime');

    if (depDateInput.value && depTimeDropDown.value) {
        var depDate = new Date(depDateInput.value + 'T' + depTimeDropDown.value);


        console.log('Departure Date Object:', depDate);

        // Add one day to the departure date
        var returnDate = new Date(depDate);
        returnDate.setDate(depDate.getDate() + 1);

        console.log('ReturnDate:', returnDate);

        // Format return date to YYYY-MM-DD manually (if use iso may have timezonediff, then when when add day will error)
        var returnDateString = returnDate.getFullYear() + '-' +
            ('0' + (returnDate.getMonth() + 1)).slice(-2) + '-' +
            ('0' + returnDate.getDate()).slice(-2);

        console.log('Return Date String:', returnDateString);

        returnDateInput.value = returnDateString;

        // Set return time to the same as departure time
        returnTimeDropDown.value = depTimeDropDown.value;

        // Set min attribute for return date and time
        returnDateInput.setAttribute('min', returnDateString);

       
    }
}


window.onload = function () {
    document.getElementById('main_txtDepartureDate').addEventListener('change', updateReturnDateTime);
    document.getElementById('main_ddlDepartureTime').addEventListener('change', updateReturnDateTime);
};*/



/*time restriction
document.addEventListener('DOMContentLoaded', function () {
    var timeInput = document.getElementById('main_txtDepartureTime');

    timeInput.addEventListener('change', function () {
        var minTime = "08:00";
        var maxTime = "23:00";
        var selectedTime = timeInput.value;

        if (selectedTime < minTime || selectedTime > maxTime) {
            alert("Please select a time between 08:00 AM and 11:00 PM.");
            timeInput.value = ""; // Clear the invalid time
        }
    });
    
});*/
