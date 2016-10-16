define([
    'jQuery',
    'numeralJs'
], function (jQuery) {
    var zhed = {};

    zhed.config = {};
    zhed.helper = {};
    zhed.helper.panel = {};
    zhed.helper.element = {};
    zhed.helper.element.event = {};

    zhed.config.baseUrl = function () {
        var baseUrl = $('#BaseUrl').val();
        return baseUrl;
    };

    zhed.helper.serialize = function (panelId) {
        var serializedData = jQuery('#' + panelId).serialize();
        return serializedData;
    };

    zhed.helper.element.show = function (elementId) {
        $('#' + elementId).show();
    };

    zhed.helper.element.hide = function (elementId) {
        $('#' + elementId).hide();
    };

    zhed.helper.panel.show = function (panelId) {
        $('#' + panelId).show();
    };

    zhed.helper.panel.hide = function (panelId) {
        $('#' + panelId).hide();
    };

    zhed.helper.post = function (url, data, callback, isAsync) {
        var cleanUrl = zhed.config.baseUrl() + url;

        $.ajax({
            url: cleanUrl,
            data: data,
            method: 'POST',
            cache: false,
            //processData: false,
            //dataType: 'JSON',
            //async: (isAsync == null ? true : isAsync),
            beforeSend: function () {
                zhed.helper.element.showAjaxLoading(true);
            },
            success: function (result) {
                callback(result);
            },
            error: function (a, b, c) {
                console.log('ERROR', a, b, c);
            },
            complete: function () {
                zhed.helper.element.showAjaxLoading(false);
            }
        });
    };

    zhed.helper.isNullOrEmpty = function (paramValue) {
        var isNullOrEmpty = true;

        if (paramValue != null && paramValue != undefined && paramValue.length != 0) {
            if (Array.isArray(paramValue) == true) {
                if (paramValue.length > 0) {
                    isNullOrEmpty = false;
                }
                else {
                    isNullOrEmpty = true;
                }
            }
            else {
                isNullOrEmpty = false;
            }
        }
        else {
            isNullOrEmpty = true;
        }

        return isNullOrEmpty;
    };

    zhed.helper.formatNumber = function (rawNumber) {
        return numeral(rawNumber).format('0,0');
    }

    zhed.helper.redirect = function (url) {
        var cleanUrl = zhed.config.baseUrl() + url;
        window.location = cleanUrl;
    }

    zhed.helper.element.click = function (elementId, callback) {
        $('#' + elementId).on('click', function (evt) {
            callback(evt);
        });
    };

    zhed.helper.element.showAjaxLoading = function (status) {
        if (status == true) {
            $('.block-wrapper, .block-wrapper-content').show();
        }
        else {
            $('.block-wrapper, .block-wrapper-content').hide();
        }
    }


    return zhed;
});


