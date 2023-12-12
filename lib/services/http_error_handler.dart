import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  // Extract the status code and reason phrase from the response
  final statusCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  // Generate an error message describing the failure
  final String errorMessage =
      'Request failed\nStatus Code: $statusCode\nReason: $reasonPhrase';

  // Return the error message
  return errorMessage;
}
