import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inheritx_assignment/view/widget/country_list_item.dart';

import '../utils/custom_dimensions.dart';
import '../utils/custom_text_styles.dart';
import '../utils/enums.dart';
import '../view_model/country_view_model.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final CountryViewModel _countryViewModel = Get.find<CountryViewModel>();

  @override
  void initState() {
    /// fetching data from local db
    _countryViewModel.getCountryListFromLocalDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: _countryViewModel,
        builder: (controller) => _getBody(),
      ),
    );
  }

  Widget _getBody() {
    switch (_countryViewModel.response.status) {
      case Status.completed:
        return _countryViewModel.countryList.isNotEmpty
            ? SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(px_10),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            vertical: spacing_xxl_4, horizontal: px_8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              flex: 5,
                              child: TextField(
                                onChanged: _countryViewModel.searchList,
                                textInputAction: TextInputAction.search,
                                style: subTitle2_14ptRegular(),
                                decoration: InputDecoration(
                                  hintText: 'Search Name/Currency',
                                  hintStyle: subTitle2_14ptRegular(),
                                  focusedBorder: const OutlineInputBorder(),
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: px_10),
                            Flexible(
                              flex: 1,
                              child: InkWell(
                                child: Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: const Icon(
                                    Icons.sort_by_alpha,
                                    size: px_20,
                                  ),
                                ),
                                onTap: () {
                                  _showSortBottomSheet();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      _countryViewModel.searchCountryList.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount:
                                    _countryViewModel.searchCountryList.length,
                                itemBuilder: (ctx, i) {
                                  return CountryListItem(
                                    country:
                                        _countryViewModel.searchCountryList[i],
                                  );
                                },
                              ),
                            )
                          : const Expanded(
                              child: Center(child: Text('No search result')),
                            ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  'No data available',
                  style: subTitle2_14ptRegular(),
                ),
              );
      case Status.error:
      case Status.noInternet:
        return Center(
          child: Text(_countryViewModel.response.message ?? ''),
        );
      case Status.loading:
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }

  void _showSortBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(px_10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(
                'Sort Name A to Z',
                style: _getSortTextStyle(SortEnum.nameAToZ),
              ),
              trailing:  Icon(Icons.sort_by_alpha_rounded,color: _getSortIconColor(SortEnum.nameAToZ)),
              onTap: () {
                _countryViewModel.sortNameAtoZ();
                Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Sort Name Z to A',
                style: _getSortTextStyle(SortEnum.nameZToA),
              ),
              trailing: Icon(Icons.sort_by_alpha_rounded,color: _getSortIconColor(SortEnum.nameZToA)),
              onTap: () {
                _countryViewModel.sortNameZtoA();
                Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Sort Currency A to Z',
                style: _getSortTextStyle(SortEnum.currencyAToZ),
              ),
              trailing:  Icon(Icons.sort_by_alpha_rounded,color: _getSortIconColor(SortEnum.currencyAToZ)),
              onTap: () {
                _countryViewModel.sortCurrencyAtoZ();
                Get.back();
              },
            ),
            ListTile(
              title: Text(
                'Sort Currency Z to A',
                style: _getSortTextStyle(SortEnum.currencyZToA),
              ),
              trailing: Icon(Icons.sort_by_alpha_rounded,color: _getSortIconColor(SortEnum.currencyZToA)),
              onTap: () {
                _countryViewModel.sortCurrencyZtoA();
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }

  TextStyle _getSortTextStyle(SortEnum sortEnum) {
    if (_countryViewModel.sortEnum != null &&
        _countryViewModel.sortEnum == sortEnum) {
      return subTitle1_16ptBold(color: Colors.blue);
    } else {
      return subTitle2_14ptRegular();
    }
  }

  Color _getSortIconColor(SortEnum sortEnum){
    if (_countryViewModel.sortEnum != null &&
        _countryViewModel.sortEnum == sortEnum) {
      return Colors.blue;
    } else {
      return Colors.black;
    }
  }
}
