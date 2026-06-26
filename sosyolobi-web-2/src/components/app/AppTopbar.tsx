"use client";

import { useEffect, useRef, useState } from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useNotifications } from "@/hooks/useNotifications";
import { getUserFromToken, clearUserToken } from "@/lib/user-auth";
import { UserAvatar } from "@/components/app/UserAvatar";
import { Compass, LogOut, Plus, UserPen } from "lucide-react";

const NAV_ITEMS = [
  { href: "/app/map", label: "Keşfet" },
  { href: "/app/activities", label: "Etkinlikler" },
  { href: "/app/requests", label: "İstekler" },
  { href: "/app/notifications", label: "Bildirimler" },
];

export function AppTopbar() {
  const pathname = usePathname();
  const router = useRouter();
  const { unreadCount } = useNotifications();
  const user = getUserFromToken();
  const [menuOpen, setMenuOpen] = useState(false);
  const menuRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!menuOpen) return;
    function handleClickOutside(e: MouseEvent) {
      if (menuRef.current && !menuRef.current.contains(e.target as Node)) setMenuOpen(false);
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [menuOpen]);

  function logout() {
    clearUserToken();
    router.replace("/auth/login");
  }

  return (
    <header style={{
      height: 60,
      background: "var(--color-navy)",
      display: "flex",
      alignItems: "center",
      padding: "0 20px",
      gap: 16,
      position: "sticky",
      top: 0,
      zIndex: 100,
      flexShrink: 0,
    }}>
      <Link href="/app/map" style={{ textDecoration: "none", display: "flex", alignItems: "center", gap: 8 }}>
        <span style={{
          width: 30,
          height: 30,
          borderRadius: "var(--radius-md)",
          background: "var(--color-accent-bright)",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          flexShrink: 0,
        }}>
          <Compass size={17} color="var(--color-navy)" strokeWidth={2.5} />
        </span>
        <span style={{ color: "#fff", fontWeight: 700, fontSize: 16 }}>Sosyolobi</span>
      </Link>

      <nav style={{ display: "flex", gap: 4, marginLeft: 16, flex: 1 }} className="hidden-mobile">
        {NAV_ITEMS.map((item) => (
          <Link
            key={item.href}
            href={item.href}
            style={{
              padding: "6px 12px",
              borderRadius: "var(--radius-sm)",
              fontSize: 14,
              fontWeight: pathname.startsWith(item.href) ? 600 : 500,
              color: pathname.startsWith(item.href) ? "var(--color-accent-bright)" : "rgba(255,255,255,0.65)",
              textDecoration: "none",
              position: "relative",
              transition: "color 0.15s ease",
            }}
          >
            {item.label}
            {item.href === "/app/notifications" && unreadCount > 0 && (
              <span style={{
                position: "absolute",
                top: 2,
                right: 2,
                background: "var(--color-destructive)",
                color: "#fff",
                borderRadius: "50%",
                width: 16,
                height: 16,
                fontSize: 10,
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontWeight: 700,
              }}>
                {unreadCount > 9 ? "9+" : unreadCount}
              </span>
            )}
          </Link>
        ))}
      </nav>

      <div style={{ marginLeft: "auto", display: "flex", alignItems: "center", gap: 12 }}>
        <Link href="/app/activities/create" style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 6,
          padding: "7px 14px",
          background: "var(--color-accent-bright)",
          color: "var(--color-navy)",
          borderRadius: "var(--radius-full)",
          fontSize: 13,
          fontWeight: 700,
          textDecoration: "none",
          transition: "filter 0.15s ease",
        }} className="hidden-mobile">
          <Plus size={15} strokeWidth={2.5} /> Oluştur
        </Link>
        {user && (
          <div ref={menuRef} style={{ position: "relative" }}>
            <button onClick={() => setMenuOpen((o) => !o)} style={{ background: "none", border: "none", cursor: "pointer", padding: 0, borderRadius: "50%" }}>
              <UserAvatar displayName={user.displayName ?? "U"} size={32} />
            </button>
            {menuOpen && (
              <div style={{
                position: "absolute",
                top: 40,
                right: 0,
                background: "var(--color-surface)",
                borderRadius: "var(--radius-md)",
                boxShadow: "var(--shadow-lg)",
                minWidth: 180,
                zIndex: 200,
                overflow: "hidden",
                border: "1px solid var(--color-border)",
              }}>
                <Link
                  href="/app/profile"
                  onClick={() => setMenuOpen(false)}
                  style={{ display: "flex", alignItems: "center", gap: 8, padding: "12px 16px", fontSize: 14, color: "var(--color-foreground)", textDecoration: "none" }}
                >
                  <UserPen size={15} /> Profili Düzenle
                </Link>
                <button
                  onClick={logout}
                  style={{
                    display: "flex",
                    alignItems: "center",
                    gap: 8,
                    width: "100%",
                    textAlign: "left",
                    padding: "12px 16px",
                    fontSize: 14,
                    color: "var(--color-destructive)",
                    background: "none",
                    border: "none",
                    borderTop: "1px solid var(--color-border)",
                    cursor: "pointer",
                  }}
                >
                  <LogOut size={15} /> Çıkış Yap
                </button>
              </div>
            )}
          </div>
        )}
      </div>
    </header>
  );
}
