import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inheritx_assignment/sqf_lite/tabel_names.dart';
import 'package:inheritx_assignment/view/country_list_screen.dart';
import 'package:inheritx_assignment/view_model/country_view_model.dart';

import 'sqf_lite/sqf_lite_operations.dart';

void main() async {
  final sqfController = Get.put(SQFLiteOperations());
  ///  opening data base
  await sqfController.openDB(countryTable);
  /// 1 sec delay because of in next step I am fetching data from api and store it in local db
  await Future.delayed(const Duration(seconds: 1));

  final countryViewModel = Get.put(CountryViewModel());
  /// fetching data from api and store it in local db
  countryViewModel.getCountryListFromApi();
  /// 2 sec delay, waiting for api response
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final sqfController = Get.find<SQFLiteOperations>();

  @override
  void dispose() async {
    await sqfController.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountryListScreen(),
    );
  }
}
