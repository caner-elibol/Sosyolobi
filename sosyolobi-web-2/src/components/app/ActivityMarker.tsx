import type { ActivityMapItem } from "@/types/user";
import { getCategoryIcon } from "@/lib/category-icons";

interface ActivityMarkerProps {
  activity: ActivityMapItem;
  onClick: (activity: ActivityMapItem) => void;
  selected?: boolean;
}

export function ActivityMarker({ activity, onClick, selected = false }: ActivityMarkerProps) {
  const Icon = getCategoryIcon(activity.categoryName);

  return (
    <button
      onClick={() => onClick(activity)}
      style={{
        background: selected ? "var(--color-navy)" : "var(--color-accent)",
        border: "2px solid #fff",
        borderRadius: "50% 50% 50% 0",
        transform: "rotate(-45deg) translate(-50%, -50%)",
        width: selected ? 44 : 36,
        height: selected ? 44 : 36,
        cursor: "pointer",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        boxShadow: "var(--shadow-md)",
        transition: "transform 0.15s var(--ease-out), background 0.15s ease",
        padding: 0,
      }}
    >
      <Icon
        size={selected ? 20 : 16}
        color="#fff"
        strokeWidth={2.25}
        style={{ transform: "rotate(45deg)" }}
      />
    </button>
  );
}
