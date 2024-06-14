import 'package:flutter/cupertino.dart';

import 'menu_button.dart';

class Menu extends StatelessWidget {
  late final List<String> _labels;
  late final List<VoidCallback> _callbacks;

  Menu(
      {super.key,
      required List<String> labels,
      required List<VoidCallback> callbacks}) {
    if (labels.length != callbacks.length) {
      throw Exception(
          'Количество элементов не совпадает с количеством функций');
    }
    _labels = labels;
    _callbacks = callbacks;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _labels.length,
        itemBuilder: (context, index) => MenuButton(
          label: _labels[index],
          onTap: _callbacks[index],
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 25),
      ),
    );
  }
}
