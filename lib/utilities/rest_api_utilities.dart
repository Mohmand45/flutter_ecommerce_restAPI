class RestApiUtilities {
  //static String product_url = 'https://fakestoreapi.com/products';
  static String url = 'https://fakestoreapi.com';
  static final String product_url = '$url/products';

  static final error_404 = "Resource not found";
  static final error_401 = "Un Authorize Error";
  static final error_time_out = "Time out Error";
  static final error_internet_issue = "You are not Conneccted to Internet";
  static final error_unknown = "Un Authorize Error";

  static String GetResponseError(int status){
    switch(status){
      case 404:
        return error_404;
      case 401:
        return error_401;
      case 420:
        return error_time_out;
      case 430:
        return error_internet_issue;
      default:
        return error_unknown;
  }
}

static void GetPrintHeaderBodyUrlResponse(url, header, body, response){
    print("Get Response: url: $url");
    print("Get Response: header: $header");
    print("Get Response: body: $body");
    print("Get Response: response: ${response.statusCode}, ${response.body}");


}

}
