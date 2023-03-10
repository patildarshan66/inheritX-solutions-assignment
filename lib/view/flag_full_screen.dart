import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagFullScreen extends StatelessWidget {
  final String url;
  const FlagFullScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SvgPicture.network(url,fit: BoxFit.fill),
        ),
      ),
    );
  }
}
