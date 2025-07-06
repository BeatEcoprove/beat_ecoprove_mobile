import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:beat_ecoprove/core/providers/language_provider.dart';

class DatetimeService {
  static final LanguageProvider _languageProvider = GetIt.I<LanguageProvider>();

  static String formatDate(DateTime time) {
    final locale = _languageProvider.getCurrentLocaleString();
    return DateFormat.yMMMMd(locale).add_Hm().format(time);
  }

  static String formatDateCompact(DateTime time) {
    final locale = _languageProvider.getCurrentLocaleString();
    return DateFormat('dd/MM/yyyy', locale).format(time);
  }
}
