"use client";

import { useState } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { toast } from "sonner";
import { AppShell } from "@/components/app/AppShell";
import { UserAvatar } from "@/components/app/UserAvatar";
import { TrustBadge } from "@/components/app/TrustBadge";
import { LoadingState } from "@/components/app/LoadingState";
import { useProfile } from "@/hooks/useProfile";
import { clearUserToken } from "@/lib/user-auth";
import { useRouter } from "next/navigation";

const schema = z.object({
  displayName: z.string().min(2, "En az 2 karakter"),
  bio: z.string().max(200).optional(),
});
type FormValues = z.infer<typeof schema>;

export default function ProfilePage() {
  const router = useRouter();
  const { data: profile, isLoading, update } = useProfile();
  const [editing, setEditing] = useState(false);

  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
    values: { displayName: profile?.displayName ?? "", bio: profile?.bio ?? "" },
  });

  async function onSubmit(values: FormValues) {
    try {
      await update.mutateAsync(values);
      toast.success("Profil güncellendi.");
      setEditing(false);
    } catch {
      toast.error("Güncellenemedi.");
    }
  }

  function logout() {
    clearUserToken();
    router.replace("/auth/login");
  }

  if (isLoading) return <AppShell><LoadingState /></AppShell>;
  if (!profile) return <AppShell><div style={{ padding: 24, color: "#EF4444" }}>Profil yüklenemedi.</div></AppShell>;

  return (
    <AppShell>
      <div style={{ maxWidth: 640, margin: "0 auto", padding: "24px 16px 40px" }}>
        {/* Header card */}
        <div style={{
          background: "#fff",
          borderRadius: 20,
          padding: 24,
          border: "1px solid #EEF2F7",
          marginBottom: 16,
          display: "flex",
          alignItems: "flex-start",
          gap: 16,
        }}>
          <UserAvatar displayName={profile.displayName} avatarUrl={profile.avatarUrl} size={72} />
          <div style={{ flex: 1 }}>
            <h1 style={{ fontSize: 20, fontWeight: 700, color: "#111827", margin: "0 0 4px" }}>
              {profile.displayName}
            </h1>
            {profile.bio && <p style={{ fontSize: 14, color: "#6B7280", margin: "0 0 8px" }}>{profile.bio}</p>}
            <TrustBadge isPhoneVerified={profile.isPhoneVerified} rating={profile.averageRating} />
          </div>
          <button
            onClick={() => setEditing(!editing)}
            style={{
              padding: "8px 14px",
              background: "#F3F4F6",
              border: "none",
              borderRadius: 10,
              fontSize: 13,
              cursor: "pointer",
              color: "#374151",
            }}
          >
            {editing ? "İptal" : "Düzenle"}
          </button>
        </div>

        {/* Stats */}
        <div style={{
          display: "grid",
          gridTemplateColumns: "1fr 1fr 1fr",
          gap: 12,
          marginBottom: 16,
        }}>
          {[
            { label: "Tamamlanan", value: profile.completedActivityCount, icon: "✅" },
            { label: "Değerlendirme", value: `${profile.averageRating.toFixed(1)} ⭐`, icon: "⭐" },
            { label: "Yorum Sayısı", value: profile.reviewCount, icon: "💬" },
          ].map((stat) => (
            <div key={stat.label} style={{
              background: "#fff",
              border: "1px solid #EEF2F7",
              borderRadius: 16,
              padding: "16px",
              textAlign: "center",
            }}>
              <div style={{ fontSize: 22, marginBottom: 4 }}>{stat.icon}</div>
              <div style={{ fontSize: 18, fontWeight: 700, color: "#111827" }}>{stat.value}</div>
              <div style={{ fontSize: 11, color: "#6B7280", marginTop: 2 }}>{stat.label}</div>
            </div>
          ))}
        </div>

        {/* Edit form */}
        {editing && (
          <div style={{
            background: "#fff",
            borderRadius: 20,
            padding: 24,
            border: "1px solid #EEF2F7",
            marginBottom: 16,
          }}>
            <h3 style={{ fontSize: 16, fontWeight: 700, margin: "0 0 16px" }}>Profili Düzenle</h3>
            <form onSubmit={handleSubmit(onSubmit)}>
              <div style={{ marginBottom: 14 }}>
                <label style={{ fontSize: 13, fontWeight: 500, color: "#374151", display: "block", marginBottom: 5 }}>
                  İsim Soyisim
                </label>
                <input
                  {...register("displayName")}
                  style={{
                    width: "100%",
                    padding: "11px 14px",
                    border: `1px solid ${errors.displayName ? "#EF4444" : "#EEF2F7"}`,
                    borderRadius: 10,
                    fontSize: 14,
                    outline: "none",
                    boxSizing: "border-box",
                  }}
                />
                {errors.displayName && <p style={{ fontSize: 12, color: "#EF4444", marginTop: 3 }}>{errors.displayName.message}</p>}
              </div>
              <div style={{ marginBottom: 16 }}>
                <label style={{ fontSize: 13, fontWeight: 500, color: "#374151", display: "block", marginBottom: 5 }}>
                  Hakkımda
                </label>
                <textarea
                  {...register("bio")}
                  rows={3}
                  style={{
                    width: "100%",
                    padding: "11px 14px",
                    border: "1px solid #EEF2F7",
                    borderRadius: 10,
                    fontSize: 14,
                    outline: "none",
                    resize: "vertical",
                    boxSizing: "border-box",
                  }}
                />
              </div>
              <button
                type="submit"
                disabled={isSubmitting}
                style={{
                  width: "100%",
                  padding: "12px",
                  background: "#FF9D23",
                  color: "#fff",
                  border: "none",
                  borderRadius: 10,
                  fontSize: 14,
                  fontWeight: 600,
                  cursor: "pointer",
                }}
              >
                {isSubmitting ? "Kaydediliyor..." : "Kaydet"}
              </button>
            </form>
          </div>
        )}

        {/* Logout */}
        <button
          onClick={logout}
          style={{
            width: "100%",
            padding: "12px",
            background: "none",
            border: "1px solid #EEF2F7",
            borderRadius: 12,
            fontSize: 14,
            color: "#EF4444",
            cursor: "pointer",
            fontWeight: 500,
          }}
        >
          Çıkış Yap
        </button>
      </div>
    </AppShell>
  );
}
