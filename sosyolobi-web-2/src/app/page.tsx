import Link from "next/link";
import { Compass } from "lucide-react";

export default function Home() {
  return (
    <main style={{
      minHeight: "100dvh",
      background: "linear-gradient(135deg, #0b1736 0%, #12224a 60%, #1a3a8f 100%)",
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "24px",
      fontFamily: "var(--font-inter), Inter, ui-sans-serif, system-ui, sans-serif",
      position: "relative",
    }}>
      <div style={{ textAlign: "center", maxWidth: 560 }}>
        <div style={{
          width: 72,
          height: 72,
          borderRadius: "var(--radius-lg)",
          background: "var(--color-accent-bright)",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          margin: "0 auto 20px",
        }}>
          <Compass size={36} color="var(--color-navy)" strokeWidth={2.25} />
        </div>
        <h1 style={{ color: "var(--color-accent-bright)", fontSize: 48, fontWeight: 700, margin: "0 0 12px", lineHeight: 1.1 }}>
          Sosyolobi
        </h1>
        <p style={{ color: "#FAFBFD", fontSize: 20, fontWeight: 400, margin: "0 0 8px" }}>
          Yapacak şey var, insan yoksa Sosyolobi var.
        </p>
        <p style={{ color: "#94a3b8", fontSize: 15, margin: "0 0 40px" }}>
          Yakındaki sosyal etkinlikleri keşfet, oluştur ve güvenle katıl.
        </p>
        <div style={{ display: "flex", gap: 16, justifyContent: "center", flexWrap: "wrap" }}>
          <Link href="/auth/login" style={{
            display: "inline-block",
            background: "var(--color-accent-bright)",
            color: "var(--color-navy)",
            padding: "14px 32px",
            borderRadius: "var(--radius-md)",
            fontWeight: 700,
            fontSize: 16,
            textDecoration: "none",
          }}>
            Giriş Yap
          </Link>
          <Link href="/app/map" style={{
            display: "inline-block",
            background: "rgba(255,255,255,0.12)",
            color: "#fff",
            padding: "14px 32px",
            borderRadius: "var(--radius-md)",
            fontWeight: 600,
            fontSize: 16,
            textDecoration: "none",
          }}>
            Etkinlikleri Keşfet
          </Link>
        </div>
      </div>
      <div style={{ position: "absolute", bottom: 20, right: 24 }}>
        <Link href="/admin/login" style={{ color: "#64748b", fontSize: 12, textDecoration: "none" }}>
          Admin Panel
        </Link>
      </div>
    </main>
  );
}

