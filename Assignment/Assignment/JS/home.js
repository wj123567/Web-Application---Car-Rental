//for location
document.addEventListener("DOMContentLoaded", function () {


    var ddl = document.getElementById('main_ddlLocation');

    var options = ddl.options;

    for (var i = 0; i < options.length; i++) {
        let value = options[i].value;

        if (value === "batu_feringghi" || value === "bukit_mertajam") {
            options[i].classList.add("selectable"); // Example styling
        }

        if (value === "penang_island" || value === "penang_mainland") {
            options[i].classList.add("non-selectable"); // Apply non-selectable styling

            options[i].disabled = true; // Make option disabled
        }
    }

   
});

//for linking departure and arrival time
function updateReturnDateTime() {
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
};



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
