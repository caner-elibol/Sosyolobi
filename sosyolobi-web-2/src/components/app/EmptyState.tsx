interface EmptyStateProps {
  icon?: string;
  title: string;
  description?: string;
  action?: React.ReactNode;
}

export function EmptyState({ icon = "🔍", title, description, action }: EmptyStateProps) {
  return (
    <div style={{
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "48px 24px",
      textAlign: "center",
    }}>
      <div style={{ fontSize: 48, marginBottom: 16 }}>{icon}</div>
      <h3 style={{ fontSize: 17, fontWeight: 600, color: "#111827", margin: "0 0 8px" }}>{title}</h3>
      {description && <p style={{ fontSize: 14, color: "#6B7280", margin: "0 0 20px" }}>{description}</p>}
      {action}
    </div>
  );
}
