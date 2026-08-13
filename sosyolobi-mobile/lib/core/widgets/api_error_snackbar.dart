import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../network/api_exception.dart';
import '../router/route_paths.dart';

/// Shared error-surface convention (plan §10): `code`-driven special cases
/// mirror `ChatPanel.tsx`'s `UserApiError` handling verbatim, otherwise show
/// the server's message. 401s aren't handled here — `AuthInterceptor`
/// already redirects to login for those.
void showApiErrorSnackBar(BuildContext context, Object error) {
  final messenger = ScaffoldMessenger.of(context);
  if (error is! ApiException) {
    messenger.showSnackBar(const SnackBar(content: Text('Bir hata oluştu. Tekrar deneyin.')));
    return;
  }

  switch (error.code) {
    case 'RATE_LIMITED':
      messenger.showSnackBar(const SnackBar(content: Text('Çok hızlı mesaj gönderiyorsunuz. Lütfen biraz bekleyin.')));
    case 'PROFILE_INCOMPLETE':
      messenger.showSnackBar(
        SnackBar(
          content: const Text('Devam etmeden önce profilinizde bir görünen ad belirlemelisiniz.'),
          action: SnackBarAction(label: 'Profili Düzenle', onPressed: () => context.push(RoutePaths.profile)),
        ),
      );
    default:
      messenger.showSnackBar(SnackBar(content: Text(error.message)));
  }
}
