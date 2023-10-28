import asyncHandler from './utils/async_handler';

document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("export-data").addEventListener("click", function () {
        const promiseObject = asyncHandler('/events/export', 'POST', {});
        promiseObject.then(() => {
            window.alert("Data Exported");
        }, (error) => {
            window.alert("Failed to Export Data");
        });
    });

    document.getElementById("send-email").addEventListener("click", function () {
        const promiseObject = asyncHandler('/events/notify', 'POST', {});
        promiseObject.then(() => {
            window.alert("User Notified");
        }, (error) => {
            window.alert("Failed to Notify User! " + error.message);
        });
    });
});