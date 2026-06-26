"use client";

import { useState } from "react";
import { use } from "react";
import { toast } from "sonner";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { ChatPanel } from "@/components/app/ChatPanel";
import { ParticipantActionsMenu } from "@/components/app/ParticipantActionsMenu";
import { useActivity } from "@/hooks/useCreateActivity";
import { useJoinRequest } from "@/hooks/useJoinRequest";
import { CATEGORY_ICONS } from "@/lib/category-icons";
import { formatDistanceMeters } from "@/lib/format";
import { ActivityStatus } from "@/types/user";
import { getUserFromToken } from "@/lib/user-auth";

const SKILL_LABELS: Record<number, string> = {
  0: "Herkes", 1: "Başlangıç", 2: "Orta", 3: "İleri",
};
const GENDER_LABELS: Record<number, string> = {
  0: "Herkes", 1: "Erkek", 2: "Kadın", 3: "Karışık",
};

function formatDate(iso: string) {
  const d = new Date(iso);
  return d.toLocaleDateString("tr-TR", { weekday: "long", day: "numeric", month: "long", year: "numeric" }) +
    " " + d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
}

export default function ActivityDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = use(params);
  const { data: activity, isLoading, error } = useActivity(id);
  const { join, cancel } = useJoinRequest(id);
  const [joinMessage, setJoinMessage] = useState("");
  const [showMessageInput, setShowMessageInput] = useState(false);

  if (isLoading) return <AppShell><LoadingState message="Etkinlik yükleniyor..." /></AppShell>;
  if (error || !activity) return <AppShell><EmptyState icon="❌" title="Etkinlik bulunamadı" /></AppShell>;

  const icon = CATEGORY_ICONS[activity.categoryName] ?? "📍";
  // currentPeopleCount organizatörü de içerir; neededPeopleCount organizatör HARİÇ ihtiyaçtır.
  const missing = activity.neededPeopleCount - (activity.currentPeopleCount - 1);
  const dist = formatDistanceMeters(activity.distanceMeters);
  const isCancelled = activity.status === ActivityStatus.Cancelled;
  const isFull = activity.status === ActivityStatus.Full;
  const currentUserId = getUserFromToken()?.sub;
  const isParticipant = !!currentUserId && activity.participants.some((p) => p.userId === currentUserId);

  async function handleJoin() {
    try {
      await join.mutateAsync(joinMessage || undefined);
      toast.success("Katılım isteği gönderildi!");
      setShowMessageInput(false);
      setJoinMessage("");
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "İstek gönderilemedi.");
    }
  }

  return (
    <AppShell>
      <div style={{ maxWidth: 680, margin: "0 auto", padding: "16px 16px 32px" }}>
        {/* Header */}
        <div style={{
          background: "#fff",
          borderRadius: 16,
          padding: 18,
          border: "1px solid #EEF2F7",
          marginBottom: 12,
        }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 10 }}>
            <div style={{
              width: 44,
              height: 44,
              background: "#FFF7ED",
              borderRadius: 12,
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: 22,
              flexShrink: 0,
            }}>
              {icon}
            </div>
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 11, color: "#6B7280", marginBottom: 1 }}>{activity.categoryName}</div>
              <h1 style={{ fontSize: 18, fontWeight: 700, color: "#111827", margin: 0 }}>{activity.title}</h1>
            </div>
          </div>

          {/* Info chips */}
          <div style={{ display: "flex", flexWrap: "wrap", gap: 6, marginBottom: 10 }}>
            {isFull ? <InfoChip icon="🔵">Dolu</InfoChip> : <InfoChip icon="🟢">Aktif</InfoChip>}
            <InfoChip icon="📅">{formatDate(activity.eventDate)}</InfoChip>
            {dist && <InfoChip icon="📍">{dist} uzakta</InfoChip>}
            <InfoChip icon="👥">{missing > 0 ? `${missing} kişi eksik` : "Kontenjan doldu"}</InfoChip>
            {activity.pricePerPerson && activity.pricePerPerson > 0
              ? <InfoChip icon="💰">{activity.pricePerPerson}₺ kişi başı</InfoChip>
              : <InfoChip icon="🆓">Ücretsiz</InfoChip>
            }
            <InfoChip icon="🎯">{SKILL_LABELS[activity.skillLevel] ?? "Herkes"}</InfoChip>
            <InfoChip icon="⚧">{GENDER_LABELS[activity.genderPreference] ?? "Herkes"}</InfoChip>
          </div>

          {/* Address */}
          <div style={{
            background: "#F9FAFB",
            borderRadius: 10,
            padding: "10px 14px",
            marginBottom: activity.description ? 10 : 0,
          }}>
            <div style={{ fontSize: 12, fontWeight: 600, color: "#374151", marginBottom: 2 }}>📍 Yaklaşık Konum</div>
            <div style={{ fontSize: 13, color: "#6B7280" }}>{activity.addressText}</div>
            {activity.addressDetailPrivate && (
              <div style={{ fontSize: 12, color: "#22C55E", marginTop: 4 }}>
                🔑 {activity.addressDetailPrivate}
              </div>
            )}
          </div>

          {/* Description */}
          {activity.description && (
            <div style={{ fontSize: 13, color: "#374151", lineHeight: 1.5 }}>
              {activity.description}
            </div>
          )}
        </div>

        {/* Creator + Participants */}
        <div style={{
          background: "#fff",
          borderRadius: 16,
          padding: 16,
          border: "1px solid #EEF2F7",
          marginBottom: 12,
        }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: activity.participants.length > 0 ? 12 : 0 }}>
            <UserAvatar displayName={activity.createdByDisplayName} avatarUrl={activity.createdByAvatarUrl} size={40} />
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 11, color: "#6B7280" }}>Oluşturan</div>
              <div style={{ fontSize: 14, fontWeight: 600, color: "#111827" }}>{activity.createdByDisplayName}</div>
            </div>
            {currentUserId && currentUserId !== activity.createdByUserId && (
              <ParticipantActionsMenu userId={activity.createdByUserId} displayName={activity.createdByDisplayName} />
            )}
          </div>

          {activity.participants.length > 0 && (
            <>
              <div style={{ fontSize: 12, fontWeight: 600, color: "#6B7280", margin: "0 0 8px" }}>
                Katılımcılar ({activity.participants.length})
              </div>
              <div style={{ display: "flex", flexDirection: "column", gap: 8 }}>
                {activity.participants.map((p) => (
                  <div key={p.userId} style={{ display: "flex", alignItems: "center", gap: 6 }}>
                    <UserAvatar displayName={p.displayName} avatarUrl={p.avatarUrl} size={28} />
                    <span style={{ fontSize: 12, color: "#374151", flex: 1 }}>{p.displayName}</span>
                    {currentUserId && currentUserId !== p.userId && (
                      <ParticipantActionsMenu userId={p.userId} displayName={p.displayName} />
                    )}
                  </div>
                ))}
              </div>
            </>
          )}
        </div>

        {/* Join CTA */}
        {!isCancelled && !isFull && !isParticipant && (
          <div style={{
            background: "#fff",
            borderRadius: 16,
            padding: 16,
            border: "1px solid #EEF2F7",
            marginBottom: 12,
          }}>
            {showMessageInput ? (
              <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>
                <textarea
                  value={joinMessage}
                  onChange={(e) => setJoinMessage(e.target.value)}
                  placeholder="Kendinizi tanıtın (opsiyonel)..."
                  rows={3}
                  style={{
                    width: "100%",
                    padding: "10px 14px",
                    border: "1px solid #EEF2F7",
                    borderRadius: 10,
                    fontSize: 14,
                    resize: "none",
                    outline: "none",
                    boxSizing: "border-box",
                  }}
                />
                <div style={{ display: "flex", gap: 8 }}>
                  <button
                    onClick={handleJoin}
                    disabled={join.isPending}
                    style={{
                      flex: 1,
                      padding: "12px",
                      background: "#FF9D23",
                      color: "#fff",
                      border: "none",
                      borderRadius: 12,
                      fontSize: 14,
                      fontWeight: 600,
                      cursor: "pointer",
                    }}
                  >
                    {join.isPending ? "Gönderiliyor..." : "İstek Gönder"}
                  </button>
                  <button
                    onClick={() => setShowMessageInput(false)}
                    style={{
                      padding: "12px 16px",
                      background: "none",
                      border: "1px solid #EEF2F7",
                      borderRadius: 12,
                      fontSize: 14,
                      cursor: "pointer",
                      color: "#6B7280",
                    }}
                  >
                    İptal
                  </button>
                </div>
              </div>
            ) : (
              <button
                onClick={() => setShowMessageInput(true)}
                style={{
                  width: "100%",
                  padding: "14px",
                  background: "#FF9D23",
                  color: "#fff",
                  border: "none",
                  borderRadius: 12,
                  fontSize: 15,
                  fontWeight: 600,
                  cursor: "pointer",
                }}
              >
                🙋 Katılmak İstiyorum
              </button>
            )}
          </div>
        )}

        {isFull && (
          <div style={{
            background: "#F3F4F6",
            borderRadius: 12,
            padding: "14px 20px",
            textAlign: "center",
            color: "#6B7280",
            fontSize: 14,
            marginBottom: 12,
          }}>
            Kontenjan doldu
          </div>
        )}

        {isCancelled && (
          <div style={{
            background: "#FEF2F2",
            borderRadius: 12,
            padding: "14px 20px",
            textAlign: "center",
            color: "#EF4444",
            fontSize: 14,
            marginBottom: 12,
          }}>
            Bu etkinlik iptal edildi
          </div>
        )}

        {/* Chat */}
        {isParticipant && <ChatPanel activityId={id} />}
      </div>
    </AppShell>
  );
}

function InfoChip({ icon, children }: { icon: string; children: React.ReactNode }) {
  return (
    <span style={{
      display: "inline-flex",
      alignItems: "center",
      gap: 4,
      padding: "4px 9px",
      background: "#F3F4F6",
      borderRadius: 20,
      fontSize: 11,
      color: "#374151",
    }}>
      {icon} {children}
    </span>
  );
}
