import 'dart:convert';
import 'package:crypto/crypto.dart';



  generateMd5(String input) {

  print("MDF :${md5.convert(utf8.encode(input))}");
   return md5.convert(utf8.encode(input)).toString();
}
