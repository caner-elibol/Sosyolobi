"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useNotifications } from "@/hooks/useNotifications";

const TABS = [
  { href: "/app/map", icon: "🗺️", label: "Keşfet" },
  { href: "/app/activities", icon: "📋", label: "Liste" },
  { href: "/app/activities/create", icon: "➕", label: "Oluştur", accent: true },
  { href: "/app/requests", icon: "📩", label: "İstekler" },
  { href: "/app/profile", icon: "👤", label: "Profil" },
];

export function AppBottomNav() {
  const pathname = usePathname();
  const { unreadCount } = useNotifications();

  return (
    <nav style={{
      position: "fixed",
      bottom: 0,
      left: 0,
      right: 0,
      height: 64,
      background: "#fff",
      borderTop: "1px solid #EEF2F7",
      display: "flex",
      alignItems: "center",
      justifyContent: "space-around",
      zIndex: 200,
      paddingBottom: "env(safe-area-inset-bottom)",
    }} className="show-mobile">
      {TABS.map((tab) => {
        const active = pathname.startsWith(tab.href) && !(tab.href === "/app/activities" && pathname.startsWith("/app/activities/create"));
        return (
          <Link
            key={tab.href}
            href={tab.href}
            style={{
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
              gap: 2,
              textDecoration: "none",
              flex: 1,
              position: "relative",
            }}
          >
            {tab.accent ? (
              <div style={{
                width: 48,
                height: 48,
                background: "#FF9D23",
                borderRadius: "50%",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontSize: 22,
                marginTop: -20,
                boxShadow: "0 4px 12px rgba(255,157,35,0.4)",
              }}>
                {tab.icon}
              </div>
            ) : (
              <span style={{ fontSize: 22, position: "relative" }}>
                {tab.icon}
                {tab.href === "/app/requests" && unreadCount > 0 && (
                  <span style={{
                    position: "absolute",
                    top: -4,
                    right: -6,
                    background: "#EF4444",
                    color: "#fff",
                    borderRadius: "50%",
                    width: 14,
                    height: 14,
                    fontSize: 9,
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center",
                    fontWeight: 700,
                  }}>!</span>
                )}
              </span>
            )}
            {!tab.accent && (
              <span style={{ fontSize: 10, color: active ? "#FF9D23" : "#9CA3AF", fontWeight: active ? 600 : 400 }}>
                {tab.label}
              </span>
            )}
          </Link>
        );
      })}
    </nav>
  );
}
