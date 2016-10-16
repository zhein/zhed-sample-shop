require(['zhedHelper'], function (helperApp) {
    loadItems();

    checkActiveUser(function (response) {
        $('#active_user').html(response.data.guestName);
    });

    function loadItems() {
        helperApp.helper.post(
            'Cart/Details',
            [],
            function (response) {
                renderItemsIntoScreen(response);
                initializeEventForItemButton();
            }
        );
    }

    function renderItemsIntoScreen(cartData) {
        var isCartDataNull = helperApp.helper.isNullOrEmpty(cartData);

        if (!isCartDataNull) {
            var isCartItemsNull = helperApp.helper.isNullOrEmpty(cartData.items);

            if (!isCartDataNull) {
                cartData.items.forEach(function (item) {
                    var itemName = item.itemName;
                    var itemID = item.itemID;
                    var itemPrice = helperApp.helper.formatNumber(item.price);
                    var itemPictureUrl = helperApp.config.baseUrl() + item.picture;
                    var itemQty = item.qty;
                    var subTotal = helperApp.helper.formatNumber(item.subTotal);

                    var htmlData = '';
                    htmlData += '<tr>';
                    htmlData += '    <td class="col-1" style="padding-left: 20px; width: 200px;">';
                    htmlData += '        <div class="item-wrapper">';
                    htmlData += '            <div class="item-image">';
                    htmlData += '                <img src="' + itemPictureUrl + '" style="width: 100px; height: 100px; left: 0px;" />';
                    htmlData += '            </div>';
                    htmlData += '            <div class="item-name">';
                    htmlData += '                <span>' + itemName + '</span>';
                    htmlData += '            </div>';
                    htmlData += '            <div class="item-price">';
                    htmlData += '                <span>Rp. ' + itemPrice + '</span>';
                    htmlData += '            </div>';
                    htmlData += '        </div>';
                    htmlData += '    </td>';
                    htmlData += '    <td class="col-2" style="padding-left: 20px; width: 200px;">Qty = ' + itemQty + '</td>';
                    htmlData += '    <td class="col-3" style="padding-left: 20px; width: 200px;">Rp. ' + subTotal  + '</td>';
                    htmlData += '    <td class="col-4" style="padding-left: 20px; width: 200px;"><button data-id="' + itemID + '" data-class="cart-item-button" class="button small"><i class="fa fa-remove"></i> Remove</button></td>';
                    htmlData += '</tr>';

                    $('#cart-container.content > table > tbody').append(htmlData);
                });
            }
        }
    }

    function initializeEventForItemButton() {
        $('[data-class="cart-item-button"]').each(function (index, element) {
            var currentButton = $(element);
            var itemID = currentButton.attr('data-id');
            var url = helperApp.config.baseUrl() + 'Cart/Remove/Item/' + itemID;
            
            currentButton.on('click', function (evt) {
                window.location = url;
            });
        });

        $('#buttonContinueShopping').on('click', function (evt) {
            var url = helperApp.config.baseUrl() + 'Store';
            window.location = url;
        });

        $('#buttonCheckout').on('click', function (evt) {
            var url = helperApp.config.baseUrl() + 'Checkout';
            window.location = url;
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