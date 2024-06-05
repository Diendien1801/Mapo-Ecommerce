// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:store/utils/constants/colors.dart';

// ignore: must_be_immutable
class CustomChoiceChip extends StatelessWidget {
  Color? color;
  final bool? selected;
  final void Function(bool) onSelected;
  String text;
  ShapeBorder? shape;
  CustomChoiceChip({
    Key? key,
    this.color,
    this.selected,
    required this.onSelected,
    required this.text,
    required this.shape,
  }) {
    // TODO: implement CustomChoiceChip
  }
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      selected: selected!,
      onSelected: onSelected,
      labelPadding: EdgeInsets.all(0),
      shape: shape as OutlinedBorder?,
      backgroundColor: color,
      selectedColor: (text != "" && selected == true) ? TColors.primary : color,
      showCheckmark: false,
      avatar: selected!
          ? Container(
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
