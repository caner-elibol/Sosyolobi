interface ClusterMarkerProps {
  count: number;
  onClick: () => void;
}

export function ClusterMarker({ count, onClick }: ClusterMarkerProps) {
  const size = count >= 50 ? 48 : count >= 10 ? 42 : 36;

  return (
    <button
      onClick={(e) => {
        e.stopPropagation();
        onClick();
      }}
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
        boxShadow: "var(--shadow-md)",
        padding: 0,
        color: "#fff",
        fontSize: size >= 42 ? 15 : 13,
        fontWeight: 700,
      }}
    >
      {count}
    </button>
  );
}
