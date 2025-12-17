import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mighty_school/api_handle/error_response.dart';
import 'package:mighty_school/util/app_constants.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 30;

  late String token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token) ?? '';
    if(kDebugMode) {
      print('Token: $token');
    }
    updateHeader(
      token, sharedPreferences.getString(AppConstants.languageCode) ?? '',
    );
  }

  void updateHeader(String token, String? languageCode, {bool ifPdf = false}) {
    Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept' : 'application/json',
      'Access-Control-Allow-Origin': '*',
      'X-Domain' : AppConstants.instituteDomain,
      AppConstants.localization: languageCode ?? AppConstants.languages[0].languageCode,
      'Authorization': 'Bearer $token',
    };
    _mainHeaders = header;
  }
  // final _chuckerHttpClient = ChuckerHttpClient(http.Client());


  Future<Response> getData(String uri, {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http.get(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      // _chuckerHttpClient.get(Uri.parse('$appBaseUrl$uri'));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
        log('====> API Body: $body');
      }
      http.Response response = await http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      // _chuckerHttpClient.post(Uri.parse('$appBaseUrl$uri'), body: jsonEncode(body));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }



  Future<dynamic> fileDownload(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
        log('====> API Body: $body');
      }
      http.Response response = await http.post(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      // _chuckerHttpClient.post(Uri.parse('$appBaseUrl$uri'), body: jsonEncode(body));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, MultipartBody? logo, List<MultipartDocument> otherFile,  {Map<String, String>? headers, MultipartDocument? videoFile,}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
        log('====> API Body: $body with ${logo!=null} 1 logo');
        log('====> API Body: $body with ${multipartBody.length} picture');
        log('====> API Body: $body with ${otherFile.length} file');
      }
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
      request.headers.addAll(headers ?? _mainHeaders);



      // === Upload Logo ===
      if (logo != null && logo.file != null) {
        Uint8List fileBytes = await logo.file!.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          logo.key,
          fileBytes,
          filename: basename(logo.file!.name),
        ));
      }

      // === Upload Images ===
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List fileBytes = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile.fromBytes(
            multipart.key,
            fileBytes,
            filename: basename(multipart.file!.name),
          ));
        }
      }

      // === Upload Other Documents ===
      for (MultipartDocument file in otherFile) {
        if (file.file != null) {
          Uint8List fileBytes = await getFileBytes(file.file!);
          request.files.add(http.MultipartFile.fromBytes(
            '${file.key}[]',
            fileBytes,
            filename: file.file!.name,
          ));
        }
      }

      // === Upload Video File ===
      if (videoFile != null && videoFile.file != null) {
        Uint8List fileBytes = await getFileBytes(videoFile.file!);
        request.files.add(http.MultipartFile.fromBytes(
          videoFile.key,
          fileBytes,
          filename: videoFile.file!.name,
        ));
      }


      request.fields.addAll(body);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }
  Future<Uint8List> getFileBytes(PlatformFile file) async {
    if (kIsWeb) {
      return file.bytes!;
    } else {
      return await io.File(file.path!).readAsBytes();
    }
  }

  Future<Response> updateMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, MultipartBody? logo, List<MultipartDocument> otherFile,  {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
        log('====> API Body: $body with ${multipartBody.length} picture');
      }
      http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
      request.headers.addAll(headers ?? _mainHeaders);




      if(logo != null){
        if(logo.file != null) {
          Uint8List list = await logo.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            logo.key, logo.file!.readAsBytes().asStream(), list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }


      for(MultipartBody multipart in multipartBody) {
        if(multipart.file != null) {
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key, multipart.file!.readAsBytes().asStream(), list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }

      if(otherFile.isNotEmpty){
        for(MultipartDocument file in otherFile){
          File aaa = File(file.file!.path!);
          Uint8List list0 = await aaa.readAsBytes();
          var part = http.MultipartFile('upload_documents[]', aaa.readAsBytes().asStream(), list0.length, filename: basename(aaa.path));
          request.files.add(part);
        }
      }



      request.fields.addAll(body);
      http.Response response = await http.Response.fromStream(await request.send());
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }


  Future<Response> postMultipartDataConversation(
      String? uri,
      Map<String, String> body,
      List<MultipartBody>? multipartBody,
      {Map<String, String>? headers,PlatformFile? otherFile}) async {

    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri!));
    request.headers.addAll(headers ?? _mainHeaders);

    if(otherFile != null) {
      request.files.add(http.MultipartFile('files[${multipartBody!.length}]', otherFile.readStream!, otherFile.size, filename: basename(otherFile.name)));
    }
    if(multipartBody!=null){
      for(MultipartBody multipart in multipartBody) {
        Uint8List list = await multipart.file!.readAsBytes();
        request.files.add(http.MultipartFile(
          multipart.key, multipart.file!.readAsBytes().asStream(), list.length, filename:'${DateTime.now().toString()}.png',
        ));
      }
    }
    request.fields.addAll(body);
    http.Response response = await http.Response.fromStream(await request.send());
    return handleResponse(response, uri);
  }



  Future<Response> putData(String uri, dynamic body, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
        log('====> API Body: $body');
      }
      http.Response response = await http.put(
        Uri.parse(appBaseUrl+uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      // _chuckerHttpClient.put(Uri.parse('$appBaseUrl$uri'), body: jsonEncode(body));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri, {Map<String, String>? headers}) async {
    try {
      if(kDebugMode) {
        log('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response response = await http.delete(
        Uri.parse(appBaseUrl+uri),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      // _chuckerHttpClient.delete(Uri.parse('$appBaseUrl$uri'));
      return handleResponse(response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    // ignore: empty_catches
    }catch(e) {}
    Response localResponse = Response(
      body: body ?? response.body, bodyString: response.body.toString(),
      request: Request(headers: response.request!.headers, method: response.request!.method, url: response.request!.url),
      headers: response.headers, statusCode: response.statusCode, statusText: response.reasonPhrase,
    );
    if(localResponse.statusCode != 200 && localResponse.body != null && localResponse.body is !String) {
      if(localResponse.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(localResponse.body);
        localResponse = Response(statusCode: localResponse.statusCode, body: localResponse.body, statusText: errorResponse.errors![0].message);
      }else if(localResponse.body.toString().startsWith('{message')) {
        localResponse = Response(statusCode: localResponse.statusCode, body: localResponse.body, statusText: localResponse.body['message']);
      }
    }else if(localResponse.statusCode != 200 && localResponse.body == null) {
      localResponse = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if(kDebugMode) {
      log('====> API Response: [${localResponse.statusCode}] $uri\n${localResponse.body}');
    }
    return localResponse;
  }
}

class MultipartBody {
  String key;
  XFile? file;
  MultipartBody(this.key, this.file);
}

class MultipartDocument {
  String key;
  PlatformFile? file;
  MultipartDocument(this.key, this.file);
}
