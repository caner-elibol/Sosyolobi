import type { Activity } from "@/types/user";
import { ActivityStatus } from "@/types/user";
import { getCategoryIcon } from "@/lib/category-icons";
import { formatDistanceMeters } from "@/lib/format";
import Link from "next/link";
import { Calendar, Gift, MapPin, Wallet } from "lucide-react";

interface ActivityCardProps {
  activity: Activity & { distanceMeters?: number };
  compact?: boolean;
}

function formatDate(iso: string) {
  const d = new Date(iso);
  return d.toLocaleDateString("tr-TR", { day: "numeric", month: "short" }) +
    " " + d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
}

export function ActivityCard({ activity, compact = false }: ActivityCardProps) {
  const Icon = getCategoryIcon(activity.categoryName);
  // currentPeopleCount organizatörü de içerir; neededPeopleCount organizatör HARİÇ ihtiyaçtır.
  const missing = activity.neededPeopleCount - (activity.currentPeopleCount - 1);
  const dist = formatDistanceMeters(activity.distanceMeters);

  return (
    <Link href={`/app/activities/${activity.id}`} style={{ textDecoration: "none" }}>
      <div
        className="activity-card"
        style={{
          background: "var(--color-surface)",
          border: "1px solid var(--color-border)",
          borderRadius: compact ? "var(--radius-lg)" : "var(--radius-xl)",
          padding: compact ? "14px 16px" : "20px",
          cursor: "pointer",
          transition: "box-shadow 0.2s var(--ease-out), transform 0.2s var(--ease-out), border-color 0.2s ease",
          display: "flex",
          flexDirection: "column",
          gap: compact ? 8 : 12,
        }}
      >
        <div style={{ display: "flex", alignItems: "flex-start", gap: 12 }}>
          <div style={{
            width: compact ? 36 : 44,
            height: compact ? 36 : 44,
            background: "var(--color-accent-soft-bg)",
            borderRadius: "var(--radius-md)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            flexShrink: 0,
          }}>
            <Icon size={compact ? 18 : 22} color="var(--color-accent-soft-fg)" strokeWidth={2} />
          </div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <h4 style={{
              fontSize: compact ? 14 : 16,
              fontWeight: 600,
              color: "var(--color-foreground)",
              margin: "0 0 2px",
              overflow: "hidden",
              textOverflow: "ellipsis",
              whiteSpace: "nowrap",
            }}>
              {activity.title}
            </h4>
            <p style={{ fontSize: 12, color: "var(--color-muted-foreground)", margin: 0 }}>
              {activity.createdByDisplayName}
            </p>
          </div>
        </div>

        <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
          {activity.status === ActivityStatus.Full
            ? <Chip accent>Dolu</Chip>
            : <Chip tone="success">Aktif</Chip>}
          <Chip icon={<Calendar size={11} />}>{formatDate(activity.eventDate)}</Chip>
          {dist && <Chip icon={<MapPin size={11} />}>{dist}</Chip>}
          {missing > 0 && <Chip accent>{missing} kişi eksik</Chip>}
          {activity.pricePerPerson && activity.pricePerPerson > 0 ? (
            <Chip icon={<Wallet size={11} />}>{activity.pricePerPerson}₺</Chip>
          ) : (
            <Chip icon={<Gift size={11} />}>Ücretsiz</Chip>
          )}
        </div>
      </div>
      <style>{`
        .activity-card:hover { box-shadow: var(--shadow-md); border-color: transparent; }
      `}</style>
    </Link>
  );
}

function Chip({ children, accent, tone, icon }: { children: React.ReactNode; accent?: boolean; tone?: "success"; icon?: React.ReactNode }) {
  const background = accent ? "var(--color-accent-soft-bg)" : tone === "success" ? "var(--color-success-bg)" : "#F3F4F6";
  const color = accent ? "var(--color-accent-soft-fg)" : tone === "success" ? "var(--color-success)" : "var(--color-muted-foreground)";
  return (
    <span style={{
      display: "inline-flex",
      alignItems: "center",
      gap: 4,
      padding: "3px 8px",
      borderRadius: "var(--radius-full)",
      fontSize: 11,
      fontWeight: 500,
      background,
      color,
      whiteSpace: "nowrap",
    }}>
      {icon}
      {children}
    </span>
  );
}
