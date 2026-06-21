"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useQuery } from "@tanstack/react-query";
import { AppShell } from "@/components/app/AppShell";
import { MapView } from "@/components/app/MapView";
import { ActivityCard } from "@/components/app/ActivityCard";
import { FilterChips } from "@/components/app/FilterChips";
import { BottomSheet } from "@/components/app/BottomSheet";
import { LocationPermissionCard } from "@/components/app/LocationPermissionCard";
import { LoadingState } from "@/components/app/LoadingState";
import { EmptyState } from "@/components/app/EmptyState";
import { useCurrentLocation } from "@/hooks/useCurrentLocation";
import { useMapActivities } from "@/hooks/useMapActivities";
import { userApiClient } from "@/lib/user-api-client";
import type { Category, ActivityMapItem, Activity } from "@/types/user";

export default function MapPage() {
  const router = useRouter();
  const { location, permission, request: requestLocation } = useCurrentLocation();
  const [selectedCategoryId, setSelectedCategoryId] = useState<string | null>(null);
  const [sheetOpen, setSheetOpen] = useState(false);

  const { data: categories = [] } = useQuery({
    queryKey: ["categories"],
    queryFn: () => userApiClient<Category[]>("/api/categories"),
    staleTime: Infinity,
  });

  const { data: mapActivities = [], isLoading } = useMapActivities(
    location ? { lat: location.lat, lng: location.lng, categoryId: selectedCategoryId ?? undefined } : null
  );

  function handleMarkerClick(activity: ActivityMapItem) {
    router.push(`/app/activities/${activity.id}`);
  }

  // Default: İstanbul
  const center = location ?? { lat: 41.0082, lng: 28.9784 };

  return (
    <AppShell fullscreen>
      <div style={{ display: "flex", flexDirection: "column", height: "calc(100vh - 60px)" }}>

        {/* Filter chips */}
        <div style={{ background: "#fff", borderBottom: "1px solid #EEF2F7", flexShrink: 0 }}>
          <FilterChips
            categories={categories}
            selected={selectedCategoryId}
            onSelect={setSelectedCategoryId}
          />
        </div>

        {/* Location permission (prompt) */}
        {permission === "prompt" && (
          <div style={{ padding: "12px 16px", background: "#fff", flexShrink: 0 }}>
            <LocationPermissionCard
              onAllow={requestLocation}
              onDismiss={() => {/* state stays as prompt, map shows Istanbul */}}
            />
          </div>
        )}

        {/* Main layout */}
        <div style={{ flex: 1, display: "flex", overflow: "hidden" }}>
          {/* Desktop: Left panel */}
          <div
            className="hidden-mobile"
            style={{
              width: 420,
              flexShrink: 0,
              overflowY: "auto",
              borderRight: "1px solid #EEF2F7",
              background: "#FAFBFD",
              padding: "16px",
              display: "flex",
              flexDirection: "column",
              gap: 12,
            }}
          >
            <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
              <h2 style={{ fontSize: 16, fontWeight: 700, color: "#111827", margin: 0 }}>
                Yakındaki Etkinlikler
              </h2>
              <span style={{ fontSize: 13, color: "#6B7280" }}>{mapActivities.length} etkinlik</span>
            </div>

            {isLoading && <LoadingState message="Etkinlikler aranıyor..." />}
            {!isLoading && mapActivities.length === 0 && (
              <EmptyState
                icon="🗺️"
                title="Yakında etkinlik bulunamadı"
                description="Arama yarıçapını artırın veya filtre kaldırın."
              />
            )}
            {mapActivities.map((a) => (
              <ActivityCard key={a.id} activity={a as unknown as Activity} compact />
            ))}
          </div>

          {/* Map */}
          <div style={{ flex: 1, position: "relative" }}>
            {permission === "loading" ? (
              <div style={{
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                height: "100%",
                background: "#f0f0f0",
              }}>
                <LoadingState message="Konum alınıyor..." />
              </div>
            ) : (
              <MapView
                center={center}
                activities={mapActivities}
                onActivityClick={handleMarkerClick}
              />
            )}

            {/* Mobile: show list button */}
            <button
              className="show-mobile"
              onClick={() => setSheetOpen(true)}
              style={{
                position: "absolute",
                bottom: 80,
                left: "50%",
                transform: "translateX(-50%)",
                background: "#081B4B",
                color: "#fff",
                border: "none",
                borderRadius: 24,
                padding: "10px 20px",
                fontSize: 14,
                fontWeight: 600,
                cursor: "pointer",
                boxShadow: "0 4px 12px rgba(0,0,0,0.2)",
              }}
            >
              📋 Listeyi Gör ({mapActivities.length})
            </button>
          </div>
        </div>

        {/* Mobile: Bottom sheet */}
        <BottomSheet open={sheetOpen} onClose={() => setSheetOpen(false)} title="Yakındaki Etkinlikler">
          {isLoading && <LoadingState />}
          {!isLoading && mapActivities.length === 0 && (
            <EmptyState icon="🗺️" title="Yakında etkinlik yok" />
          )}
          <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
            {mapActivities.map((a) => (
              <ActivityCard key={a.id} activity={a as unknown as Activity} compact />
            ))}
          </div>
        </BottomSheet>
      </div>

      <style>{`
        @media (max-width: 767px) {
          .show-mobile { display: flex !important; }
        }
        @media (min-width: 768px) {
          .show-mobile { display: none !important; }
        }
      `}</style>
    </AppShell>
  );
}
