"use client";

import { Suspense, useEffect, useRef, useState } from "react";
import Link from "next/link";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import { getUserFromToken, clearUserToken } from "@/lib/user-auth";
import { UserAvatar } from "@/components/app/UserAvatar";
import { NotificationsBell } from "@/components/app/NotificationsBell";
import { Calendar, Crosshair, Inbox, LogOut, MapPin, Plus, Search, UserPen } from "lucide-react";

const NAV_ITEMS = [
  { href: "/app/map", label: "Keşfet", icon: MapPin },
  { href: "/app/activities", label: "Etkinlikler", icon: Calendar },
  { href: "/app/requests", label: "İstekler", icon: Inbox },
];

export function AppTopbar() {
  return (
    <Suspense fallback={null}>
      <AppTopbarInner />
    </Suspense>
  );
}

// Hoisted to module scope on purpose: an inline function component re-created on
// every parent render gets a new identity, so React unmounts/remounts the <input>
// DOM node after each keystroke — the input loses focus and needs a re-click to
// type the next character. Keeping this outside the render body keeps its
// identity stable across renders.
function TopSearchBar({
  className,
  value,
  onChange,
  onSubmit,
  onLocate,
}: {
  className?: string;
  value: string;
  onChange: (value: string) => void;
  onSubmit: (e: React.FormEvent) => void;
  onLocate: () => void;
}) {
  return (
    <form onSubmit={onSubmit} className={className} style={{
      flex: 1,
      maxWidth: 420,
      display: "flex",
      alignItems: "center",
      gap: 8,
      background: "#F3F4F6",
      borderRadius: "var(--radius-full)",
      padding: "8px 8px 8px 16px",
    }}>
      <Search size={16} color="var(--color-muted-foreground)" style={{ flexShrink: 0 }} />
      <input
        value={value}
        onChange={(e) => onChange(e.target.value)}
        placeholder="Etkinlik, kategori veya konum ara..."
        style={{
          flex: 1,
          border: "none",
          outline: "none",
          background: "transparent",
          fontSize: 14,
          fontFamily: "inherit",
          color: "var(--color-foreground)",
        }}
      />
      <button
        type="button"
        onClick={onLocate}
        title="Haritada konumumu gör"
        style={{
          width: 28,
          height: 28,
          borderRadius: "var(--radius-sm)",
          background: "#E5E7EB",
          border: "none",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          cursor: "pointer",
          flexShrink: 0,
        }}
      >
        <Crosshair size={14} color="var(--color-foreground)" />
      </button>
    </form>
  );
}

function AppTopbarInner() {
  const pathname = usePathname();
  const router = useRouter();
  const searchParams = useSearchParams();
  const user = getUserFromToken();
  const [menuOpen, setMenuOpen] = useState(false);
  const [search, setSearch] = useState(searchParams.get("q") ?? "");
  const menuRef = useRef<HTMLDivElement>(null);
  const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    setSearch(searchParams.get("q") ?? "");
  }, [searchParams]);

  useEffect(() => {
    if (!menuOpen) return;
    function handleClickOutside(e: MouseEvent) {
      if (menuRef.current && !menuRef.current.contains(e.target as Node)) setMenuOpen(false);
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [menuOpen]);

  useEffect(() => {
    return () => {
      if (debounceRef.current) clearTimeout(debounceRef.current);
    };
  }, []);

  function logout() {
    clearUserToken();
    router.replace("/auth/login");
  }

  function navigateSearch(value: string) {
    const q = value.trim();
    router.push(q ? `/app/activities?q=${encodeURIComponent(q)}` : "/app/activities");
  }

  function handleSearchChange(value: string) {
    setSearch(value);
    if (debounceRef.current) clearTimeout(debounceRef.current);
    debounceRef.current = setTimeout(() => {
      if (value.trim() !== (searchParams.get("q") ?? "").trim()) {
        navigateSearch(value);
      }
    }, 400);
  }

  function handleSearchSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (debounceRef.current) clearTimeout(debounceRef.current);
    navigateSearch(search);
  }

  return (
    <header style={{
      background: "var(--color-surface)",
      borderBottom: "1px solid var(--color-border)",
      position: "sticky",
      top: 0,
      zIndex: 100,
      flexShrink: 0,
      display: "flex",
      flexDirection: "column",
    }}>
      <div style={{
        height: 60,
        display: "flex",
        alignItems: "center",
        padding: "0 16px",
        gap: 16,
      }}>
        <Link href="/app/map" style={{ textDecoration: "none", display: "flex", alignItems: "center", gap: 8, flexShrink: 0 }}>
          <span style={{
            width: 32,
            height: 32,
            borderRadius: "var(--radius-md)",
            background: "var(--color-accent-bright)",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            flexShrink: 0,
          }}>
            <MapPin size={18} color="#fff" strokeWidth={2.5} />
          </span>
          <span style={{ color: "var(--color-navy)", fontWeight: 700, fontSize: 17 }}>Sosyolobi</span>
        </Link>

        <TopSearchBar
          className="hidden-mobile"
          value={search}
          onChange={handleSearchChange}
          onSubmit={handleSearchSubmit}
          onLocate={() => router.push("/app/map")}
        />

        <nav style={{ display: "flex", gap: 4, marginLeft: "auto" }} className="hidden-mobile">
        {NAV_ITEMS.map((item) => {
          const active = pathname.startsWith(item.href);
          const Icon = item.icon;
          return (
            <Link
              key={item.href}
              href={item.href}
              style={{
                display: "inline-flex",
                alignItems: "center",
                gap: 6,
                padding: "8px 12px",
                borderRadius: "var(--radius-sm)",
                fontSize: 13,
                fontWeight: active ? 600 : 500,
                color: active ? "var(--color-accent)" : "var(--color-muted-foreground)",
                textDecoration: "none",
                position: "relative",
                transition: "color 0.15s ease",
              }}
            >
              <Icon size={16} strokeWidth={active ? 2.4 : 2} />
              {item.label}
            </Link>
          );
        })}
      </nav>

      <div style={{ display: "flex", alignItems: "center", gap: 12, marginLeft: "auto" }}>
        <Link href="/app/activities/create" style={{
          display: "inline-flex",
          alignItems: "center",
          gap: 6,
          padding: "8px 16px",
          background: "var(--color-accent-bright)",
          color: "#fff",
          borderRadius: "var(--radius-full)",
          fontSize: 13,
          fontWeight: 700,
          textDecoration: "none",
          transition: "filter 0.15s ease",
        }} className="hidden-mobile">
          <Plus size={15} strokeWidth={2.5} /> Oluştur
        </Link>
        <NotificationsBell className="hidden-mobile" />
        <NotificationsBell className="show-mobile" />
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
      </div>

      <div className="show-mobile" style={{ padding: "0 16px 12px" }}>
        <TopSearchBar
          value={search}
          onChange={handleSearchChange}
          onSubmit={handleSearchSubmit}
          onLocate={() => router.push("/app/map")}
        />
      </div>
    </header>
  );
}
