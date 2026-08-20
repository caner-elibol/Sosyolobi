/**
 * Backend-served image URLs (avatars, category photos) are built from
 * whichever host issued the request that first cached them, not
 * reconstructed per-request — if that host differs from the current
 * `NEXT_PUBLIC_API_URL`, the stored URL's origin is unreachable and the
 * image silently fails to load. Always rewrite to this client's own API
 * origin, keeping only the path.
 */
export function resolveImageUrl<T extends string | null | undefined>(url: T): T {
  if (!url) return url;
  const apiBase = process.env.NEXT_PUBLIC_API_URL;
  if (!apiBase) return url;
  try {
    const parsed = new URL(url, apiBase);
    const base = new URL(apiBase);
    if (parsed.origin === base.origin) return url;
    return `${base.origin}${parsed.pathname}${parsed.search}` as T;
  } catch {
    return url;
  }
}
