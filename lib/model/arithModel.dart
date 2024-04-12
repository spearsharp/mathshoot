import 'dart:ffi';

import 'package:arithg/services/arith.dart';
import 'package:flutter/foundation.dart';

class ArithModel {
  String key;
  Int level;
  Int calcnum;
  String? arithquote;

  ArithModel({
    required this.key,
    required this.level,
    required this.calcnum,
    required this.arithquote,
  });

  Map<String, dynamic> arithmodel() {
    return {
      'UUID': key,
      'Name': level,
      'Score': calcnum,
      'Level': arithquote,
    };
  }
}
