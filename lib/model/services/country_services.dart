import 'dart:convert';
import 'dart:io';
import 'package:inheritx_assignment/model/services/base_service.dart';
import 'package:inheritx_assignment/model/services/urls.dart';
import 'package:http/http.dart' as http;
import '../apis/app_exception.dart';

class CountryServices extends BaseService {

  @override
  Future getResponse(String url) async{
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrl + url));
        responseJson = returnResponse(response);
    } on SocketException catch (e){
      throw FetchDataException(e.message);
    }
    return responseJson;
  }

  dynamic returnResponse(response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

}