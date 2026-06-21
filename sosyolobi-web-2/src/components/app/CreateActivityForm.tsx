"use client";

import { useState, useCallback } from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { useQuery } from "@tanstack/react-query";
import Map, { Marker } from "react-map-gl/maplibre";
import "maplibre-gl/dist/maplibre-gl.css";
import { toast } from "sonner";
import { useRouter } from "next/navigation";
import { userApiClient } from "@/lib/user-api-client";
import { useCreateActivity } from "@/hooks/useCreateActivity";
import { SkillLevel, GenderPreference } from "@/types/user";
import type { Category } from "@/types/user";

const schema = z.object({
  categoryId: z.string().min(1, "Kategori seçin"),
  title: z.string().min(3, "Başlık en az 3 karakter"),
  description: z.string().optional(),
  eventDate: z.string().min(1, "Tarih seçin"),
  neededPeopleCount: z.number().min(1, "En az 1 kişi"),
  pricePerPerson: z.number().min(0).optional(),
  skillLevel: z.number(),
  genderPreference: z.number(),
  addressText: z.string().min(5, "Adres açıklaması zorunlu"),
  addressDetailPrivate: z.string().optional(),
});
type FormValues = z.infer<typeof schema>;

export function CreateActivityForm() {
  const router = useRouter();
  const create = useCreateActivity();
  const [pin, setPin] = useState<{ lat: number; lng: number } | null>(null);

  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: () => userApiClient<Category[]>("/api/categories"),
    staleTime: Infinity,
  });

  const { register, handleSubmit, formState: { errors, isSubmitting } } = useForm<FormValues>({
    resolver: zodResolver(schema),
    defaultValues: { skillLevel: SkillLevel.Any, genderPreference: GenderPreference.Any, neededPeopleCount: 1 },
  });

  const handleMapClick = useCallback((evt: { lngLat: { lat: number; lng: number } }) => {
    setPin({ lat: evt.lngLat.lat, lng: evt.lngLat.lng });
  }, []);

  async function onSubmit(values: FormValues) {
    if (!pin) { toast.error("Haritadan bir konum seçin."); return; }
    try {
      const activity = await create.mutateAsync({
        ...values,
        latitude: pin.lat,
        longitude: pin.lng,
        eventDate: new Date(values.eventDate).toISOString(),
      });
      toast.success("Etkinlik oluşturuldu!");
      router.push(`/app/activities/${activity.id}`);
    } catch (e: unknown) {
      toast.error(e instanceof Error ? e.message : "Etkinlik oluşturulamadı.");
    }
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div style={{ display: "flex", flexDirection: "column", gap: 20 }}>

        {/* Category */}
        <Field label="Kategori" error={errors.categoryId?.message}>
          <select {...register("categoryId")} style={inputStyle}>
            <option value="">Kategori seçin</option>
            {categories.map((c) => <option key={c.id} value={c.id}>{c.name}</option>)}
          </select>
        </Field>

        {/* Title */}
        <Field label="Başlık" error={errors.title?.message}>
          <input {...register("title")} placeholder="Etkinlik başlığı" style={inputStyle} />
        </Field>

        {/* Description */}
        <Field label="Açıklama (opsiyonel)">
          <textarea {...register("description")} rows={3} placeholder="Etkinlik hakkında bilgi..." style={{ ...inputStyle, resize: "vertical" }} />
        </Field>

        {/* Date */}
        <Field label="Tarih ve Saat" error={errors.eventDate?.message}>
          <input {...register("eventDate")} type="datetime-local" style={inputStyle} />
        </Field>

        {/* People count + price */}
        <div style={{ display: "flex", gap: 12 }}>
          <Field label="Eksik Kişi Sayısı" error={errors.neededPeopleCount?.message} style={{ flex: 1 }}>
            <input {...register("neededPeopleCount", { valueAsNumber: true })} type="number" min={1} style={inputStyle} />
          </Field>
          <Field label="Kişi Başı Ücret (₺)" style={{ flex: 1 }}>
            <input {...register("pricePerPerson", { valueAsNumber: true })} type="number" min={0} placeholder="0" style={inputStyle} />
          </Field>
        </div>

        {/* Skill + gender */}
        <div style={{ display: "flex", gap: 12 }}>
          <Field label="Seviye" style={{ flex: 1 }}>
            <select {...register("skillLevel", { valueAsNumber: true })} style={inputStyle}>
              <option value={0}>Herkes</option>
              <option value={1}>Başlangıç</option>
              <option value={2}>Orta</option>
              <option value={3}>İleri</option>
            </select>
          </Field>
          <Field label="Cinsiyet Tercihi" style={{ flex: 1 }}>
            <select {...register("genderPreference", { valueAsNumber: true })} style={inputStyle}>
              <option value={0}>Herkes</option>
              <option value={1}>Erkek</option>
              <option value={2}>Kadın</option>
              <option value={3}>Karışık</option>
            </select>
          </Field>
        </div>

        {/* Address text */}
        <Field label="Adres Açıklaması" error={errors.addressText?.message}>
          <input {...register("addressText")} placeholder="Mahalle, semt veya yakın nokta" style={inputStyle} />
        </Field>

        {/* Private address detail */}
        <Field label="Gizli Adres Detayı (onaylı katılımcılara gösterilir)">
          <input {...register("addressDetailPrivate")} placeholder="Kapı numarası, detaylı adres..." style={inputStyle} />
        </Field>

        {/* Map pin */}
        <Field label="Konum Seç (haritaya tıklayın)" error={pin ? undefined : "Konum zorunlu"}>
          <div style={{ height: 300, borderRadius: 12, overflow: "hidden", border: "1px solid #EEF2F7" }}>
            <Map
              initialViewState={{ longitude: 28.9784, latitude: 41.0082, zoom: 11 }}
              mapStyle="https://tiles.openfreemap.org/styles/liberty"
              style={{ width: "100%", height: "100%" }}
              onClick={handleMapClick}
              cursor="crosshair"
            >
              {pin && (
                <Marker longitude={pin.lng} latitude={pin.lat} anchor="bottom">
                  <div style={{ fontSize: 28, lineHeight: 1 }}>📍</div>
                </Marker>
              )}
            </Map>
          </div>
          {pin && (
            <p style={{ fontSize: 12, color: "#6B7280", marginTop: 4 }}>
              {pin.lat.toFixed(5)}, {pin.lng.toFixed(5)}
            </p>
          )}
        </Field>

        <button
          type="submit"
          disabled={isSubmitting || create.isPending}
          style={{
            width: "100%",
            padding: "14px",
            background: "#FF9D23",
            color: "#fff",
            border: "none",
            borderRadius: 12,
            fontSize: 15,
            fontWeight: 600,
            cursor: "pointer",
          }}
        >
          {isSubmitting || create.isPending ? "Oluşturuluyor..." : "Etkinliği Oluştur"}
        </button>
      </div>
    </form>
  );
}

const inputStyle: React.CSSProperties = {
  width: "100%",
  padding: "11px 14px",
  border: "1px solid #EEF2F7",
  borderRadius: 10,
  fontSize: 14,
  outline: "none",
  background: "#fff",
  boxSizing: "border-box",
};

function Field({ label, error, children, style }: {
  label: string;
  error?: string;
  children: React.ReactNode;
  style?: React.CSSProperties;
}) {
  return (
    <div style={style}>
      <label style={{ display: "block", fontSize: 13, fontWeight: 500, color: "#374151", marginBottom: 6 }}>
        {label}
      </label>
      {children}
      {error && <p style={{ fontSize: 12, color: "#EF4444", marginTop: 4 }}>{error}</p>}
    </div>
  );
}
