"use client";

import { Suspense, useState } from "react";
import { useSearchParams } from "next/navigation";
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
import { MapPinOff, SearchX } from "lucide-react";

export default function ActivitiesPage() {
  return (
    <Suspense fallback={<AppShell><LoadingState /></AppShell>}>
      <ActivitiesPageInner />
    </Suspense>
  );
}

function ActivitiesPageInner() {
  const searchParams = useSearchParams();
  const search = searchParams.get("q") ?? "";
  const { location } = useCurrentLocation();
  const [categoryId, setCategoryId] = useState<string | null>(null);

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
    ? activities.filter((a) => {
        const q = search.toLowerCase();
        return (
          a.title.toLowerCase().includes(q) ||
          a.createdByDisplayName.toLowerCase().includes(q) ||
          a.categoryName.toLowerCase().includes(q) ||
          a.addressText.toLowerCase().includes(q)
        );
      })
    : activities;

  return (
    <AppShell>
      <div style={{ maxWidth: 800, margin: "0 auto" }}>
        {/* Category filter */}
        <FilterChips
          categories={categories}
          selected={categoryId}
          onSelect={setCategoryId}
        />

        {/* Results */}
        <div style={{ padding: "0 16px 24px", display: "flex", flexDirection: "column", gap: 12 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 4 }}>
            <h2 style={{ fontSize: 15, fontWeight: 700, color: "var(--color-foreground)", margin: 0 }}>
              Yakındaki Etkinlikler
            </h2>
            {!isLoading && <span style={{ fontSize: 13, color: "var(--color-muted-foreground)" }}>{filtered.length} sonuç</span>}
          </div>

          {isLoading && <LoadingState />}
          {!isLoading && !location && (
            <EmptyState icon={MapPinOff} title="Konum gerekli" description="Etkinlikleri görmek için harita sayfasından konum izni verin." />
          )}
          {!isLoading && location && filtered.length === 0 && (
            <EmptyState icon={SearchX} title="Etkinlik bulunamadı" description="Arama kelimesini veya filtreyi değiştirin." />
          )}
          {filtered.map((a) => (
            <ActivityCard key={a.id} activity={a} />
          ))}
        </div>
      </div>
    </AppShell>
  );
}
