interface LocationPermissionCardProps {
  onAllow: () => void;
  onDismiss?: () => void;
}

export function LocationPermissionCard({ onAllow, onDismiss }: LocationPermissionCardProps) {
  return (
    <div style={{
      background: "#fff",
      border: "1px solid #EEF2F7",
      borderRadius: 16,
      padding: "20px 24px",
      display: "flex",
      alignItems: "flex-start",
      gap: 16,
    }}>
      <div style={{ fontSize: 32 }}>📍</div>
      <div style={{ flex: 1 }}>
        <h4 style={{ fontSize: 15, fontWeight: 600, color: "#111827", margin: "0 0 4px" }}>
          Konumuna İzin Ver
        </h4>
        <p style={{ fontSize: 13, color: "#6B7280", margin: "0 0 12px" }}>
          Yakındaki etkinlikleri görmek için konumuna ihtiyaç var.
        </p>
        <div style={{ display: "flex", gap: 8 }}>
          <button
            onClick={onAllow}
            style={{
              padding: "8px 16px",
              background: "#FF9D23",
              color: "#fff",
              border: "none",
              borderRadius: 8,
              fontSize: 13,
              fontWeight: 600,
              cursor: "pointer",
            }}
          >
            Konumu Paylaş
          </button>
          {onDismiss && (
            <button
              onClick={onDismiss}
              style={{
                padding: "8px 16px",
                background: "none",
                color: "#6B7280",
                border: "1px solid #EEF2F7",
                borderRadius: 8,
                fontSize: 13,
                cursor: "pointer",
              }}
            >
              Şimdi Değil
            </button>
          )}
        </div>
      </div>
    </div>
  );
}
