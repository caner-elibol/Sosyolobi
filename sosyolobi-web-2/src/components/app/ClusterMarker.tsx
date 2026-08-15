"use client";

import { useState } from "react";
import { getCategoryIcon, getCategoryColor } from "@/lib/category-icons";

interface ClusterMarkerProps {
  count: number;
  categoryCounts?: Record<string, number>;
  onClick: () => void;
}

export function ClusterMarker({ count, categoryCounts, onClick }: ClusterMarkerProps) {
  const [hovered, setHovered] = useState(false);
  const size = count >= 50 ? 56 : count >= 10 ? 48 : 40;

  const breakdown = Object.entries(categoryCounts ?? {}).sort((a, b) => b[1] - a[1]);
  const topBreakdown = breakdown.slice(0, 4);
  const restCount = breakdown.slice(4).reduce((sum, [, n]) => sum + n, 0);

  return (
    <div
      style={{ position: "relative" }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {hovered && breakdown.length > 0 && (
        <div style={{
          position: "absolute",
          bottom: "calc(100% + 8px)",
          left: "50%",
          transform: "translateX(-50%)",
          background: "var(--color-navy)",
          color: "#fff",
          borderRadius: "var(--radius-sm)",
          padding: "8px 10px",
          boxShadow: "var(--shadow-lg)",
          whiteSpace: "nowrap",
          zIndex: 10,
          pointerEvents: "none",
        }}>
          <div style={{ display: "flex", flexDirection: "column", gap: 4 }}>
            {topBreakdown.map(([name, n]) => {
              const Icon = getCategoryIcon(name);
              const color = getCategoryColor(name);
              return (
                <div key={name} style={{ display: "flex", alignItems: "center", gap: 6, fontSize: 12, fontWeight: 600 }}>
                  <Icon size={12} color={color} />
                  {name} <span style={{ opacity: 0.75, fontWeight: 500 }}>{n}</span>
                </div>
              );
            })}
            {restCount > 0 && (
              <div style={{ fontSize: 11, opacity: 0.75 }}>+{restCount} diğer</div>
            )}
          </div>
          <div style={{
            position: "absolute",
            top: "100%",
            left: "50%",
            transform: "translateX(-50%)",
            width: 0,
            height: 0,
            borderLeft: "5px solid transparent",
            borderRight: "5px solid transparent",
            borderTop: "5px solid var(--color-navy)",
          }} />
        </div>
      )}

      <button
        onClick={(e) => {
          e.stopPropagation();
          onClick();
        }}
        title={breakdown.map(([name, n]) => `${name}: ${n}`).join(", ")}
        style={{
          background: "var(--color-navy)",
          border: "3px solid #fff",
          borderRadius: "50%",
          width: size,
          height: size,
          cursor: "pointer",
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
          boxShadow: "0 3px 12px rgba(0,0,0,0.3)",
          padding: 0,
          color: "#fff",
          fontSize: size >= 48 ? 16 : 14,
          fontWeight: 700,
        }}
      >
        {count}
      </button>
    </div>
  );
}
