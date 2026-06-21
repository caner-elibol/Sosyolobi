"use client";

import { AppShell } from "@/components/app/AppShell";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useNotifications } from "@/hooks/useNotifications";

const NOTIF_ICONS: Record<number, string> = {
  1: "📩", // ActivityRequest
  2: "✅", // RequestApproved
  3: "❌", // RequestRejected
  4: "🚫", // ActivityCancelled
  5: "💬", // NewReview
  6: "⚠️",  // Report
  7: "🎯", // Recommendation
};

export default function NotificationsPage() {
  const { data: notifications = [], isLoading, markRead, markAllRead, unreadCount } = useNotifications();

  return (
    <AppShell>
      <div style={{ maxWidth: 640, margin: "0 auto", padding: "20px 16px 40px" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 20 }}>
          <h1 style={{ fontSize: 22, fontWeight: 700, color: "#111827", margin: 0 }}>
            Bildirimler
            {unreadCount > 0 && (
              <span style={{
                marginLeft: 8,
                background: "#FF9D23",
                color: "#fff",
                borderRadius: 20,
                padding: "2px 8px",
                fontSize: 12,
                fontWeight: 600,
              }}>
                {unreadCount}
              </span>
            )}
          </h1>
          {unreadCount > 0 && (
            <button
              onClick={() => markAllRead.mutate()}
              style={{
                padding: "6px 12px",
                background: "none",
                border: "1px solid #EEF2F7",
                borderRadius: 8,
                fontSize: 12,
                color: "#6B7280",
                cursor: "pointer",
              }}
            >
              Tümünü okundu işaretle
            </button>
          )}
        </div>

        {isLoading && <LoadingState />}
        {!isLoading && notifications.length === 0 && (
          <EmptyState icon="🔔" title="Henüz bildirim yok" description="Etkinlik istekleri ve güncellemeler burada görünecek." />
        )}

        <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
          {notifications.map((n) => (
            <div
              key={n.id}
              onClick={() => !n.isRead && markRead.mutate(n.id)}
              style={{
                background: n.isRead ? "#fff" : "#FFF7ED",
                border: `1px solid ${n.isRead ? "#EEF2F7" : "#FFD580"}`,
                borderRadius: 14,
                padding: "14px 16px",
                display: "flex",
                gap: 12,
                cursor: n.isRead ? "default" : "pointer",
                transition: "background 0.15s",
              }}
            >
              <div style={{ fontSize: 24, flexShrink: 0 }}>{NOTIF_ICONS[n.type] ?? "🔔"}</div>
              <div style={{ flex: 1 }}>
                <div style={{ fontSize: 14, fontWeight: 600, color: "#111827", marginBottom: 2 }}>{n.title}</div>
                {n.message && <div style={{ fontSize: 13, color: "#6B7280" }}>{n.message}</div>}
                <div style={{ fontSize: 11, color: "#9CA3AF", marginTop: 4 }}>
                  {new Date(n.createdAt).toLocaleString("tr-TR", {
                    day: "numeric", month: "short", hour: "2-digit", minute: "2-digit",
                  })}
                </div>
              </div>
              {!n.isRead && (
                <div style={{
                  width: 8,
                  height: 8,
                  background: "#FF9D23",
                  borderRadius: "50%",
                  flexShrink: 0,
                  marginTop: 6,
                }} />
              )}
            </div>
          ))}
        </div>
      </div>
    </AppShell>
  );
}
