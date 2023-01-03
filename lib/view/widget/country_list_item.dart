import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inheritx_assignment/model/country.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils/custom_dimensions.dart';
import '../../utils/custom_text_styles.dart';
import '../../view_model/country_view_model.dart';
import '../flag_full_screen.dart';
import 'delete_country_popup.dart';

class CountryListItem extends StatelessWidget {
  final Country country;
  CountryListItem({Key? key, required this.country}) : super(key: key);

  final CountryViewModel _countryViewModel = Get.find<CountryViewModel>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) => DeleteCountryPopup(
            yesButtonCallBack: () {
              _countryViewModel.deleteCountryFromLocalDB(country.name);
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(px_20),
        margin: const EdgeInsets.only(bottom: px_10, left: px_8, right: px_8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(1, 1),
              )
            ]),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rotate,
                    duration: const Duration(seconds: 1),
                    alignment: Alignment.center,
                    child: FlagFullScreen(
                      url: country.flag,
                    ),
                  ),
                );
              },
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(px_50),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(px_50),
                  child: SvgPicture.network(
                    country.flag,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: px_20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getTitleAndValue('Country', country.name),
                  _getTitleAndValue('Currency', country.currency),
                  _getTitleAndValue('Dial Code', country.dialCode),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getTitleAndValue(String title, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ',
          style: subTitle1_16ptBold(),
        ),
        Flexible(
          child: Text(
            value,
            style: subTitle1_16ptRegular(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
