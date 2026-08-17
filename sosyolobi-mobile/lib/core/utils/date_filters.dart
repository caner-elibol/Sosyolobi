/// Ports `sosyolobi-web-2/src/lib/date-filters.ts` verbatim — client-side
/// date-range + weekend-only filtering for the activities list and map
/// screens. Backend already supports `fromDate`/`toDate` query params on
/// `/api/activities/nearby` and `/api/activities/map` (no backend change
/// needed); weekend filtering is purely client-side (`eventDate`'s local
/// weekday is Saturday/Sunday).
enum DateFilterKey { all, today, week, month }

const dateFilterOptions = [
  (label: 'Tümü', value: DateFilterKey.all),
  (label: 'Bugün', value: DateFilterKey.today),
  (label: 'Bu Hafta', value: DateFilterKey.week),
  (label: 'Bu Ay', value: DateFilterKey.month),
];

abstract final class DateFilters {
  static DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day);

  static DateTime _endOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 23, 59, 59, 999);

  /// Monday-start week, mirroring web's `startOfWeek`.
  static DateTime _startOfWeek(DateTime d) {
    final start = _startOfDay(d);
    final daysFromMonday = start.weekday - DateTime.monday; // Mon=0 ... Sun=6
    return start.subtract(Duration(days: daysFromMonday));
  }

  static DateTime _endOfWeek(DateTime d) => _endOfDay(_startOfWeek(d).add(const Duration(days: 6)));

  static DateTime _startOfMonth(DateTime d) => DateTime(d.year, d.month, 1);

  static DateTime _endOfMonth(DateTime d) => _endOfDay(DateTime(d.year, d.month + 1, 0));

  /// Returns the local-time `(fromDate, toDate)` bounds for [key] — callers
  /// should send `.toUtc()` when passing these as query params, matching the
  /// backend's `.ToUniversalTime()` normalization.
  static ({DateTime? fromDate, DateTime? toDate}) rangeFor(DateFilterKey key, [DateTime? now]) {
    final n = now ?? DateTime.now();
    switch (key) {
      case DateFilterKey.today:
        return (fromDate: _startOfDay(n), toDate: _endOfDay(n));
      case DateFilterKey.week:
        return (fromDate: _startOfWeek(n), toDate: _endOfWeek(n));
      case DateFilterKey.month:
        return (fromDate: _startOfMonth(n), toDate: _endOfMonth(n));
      case DateFilterKey.all:
        return (fromDate: null, toDate: null);
    }
  }

  static bool isWeekend(DateTime eventDate) {
    final local = eventDate.toLocal();
    return local.weekday == DateTime.saturday || local.weekday == DateTime.sunday;
  }
}
