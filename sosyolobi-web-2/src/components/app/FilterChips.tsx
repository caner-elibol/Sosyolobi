import type { Category } from "@/types/user";
import { CATEGORY_ICONS } from "@/lib/category-icons";

interface FilterChipsProps {
  categories: Category[];
  selected: string | null;
  onSelect: (id: string | null) => void;
}

export function FilterChips({ categories, selected, onSelect }: FilterChipsProps) {
  return (
    <div style={{
      display: "flex",
      gap: 8,
      overflowX: "auto",
      padding: "12px 16px",
      scrollbarWidth: "none",
    }}>
      <style>{`.filter-chips-scroll::-webkit-scrollbar { display: none }`}</style>
      <Chip
        active={selected === null}
        onClick={() => onSelect(null)}
        label="Tümü"
        icon="🌍"
      />
      {categories.map((cat) => (
        <Chip
          key={cat.id}
          active={selected === cat.id}
          onClick={() => onSelect(selected === cat.id ? null : cat.id)}
          label={cat.name}
          icon={CATEGORY_ICONS[cat.name] ?? "📍"}
        />
      ))}
    </div>
  );
}

function Chip({ active, onClick, label, icon }: { active: boolean; onClick: () => void; label: string; icon: string }) {
  return (
    <button
      onClick={onClick}
      style={{
        display: "inline-flex",
        alignItems: "center",
        gap: 5,
        padding: "7px 14px",
        borderRadius: 20,
        border: `1.5px solid ${active ? "#FF9D23" : "#EEF2F7"}`,
        background: active ? "#FFF7ED" : "#fff",
        color: active ? "#FF9D23" : "#374151",
        fontSize: 13,
        fontWeight: active ? 600 : 400,
        cursor: "pointer",
        whiteSpace: "nowrap",
        flexShrink: 0,
        transition: "all 0.15s ease",
      }}
    >
      {icon} {label}
    </button>
  );
}
