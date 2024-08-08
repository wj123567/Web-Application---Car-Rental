document.addEventListener('DOMContentLoaded', function () {
    const chkDriver = document.getElementById('main_chkDriver');
    const driverFieldsLeft = document.getElementById('driverFieldsLeft');
    const driverFieldsRight = document.getElementById('driverFieldsRight');

    function toggleDriverFields() {
        if (chkDriver.checked) {
            driverFieldsLeft.style.display = 'block';
            driverFieldsRight.style.display = 'block';
            enableDriverValidation(true);
        } else {
            driverFieldsLeft.style.display = 'none';
            driverFieldsRight.style.display = 'none';
            enableDriverValidation(false);
        }
    }

    function enableDriverValidation(enable) {
        const validators = document.querySelectorAll('.driver_validate');
        validators.forEach(function (validator) {
            ValidatorEnable(validator, enable);
        });

    }

    // Attach the event listener to the checkbox
    chkDriver.addEventListener('change', toggleDriverFields);
    

    // Initial check on page load
    toggleDriverFields();
});