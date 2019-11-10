import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadUserAsset() async {
 return rootBundle.loadString('assets/user_data.json');
}
