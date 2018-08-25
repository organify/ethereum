function UserAction() {
    console.log('clicked');
    var settings = {
        // "type": "GET",
        "async": true,
        "crossDomain": true,
        "url": "http://quickstats.nass.usda.gov/api/api_GET/?key=2BE069A8-75A9-3869-9DBB-E120C1679063&commodity_desc=CORN&year__GE=2016&state_alpha=VA&format=JSON",
        "method": "GET",
        "headers": {
            // "Access-Control-Allow-Headers": "X-Custom-Header",
            // "Access-Control-Request-Method":"GET",
          "Cache-Control": "no-cache",
          "Postman-Token": "0034b8e5-ce63-47a7-9f27-649670f74eaa"
        },
        "Content-Type" : "text/plain",
    }
    
    $.ajax(settings).done(function (response) {
    console.log('it worked');
    // console.log(response);
    });
}