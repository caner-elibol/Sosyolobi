"use client";

import { useEffect, useRef } from "react";

interface ChatMessageContextMenuProps {
  x: number;
  y: number;
  onReply: () => void;
  onClose: () => void;
}

export function ChatMessageContextMenu({ x, y, onReply, onClose }: ChatMessageContextMenuProps) {
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) onClose();
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [onClose]);

  return (
    <div
      ref={ref}
      style={{
        position: "fixed",
        top: y,
        left: x,
        background: "#fff",
        borderRadius: 10,
        boxShadow: "0 4px 20px rgba(0,0,0,0.18)",
        zIndex: 300,
        overflow: "hidden",
        minWidth: 120,
      }}
    >
      <button
        onClick={onReply}
        style={{
          display: "block",
          width: "100%",
          textAlign: "left",
          padding: "10px 14px",
          fontSize: 13,
          color: "#111827",
          background: "none",
          border: "none",
          cursor: "pointer",
        }}
      >
        ↩ Cevapla
      </button>
    </div>
  );
}
