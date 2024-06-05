import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
