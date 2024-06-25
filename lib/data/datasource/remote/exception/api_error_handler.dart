import 'package:dio/dio.dart';
import 'package:geo_enabled/data/model/response/base/error_response.dart';

class ApiErrorHandler {
  static String getMessage(dynamic error) {
    String errorDescription = "";

    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Connection to server failed due to internet connection";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioExceptionType.badResponse:
          errorDescription = _handleResponseError(error);
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = "Send timeout with server";
          break;
        default:
          errorDescription = "Unexpected error occurred";
          break;
      }
    } else {
      errorDescription = "Provided error is not a subtype of DioException";
    }

    return errorDescription;
  }

  static String _handleResponseError(DioException error) {
    String errorDescription = "Failed to load data";
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 404:
        case 500:
        case 503:
          errorDescription = error.response?.statusMessage ?? "Error occurred";
          break;
        default:
          try {
            // Ensure that ErrorResponse.fromJson() correctly handles parsing.
            ErrorResponse errorResponse = ErrorResponse.fromJson(error.response!.data);
            if (errorResponse.errors != null && errorResponse.errors!.isNotEmpty) {
              errorDescription = errorResponse.errors!.join(", ");
            } else {
              errorDescription = "Failed to load data - status code: ${error.response?.statusCode}";
            }
          } on FormatException catch (e) {
            errorDescription = "Error parsing data: ${e.message}";
          } catch (e) {
            errorDescription = "Failed to load data - status code: ${error.response?.statusCode}";
          }
          break;
      }
    } else {
      errorDescription = "No response received";
    }
    return errorDescription;
  }
}
