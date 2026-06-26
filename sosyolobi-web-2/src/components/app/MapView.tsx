"use client";

import { useState, useCallback } from "react";
import Map, { Marker, Popup, NavigationControl } from "react-map-gl/maplibre";
import "maplibre-gl/dist/maplibre-gl.css";
import { silenceMissingStyleImages } from "@/lib/map-utils";
import { ActivityMarker } from "@/components/app/ActivityMarker";
import type { ActivityMapItem } from "@/types/user";

const OPENFREEMAP_STYLE = "https://tiles.openfreemap.org/styles/liberty";

interface MapViewProps {
  center: { lat: number; lng: number };
  activities: ActivityMapItem[];
  onActivityClick?: (activity: ActivityMapItem) => void;
}

function formatDate(iso: string) {
  const d = new Date(iso);
  return d.toLocaleDateString("tr-TR", { day: "numeric", month: "short" }) +
    " " + d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
}

export function MapView({ center, activities, onActivityClick }: MapViewProps) {
  const [selected, setSelected] = useState<ActivityMapItem | null>(null);

  const handleMarkerClick = useCallback((activity: ActivityMapItem) => {
    setSelected(activity);
    onActivityClick?.(activity);
  }, [onActivityClick]);

  return (
    <Map
      reuseMaps
      onLoad={silenceMissingStyleImages}
      initialViewState={{
        longitude: center.lng,
        latitude: center.lat,
        zoom: 13,
      }}
      mapStyle={OPENFREEMAP_STYLE}
      style={{ width: "100%", height: "100%" }}
    >
      <NavigationControl position="top-right" />

      {/* User location dot */}
      <Marker longitude={center.lng} latitude={center.lat}>
        <div style={{
          width: 14,
          height: 14,
          background: "var(--color-navy)",
          border: "3px solid #fff",
          borderRadius: "50%",
          boxShadow: "0 0 0 3px rgba(11,23,54,0.25)",
        }} />
      </Marker>

      {activities.map((activity) => (
        <Marker
          key={activity.id}
          longitude={activity.longitude}
          latitude={activity.latitude}
          anchor="bottom"
          onClick={(e) => {
            e.originalEvent.stopPropagation();
            handleMarkerClick(activity);
          }}
        >
          <ActivityMarker
            activity={activity}
            onClick={handleMarkerClick}
            selected={selected?.id === activity.id}
          />
        </Marker>
      ))}

      {selected && (
        <Popup
          longitude={selected.longitude}
          latitude={selected.latitude}
          anchor="top"
          onClose={() => setSelected(null)}
          closeButton={false}
          offset={20}
        >
          <div
            onClick={() => onActivityClick?.(selected)}
            style={{
              minWidth: 200,
              cursor: "pointer",
              fontFamily: "Inter, ui-sans-serif, system-ui, sans-serif",
            }}
          >
            <p style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)", margin: "0 0 4px" }}>
              {selected.title}
            </p>
            <p style={{ fontSize: 12, color: "var(--color-muted-foreground)", margin: "0 0 4px" }}>
              {formatDate(selected.eventDate)}
            </p>
            <div style={{ display: "flex", gap: 8, alignItems: "center" }}>
              <span style={{
                fontSize: 11,
                background: "var(--color-accent-soft-bg)",
                color: "var(--color-accent-soft-fg)",
                padding: "2px 6px",
                borderRadius: "var(--radius-sm)",
                fontWeight: 600,
              }}>
                {selected.neededPeopleCount} kişi eksik
              </span>
              {selected.distanceMeters < 1000
                ? <span style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>{Math.round(selected.distanceMeters)} m</span>
                : <span style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>{(selected.distanceMeters / 1000).toFixed(1)} km</span>
              }
            </div>
            <div style={{ marginTop: 8 }}>
              <span style={{
                fontSize: 12,
                color: "var(--color-accent)",
                fontWeight: 600,
              }}>
                Detay →
              </span>
            </div>
          </div>
        </Popup>
      )}
    </Map>
  );
}
