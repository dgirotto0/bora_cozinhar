import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool>? onChanged;

  const RoundedCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged?.call(!isChecked);
      },
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          color: isChecked ? Colors.yellow : Colors.transparent,
        ),
        child: isChecked
            ? const Icon(
          Icons.check,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}