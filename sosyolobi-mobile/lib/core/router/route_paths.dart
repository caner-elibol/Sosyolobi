abstract final class RoutePaths {
  static const splash = '/splash';

  static const login = '/auth/login';
  static const verify = '/auth/verify';

  /// Mandatory gate between a successful login and the app shell — no /app/*
  /// route is reachable until location permission resolves to granted.
  static const locationGate = '/onboarding/location';

  static const map = '/app/map';
  static const activities = '/app/activities';
  static const activityCreate = '/app/activities/create';
  static String activityDetail(String id) => '/app/activities/$id';
  static const activityDetailPattern = '/app/activities/:id';

  static const requests = '/app/requests';
  static const profile = '/app/profile';
  static String publicProfile(String userId) => '/app/profile/$userId';
  static const publicProfilePattern = '/app/profile/:userId';

  static const friends = '/app/friends';
  static const myReports = '/app/reports';
}
