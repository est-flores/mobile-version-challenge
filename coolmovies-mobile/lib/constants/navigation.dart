import 'package:flutter/material.dart';

Future<dynamic> pushNavigation(
    {required BuildContext context, required dynamic view}) {
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => view));
}
