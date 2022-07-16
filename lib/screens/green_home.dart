import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_mhealth_companion/components/bottom_navbar.dart';
import 'package:smart_mhealth_companion/components/button.dart';
import 'package:smart_mhealth_companion/screens/placeholder.dart';
import 'package:smart_mhealth_companion/themes/color.dart';


class GreenHome extends StatelessWidget {
  const GreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (
          CustomBtn(
            "Verde",
             MyTheme.defaultTheme.primaryColor,
             PlaceholderWidget(),           
        )
      )
    );
  }
}