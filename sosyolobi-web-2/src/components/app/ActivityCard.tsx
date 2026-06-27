import type { Activity } from "@/types/user";
import { ActivityStatus } from "@/types/user";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";
import { formatDistanceMeters } from "@/lib/format";
import { UserAvatar } from "@/components/app/UserAvatar";
import Link from "next/link";
import { Clock, MapPin, Users } from "lucide-react";

interface ActivityCardProps {
  activity: Activity & { distanceMeters?: number };
  compact?: boolean;
  categoryColor?: string;
  variant?: "horizontal" | "vertical";
}

function formatDate(iso: string) {
  const d = new Date(iso);
  const today = new Date();
  const isToday = d.toDateString() === today.toDateString();
  const time = d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
  if (isToday) return `Bugün ${time}`;
  return d.toLocaleDateString("tr-TR", { day: "numeric", month: "short" }) + " " + time;
}

export function ActivityCard({ activity, compact = false, categoryColor, variant = "horizontal" }: ActivityCardProps) {
  const Icon = getCategoryIcon(activity.categoryName);
  const color = getCategoryColor(activity.categoryName, categoryColor);
  const dist = formatDistanceMeters(activity.distanceMeters);
  const isFull = activity.status === ActivityStatus.Full;
  const hasParticipantData = typeof activity.currentPeopleCount === "number";

  const categoryBadge = (
    <span style={{
      display: "inline-flex",
      alignItems: "center",
      gap: 5,
      alignSelf: "flex-start",
      padding: "2px 9px 2px 7px",
      borderRadius: "var(--radius-full)",
      background: `color-mix(in srgb, ${color} 14%, white)`,
      color,
      fontSize: 11,
      fontWeight: 600,
    }}>
      <span style={{ width: 6, height: 6, borderRadius: "50%", background: color, flexShrink: 0 }} />
      {activity.categoryName}
    </span>
  );

  const participantsRow = (
    <div style={{ display: "flex", alignItems: "center", gap: 6, marginTop: 2 }}>
      {activity.createdByDisplayName ? (
        <UserAvatar displayName={activity.createdByDisplayName} avatarUrl={activity.createdByAvatarUrl} size={20} />
      ) : (
        <Users size={14} color="var(--color-subtle-foreground)" />
      )}
      <span style={{ fontSize: 12, color: "var(--color-muted-foreground)", fontWeight: 500 }}>
        {hasParticipantData
          ? `${activity.currentPeopleCount} / ${activity.neededPeopleCount + 1} katılıyor`
          : `${activity.neededPeopleCount} kişi aranıyor`}
      </span>
    </div>
  );

  if (variant === "vertical") {
    return (
      <Link href={`/app/activities/${activity.id}`} style={{ textDecoration: "none" }}>
        <div
          className="activity-card"
          style={{
            background: "var(--color-surface)",
            border: "1px solid var(--color-border)",
            borderRadius: "var(--radius-lg)",
            overflow: "hidden",
            cursor: "pointer",
            transition: "box-shadow 0.2s var(--ease-out), border-color 0.2s ease",
          }}
        >
          <div style={{
            height: 120,
            background: `linear-gradient(135deg, color-mix(in srgb, ${color} 22%, white) 0%, color-mix(in srgb, ${color} 10%, white) 100%)`,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}>
            <Icon size={34} color={color} strokeWidth={1.75} />
          </div>
          <div style={{ padding: 12, display: "flex", flexDirection: "column", gap: 5 }}>
            {categoryBadge}
            <h4 style={{
              fontSize: 14,
              fontWeight: 700,
              color: "var(--color-foreground)",
              margin: 0,
              overflow: "hidden",
              textOverflow: "ellipsis",
              whiteSpace: "nowrap",
            }}>
              {activity.title}
            </h4>
            <Row icon={<Clock size={12} />} color="var(--color-accent)">
              {formatDate(activity.eventDate)}
              {isFull && <span style={{ color: "var(--color-destructive)", fontWeight: 600, marginLeft: 6 }}>· Dolu</span>}
            </Row>
            <Row icon={<MapPin size={12} />} color="var(--color-muted-foreground)">
              {dist || activity.addressText || "Konum"}
            </Row>
            {participantsRow}
          </div>
        </div>
        <style>{`
          .activity-card:hover { box-shadow: var(--shadow-md); border-color: transparent; }
        `}</style>
      </Link>
    );
  }

  return (
    <Link href={`/app/activities/${activity.id}`} style={{ textDecoration: "none" }}>
      <div
        className="activity-card"
        style={{
          background: "var(--color-surface)",
          border: "1px solid var(--color-border)",
          borderRadius: "var(--radius-lg)",
          padding: compact ? 12 : 14,
          cursor: "pointer",
          transition: "box-shadow 0.2s var(--ease-out), border-color 0.2s ease",
          display: "flex",
          gap: 12,
        }}
      >
        <div style={{
          width: compact ? 56 : 64,
          height: compact ? 56 : 64,
          borderRadius: "var(--radius-md)",
          background: `color-mix(in srgb, ${color} 14%, white)`,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          flexShrink: 0,
        }}>
          <Icon size={compact ? 22 : 26} color={color} strokeWidth={2} />
        </div>

        <div style={{ flex: 1, minWidth: 0, display: "flex", flexDirection: "column", gap: 4 }}>
          {categoryBadge}

          <h4 style={{
            fontSize: compact ? 14 : 15,
            fontWeight: 700,
            color: "var(--color-foreground)",
            margin: 0,
            overflow: "hidden",
            textOverflow: "ellipsis",
            whiteSpace: "nowrap",
          }}>
            {activity.title}
          </h4>

          <Row icon={<Clock size={12} />} color="var(--color-accent)">
            {formatDate(activity.eventDate)}
            {isFull && <span style={{ color: "var(--color-destructive)", fontWeight: 600, marginLeft: 6 }}>· Dolu</span>}
          </Row>

          <Row icon={<MapPin size={12} />} color="var(--color-muted-foreground)">
            {activity.addressText || "Konum"}
            {dist && <span style={{ marginLeft: 6 }}>· {dist}</span>}
          </Row>

          {participantsRow}
        </div>
      </div>
      <style>{`
        .activity-card:hover { box-shadow: var(--shadow-md); border-color: transparent; }
      `}</style>
    </Link>
  );
}

function Row({ icon, color, children }: { icon: React.ReactNode; color: string; children: React.ReactNode }) {
  return (
    <div style={{ display: "flex", alignItems: "center", gap: 5, fontSize: 12, color, fontWeight: 500, overflow: "hidden", whiteSpace: "nowrap", textOverflow: "ellipsis" }}>
      <span style={{ display: "inline-flex", flexShrink: 0 }}>{icon}</span>
      <span style={{ overflow: "hidden", textOverflow: "ellipsis" }}>{children}</span>
    </div>
  );
}
