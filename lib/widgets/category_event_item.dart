import 'package:flutter/material.dart';

class CategoryEventItem extends StatelessWidget {
  String text;
  bool isSelected;

  CategoryEventItem({required this.text, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(24)),
      child: Text(text,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color:
                  isSelected ? Colors.white : Theme.of(context).primaryColor)),
    );
  }
}
