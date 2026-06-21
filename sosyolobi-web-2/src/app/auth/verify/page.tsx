"use client";

import { useEffect, useRef } from "react";
import { useRouter } from "next/navigation";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { toast } from "sonner";
import { setUserToken } from "@/lib/user-auth";
import type { ApiResponse, UserAuthResponse } from "@/types/user";

const schema = z.object({
  code: z.string().length(6, "Kod 6 haneli olmalı"),
});
type FormValues = z.infer<typeof schema>;

export default function VerifyPage() {
  const router = useRouter();
  const phoneRef = useRef<string | null>(null);
  const redirectRef = useRef<string>("/app/map");

  useEffect(() => {
    phoneRef.current = sessionStorage.getItem("otp_phone");
    redirectRef.current = sessionStorage.getItem("otp_redirect") ?? "/app/map";
    if (!phoneRef.current) router.replace("/auth/login");
  }, [router]);

  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
  });

  async function onSubmit(values: FormValues) {
    try {
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/verify-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phoneNumber: phoneRef.current, code: values.code }),
      });
      const json = (await res.json()) as ApiResponse<UserAuthResponse>;
      if (!res.ok || !json.success) { toast.error(json.message ?? "Kod hatalı."); return; }
      setUserToken(json.data.accessToken);
      sessionStorage.removeItem("otp_phone");
      sessionStorage.removeItem("otp_redirect");
      router.replace(redirectRef.current);
    } catch {
      toast.error("Bir hata oluştu. Tekrar deneyin.");
    }
  }

  async function resend() {
    const phone = phoneRef.current;
    if (!phone) return;
    try {
      await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/auth/send-otp`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ phoneNumber: phone }),
      });
      toast.success("Kod yeniden gönderildi.");
    } catch {
      toast.error("Yeniden gönderilemedi.");
    }
  }

  return (
    <div style={{
      minHeight: "100vh",
      background: "linear-gradient(160deg, #fff8ee 0%, #fff3e0 40%, #fafbfd 100%)",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      padding: 24,
      fontFamily: "Inter, ui-sans-serif, system-ui, sans-serif",
    }}>
      <div style={{ width: "100%", maxWidth: 400 }}>
        <div style={{ textAlign: "center", marginBottom: 40 }}>
          <div style={{ fontSize: 40, marginBottom: 8 }}>📱</div>
          <h1 style={{ fontSize: 22, fontWeight: 700, color: "#081B4B", margin: "0 0 4px" }}>Kodu Gir</h1>
          <p style={{ color: "#6B7280", fontSize: 15, margin: 0 }}>
            Telefon numaranıza gönderilen 6 haneli kodu girin
          </p>
        </div>

        <div style={{
          background: "#fff",
          borderRadius: 20,
          padding: 32,
          boxShadow: "0 4px 24px rgba(8,27,75,0.08)",
        }}>
          <form onSubmit={handleSubmit(onSubmit)}>
            <div style={{ marginBottom: 20 }}>
              <input
                {...register("code")}
                type="text"
                inputMode="numeric"
                maxLength={6}
                placeholder="000000"
                style={{
                  width: "100%",
                  padding: "16px",
                  border: `1px solid ${errors.code ? "#EF4444" : "#EEF2F7"}`,
                  borderRadius: 12,
                  fontSize: 28,
                  fontWeight: 700,
                  letterSpacing: 12,
                  textAlign: "center",
                  outline: "none",
                  boxSizing: "border-box",
                }}
              />
              {errors.code && (
                <p style={{ color: "#EF4444", fontSize: 12, marginTop: 4 }}>{errors.code.message}</p>
              )}
            </div>

            <button
              type="submit"
              disabled={isSubmitting}
              style={{
                width: "100%",
                padding: "13px",
                background: isSubmitting ? "#fb923c" : "#FF9D23",
                color: "#fff",
                border: "none",
                borderRadius: 12,
                fontSize: 15,
                fontWeight: 600,
                cursor: isSubmitting ? "not-allowed" : "pointer",
              }}
            >
              {isSubmitting ? "Doğrulanıyor..." : "Onayla"}
            </button>
          </form>

          <button
            onClick={resend}
            style={{
              display: "block",
              width: "100%",
              marginTop: 12,
              padding: "10px",
              background: "none",
              border: "none",
              color: "#6B7280",
              fontSize: 13,
              cursor: "pointer",
            }}
          >
            Kodu tekrar gönder
          </button>

          <button
            onClick={() => router.push("/auth/login")}
            style={{
              display: "block",
              width: "100%",
              marginTop: 4,
              padding: "10px",
              background: "none",
              border: "none",
              color: "#9CA3AF",
              fontSize: 13,
              cursor: "pointer",
            }}
          >
            ← Telefon numarasını değiştir
          </button>
        </div>
      </div>
    </div>
  );
}
