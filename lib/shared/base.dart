import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../firebase_options.dart';

class Base {
  static final DatabaseReference _db = FirebaseDatabase.instance.ref();
  static final String _url = DefaultFirebaseOptions.currentPlatform.databaseURL!;

  static Future<Object?> _getJSON(String url) async {
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body);
  }

  static Future<Object?> get(String path) async {
    if (isNotImplemented) {
      final url = '$_url/$path.json';
      try {
        return _getJSON(url);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return null;
      }
    }
    var snapshot = await _db.child(path).get();
    return snapshot.value;
  }

  static Future<void> set(String path, Object value) async {
    if (isNotImplemented) {
      final url = '$_url/$path.json';
      var body = json.encode(value);
      await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: body
      );
    } else {
      await _db.child(path).set(value);
    }
  }

  static bool get isNotImplemented {
    return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }
}
