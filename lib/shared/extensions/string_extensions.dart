import 'package:intl/intl.dart';

extension ToStringDateFormat on int {
  String toStringDateFormat(){
    var dt = DateTime.fromMillisecondsSinceEpoch(this);
    return DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
  }
}