"use client";

import { useEffect, useRef, useState } from "react";
import { toast } from "sonner";
import { useBlockUser } from "@/hooks/useUserActions";
import { ReportUserModal } from "@/components/app/ReportUserModal";

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
          color: "#9CA3AF",
          fontSize: 16,
          padding: 4,
          lineHeight: 1,
        }}
      >
        ⋮
      </button>
      {menuOpen && (
        <div style={{
          position: "absolute",
          top: 24,
          right: 0,
          background: "#fff",
          borderRadius: 12,
          boxShadow: "0 4px 20px rgba(0,0,0,0.15)",
          minWidth: 170,
          zIndex: 200,
          overflow: "hidden",
        }}>
          <button
            onClick={() => { setReportOpen(true); setMenuOpen(false); }}
            style={{ display: "block", width: "100%", textAlign: "left", padding: "10px 14px", fontSize: 13, color: "#111827", background: "none", border: "none", cursor: "pointer" }}
          >
            Şikayet Et
          </button>
          <button
            onClick={handleBlock}
            style={{ display: "block", width: "100%", textAlign: "left", padding: "10px 14px", fontSize: 13, color: "#EF4444", background: "none", border: "none", borderTop: "1px solid #EEF2F7", cursor: "pointer" }}
          >
            Kullanıcıyı Engelle
          </button>
        </div>
      )}

      {reportOpen && (
        <ReportUserModal userId={userId} displayName={displayName} onClose={() => setReportOpen(false)} />
      )}
    </div>
  );
}
