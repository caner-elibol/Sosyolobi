import 'package:flutter/foundation.dart' show kIsWeb;

import '../config/app_config.dart';

/// Backend-served image URLs (avatars, category photos) are built from
/// `Request.Scheme`/`Request.Host` **at the moment they're first fetched and
/// cached** (`CategoriesController.FetchAndStoreCategoryImageAsync`, up to
/// 30 days) — not reconstructed per-request. If that first fetch happened
/// from a different host than the one this client is currently configured
/// for (e.g. a category image was cached while hitting the API from
/// `localhost:5000` directly, but the Android emulator must reach the same
/// backend via `10.0.2.2:5000`), the stored URL's host becomes unreachable
/// from this client (confirmed live: broken-image icons, `SocketException:
/// Connection refused ... address = localhost`).
///
/// This is a dev/local-network quirk only — in production the API has a
/// real public domain and this rewrite is a no-op. Rather than silently
/// living with broken images (or touching the backend's caching behavior,
/// out of scope here), normalize `localhost`/`127.0.0.1` in any image URL to
/// the host this client is actually configured to reach.
String? resolveImageUrl(String? url) {
  if (url == null || url.isEmpty) return url;
  if (kIsWeb) return url;

  final uri = Uri.tryParse(url);
  if (uri == null) return url;
  if (uri.host != 'localhost' && uri.host != '127.0.0.1') return url;

  final apiUri = Uri.tryParse(AppConfig.apiBaseUrl);
  if (apiUri == null || apiUri.host == uri.host) return url;

  return uri.replace(host: apiUri.host, port: apiUri.hasPort ? apiUri.port : uri.port).toString();
}

extension ResolvedNetworkImage on String? {
  /// `resolveImageUrl(this)` as a getter, for terse call sites:
  /// `Image.network(item.categoryImageUrl.resolved!)`.
  String? get resolved => resolveImageUrl(this);
}
