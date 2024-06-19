import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../shared/colors.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => DefaultScreenState();
}

class DefaultScreenState extends State<DefaultScreen> {
  static Widget builder(BuildContext context, Widget? child) {
    return Container(
      decoration: const BoxDecoration(color: StaticColors.backgroundColor),
      width: double.infinity,
      height: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, null);
  }

  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
}
