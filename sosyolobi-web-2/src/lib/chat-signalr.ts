import { HubConnection, HubConnectionBuilder, ILogger, LogLevel } from "@microsoft/signalr";

function getUserToken(): string | null {
  if (typeof document === "undefined") return null;
  const match = document.cookie.match(/(?:^|;\s*)user_token=([^;]+)/);
  return match ? decodeURIComponent(match[1]) : null;
}

// React Strict Mode'da geliştirme ortamında effect'ler mount->cleanup->mount
// sırasıyla iki kez çalışır; bu da ilk bağlantının negotiate sırasında
// durdurulmasına ve SignalR'ın bunu console.error ile loglamasına yol açar.
// Bu beklenen/zararsız durumu console.warn'a düşürüp gerçek hataları
// console.error'da bırakıyoruz.
const benignLogger: ILogger = {
  log(logLevel, message) {
    if (logLevel < LogLevel.Error) return;
    if (message.includes("stopped during negotiation") || message.includes("connection was stopped")) {
      console.warn(message);
      return;
    }
    console.error(message);
  },
};

export function buildChatConnection(): HubConnection {
  return new HubConnectionBuilder()
    .withUrl(`${process.env.NEXT_PUBLIC_API_URL}/hubs/chat`, {
      accessTokenFactory: () => getUserToken() ?? "",
    })
    .withAutomaticReconnect()
    .configureLogging(benignLogger)
    .build();
}
