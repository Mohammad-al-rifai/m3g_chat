// ignore: slash_for_doc_comments
/**
 * Write All Global Functions Here Like:
 *  1- getDataFromString
 *  2- getNameTranslation
 *  3- getLatLangLocation
 *  4- ......and Other
 */

import 'package:flutter/material.dart';

defaultNavigator({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

defaultReplaceNavigator({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
