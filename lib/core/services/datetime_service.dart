import 'package:beat_ecoprove/core/locales/locale_context.dart';
import 'package:intl/intl.dart';

class DatetimeService {
  static String formatDate(DateTime time) {
    var locale = LocaleContext.getCurrentLocaleString();

    return DateFormat.yMMMMd(locale).add_Hm().format(time);
  }

  static String formatDateCompact(DateTime time) {
    var locale = LocaleContext.getCurrentLocaleString();

    return DateFormat('dd/MM/yyyy', locale).format(time);
  }
}
