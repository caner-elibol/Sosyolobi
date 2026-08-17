"use client";

import { Suspense, useEffect, useRef, useState } from "react";
import { use } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import Link from "next/link";
import { toast } from "sonner";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { ChatPanel } from "@/components/app/ChatPanel";
import { ParticipantActionsMenu } from "@/components/app/ParticipantActionsMenu";
import { useActivity } from "@/hooks/useCreateActivity";
import { useJoinRequest } from "@/hooks/useJoinRequest";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";
import { formatDistanceMeters } from "@/lib/format";
import { ActivityStatus } from "@/types/user";
import { getUserFromToken } from "@/lib/user-auth";
import {
  ArrowLeft,
  Calendar,
  Gift,
  Key,
  MapPin,
  Star,
  Target,
  Users,
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
  const today = new Date();
  const isToday = d.toDateString() === today.toDateString();
  const day = isToday ? "Bugün" : d.toLocaleDateString("tr-TR", { weekday: "long", day: "numeric", month: "long" });
  return `${day} ${d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" })}`;
}

export default function ActivityDetailPage({ params }: { params: Promise<{ id: string }> }) {
  return (
    <Suspense fallback={<AppShell><LoadingState message="Etkinlik yükleniyor..." /></AppShell>}>
      <ActivityDetailPageInner params={params} />
    </Suspense>
  );
}

function ActivityDetailPageInner({ params }: { params: Promise<{ id: string }> }) {
  const { id } = use(params);
  const router = useRouter();
  const searchParams = useSearchParams();
  const { data: activity, isLoading, error } = useActivity(id);
  const { join } = useJoinRequest(id);
  const [joinMessage, setJoinMessage] = useState("");
  const [showMessageInput, setShowMessageInput] = useState(false);
  const chatRef = useRef<HTMLDivElement>(null);

  const shouldFocusChat = searchParams.get("chat") === "1";

  useEffect(() => {
    if (!shouldFocusChat || !activity) return;
    const timer = setTimeout(() => {
      chatRef.current?.scrollIntoView({ behavior: "smooth", block: "start" });
    }, 200);
    return () => clearTimeout(timer);
  }, [shouldFocusChat, activity]);

  if (isLoading) return <AppShell><LoadingState message="Etkinlik yükleniyor..." /></AppShell>;
  if (error || !activity) return <AppShell><EmptyState icon={XCircle} title="Etkinlik bulunamadı" /></AppShell>;

  const CategoryIcon = getCategoryIcon(activity.categoryName);
  const categoryColor = getCategoryColor(activity.categoryName);
  const totalSpots = activity.neededPeopleCount + 1;
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
      <div style={{ maxWidth: 680, margin: "0 auto", padding: "0 0 32px" }}>
        {/* Hero */}
        <div style={{
          position: "relative",
          height: 180,
          background: `linear-gradient(135deg, ${categoryColor} 0%, color-mix(in srgb, ${categoryColor} 70%, black) 100%)`,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        }}>
          <button
            onClick={() => router.back()}
            aria-label="Geri"
            style={{
              position: "absolute",
              top: 16,
              left: 16,
              width: 36,
              height: 36,
              borderRadius: "50%",
              background: "rgba(255,255,255,0.92)",
              border: "none",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              cursor: "pointer",
              boxShadow: "var(--shadow-md)",
            }}
          >
            <ArrowLeft size={18} color="var(--color-foreground)" />
          </button>
          <CategoryIcon size={56} color="rgba(255,255,255,0.85)" strokeWidth={1.75} />
        </div>

        <div style={{ padding: "16px 16px 0" }}>
          {/* Category + status */}
          <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 10 }}>
            <span style={{
              display: "inline-flex",
              alignItems: "center",
              gap: 5,
              padding: "3px 10px 3px 8px",
              borderRadius: "var(--radius-full)",
              background: `color-mix(in srgb, ${categoryColor} 14%, white)`,
              color: categoryColor,
              fontSize: 12,
              fontWeight: 600,
            }}>
              <span style={{ width: 6, height: 6, borderRadius: "50%", background: categoryColor }} />
              {activity.categoryName}
            </span>
            {isCancelled ? (
              <InfoChip icon={XCircle} tone="muted">İptal edildi</InfoChip>
            ) : isFull ? (
              <InfoChip icon={Users} tone="muted">Dolu</InfoChip>
            ) : (
              <InfoChip icon={Users} tone="success">Açık</InfoChip>
            )}
          </div>

          <h1 style={{ fontSize: 21, fontWeight: 700, color: "var(--color-foreground)", margin: "0 0 10px" }}>{activity.title}</h1>

          <div style={{ display: "flex", flexDirection: "column", gap: 7, marginBottom: 12 }}>
            <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, fontWeight: 600, color: "var(--color-accent)" }}>
              <Calendar size={14} /> {formatDate(activity.eventDate)}
            </div>
            <div style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 13, color: "var(--color-muted-foreground)" }}>
              <MapPin size={14} /> {activity.addressText}
              {dist && <span>· {dist}</span>}
            </div>
          </div>

          {/* Participants + skill/gender chips */}
          <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 10, flexWrap: "wrap" }}>
            {activity.participants.length > 0 && (
              <div style={{ display: "flex", marginLeft: 4 }}>
                {activity.participants.slice(0, 4).map((p, i) => (
                  <span key={p.userId} style={{ marginLeft: i === 0 ? 0 : -8, border: "2px solid var(--color-background)", borderRadius: "50%" }}>
                    <UserAvatar displayName={p.displayName} avatarUrl={p.avatarUrl} size={26} />
                  </span>
                ))}
              </div>
            )}
            <span style={{ fontSize: 13, fontWeight: 600, color: "var(--color-foreground)" }}>
              {activity.currentPeopleCount} / {totalSpots} katılıyor
            </span>
          </div>

          <div style={{ display: "flex", flexWrap: "wrap", gap: 6, marginBottom: 16 }}>
            <InfoChip icon={Target}>{SKILL_LABELS[activity.skillLevel] ?? "Herkes"}</InfoChip>
            <InfoChip icon={Users}>{GENDER_LABELS[activity.genderPreference] ?? "Herkes"}</InfoChip>
          </div>

          {/* About */}
          {activity.description && (
            <>
              <SectionTitle>Hakkında</SectionTitle>
              <p style={{ fontSize: 13, color: "#374151", lineHeight: 1.6, margin: "0 0 16px" }}>{activity.description}</p>
            </>
          )}

          {/* Details grid */}
          <SectionTitle>Detaylar</SectionTitle>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10, marginBottom: 16 }}>
            <DetailBox icon={Wallet} label="Kişi Başı Ücret" value={activity.pricePerPerson && activity.pricePerPerson > 0 ? `${activity.pricePerPerson} ₺` : "Ücretsiz"} />
            <DetailBox icon={Users} label="Kontenjan" value={`${totalSpots} kişi`} />
            <DetailBox icon={Users} label="Şu an" value={`${activity.currentPeopleCount} kişi`} />
            <DetailBox icon={Target} label="Seviye" value={SKILL_LABELS[activity.skillLevel] ?? "Herkes"} />
          </div>

          {/* Owner */}
          <SectionTitle>Etkinlik Sahibi</SectionTitle>
          <div style={{
            background: "var(--color-surface)",
            borderRadius: "var(--radius-lg)",
            padding: 14,
            border: "1px solid var(--color-border)",
            marginBottom: 16,
            display: "flex",
            alignItems: "center",
            gap: 10,
          }}>
            <UserAvatar displayName={activity.createdByDisplayName} avatarUrl={activity.createdByAvatarUrl} size={42} />
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)" }}>{activity.createdByDisplayName}</div>
              <div style={{ display: "flex", alignItems: "center", gap: 3, fontSize: 12, color: "var(--color-muted-foreground)" }}>
                <Star size={12} fill="#F59E0B" color="#F59E0B" strokeWidth={0} /> Etkinlik sahibi
              </div>
            </div>
            {currentUserId && currentUserId !== activity.createdByUserId && (
              <ParticipantActionsMenu userId={activity.createdByUserId} displayName={activity.createdByDisplayName} />
            )}
          </div>

          {/* Location */}
          {activity.addressDetailPrivate && (
            <>
              <SectionTitle>Konum</SectionTitle>
              <div style={{
                background: "#F9FAFB",
                borderRadius: "var(--radius-lg)",
                padding: "12px 14px",
                marginBottom: 16,
              }}>
                <div style={{ display: "flex", alignItems: "center", gap: 5, fontSize: 12, fontWeight: 600, color: "var(--color-success)" }}>
                  <Key size={12} /> {activity.addressDetailPrivate}
                </div>
                <p style={{ fontSize: 11, color: "var(--color-muted-foreground)", margin: "4px 0 0" }}>
                  Bu adres detayı sadece onaylı katılımcılara gösterilir.
                </p>
              </div>
            </>
          )}

          {/* Participants list */}
          {activity.participants.length > 0 && (
            <>
              <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginBottom: 8 }}>
                <SectionTitle noMargin>Katılımcılar</SectionTitle>
                <span style={{ fontSize: 12, color: "var(--color-muted-foreground)" }}>{activity.participants.length} kişi</span>
              </div>
              <div style={{
                background: "var(--color-surface)",
                borderRadius: "var(--radius-lg)",
                border: "1px solid var(--color-border)",
                marginBottom: 16,
                overflow: "hidden",
              }}>
                {activity.participants.map((p, i) => (
                  <div key={p.userId} style={{
                    display: "flex",
                    alignItems: "center",
                    gap: 8,
                    padding: "10px 14px",
                    borderTop: i === 0 ? "none" : "1px solid var(--color-border)",
                  }}>
                    <Link
                      href={`/app/profile/${p.userId}`}
                      style={{ display: "flex", alignItems: "center", gap: 8, flex: 1, minWidth: 0, textDecoration: "none" }}
                    >
                      <UserAvatar displayName={p.displayName} avatarUrl={p.avatarUrl} size={28} />
                      <span style={{ fontSize: 13, color: "var(--color-foreground)", fontWeight: 500 }}>{p.displayName}</span>
                    </Link>
                    {currentUserId && currentUserId !== p.userId && (
                      <ParticipantActionsMenu userId={p.userId} displayName={p.displayName} />
                    )}
                  </div>
                ))}
              </div>
            </>
          )}
        </div>

        <div style={{ padding: "0 16px" }}>
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
        {isParticipant && <div ref={chatRef}><ChatPanel activityId={id} /></div>}
        </div>
      </div>
    </AppShell>
  );
}

function SectionTitle({ children, noMargin }: { children: React.ReactNode; noMargin?: boolean }) {
  return (
    <h2 style={{ fontSize: 15, fontWeight: 700, color: "var(--color-foreground)", margin: noMargin ? 0 : "0 0 10px" }}>
      {children}
    </h2>
  );
}

function DetailBox({ icon: Icon, label, value }: { icon: LucideIcon; label: string; value: string }) {
  return (
    <div style={{ background: "#F9FAFB", borderRadius: "var(--radius-md)", padding: "12px 14px" }}>
      <div style={{ display: "flex", alignItems: "center", gap: 5, fontSize: 11, color: "var(--color-muted-foreground)", marginBottom: 4 }}>
        <Icon size={12} /> {label}
      </div>
      <div style={{ fontSize: 15, fontWeight: 700, color: "var(--color-foreground)" }}>{value}</div>
    </div>
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
