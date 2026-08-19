import 'package:flutter/material.dart';

/// Shown only while [authProvider]'s initial token-restore is
/// in-flight — `go_router`'s `redirect` returning `null` mid-load doesn't
/// pause navigation, it renders whatever route is current, so without this
/// dedicated route the app would briefly flash `/app/map` (with real side
/// effects, e.g. a location-permission prompt) before correcting to
/// `/auth/login` on a cold, logged-out start.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator()));
}
