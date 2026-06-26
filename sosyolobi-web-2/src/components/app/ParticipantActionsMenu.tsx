"use client";

import { useEffect, useRef, useState } from "react";
import { toast } from "sonner";
import { useBlockUser } from "@/hooks/useUserActions";
import { ReportUserModal } from "@/components/app/ReportUserModal";
import { Flag, MoreVertical, ShieldOff } from "lucide-react";

interface ParticipantActionsMenuProps {
  userId: string;
  displayName: string;
}

export function ParticipantActionsMenu({ userId, displayName }: ParticipantActionsMenuProps) {
  const [menuOpen, setMenuOpen] = useState(false);
  const [reportOpen, setReportOpen] = useState(false);
  const menuRef = useRef<HTMLDivElement>(null);
  const block = useBlockUser();

  useEffect(() => {
    if (!menuOpen) return;
    function handleClickOutside(e: MouseEvent) {
      if (menuRef.current && !menuRef.current.contains(e.target as Node)) setMenuOpen(false);
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [menuOpen]);

  function handleBlock() {
    setMenuOpen(false);
    if (!window.confirm(`${displayName} kullanıcısını engellemek istediğinize emin misiniz? Bu kullanıcının etkinliklerini artık görmeyeceksiniz.`)) return;
    block.mutate(userId, {
      onSuccess: () => toast.success("Kullanıcı engellendi."),
      onError: () => toast.error("Kullanıcı engellenemedi."),
    });
  }

  return (
    <div ref={menuRef} style={{ position: "relative" }}>
      <button
        onClick={() => setMenuOpen((o) => !o)}
        aria-label="Kullanıcı işlemleri"
        style={{
          background: "none",
          border: "none",
          cursor: "pointer",
          color: "var(--color-muted-foreground)",
          padding: 4,
          display: "flex",
          alignItems: "center",
          borderRadius: "var(--radius-sm)",
        }}
      >
        <MoreVertical size={17} />
      </button>
      {menuOpen && (
        <div style={{
          position: "absolute",
          top: 28,
          right: 0,
          background: "var(--color-surface)",
          borderRadius: "var(--radius-md)",
          boxShadow: "var(--shadow-lg)",
          minWidth: 180,
          zIndex: 200,
          overflow: "hidden",
          border: "1px solid var(--color-border)",
        }}>
          <button
            onClick={() => { setReportOpen(true); setMenuOpen(false); }}
            style={{ display: "flex", alignItems: "center", gap: 8, width: "100%", textAlign: "left", padding: "10px 14px", fontSize: 13, color: "var(--color-foreground)", background: "none", border: "none", cursor: "pointer" }}
          >
            <Flag size={14} /> Şikayet Et
          </button>
          <button
            onClick={handleBlock}
            style={{ display: "flex", alignItems: "center", gap: 8, width: "100%", textAlign: "left", padding: "10px 14px", fontSize: 13, color: "var(--color-destructive)", background: "none", border: "none", borderTop: "1px solid var(--color-border)", cursor: "pointer" }}
          >
            <ShieldOff size={14} /> Kullanıcıyı Engelle
          </button>
        </div>
      )}

      {reportOpen && (
        <ReportUserModal userId={userId} displayName={displayName} onClose={() => setReportOpen(false)} />
      )}
    </div>
  );
}
