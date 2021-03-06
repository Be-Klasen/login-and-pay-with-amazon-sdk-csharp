<!-- /*******************************************************************************
 *  Copyright 2013 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *  Licensed under the Apache License, Version 2.0 (the "License"); 
 *
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at:
 *  http://aws.amazon.com/apache2.0
 *  This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 *  CONDITIONS OF ANY KIND, either express or implied. See the License
 *  for the
 *  specific language governing permissions and limitations under the
 *  License.
 * *****************************************************************************    
 */
 -->
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="address.aspx.cs" Inherits="address" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Address</title>
    <style>
        #AmazonAddressWidget {width: 400px; height: 228px;}
    </style>
    <script type="text/javascript">
        window.onAmazonLoginReady = function () {
            amazon.Login.setClientId('<%= ClientId %>');
        };
    </script>
    <script type="text/javascript" src="<%= JavascriptInclude %>"></script>
</head>
<body>
    <div id="AmazonAddressWidget"></div>

    <div id="WalletLink"></div>

    <script type='text/javascript' >
        function getParamFromQueryString(name, url) {
            var regexString = "[\\?&]" + name + "=([^&#]*)";
            var regex = new RegExp(regexString);
            var results = regex.exec(url);

            var result = null;

            if (results != null && results.length >= 2 && results[1] != null) {
                var result = results[1].replace("?" + name);
            }

            return result;
        }

        var url = window.location.href;
        var session = getParamFromQueryString("session", url);
        var access_token = getParamFromQueryString("access_token", url);

        if (session == null && access_token == null) {
            alert("Missing query string parameters from request, verify that session & access_token are present.");
        }

        new OffAmazonPayments.Widgets.AddressBook({
            sellerId: "<%= MerchantId %>",
            amazonOrderReferenceId: session,
            displayMode: 'Edit',
            design : {
                designMode : 'responsive'
            },
            onOrderReferenceCreate: function (orderReference) {
                session = orderReference.getAmazonOrderReferenceId();
                document.getElementById("WalletLink").innerHTML = "<a href=\"wallet.aspx?session=" + session + "&access_token=" + access_token + "\">Wallet page</a>";
            },
            onAddressSelect: function (orderReference) {
                // this method is triggered when the shipping address is selected
            },
            onError: function (error) {
                alert(error.getErrorCode() + ": " + error.getErrorMessage());
            }
        }).bind("AmazonAddressWidget");
    </script>

</body>
</html>
