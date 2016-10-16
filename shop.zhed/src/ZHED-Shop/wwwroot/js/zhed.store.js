require(['zhedHelper'], function (helperApp) {
    loadItems();

    checkActiveUser(function (response) {
        $('#active_user').html(response.data.guestName);
    });

    function loadItems() {
        helperApp.helper.post(
            'Item/GetItems',
            [],
            function (response) {
                renderItemsIntoScreen(response);
                initializeEventForItemButton();
            }
        );
    }

    function renderItemsIntoScreen(items) {
        helperApp.helper.element.showAjaxLoading(false);

        var isItemsNull = helperApp.helper.isNullOrEmpty(items);
        if (!isItemsNull) {
            items.forEach(function (item) {
                var itemImageUrl = helperApp.config.baseUrl() + item.picture;
                var itemName = item.itemName;
                var itemPrice = helperApp.helper.formatNumber(item.price);
                var itemID = item.itemID;

                var htmlData = '';
                htmlData += '<div class="item-wrapper">';
                htmlData += '<div class="item-image">';
                htmlData += '   <img src="' + itemImageUrl + '" style="height: 100%; width: 100%; left: 0px;" />';
                htmlData += '</div>';
                htmlData += '<div class="item-name">';
                htmlData += '    <span>' + item.itemName + '</span>';
                htmlData += '</div>';
                htmlData += '<div class="item-price">';
                htmlData += '    <span>Rp. ' + itemPrice + '</span>';
                htmlData += '</div>';
                htmlData += '<div class="item-button">';
                htmlData += '    <button data-class="item-button" data-id="' + itemID + '" class="button small"><i class="fa fa-shopping-cart"></i> Buy</button>';
                htmlData += '</div>';
                htmlData += '</div>';

                $('#item-container').append(htmlData);
            });
        }
    }

    function initializeEventForItemButton() {
        $('[data-class="item-button"]').each(function (index, element) {
            var currentButton = $(element);
            var itemID = currentButton.attr('data-id');
            var url = helperApp.config.baseUrl() + 'Cart/Buy/Item/' + itemID;

            currentButton.on('click', function (evt) {
                window.location = url;
            });
        });
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