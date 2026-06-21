"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useNotifications } from "@/hooks/useNotifications";
import { getUserFromToken, clearUserToken } from "@/lib/user-auth";
import { UserAvatar } from "@/components/app/UserAvatar";

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

  function logout() {
    clearUserToken();
    router.replace("/auth/login");
  }

  return (
    <header style={{
      height: 60,
      background: "#081B4B",
      display: "flex",
      alignItems: "center",
      padding: "0 20px",
      gap: 16,
      position: "sticky",
      top: 0,
      zIndex: 100,
      flexShrink: 0,
    }}>
      <Link href="/app/map" style={{ textDecoration: "none", display: "flex", alignItems: "center", gap: 6 }}>
        <span style={{ fontSize: 20 }}>🏃</span>
        <span style={{ color: "#FF9D23", fontWeight: 700, fontSize: 16 }}>Sosyolobi</span>
      </Link>

      <nav style={{ display: "flex", gap: 4, marginLeft: 16, flex: 1 }} className="hidden-mobile">
        {NAV_ITEMS.map((item) => (
          <Link
            key={item.href}
            href={item.href}
            style={{
              padding: "6px 12px",
              borderRadius: 8,
              fontSize: 14,
              fontWeight: pathname.startsWith(item.href) ? 600 : 400,
              color: pathname.startsWith(item.href) ? "#FF9D23" : "#94a3b8",
              textDecoration: "none",
              position: "relative",
            }}
          >
            {item.label}
            {item.href === "/app/notifications" && unreadCount > 0 && (
              <span style={{
                position: "absolute",
                top: 2,
                right: 2,
                background: "#EF4444",
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
          padding: "6px 14px",
          background: "#FF9D23",
          color: "#fff",
          borderRadius: 20,
          fontSize: 13,
          fontWeight: 600,
          textDecoration: "none",
        }} className="hidden-mobile">
          + Oluştur
        </Link>
        {user && (
          <button onClick={logout} style={{ background: "none", border: "none", cursor: "pointer" }}>
            <UserAvatar displayName={user.displayName ?? "U"} size={32} />
          </button>
        )}
      </div>
    </header>
  );
}
