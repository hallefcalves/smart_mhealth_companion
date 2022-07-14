import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_mhealth_companion/components/bottom_navbar.dart';

import '../components/button.dart';

class PurpleHome extends StatelessWidget {
  const PurpleHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const BottomAppBar(),
          CustomBtn("próximo"),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
