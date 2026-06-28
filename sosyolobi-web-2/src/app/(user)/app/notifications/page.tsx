"use client";

import { useRouter } from "next/navigation";
import { AppShell } from "@/components/app/AppShell";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useNotifications } from "@/hooks/useNotifications";
import { useChatUnread } from "@/hooks/useChatUnread";
import {
  AlertTriangle,
  Ban,
  Bell,
  BellRing,
  CheckCircle2,
  CheckCircle,
  MessageSquare,
  Star,
  XCircle,
  type LucideIcon,
} from "lucide-react";

const NOTIF_ICONS: Record<number, LucideIcon> = {
  1: BellRing, // ActivityRequest
  2: CheckCircle2, // RequestApproved
  3: XCircle, // RequestRejected
  4: Ban, // ActivityCancelled
  5: CheckCircle, // ActivityCompleted
  6: Star, // NewReview
  7: AlertTriangle, // NewReport
};

interface FeedItem {
  key: string;
  icon: LucideIcon;
  title: string;
  message?: string;
  activityTitle?: string;
  isRead: boolean;
  createdAt: string;
  onOpen: () => void;
}

export default function NotificationsPage() {
  const router = useRouter();
  const { data: notifications = [], isLoading: notifLoading, markRead, markAllRead, unreadCount } = useNotifications();
  const { data: chatUnread = [], isLoading: chatLoading, markChatRead } = useChatUnread();

  const isLoading = notifLoading || chatLoading;
  const totalUnreadCount = unreadCount + chatUnread.length;

  const items: FeedItem[] = [
    ...notifications.map((n): FeedItem => ({
      key: `n-${n.id}`,
      icon: NOTIF_ICONS[n.type] ?? Bell,
      title: n.title,
      message: n.message,
      activityTitle: n.relatedActivityTitle,
      isRead: n.isRead,
      createdAt: n.createdAt,
      onOpen: () => {
        if (!n.isRead) markRead.mutate(n.id);
        if (n.relatedActivityId) router.push(`/app/activities/${n.relatedActivityId}`);
      },
    })),
    ...chatUnread.map((c): FeedItem => ({
      key: `c-${c.chatRoomId}`,
      icon: MessageSquare,
      title: `${c.activityTitle} Chat'i`,
      message: `${c.unreadCount} yeni mesaj`,
      isRead: false,
      createdAt: new Date().toISOString(),
      onOpen: () => {
        markChatRead.mutate(c.chatRoomId);
        router.push(`/app/activities/${c.activityId}?chat=1`);
      },
    })),
  ].sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());

  return (
    <AppShell>
      <div style={{ maxWidth: 640, margin: "0 auto", padding: "20px 16px 40px" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 20 }}>
          <h1 style={{ fontSize: 22, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>
            Bildirimler
            {totalUnreadCount > 0 && (
              <span style={{
                marginLeft: 8,
                background: "var(--color-accent)",
                color: "#fff",
                borderRadius: "var(--radius-full)",
                padding: "2px 8px",
                fontSize: 12,
                fontWeight: 600,
              }}>
                {totalUnreadCount}
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
        {!isLoading && items.length === 0 && (
          <EmptyState icon={Bell} title="Henüz bildirim yok" description="Etkinlik istekleri, sohbet mesajları ve güncellemeler burada görünecek." />
        )}

        <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
          {items.map((item) => {
            const Icon = item.icon;
            return (
              <div
                key={item.key}
                onClick={item.onOpen}
                style={{
                  background: item.isRead ? "var(--color-surface)" : "var(--color-accent-soft-bg)",
                  border: `1px solid ${item.isRead ? "var(--color-border)" : "#FFD580"}`,
                  borderRadius: "var(--radius-md)",
                  padding: "14px 16px",
                  display: "flex",
                  gap: 12,
                  cursor: "pointer",
                  transition: "background 0.15s ease",
                }}
              >
                <div style={{
                  width: 36,
                  height: 36,
                  flexShrink: 0,
                  borderRadius: "var(--radius-full)",
                  background: item.isRead ? "#F3F4F6" : "var(--color-surface)",
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                }}>
                  <Icon size={17} color={item.isRead ? "var(--color-muted-foreground)" : "var(--color-accent)"} />
                </div>
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)", marginBottom: 2 }}>{item.title}</div>
                  {item.message && <div style={{ fontSize: 13, color: "var(--color-muted-foreground)" }}>{item.message}</div>}
                  {item.activityTitle && (
                    <div style={{ fontSize: 12, color: "var(--color-accent)", fontWeight: 600, marginTop: 2 }}>{item.activityTitle}</div>
                  )}
                  <div style={{ fontSize: 11, color: "var(--color-subtle-foreground)", marginTop: 4 }}>
                    {new Date(item.createdAt).toLocaleString("tr-TR", {
                      day: "numeric", month: "short", hour: "2-digit", minute: "2-digit",
                    })}
                  </div>
                </div>
                {!item.isRead && (
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
