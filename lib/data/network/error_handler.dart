enum DataSource{
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
}

class ResponseCode{
  // API Status Codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, Api rejected the request
  static const int forbidden = 403; // failure, Api rejected the request
  static const int unAuthorised = 401; // failure user is not authorised
  static const int notFound = 404; // failure, Api url is not correct and not found
  static const int internalServerError = 500; // failure, crash happened is server side


  // Local Status Code
  static const int unknown = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}