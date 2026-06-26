"use client";

import { useState, useEffect, useCallback } from "react";

interface GeoLocation {
  lat: number;
  lng: number;
}

type PermissionState = "prompt" | "granted" | "denied" | "loading";

export function useCurrentLocation() {
  const [location, setLocation] = useState<GeoLocation | null>(null);
  const [permission, setPermission] = useState<PermissionState>("loading");

  const request = useCallback(() => {
    setPermission("loading");
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        setLocation({ lat: pos.coords.latitude, lng: pos.coords.longitude });
        setPermission("granted");
      },
      () => {
        setPermission("denied");
        // Default: Istanbul
        setLocation({ lat: 41.0082, lng: 28.9784 });
      },
      { enableHighAccuracy: false, timeout: 8000, maximumAge: 60_000 }
    );
  }, []);

  useEffect(() => {
    // React Strict Mode dev'de bu effect mount->cleanup->mount sırasıyla iki kez
    // çalışabilir; `cancelled` bayrağı olmadan iki ayrı permissions.query() çağrısı
    // permission state'ini "granted" -> "loading" -> "granted" arasında art arda
    // değiştirip Map bileşeninin hızlıca unmount/remount olmasına (ve maplibre-gl'in
    // container hatası vermesine) yol açıyordu.
    let cancelled = false;

    if (!navigator.geolocation) {
      setPermission("denied");
      setLocation({ lat: 41.0082, lng: 28.9784 });
      return;
    }
    navigator.permissions
      .query({ name: "geolocation" })
      .then((result) => {
        if (cancelled) return;
        if (result.state === "granted") {
          request();
        } else if (result.state === "denied") {
          setPermission("denied");
          setLocation({ lat: 41.0082, lng: 28.9784 });
        } else {
          setPermission("prompt");
        }
      })
      .catch(() => {
        if (!cancelled) setPermission("prompt");
      });

    return () => {
      cancelled = true;
    };
  }, [request]);

  return { location, permission, request };
}
