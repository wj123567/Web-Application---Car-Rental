
// Function to update the total
/*DOMContentLoaded - the script runs only after the DOM is fully loaded
(if not document.querySelector('.addon_total').textContent = total.toFixed(2); will shows error)
*/

document.addEventListener('DOMContentLoaded', function () {
    function updateTotal() {
        let total = 0.00;
        const quantities = document.querySelectorAll('.quantity_input');

        quantities.forEach(input => {   //when updateTotal is called, calculate again the total price in this code block
            const price = parseFloat(input.closest('tr').querySelector('.text_center[data-price]').dataset.price);
            const quantity = parseInt(input.value);
            total += price * quantity;      //add on continuously

        });

        document.querySelector('.addon_total').textContent = total.toFixed(2);  //decimal place
        // Update the total in the summary_add_on element
        document.querySelector('.summary_add_on').textContent = total.toFixed(2);

        // Static rental amount
        const rentalAmount = parseFloat(document.querySelector('.rental_amt').textContent);
        // Calculate the grand total
        const grandTotal = rentalAmount + total;
        const grandTotalToFixed = grandTotal.toFixed(2);

        // Update the grand total in the summary_total element

        document.querySelector('.grand_total').textContent = grandTotalToFixed;

        //save the grandTotal
        localStorage.setItem("grandTotal", grandTotalToFixed);

        var grandTotalSupplier = document.querySelector('.grand_total');
        if (grandTotalSupplier) {
            localStorage.setItem("grandTotal", grandTotalSupplier.textContent);
        }
        var stickyBarPrice = document.querySelector(".sticky_bar_price");
        if (stickyBarPrice) {
            var getGrandTotal = localStorage.getItem("grandTotal");
            console.log("123", getGrandTotal);
            stickyBarPrice.textContent = "RM" + getGrandTotal;

        }


    }


    // Add event listeners to quantity inputs
    document.querySelectorAll('.quantity_input').forEach(input => {
        input.addEventListener('input', updateTotal);       //call the updateTotal every time user change on the quantity(fires everytime input change)
    });

    // Initial calculation on page load to set initial total value
    updateTotal();

});


document.addEventListener('DOMContentLoaded', function () {

    // Retrieve current step from session storage
    let currentStep = parseInt(sessionStorage.getItem('currentStep')) || 1;

    // Update progress bar based on current step
    updateProgressBar(currentStep);

    // Handle next button clicks
    const nextButtons = document.getElementsByClassName('next_btn');
    Array.from(nextButtons).forEach(button => {
        button.addEventListener('click', function () {
            currentStep++;
            // Ensure currentStep stays within the valid range
            if (currentStep > 3) currentStep = 1;

            // Save the current step to session storage
            sessionStorage.setItem('currentStep', currentStep);
        });
    });

    // Handle previous button clicks
    const prevButtons = document.getElementsByClassName('prev_btn');
    Array.from(prevButtons).forEach(button => {
        button.addEventListener('click', function () {
            currentStep--;
            // Ensure currentStep stays within the valid range
            if (currentStep < 1) currentStep = 3;

            // Save the current step to session storage
            sessionStorage.setItem('currentStep', currentStep);


        });
    });
});
//step 是 1(infopg),2,3 index=0,1,2 so when step 1, index 0,1 on;step 2;
function updateProgressBar(step) {
    const steps = ['bar_addon', 'bar_driver_info', 'bar_payment'];
    steps.forEach((id, index) => {
        const element = document.getElementById(id);
        if (index + 1 === step || index + 2 === step || index + 3 === step) {
            element.classList.add('active');
        } else {
            element.classList.remove('active');
        }

    });
}

document.addEventListener('DOMContentLoaded', function () {
    // Select all quantity inputs
    var quantityInputs = document.querySelectorAll('.quantity_input');

    quantityInputs.forEach(function (input) {
        input.addEventListener('keypress', function (event) {
            event.preventDefault(); // Prevent typing in the input field
        });
    });
});

//link the car type,addonprice, grand total...

