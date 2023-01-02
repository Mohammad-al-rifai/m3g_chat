import 'package:crypto/crypto.dart';
import 'dart:convert';

import '../components/resources/constants_manager.dart';

class HMacAlgorithm {
  static String create(dynamic data) {
    var key = utf8.encode(AppConstants.secret);
    var bytes = utf8.encode(data.toString());
    var hmacSha1 = Hmac(sha1, key);
    Digest sha1Result = hmacSha1.convert(bytes);
    return sha1Result.toString();
  }
}
