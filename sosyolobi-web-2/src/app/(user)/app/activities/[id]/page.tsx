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
import { getCategoryIcon } from "@/lib/category-icons";
import { formatDistanceMeters } from "@/lib/format";
import { ActivityStatus } from "@/types/user";
import { getUserFromToken } from "@/lib/user-auth";
import {
  Calendar,
  CircleDot,
  Gift,
  Key,
  MapPin,
  Target,
  Users,
  VenusAndMars,
  Wallet,
  XCircle,
  type LucideIcon,
} from "lucide-react";

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
  if (error || !activity) return <AppShell><EmptyState icon={XCircle} title="Etkinlik bulunamadı" /></AppShell>;

  const CategoryIcon = getCategoryIcon(activity.categoryName);
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
          background: "var(--color-surface)",
          borderRadius: "var(--radius-lg)",
          padding: 18,
          border: "1px solid var(--color-border)",
          marginBottom: 12,
        }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 10 }}>
            <div style={{
              width: 44,
              height: 44,
              background: "var(--color-accent-soft-bg)",
              borderRadius: "var(--radius-md)",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              flexShrink: 0,
            }}>
              <CategoryIcon size={22} color="var(--color-accent-soft-fg)" strokeWidth={2} />
            </div>
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 11, color: "var(--color-muted-foreground)", marginBottom: 1 }}>{activity.categoryName}</div>
              <h1 style={{ fontSize: 18, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>{activity.title}</h1>
            </div>
          </div>

          {/* Info chips */}
          <div style={{ display: "flex", flexWrap: "wrap", gap: 6, marginBottom: 10 }}>
            {isFull ? <InfoChip icon={CircleDot} tone="muted">Dolu</InfoChip> : <InfoChip icon={CircleDot} tone="success">Aktif</InfoChip>}
            <InfoChip icon={Calendar}>{formatDate(activity.eventDate)}</InfoChip>
            {dist && <InfoChip icon={MapPin}>{dist} uzakta</InfoChip>}
            <InfoChip icon={Users}>{missing > 0 ? `${missing} kişi eksik` : "Kontenjan doldu"}</InfoChip>
            {activity.pricePerPerson && activity.pricePerPerson > 0
              ? <InfoChip icon={Wallet}>{activity.pricePerPerson}₺ kişi başı</InfoChip>
              : <InfoChip icon={Gift}>Ücretsiz</InfoChip>
            }
            <InfoChip icon={Target}>{SKILL_LABELS[activity.skillLevel] ?? "Herkes"}</InfoChip>
            <InfoChip icon={VenusAndMars}>{GENDER_LABELS[activity.genderPreference] ?? "Herkes"}</InfoChip>
          </div>

          {/* Address */}
          <div style={{
            background: "#F9FAFB",
            borderRadius: "var(--radius-sm)",
            padding: "10px 14px",
            marginBottom: activity.description ? 10 : 0,
          }}>
            <div style={{ display: "flex", alignItems: "center", gap: 5, fontSize: 12, fontWeight: 600, color: "#374151", marginBottom: 2 }}>
              <MapPin size={13} /> Yaklaşık Konum
            </div>
            <div style={{ fontSize: 13, color: "var(--color-muted-foreground)" }}>{activity.addressText}</div>
            {activity.addressDetailPrivate && (
              <div style={{ display: "flex", alignItems: "center", gap: 5, fontSize: 12, color: "var(--color-success)", marginTop: 4 }}>
                <Key size={12} /> {activity.addressDetailPrivate}
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
          background: "var(--color-surface)",
          borderRadius: "var(--radius-lg)",
          padding: 16,
          border: "1px solid var(--color-border)",
          marginBottom: 12,
        }}>
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: activity.participants.length > 0 ? 12 : 0 }}>
            <UserAvatar displayName={activity.createdByDisplayName} avatarUrl={activity.createdByAvatarUrl} size={40} />
            <div style={{ flex: 1 }}>
              <div style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>Oluşturan</div>
              <div style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)" }}>{activity.createdByDisplayName}</div>
            </div>
            {currentUserId && currentUserId !== activity.createdByUserId && (
              <ParticipantActionsMenu userId={activity.createdByUserId} displayName={activity.createdByDisplayName} />
            )}
          </div>

          {activity.participants.length > 0 && (
            <>
              <div style={{ fontSize: 12, fontWeight: 600, color: "var(--color-muted-foreground)", margin: "0 0 8px" }}>
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
            background: "var(--color-surface)",
            borderRadius: "var(--radius-lg)",
            padding: 16,
            border: "1px solid var(--color-border)",
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
                    border: "1px solid var(--color-border)",
                    borderRadius: "var(--radius-sm)",
                    fontSize: 14,
                    resize: "none",
                    outline: "none",
                    boxSizing: "border-box",
                    fontFamily: "inherit",
                  }}
                />
                <div style={{ display: "flex", gap: 8 }}>
                  <button
                    onClick={handleJoin}
                    disabled={join.isPending}
                    style={{
                      flex: 1,
                      padding: "12px",
                      background: "var(--color-accent)",
                      color: "#fff",
                      border: "none",
                      borderRadius: "var(--radius-md)",
                      fontSize: 14,
                      fontWeight: 600,
                      cursor: join.isPending ? "default" : "pointer",
                      opacity: join.isPending ? 0.7 : 1,
                    }}
                  >
                    {join.isPending ? "Gönderiliyor..." : "İstek Gönder"}
                  </button>
                  <button
                    onClick={() => setShowMessageInput(false)}
                    style={{
                      padding: "12px 16px",
                      background: "none",
                      border: "1px solid var(--color-border)",
                      borderRadius: "var(--radius-md)",
                      fontSize: 14,
                      cursor: "pointer",
                      color: "var(--color-muted-foreground)",
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
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "center",
                  gap: 8,
                  width: "100%",
                  padding: "14px",
                  background: "var(--color-accent)",
                  color: "#fff",
                  border: "none",
                  borderRadius: "var(--radius-md)",
                  fontSize: 15,
                  fontWeight: 600,
                  cursor: "pointer",
                }}
              >
                <Users size={17} /> Katılmak İstiyorum
              </button>
            )}
          </div>
        )}

        {isFull && (
          <div style={{
            background: "#F3F4F6",
            borderRadius: "var(--radius-md)",
            padding: "14px 20px",
            textAlign: "center",
            color: "var(--color-muted-foreground)",
            fontSize: 14,
            marginBottom: 12,
          }}>
            Kontenjan doldu
          </div>
        )}

        {isCancelled && (
          <div style={{
            background: "var(--color-destructive-bg)",
            borderRadius: "var(--radius-md)",
            padding: "14px 20px",
            textAlign: "center",
            color: "var(--color-destructive)",
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

function InfoChip({ icon: Icon, children, tone }: { icon: LucideIcon; children: React.ReactNode; tone?: "success" | "muted" }) {
  const color = tone === "success" ? "var(--color-success)" : tone === "muted" ? "var(--color-muted-foreground)" : "#374151";
  const background = tone === "success" ? "var(--color-success-bg)" : "#F3F4F6";
  return (
    <span style={{
      display: "inline-flex",
      alignItems: "center",
      gap: 4,
      padding: "4px 9px",
      background,
      borderRadius: "var(--radius-full)",
      fontSize: 11,
      color,
      fontWeight: tone ? 600 : 400,
    }}>
      <Icon size={11} /> {children}
    </span>
  );
}
