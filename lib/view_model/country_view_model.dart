import 'package:get/get.dart';
import 'package:inheritx_assignment/utils/enums.dart';
import '../model/apis/api_response.dart';
import '../model/country.dart';
import '../model/country_repository.dart';
import '../model/services/urls.dart';
import '../utils/utils.dart';

class CountryViewModel extends GetxController {
  final CountryRepository _countryRepository = CountryRepository();
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  SortEnum? _selectedSort;

  List<Country> _countryList = [];
  List<Country> _searchCountryList = [];

  List<Country> get countryList {
    return _countryList;
  }

  List<Country> get searchCountryList {
    return _searchCountryList;
  }

  ApiResponse get response {
    return _apiResponse;
  }

  SortEnum? get sortEnum {
    return _selectedSort;
  }

  Future<void> getCountryListFromApi() async {
    await isConnected().then((value) async {
      try {
        await _countryRepository.fetchCountryListFromApi(countriesUrl);
      } catch (e) {
        customPrinter(e.toString());
        showSnackBar(e.toString(), title: 'Error');
      }
    }).onError((error, stackTrace) {
      customPrinter(error.toString());
      showSnackBar('No internet connection!', title: 'Error');
    });
  }

  Future<void> getCountryListFromLocalDB() async {
      _apiResponse = ApiResponse.loading('Data Received');
      update();
      try {
        _countryList = _searchCountryList =
            await _countryRepository.fetchCountryListFromLocalDB();
        _apiResponse = ApiResponse.completed('Data Received');
        update();
      } catch (e) {
        _apiResponse = ApiResponse.error(e.toString());
        customPrinter(e.toString());
        showSnackBar(e.toString(), title: 'Error');
        update();
      }
  }

  Future<void> deleteCountryFromLocalDB(String name) async {
    try{
      final result = await _countryRepository.deleteCountryFromDB(name);
       if(result){
         getCountryListFromLocalDB();
       }
      } catch (e) {
        customPrinter(e.toString());
        showSnackBar(e.toString(), title: 'Error');
      }
  }

  void searchList(String value) {
    _searchCountryList = _countryList
        .where((element) =>
    element.name.toLowerCase().contains(value.toLowerCase()) ||
        element.currency.toLowerCase().contains(value.toLowerCase()))
        .toList();
    if (_selectedSort != null) {
      switch(_selectedSort){
        case SortEnum.nameAToZ:
          sortNameAtoZ();
          break;
        case SortEnum.nameZToA:
          sortNameZtoA();
          break;
        case SortEnum.currencyAToZ:
          sortCurrencyAtoZ();
          break;
        case SortEnum.currencyZToA:
        default:
          sortCurrencyZtoA();
          break;
      }
    } else {
      update();
    }
  }

  void sortNameAtoZ(){
    _selectedSort = SortEnum.nameAToZ;
    _searchCountryList.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    update();
  }

  void sortNameZtoA(){
    _selectedSort = SortEnum.nameZToA;
    _searchCountryList.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
    update();
  }

  void sortCurrencyAtoZ(){
    _selectedSort = SortEnum.currencyAToZ;
    _searchCountryList.sort((a, b) => a.currency.toLowerCase().compareTo(b.currency.toLowerCase()));
    update();
  }

  void sortCurrencyZtoA(){
    _selectedSort = SortEnum.currencyZToA;
    _searchCountryList.sort((a, b) => b.currency.toLowerCase().compareTo(a.currency.toLowerCase()));
    update();
  }

}
