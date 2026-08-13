import 'package:signalr_netcore/signalr_client.dart';

import '../storage/token_storage.dart';

/// Builds a SignalR `HubConnection` against `/hubs/*`. Both hubs require the
/// JWT as an `?access_token=` query-string param (see
/// `ServiceCollectionExtensions.AddJwtAuthentication`'s `OnMessageReceived`
/// handler) — `accessTokenFactory` below is signalr_netcore's hook for that.
HubConnection buildHubConnection(String url, TokenStorage tokenStorage) {
  return HubConnectionBuilder()
      .withUrl(
        url,
        options: HttpConnectionOptions(
          accessTokenFactory: () async => await tokenStorage.readAccessToken() ?? '',
        ),
      )
      .withAutomaticReconnect(retryDelays: [2000, 5000, 10000, 20000, 30000])
      .build();
}
