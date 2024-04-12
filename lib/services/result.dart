import 'dart:ffi';
import 'dart:math';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DataRes {
  var data;
  bool result;
  Function? next;
  DataRes(this.data, this.result, {this.next});
}
