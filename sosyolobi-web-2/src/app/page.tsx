import Link from "next/link";

export default function Home() {
  return (
    <main style={{
      minHeight: "100vh",
      background: "linear-gradient(135deg, #081B4B 0%, #0d2a6e 60%, #1a3a8f 100%)",
      display: "flex",
      flexDirection: "column",
      alignItems: "center",
      justifyContent: "center",
      padding: "24px",
      fontFamily: "Inter, ui-sans-serif, system-ui, sans-serif",
    }}>
      <div style={{ textAlign: "center", maxWidth: 560 }}>
        <div style={{ fontSize: 56, marginBottom: 12 }}>🏃</div>
        <h1 style={{ color: "#FF9D23", fontSize: 48, fontWeight: 700, margin: "0 0 12px", lineHeight: 1.1 }}>
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
            background: "#FF9D23",
            color: "#fff",
            padding: "14px 32px",
            borderRadius: 12,
            fontWeight: 600,
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
            borderRadius: 12,
            fontWeight: 600,
            fontSize: 16,
            textDecoration: "none",
          }}>
            Etkinlikleri Keşfet
          </Link>
        </div>
      </div>
      <div style={{ position: "absolute", bottom: 20, right: 24 }}>
        <Link href="/admin/login" style={{ color: "#475569", fontSize: 12, textDecoration: "none" }}>
          Admin Panel
        </Link>
      </div>
    </main>
  );
}

