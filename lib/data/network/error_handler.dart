import 'package:complete_advanced_project/data/network/failure.dart';
import 'package:dio/dio.dart';

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
  defaultError,
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error){
    Failure handleError(DioError error){
      switch(error.type) {
        case DioErrorType.connectTimeout:
          return DataSource.connectTimeout.getFailure();
        case DioErrorType.sendTimeout:
          return DataSource.sendTimeout.getFailure();
        case DioErrorType.receiveTimeout:
          return DataSource.receiveTimeout.getFailure();
        case DioErrorType.response:
          switch(error.response!.statusCode){
            case ResponseCode.badRequest:
              return DataSource.badRequest.getFailure();
            case ResponseCode.forbidden:
              return DataSource.forbidden.getFailure();
            case ResponseCode.unAuthorised:
              return DataSource.unAuthorised.getFailure();
            case ResponseCode.notFound:
              return DataSource.notFound.getFailure();
            case ResponseCode.internalServerError:
              return DataSource.internalServerError.getFailure();
            default:
              return DataSource.defaultError.getFailure();
          }
        case DioErrorType.cancel:
          return DataSource.cancel.getFailure();
        case DioErrorType.other:
          return DataSource.defaultError.getFailure();
      }
    }
    if (error is DioError) {
      // dio error so its error from response of the API
      failure= handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }

  }
}

extension DataSourceExtension on DataSource{
  Failure getFailure(){
    switch(this) {
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unAuthorised:
        return Failure(ResponseCode.unAuthorised, ResponseMessage.unAuthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError, ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection, ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
      default:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
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
  static const int defaultError = -1;
  static const int connectTimeout = -2;
  static const int cancel = -3;
  static const int receiveTimeout = -4;
  static const int sendTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage{
  // API Message Codes
  static const String success = 'Success'; // success with data
  static const String noContent = 'Success with no Content'; // success with no content
  static const String badRequest = 'Bad request, try again later'; // failure, Api rejected the request
  static const String forbidden = 'Forbidden request, try again later'; // failure, Api rejected the request
  static const String unAuthorised = 'User is unauthorised, try again later'; // failure user is not authorised
  static const String notFound = 'Url is not found, try again later'; // failure, Api url is not correct and not found
  static const String internalServerError = 'Some thing went wrong, try again later'; // failure, crash happened is server side


  // Local Message Code
  static const String defaultError = 'Some thing went wrong, try again later';
  static const String connectTimeout = 'Time out error, try again later';
  static const String cancel = 'Request was cancelled, try again later';
  static const String receiveTimeout = 'Time out error, try again later';
  static const String sendTimeout = 'Time out error, try again later';
  static const String cacheError = 'Cache error, try again later';
  static const String noInternetConnection = 'Please check your internet connection';
}

class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;
}