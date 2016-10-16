require(['zhedHelper'], function (helperApp) {
    var userData = {
        CustomerName: '',
        Total: 0,
        ShippingFee: 50000,
        ShippingCourier: '',
        Address: '',
        Items: null
    };

    loadItems();

    checkActiveUser(function (response) {
        $('#active_user').html(response.data.guestName);
        $('#customerName').html(response.data.guestName);
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
                userData.Items = cartData.items;
                var totalPrice = 0;

                cartData.items.forEach(function (item) {
                    var itemName = item.itemName;
                    var itemID = item.itemID;
                    var itemPrice = helperApp.helper.formatNumber(item.price);
                    var itemPictureUrl = helperApp.config.baseUrl() + item.picture;
                    var itemQty = item.qty;
                    var subTotal = helperApp.helper.formatNumber(item.subTotal);
                    userData.Total += item.subTotal;

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
                    htmlData += '    <td class="col-3" style="padding-left: 20px; width: 200px;">Rp. ' + subTotal + '</td>';
                    htmlData += '</tr>';

                    $('#cart-container.content > table#CartItems > tbody').append(htmlData);

                });

                renderCartSummary();
            }
        }
    }

    function renderCartSummary() {
        var totalPriceBeforeShipping = helperApp.helper.formatNumber(userData.Total);
        var totalPriceAfterShipping = helperApp.helper.formatNumber(userData.ShippingFee);
        var shippingCost = helperApp.helper.formatNumber(userData.Total + userData.ShippingFee);

        $('#totalPriceBeforeShipping').html(totalPriceBeforeShipping);
        $('#shippingCost').html(totalPriceAfterShipping);
        $('#totalPriceAfterShipping').html(shippingCost);

        if (helperApp.helper.isNullOrEmpty(userData.Items)) {
            $('#CartSummary').hide();
            $('#buttonConfirmSales').hide();
        }
        else {
            $('#CartSummary').show();
            $('#buttonConfirmSales').show();
        }
    }

    function initializeEventForItemButton() {
        $('#buttonBackToCart').on('click', function (evt) {
            var url = helperApp.config.baseUrl() + 'Cart';
            window.location = url;
        });

        $('#buttonConfirmSales').on('click', function (evt) {
            userData.Address = $('#address').val();
            userData.ShippingCourier = $('#shippingCourier').val();


            if (helperApp.helper.isNullOrEmpty(userData.Address)) {
                alert('Address cannot be empty!');
                return;
            }
            else {
                var url = 'Checkout/Confirm';
                helperApp.helper.post(
                    url,
                    userData,
                    function (response) {
                        console.log(response);
                    }
                );
            }
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