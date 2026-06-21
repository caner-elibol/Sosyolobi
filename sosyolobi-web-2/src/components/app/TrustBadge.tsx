interface TrustBadgeProps {
  isPhoneVerified?: boolean;
  rating?: number;
  compact?: boolean;
}

export function TrustBadge({ isPhoneVerified, rating, compact = false }: TrustBadgeProps) {
  return (
    <div style={{ display: "flex", alignItems: "center", gap: 6, flexWrap: "wrap" }}>
      {isPhoneVerified && (
        <span style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 3,
          background: "#DCFCE7",
          color: "#16A34A",
          fontSize: compact ? 11 : 12,
          fontWeight: 600,
          padding: "2px 8px",
          borderRadius: 20,
        }}>
          ✓ {!compact && "Doğrulandı"}
        </span>
      )}
      {rating !== undefined && rating > 0 && (
        <span style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 3,
          color: "#6B7280",
          fontSize: compact ? 12 : 13,
        }}>
          ⭐ {rating.toFixed(1)}
        </span>
      )}
    </div>
  );
}
