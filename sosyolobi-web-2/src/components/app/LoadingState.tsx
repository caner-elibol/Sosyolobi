interface LoadingStateProps {
  message?: string;
}

export function LoadingState({ message = "Yükleniyor..." }: LoadingStateProps) {
  return (
    <div style={{
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "48px 24px",
      gap: 12,
    }}>
      <div style={{
        width: 32,
        height: 32,
        border: "3px solid #EEF2F7",
        borderTopColor: "#FF9D23",
        borderRadius: "50%",
        animation: "spin 0.8s linear infinite",
      }} />
      <p style={{ fontSize: 14, color: "#6B7280", margin: 0 }}>{message}</p>
      <style>{`@keyframes spin { to { transform: rotate(360deg) } }`}</style>
    </div>
  );
}
