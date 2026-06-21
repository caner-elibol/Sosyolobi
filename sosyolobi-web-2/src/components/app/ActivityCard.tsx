import type { Activity } from "@/types/user";
import { CATEGORY_ICONS } from "@/lib/category-icons";
import Link from "next/link";

interface ActivityCardProps {
  activity: Activity & { distanceMeters?: number };
  compact?: boolean;
}

function formatDate(iso: string) {
  const d = new Date(iso);
  return d.toLocaleDateString("tr-TR", { day: "numeric", month: "short" }) +
    " " + d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
}

function formatDistance(m?: number) {
  if (!m) return null;
  return m < 1000 ? `${Math.round(m)} m` : `${(m / 1000).toFixed(1)} km`;
}

export function ActivityCard({ activity, compact = false }: ActivityCardProps) {
  const icon = CATEGORY_ICONS[activity.categoryName] ?? "📍";
  const missing = activity.neededPeopleCount - activity.currentPeopleCount;
  const dist = formatDistance(activity.distanceMeters);

  return (
    <Link href={`/app/activities/${activity.id}`} style={{ textDecoration: "none" }}>
      <div style={{
        background: "#fff",
        border: "1px solid #EEF2F7",
        borderRadius: compact ? 16 : 20,
        padding: compact ? "14px 16px" : "20px",
        cursor: "pointer",
        transition: "box-shadow 0.15s ease",
        display: "flex",
        flexDirection: "column",
        gap: compact ? 8 : 12,
      }}
        onMouseEnter={(e) => (e.currentTarget.style.boxShadow = "0 4px 20px rgba(8,27,75,0.1)")}
        onMouseLeave={(e) => (e.currentTarget.style.boxShadow = "none")}
      >
        <div style={{ display: "flex", alignItems: "flex-start", gap: 12 }}>
          <div style={{
            width: compact ? 36 : 44,
            height: compact ? 36 : 44,
            background: "#FFF7ED",
            borderRadius: 12,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            fontSize: compact ? 18 : 22,
            flexShrink: 0,
          }}>
            {icon}
          </div>
          <div style={{ flex: 1, minWidth: 0 }}>
            <h4 style={{
              fontSize: compact ? 14 : 16,
              fontWeight: 600,
              color: "#111827",
              margin: "0 0 2px",
              overflow: "hidden",
              textOverflow: "ellipsis",
              whiteSpace: "nowrap",
            }}>
              {activity.title}
            </h4>
            <p style={{ fontSize: 12, color: "#6B7280", margin: 0 }}>
              {activity.createdByDisplayName}
            </p>
          </div>
        </div>

        <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
          <Chip>📅 {formatDate(activity.eventDate)}</Chip>
          {dist && <Chip>📍 {dist}</Chip>}
          {missing > 0 && <Chip accent>{missing} kişi eksik</Chip>}
          {activity.pricePerPerson && activity.pricePerPerson > 0 ? (
            <Chip>💰 {activity.pricePerPerson}₺</Chip>
          ) : (
            <Chip>🆓 Ücretsiz</Chip>
          )}
        </div>
      </div>
    </Link>
  );
}

function Chip({ children, accent }: { children: React.ReactNode; accent?: boolean }) {
  return (
    <span style={{
      display: "inline-flex",
      alignItems: "center",
      gap: 3,
      padding: "3px 8px",
      borderRadius: 20,
      fontSize: 11,
      fontWeight: 500,
      background: accent ? "#FFF7ED" : "#F3F4F6",
      color: accent ? "#FF9D23" : "#6B7280",
      whiteSpace: "nowrap",
    }}>
      {children}
    </span>
  );
}
