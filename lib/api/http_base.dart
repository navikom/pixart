import 'dart:convert';

import 'package:http/http.dart';
import 'package:pixart/api/settings.dart';
import 'package:pixart/service/device_info_service.dart';
import 'package:pixart/utils/error_handler.dart';

abstract class HTTPBase extends BaseClient {
  final String _url;
  String token;
  DeviceInfoService device = new DeviceInfoService();
  bool debug = true;

  HTTPBase(this._url);

  BaseRequest prepareRequest(String method, String url, [Map body]) {
    body ??= {};
    Uri uri = Uri.parse('$backendUrl/$_url/$url');
    if (debug) {
      print('REQUEST $method $uri $body ');
    }
    return Request(method, uri)..body = json.encode(body);
  }

  Future<dynamic> fetch(String method, String url, [Map body]) async {
    BaseRequest request = prepareRequest(method, url, body);
    request.headers['Cookie'] = 'APP=Pixart';
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';
    request.headers['user-agent'] = json.encode(await this.device.deviceInfo);
    if (token != null) {
      request.headers['Authorization'] = token;
    }
    final Client client = Client();

    try {
      Response response = await Response.fromStream(await client.send(request));
      print('fetch 12121212 ${request.headers}');
      if (debug) {
        print('RESPONSE ${request.url} ${response.statusCode}');
      }
      dynamic jsonResponse = json.decode(response.body);
      if (debug) {
        print('RESPONSE BODY ${request.url} $jsonResponse');
      }
      if (response.statusCode != 200) {
        throw ErrorHandler(
          jsonResponse['error'] == null ? 'HTTP Error' : jsonResponse['error'],
        );
      }
      return jsonResponse['data'];
    } catch (err) {
      throw throw ErrorHandler(err);
    } finally {
      client.close();
    }
  }
}
