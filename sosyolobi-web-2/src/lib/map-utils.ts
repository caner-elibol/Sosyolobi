import type { MapLibreEvent, MapStyleImageMissingEvent } from "maplibre-gl";

// OpenFreeMap "liberty" stilindeki bazı POI ikonları (office, atm, gate vb.)
// sprite'ta yok; her eksik id için 1x1 şeffaf görsel kaydedip maplibre'in
// "styleimagemissing" uyarısını tekrar tekrar konsola basmasını önlüyoruz.
export function silenceMissingStyleImages(e: MapLibreEvent) {
  e.target.on("styleimagemissing", (ev: MapStyleImageMissingEvent) => {
    const map = ev.target;
    if (map.hasImage(ev.id)) return;
    map.addImage(ev.id, { width: 1, height: 1, data: new Uint8Array(4) });
  });
}
