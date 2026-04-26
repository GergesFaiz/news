import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

extension ScreenUtils on BuildContext{
  double get width => MediaQuery.of(this).size.width;
   double get height => MediaQuery.of(this).size.height;
}
