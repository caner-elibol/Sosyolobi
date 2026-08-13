/// tr-TR date/distance formatting — mirrors
/// `sosyolobi-web-2/src/lib/format.ts` + the inline `formatDate` helpers in
/// `ActivityCard.tsx`/`MapView.tsx`.
///
/// All backend timestamps arrive as UTC ISO-8601 strings (`...Z`), and
/// `DateTime.parse()` preserves that as a UTC-flagged `DateTime`. JS's
/// `Date` methods (`toLocaleDateString`, `getHours`, ...) used on web always
/// operate in the browser's local time automatically; Dart does not — every
/// formatter here must call `.toLocal()` first or it silently displays UTC
/// clock values as if they were local (confirmed live: showed times 3 hours
/// behind on a UTC+3 device before this fix).
abstract final class Formatters {
  static const _months = ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'];

  static String distanceMeters(double? meters) {
    if (meters == null) return '';
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  static String eventDate(DateTime date) {
    final local = date.toLocal();
    final now = DateTime.now();
    final isToday = local.year == now.year && local.month == now.month && local.day == now.day;
    final time = '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    if (isToday) return 'Bugün $time';
    return '${local.day} ${_months[local.month - 1]} $time';
  }

  /// Longer form: "Bugün 20:17" or "14 Ağustos 20:17" — mirrors the detail
  /// screen's `formatDate` (weekday/full month name trimmed to short form
  /// for space; see `ActivityDetailScreen`).
  static String eventDateLong(DateTime date) {
    final local = date.toLocal();
    final now = DateTime.now();
    final isToday = local.year == now.year && local.month == now.month && local.day == now.day;
    final time = '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    if (isToday) return 'Bugün $time';
    return '${local.day} ${_monthsLong[local.month - 1]} $time';
  }

  static const _monthsLong = [
    'Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran',
    'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık',
  ];

  static String time(DateTime date) {
    final local = date.toLocal();
    return '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }

  static String shortDate(DateTime date) {
    final local = date.toLocal();
    return '${local.day}.${local.month}.${local.year}';
  }

  static String dateTimeShort(DateTime date) {
    final local = date.toLocal();
    return '${local.day} ${_months[local.month - 1]} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  }
}
