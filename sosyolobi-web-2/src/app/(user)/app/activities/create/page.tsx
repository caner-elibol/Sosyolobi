import { AppShell } from "@/components/app/AppShell";
import { CreateActivityForm } from "@/components/app/CreateActivityForm";

export default function CreateActivityPage() {
  return (
    <AppShell>
      <div style={{ maxWidth: 680, margin: "0 auto", padding: "24px 16px 40px" }}>
        <h1 style={{ fontSize: 24, fontWeight: 700, color: "#111827", margin: "0 0 24px" }}>
          Etkinlik Oluştur
        </h1>
        <div style={{
          background: "#fff",
          borderRadius: 20,
          padding: 24,
          border: "1px solid #EEF2F7",
        }}>
          <CreateActivityForm />
        </div>
      </div>
    </AppShell>
  );
}
