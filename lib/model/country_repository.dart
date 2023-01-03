import 'dart:io';

import 'package:get/get.dart';
import 'package:inheritx_assignment/model/country_res_data.dart';
import 'package:inheritx_assignment/model/services/base_service.dart';
import 'package:inheritx_assignment/model/services/country_services.dart';
import 'package:inheritx_assignment/sqf_lite/tabel_names.dart';

import '../sqf_lite/sqf_lite_operations.dart';
import 'apis/app_exception.dart';
import 'country.dart';

class CountryRepository {
  final BaseService _service = CountryServices();

  Future<void> fetchCountryListFromApi(String endpoint) async {
    dynamic response = await _service.getResponse(endpoint);
    final resData = countryResData.fromJson(response);
    if(!resData.error){
      final sqfController = Get.find<SQFLiteOperations>();
      final dataList = List<Map<String,dynamic>>.from(resData.data.map((x) => x.toJson()));
      await sqfController.addEntries(countryTable, dataList);
    }else{
      throw resData.msg;
    }
  }

  Future<List<Country>> fetchCountryListFromLocalDB() async {
    dynamic responseJson;
    try {
      final sqfController = Get.find<SQFLiteOperations>();
      final data  = await sqfController.getEntries(countryTable);
      responseJson = List<Country>.from((data.map((e) => Country.fromJson(e))));
    } on SocketException catch (e){
      throw FetchDataException(e.message);
    }
    return responseJson;
  }

  Future<bool> deleteCountryFromDB(String name) async {
    dynamic responseJson;
    try {
      final sqfController = Get.find<SQFLiteOperations>();
      responseJson = await sqfController.deleteEntry(countryTable,name);
    } on SocketException catch (e){
      throw FetchDataException(e.message);
    }
    return responseJson;
  }
}