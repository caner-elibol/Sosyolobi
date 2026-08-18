"use client";

import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";

interface ClusterMarkerProps {
  count: number;
  /** Homojen (tek kategorili) küme — rengi/ikonu bu kategoriden gelir. Overflow baloncuğunda yok. */
  categoryName?: string;
  /** Aynı noktada üst üste binen kategori sayısı görsel sınırı aşınca gösterilen "+N" toplayıcı baloncuk. */
  isOverflow?: boolean;
  onClick: () => void;
}

/** Tek bir kategorinin kümesini gösteren küçük, kategori renkli/ikonlu baloncuk — artık
 * birden çok kategoriyi tek "toplam sayı" baloncuğunda gizlemiyor, her kategori kendi
 * baloncuğuyla haritada yan yana render ediliyor (bkz. `MapView`'daki çakışma/yerleşim mantığı). */
export function ClusterMarker({ count, categoryName, isOverflow, onClick }: ClusterMarkerProps) {
  const size = count >= 50 ? 56 : count >= 10 ? 48 : 40;
  const Icon = categoryName ? getCategoryIcon(categoryName) : null;
  const background = isOverflow ? "var(--color-navy)" : getCategoryColor(categoryName ?? "");

  return (
    <button
      onClick={(e) => {
        e.stopPropagation();
        onClick();
      }}
      title={isOverflow ? `+${count} diğer kategori` : `${categoryName}: ${count}`}
      style={{
        background,
        border: "3px solid #fff",
        borderRadius: "50%",
        width: size,
        height: size,
        cursor: "pointer",
        display: "flex",
        flexDirection: "column",
        alignItems: "center",
        justifyContent: "center",
        boxShadow: "0 3px 12px rgba(0,0,0,0.3)",
        padding: 0,
        color: "#fff",
        gap: 1,
      }}
    >
      {!isOverflow && Icon && <Icon size={size >= 48 ? 15 : 12} color="#fff" />}
      <span style={{ fontSize: size >= 48 ? 13 : 11, fontWeight: 700, lineHeight: 1 }}>
        {isOverflow ? `+${count}` : count}
      </span>
    </button>
  );
}
