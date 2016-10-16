require(['zhedHelper'], function (helperApp) {
    initializeElementEvent();
    renderGuestForm();

    function initializeElementEvent() {
        helperApp.helper.element.click('buttonProceedGuest', function (evt) {
            var guestName = $('#GuestName').val();
            helperApp.helper.post(
                'User/SaveUser',
                { GuestName: guestName },
                function (response) {
                    if (response.status) {
                        helperApp.helper.redirect('Store/Index');
                    }
                }
            );
        });
    }

    function renderGuestForm() {
        helperApp.helper.element.showAjaxLoading(false);

        var renderPanel = function (response) {
            var userData = response.data;
            if (!helperApp.helper.isNullOrEmpty(userData.guestName)) {
                helperApp.helper.panel.show('panel_current_user_information');
            }
            else {
                helperApp.helper.panel.hide('panel_current_user_information');
            }

            $('#CurrentUser').html(userData.guestName);
        }
        var isAnyActiveUser = checkActiveUser(renderPanel);
    }

    function checkActiveUser(callbackCheckingActiveUser) {
        helperApp.helper.post(
            'User/ActiveUser',
            {},
            function (response) {
                callbackCheckingActiveUser(response);
            }
        );
    }
});