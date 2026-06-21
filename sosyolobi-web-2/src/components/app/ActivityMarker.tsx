import type { ActivityMapItem } from "@/types/user";
import { CATEGORY_ICONS } from "@/lib/category-icons";

interface ActivityMarkerProps {
  activity: ActivityMapItem;
  onClick: (activity: ActivityMapItem) => void;
  selected?: boolean;
}

export function ActivityMarker({ activity, onClick, selected = false }: ActivityMarkerProps) {
  const icon = CATEGORY_ICONS[activity.categoryName] ?? "📍";

  return (
    <button
      onClick={() => onClick(activity)}
      style={{
        background: selected ? "#081B4B" : "#FF9D23",
        border: "none",
        borderRadius: "50% 50% 50% 0",
        transform: "rotate(-45deg) translate(-50%, -50%)",
        width: selected ? 44 : 36,
        height: selected ? 44 : 36,
        cursor: "pointer",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        boxShadow: "0 2px 8px rgba(0,0,0,0.25)",
        transition: "all 0.15s ease",
        padding: 0,
      }}
    >
      <span style={{ transform: "rotate(45deg)", fontSize: selected ? 20 : 16 }}>{icon}</span>
    </button>
  );
}
