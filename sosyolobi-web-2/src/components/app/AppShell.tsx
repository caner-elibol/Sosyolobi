import { AppTopbar } from "@/components/app/AppTopbar";
import { AppBottomNav } from "@/components/app/AppBottomNav";

interface AppShellProps {
  children: React.ReactNode;
  fullscreen?: boolean;
}

export function AppShell({ children, fullscreen = false }: AppShellProps) {
  return (
    <div style={{
      display: "flex",
      flexDirection: "column",
      minHeight: "100vh",
      fontFamily: "Inter, ui-sans-serif, system-ui, sans-serif",
      background: "#FAFBFD",
    }}>
      <AppTopbar />
      <main style={{
        flex: 1,
        ...(fullscreen ? {} : { padding: "0 0 64px 0" }),
      }}>
        {children}
      </main>
      <AppBottomNav />

      <style>{`
        @media (min-width: 768px) {
          .hidden-mobile { display: flex !important; }
          .show-mobile { display: none !important; }
          main { padding-bottom: 0 !important; }
        }
        @media (max-width: 767px) {
          .hidden-mobile { display: none !important; }
          .show-mobile { display: flex !important; }
        }
      `}</style>
    </div>
  );
}
