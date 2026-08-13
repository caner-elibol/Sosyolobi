import 'package:flutter/material.dart';

/// Root-level messenger key, wired into `MaterialApp.router`. A `SnackBar`
/// shown via `ScaffoldMessenger.of(context)` is torn down along with the
/// route's own `Scaffold` — so showing one immediately before navigating
/// away (e.g. "Etkinlik oluşturuldu!" right before `pushReplacement` to the
/// new activity) gets cut off mid-render and the user never sees it
/// (confirmed live: create-activity had no visible success confirmation).
/// This key is the app's single `ScaffoldMessengerState`, independent of
/// any one route, so a message shown through it survives navigation —
/// the Flutter equivalent of web's `sonner` toast overlay persisting
/// across `router.push`.
final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showRootSnackBar(SnackBar snackBar) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);
}
