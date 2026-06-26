"use client";

interface ChatReplyPreviewBarProps {
  senderDisplayName: string;
  content: string;
  onCancel: () => void;
}

export function ChatReplyPreviewBar({ senderDisplayName, content, onCancel }: ChatReplyPreviewBarProps) {
  return (
    <div style={{
      display: "flex",
      alignItems: "flex-start",
      gap: 8,
      padding: "8px 16px",
      background: "#F3F4F6",
      borderTop: "1px solid #EEF2F7",
    }}>
      <div style={{ flex: 1, minWidth: 0, borderLeft: "3px solid #FF9D23", paddingLeft: 8 }}>
        <div style={{ fontSize: 12, fontWeight: 600, color: "#FF9D23" }}>{senderDisplayName}</div>
        <div style={{
          fontSize: 12,
          color: "#6B7280",
          overflow: "hidden",
          textOverflow: "ellipsis",
          whiteSpace: "nowrap",
        }}>
          {content}
        </div>
      </div>
      <button
        onClick={onCancel}
        aria-label="Yanıtlamayı iptal et"
        style={{ background: "none", border: "none", cursor: "pointer", color: "#6B7280", fontSize: 16, padding: 2 }}
      >
        ✕
      </button>
    </div>
  );
}
