"use client";

import { AppShell } from "@/components/app/AppShell";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useNotifications } from "@/hooks/useNotifications";
import {
  AlertTriangle,
  Ban,
  Bell,
  BellRing,
  CheckCircle2,
  MessageSquare,
  Target,
  XCircle,
  type LucideIcon,
} from "lucide-react";

const NOTIF_ICONS: Record<number, LucideIcon> = {
  1: BellRing, // ActivityRequest
  2: CheckCircle2, // RequestApproved
  3: XCircle, // RequestRejected
  4: Ban, // ActivityCancelled
  5: MessageSquare, // NewReview
  6: AlertTriangle, // Report
  7: Target, // Recommendation
};

export default function NotificationsPage() {
  const { data: notifications = [], isLoading, markRead, markAllRead, unreadCount } = useNotifications();

  return (
    <AppShell>
      <div style={{ maxWidth: 640, margin: "0 auto", padding: "20px 16px 40px" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 20 }}>
          <h1 style={{ fontSize: 22, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>
            Bildirimler
            {unreadCount > 0 && (
              <span style={{
                marginLeft: 8,
                background: "var(--color-accent)",
                color: "#fff",
                borderRadius: "var(--radius-full)",
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
                border: "1px solid var(--color-border)",
                borderRadius: "var(--radius-sm)",
                fontSize: 12,
                color: "var(--color-muted-foreground)",
                cursor: "pointer",
              }}
            >
              Tümünü okundu işaretle
            </button>
          )}
        </div>

        {isLoading && <LoadingState />}
        {!isLoading && notifications.length === 0 && (
          <EmptyState icon={Bell} title="Henüz bildirim yok" description="Etkinlik istekleri ve güncellemeler burada görünecek." />
        )}

        <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
          {notifications.map((n) => {
            const Icon = NOTIF_ICONS[n.type] ?? Bell;
            return (
              <div
                key={n.id}
                onClick={() => !n.isRead && markRead.mutate(n.id)}
                style={{
                  background: n.isRead ? "var(--color-surface)" : "var(--color-accent-soft-bg)",
                  border: `1px solid ${n.isRead ? "var(--color-border)" : "#FFD580"}`,
                  borderRadius: "var(--radius-md)",
                  padding: "14px 16px",
                  display: "flex",
                  gap: 12,
                  cursor: n.isRead ? "default" : "pointer",
                  transition: "background 0.15s ease",
                }}
              >
                <div style={{
                  width: 36,
                  height: 36,
                  flexShrink: 0,
                  borderRadius: "var(--radius-full)",
                  background: n.isRead ? "#F3F4F6" : "var(--color-surface)",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                }}>
                  <Icon size={17} color={n.isRead ? "var(--color-muted-foreground)" : "var(--color-accent)"} />
                </div>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)", marginBottom: 2 }}>{n.title}</div>
                  {n.message && <div style={{ fontSize: 13, color: "var(--color-muted-foreground)" }}>{n.message}</div>}
                  <div style={{ fontSize: 11, color: "var(--color-subtle-foreground)", marginTop: 4 }}>
                    {new Date(n.createdAt).toLocaleString("tr-TR", {
                      day: "numeric", month: "short", hour: "2-digit", minute: "2-digit",
                    })}
                  </div>
                </div>
                {!n.isRead && (
                  <div style={{
                    width: 8,
                    height: 8,
                    background: "var(--color-accent)",
                    borderRadius: "50%",
                    flexShrink: 0,
                    marginTop: 6,
                  }} />
                )}
              </div>
            );
          })}
        </div>
      </div>
    </AppShell>
  );
}
