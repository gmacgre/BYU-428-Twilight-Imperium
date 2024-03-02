import 'package:http/http.dart' as http;

class HTTPService {
  final String _serverDomain = 'http://localhost:8000';
  final HTTPServiceObserver _observer;
  HTTPService(this._observer);

  //the main input for the HTTP Service
  //Just sends the information. Other, observing classes will make the request to actually send down the wire, based on their service.
  //We work with strings here because we assume that the JSON or other type of encoding has already been completed.

  //A GET request. Requires only the URI, and Headers (with one of the headers being a key for User Authentication).
  void getRequest(String uri, Map<String, String> headers) async {
    try {
      http.Response res =  await http.get(
      Uri.parse('$_serverDomain$uri'),
      headers: headers
    );
    _determineResult(res);
    }
    on http.ClientException catch (error) {
      _observer.processException('Failed to call ${error.uri.toString()}: ${error.message}');
    }
  }

  //A POST Request. Requires the URI, Headers (with the UserAuth header), and a body serialized.
  void postRequest(String uri, Map<String, String> headers, String body) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$_serverDomain$uri'),
        headers: headers,
        body: body
      );
      _determineResult(res);
    }
    on http.ClientException catch (error) {
      _observer.processException('Failed to call ${error.uri.toString()}: ${error.message}');
    }
  }


  //If the HTTP Request was successful, the body of the response is sent to the observer. In case of failure, the Status Code and the body are sent. 
  void _determineResult(http.Response res) {
    if(res.statusCode != 200) {
      _observer.processFailure(res.statusCode, res.body);
    }
    else {
      _observer.processSuccess(res.body);
    }
  }
}

abstract interface class HTTPServiceObserver {
  void processFailure(int errorCode, String body);
  void processSuccess(String body);
  void processException(String body);
}