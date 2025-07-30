import 'package:Intellio/infrastructure/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String Function(T) itemToString;
  final void Function(T?) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.itemToString,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: regular50.withValues(alpha: 0.3),
        border: Border(bottom: BorderSide(width: 1.5, color: white)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_outlined, color: Theme.of(context).textTheme.bodyLarge!.color),
          style: r14.copyWith(),
          items:
              items.map((T item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemToString(item)),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
