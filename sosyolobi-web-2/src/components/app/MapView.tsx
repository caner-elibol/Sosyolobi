"use client";

import { useCallback, useMemo, useRef, useState } from "react";
import Map, { Marker, Popup, NavigationControl, type MapRef } from "react-map-gl/maplibre";
import Supercluster from "supercluster";
import type { Map as MaplibreMap } from "maplibre-gl";
import "maplibre-gl/dist/maplibre-gl.css";
import { silenceMissingStyleImages } from "@/lib/map-utils";
import { ActivityMarker } from "@/components/app/ActivityMarker";
import { ClusterMarker } from "@/components/app/ClusterMarker";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";
import type { ActivityMapItem } from "@/types/user";

const OPENFREEMAP_STYLE = "https://tiles.openfreemap.org/styles/liberty";
const WORLD_BBOX: [number, number, number, number] = [-180, -85, 180, 85];

interface MapViewProps {
  center: { lat: number; lng: number };
  activities: ActivityMapItem[];
  onActivityClick?: (activity: ActivityMapItem) => void;
}

interface PointProps {
  activity: ActivityMapItem;
}

function formatDate(iso: string) {
  const d = new Date(iso);
  return d.toLocaleDateString("tr-TR", { day: "numeric", month: "short" }) +
    " " + d.toLocaleTimeString("tr-TR", { hour: "2-digit", minute: "2-digit" });
}

export function MapView({ center, activities, onActivityClick }: MapViewProps) {
  const mapRef = useRef<MapRef>(null);
  const [selected, setSelected] = useState<ActivityMapItem | null>(null);
  const [viewport, setViewport] = useState<{ bbox: [number, number, number, number]; zoom: number }>({
    bbox: WORLD_BBOX,
    zoom: 13,
  });

  const index = useMemo(() => {
    const sc = new Supercluster<PointProps>({ radius: 60, maxZoom: 17 });
    const points: Array<Supercluster.PointFeature<PointProps>> = activities.map((activity) => ({
      type: "Feature",
      properties: { activity },
      geometry: { type: "Point", coordinates: [activity.longitude, activity.latitude] },
    }));
    sc.load(points);
    return sc;
  }, [activities]);

  const clusters = useMemo(
    () => index.getClusters(viewport.bbox, Math.round(viewport.zoom)),
    [index, viewport]
  );

  const syncViewport = useCallback((map: MaplibreMap) => {
    const b = map.getBounds();
    setViewport({
      bbox: [b.getWest(), b.getSouth(), b.getEast(), b.getNorth()],
      zoom: map.getZoom(),
    });
  }, []);

  function handleClusterClick(clusterId: number, longitude: number, latitude: number) {
    const expansionZoom = Math.min(index.getClusterExpansionZoom(clusterId), 18);
    mapRef.current?.flyTo({ center: [longitude, latitude], zoom: expansionZoom, duration: 500 });
  }

  return (
    <Map
      ref={mapRef}
      reuseMaps
      onLoad={(e) => {
        silenceMissingStyleImages(e);
        syncViewport(e.target);
      }}
      onMove={(e) => syncViewport(e.target)}
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

      {clusters.map((feature) => {
        const [longitude, latitude] = feature.geometry.coordinates;

        if ("cluster" in feature.properties && feature.properties.cluster) {
          const clusterFeature = feature as Supercluster.ClusterFeature<PointProps>;
          return (
            <Marker
              key={`cluster-${clusterFeature.properties.cluster_id}`}
              longitude={longitude}
              latitude={latitude}
              anchor="center"
            >
              <ClusterMarker
                count={clusterFeature.properties.point_count}
                onClick={() => handleClusterClick(clusterFeature.properties.cluster_id, longitude, latitude)}
              />
            </Marker>
          );
        }

        const { activity } = (feature as Supercluster.PointFeature<PointProps>).properties;
        return (
          <Marker
            key={activity.id}
            longitude={longitude}
            latitude={latitude}
            anchor="bottom"
            onClick={(e) => {
              e.originalEvent.stopPropagation();
              setSelected(activity);
            }}
          >
            <ActivityMarker
              activity={activity}
              onClick={setSelected}
              selected={selected?.id === activity.id}
            />
          </Marker>
        );
      })}

      {selected && (
        <Popup
          longitude={selected.longitude}
          latitude={selected.latitude}
          anchor="top"
          onClose={() => setSelected(null)}
          closeButton={false}
          offset={20}
        >
          <ActivityPreview activity={selected} onGoToActivity={() => onActivityClick?.(selected)} />
        </Popup>
      )}
    </Map>
  );
}

function ActivityPreview({ activity, onGoToActivity }: { activity: ActivityMapItem; onGoToActivity: () => void }) {
  const Icon = getCategoryIcon(activity.categoryName);
  const color = getCategoryColor(activity.categoryName);

  return (
    <div style={{ minWidth: 220, fontFamily: "Inter, ui-sans-serif, system-ui, sans-serif" }}>
      <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 6 }}>
        <span style={{
          width: 28,
          height: 28,
          borderRadius: "var(--radius-sm)",
          background: `color-mix(in srgb, ${color} 16%, white)`,
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          flexShrink: 0,
        }}>
          <Icon size={15} color={color} />
        </span>
        <p style={{ fontSize: 14, fontWeight: 600, color: "var(--color-foreground)", margin: 0, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
          {activity.title}
        </p>
      </div>
      <p style={{ fontSize: 12, color: "var(--color-muted-foreground)", margin: "0 0 4px" }}>
        {formatDate(activity.eventDate)}
      </p>
      <div style={{ display: "flex", gap: 8, alignItems: "center", marginBottom: 10 }}>
        <span style={{
          fontSize: 11,
          background: "var(--color-accent-soft-bg)",
          color: "var(--color-accent-soft-fg)",
          padding: "2px 6px",
          borderRadius: "var(--radius-sm)",
          fontWeight: 600,
        }}>
          {activity.neededPeopleCount} kişi eksik
        </span>
        {activity.distanceMeters < 1000
          ? <span style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>{Math.round(activity.distanceMeters)} m</span>
          : <span style={{ fontSize: 11, color: "var(--color-muted-foreground)" }}>{(activity.distanceMeters / 1000).toFixed(1)} km</span>
        }
      </div>
      <button
        onClick={onGoToActivity}
        style={{
          width: "100%",
          padding: "8px 12px",
          background: "var(--color-accent)",
          color: "#fff",
          border: "none",
          borderRadius: "var(--radius-sm)",
          fontSize: 13,
          fontWeight: 600,
          cursor: "pointer",
        }}
      >
        Etkinliğe Git →
      </button>
    </div>
  );
}
