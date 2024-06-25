import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:page_transition/page_transition.dart';
import 'package:startup/screens/plan.dart';
import 'package:startup/screens/templates/main.dart';
import 'package:startup/shared/strings.dart';

import '../shared/base.dart';
import '../shared/colors.dart';
import '../shared/markdown.dart';
import '../widgets/menu_button.dart';

class PlanPreviewScreen extends MainScreen {
  static BuildContext? context;

  const PlanPreviewScreen({super.key})
      : super(
          onExitTap: PlanPreviewScreen.exitTap,
          title: StaticStrings.myPlanTitle,
        );

  @override
  PlanPreviewScreenState createState() => PlanPreviewScreenState();

  static exitTap() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }

  @override
  Widget get footer {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Center(
        child: SizedBox(
          width: 300,
          child: MenuButton(
            label: StaticStrings.next,
            onTap: openPlan,
          ),
        ),
      ),
    );
  }

  static openPlan() {
    Navigator.push(
        context!,
        PageTransition(
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 250),
          child: const PlanScreen(index: 0),
        ));
  }
}

class PlanPreviewScreenState extends MainScreenState {
  late Stream<Object?> _stream;
  late String text;
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    PlanPreviewScreen.context = context;
    var get = Base.get('plan_preview');

    _stream = get.asStream();
    get.then((Object? value) {
      text = value! as String;
    });

    return builder(context, Container(
      width: double.infinity,
      height: double.infinity,
      decoration: ShapeDecoration(
        color: StaticColors.back,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(7),
      child: StreamBuilder<Object?>(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator()),
              );
            }

            return Scrollbar(
              controller: controller,
              thickness: 10.0,
              thumbVisibility: true,
              trackVisibility: true,
              child: Markdown(
                data: text,
                selectable: false,
                controller: controller,
                styleSheet: StaticMarkdown.getStyle(),
              ),
            );
          }),
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
