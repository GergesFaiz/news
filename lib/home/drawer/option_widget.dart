import 'package:flutter/material.dart';
import 'package:news/utils/screen_utils.dart';

class OptionWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  OptionWidget({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).splashColor, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).splashColor),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.swap_horiz_rounded,
              size: 28,
              color: Theme.of(context).splashColor,
            ),
          ),
        ],
      ),
    );
  }
}