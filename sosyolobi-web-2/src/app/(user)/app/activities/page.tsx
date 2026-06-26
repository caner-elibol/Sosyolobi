"use client";

import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { AppShell } from "@/components/app/AppShell";
import { ActivityCard } from "@/components/app/ActivityCard";
import { FilterChips } from "@/components/app/FilterChips";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useCurrentLocation } from "@/hooks/useCurrentLocation";
import { useNearbyActivities } from "@/hooks/useNearbyActivities";
import { userApiClient } from "@/lib/user-api-client";
import type { Category } from "@/types/user";

export default function ActivitiesPage() {
  const { location } = useCurrentLocation();
  const [categoryId, setCategoryId] = useState<string | null>(null);
  const [search, setSearch] = useState("");

  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: () => userApiClient<Category[]>("/api/categories"),
    staleTime: Infinity,
  });

  const { data: activities = [], isLoading } = useNearbyActivities(
    location
      ? { lat: location.lat, lng: location.lng, radiusMeters: 10000, categoryId: categoryId ?? undefined }
      : null
  );

  const filtered = search.trim()
    ? activities.filter((a) =>
        a.title.toLowerCase().includes(search.toLowerCase()) ||
        a.createdByDisplayName.toLowerCase().includes(search.toLowerCase())
      )
    : activities;

  return (
    <AppShell>
      <div style={{ maxWidth: 800, margin: "0 auto" }}>
        {/* Search */}
        <div style={{ padding: "16px 16px 0" }}>
          <input
            type="text"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Etkinlik ara..."
            style={{
              width: "100%",
              padding: "12px 16px",
              border: "1px solid #EEF2F7",
              borderRadius: 12,
              fontSize: 14,
              outline: "none",
              boxSizing: "border-box",
              background: "#fff",
            }}
          />
        </div>

        {/* Category filter */}
        <FilterChips
          categories={categories}
          selected={categoryId}
          onSelect={setCategoryId}
        />

        {/* Results */}
        <div style={{ padding: "0 16px 24px", display: "flex", flexDirection: "column", gap: 12 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 4 }}>
            <h2 style={{ fontSize: 15, fontWeight: 700, color: "#111827", margin: 0 }}>
              Yakındaki Etkinlikler
            </h2>
            {!isLoading && <span style={{ fontSize: 13, color: "#6B7280" }}>{filtered.length} sonuç</span>}
          </div>

          {isLoading && <LoadingState />}
          {!isLoading && !location && (
            <EmptyState icon="📍" title="Konum gerekli" description="Etkinlikleri görmek için harita sayfasından konum izni verin." />
          )}
          {!isLoading && location && filtered.length === 0 && (
            <EmptyState icon="🔍" title="Etkinlik bulunamadı" description="Arama kelimesini veya filtreyi değiştirin." />
          )}
          {filtered.map((a) => (
            <ActivityCard key={a.id} activity={a} />
          ))}
        </div>
      </div>
    </AppShell>
  );
}
