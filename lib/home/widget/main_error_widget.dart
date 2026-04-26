import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {
  String massage;
  VoidCallback onPressed;

  MainErrorWidget({super.key, required this.massage, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(massage, style: Theme.of(context).textTheme.labelMedium),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(
            "try again",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
