import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteCountryPopup extends StatelessWidget {
  final VoidCallback yesButtonCallBack;
  const DeleteCountryPopup({Key? key, required this.yesButtonCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want delete this country?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            yesButtonCallBack();
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
