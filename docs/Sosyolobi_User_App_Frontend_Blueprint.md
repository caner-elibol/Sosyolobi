# Sosyolobi User App Frontend Blueprint

## Amaç

Sosyolobi User App, kullanıcıların yakındaki sosyal aktiviteleri keşfetmesini, etkinlik oluşturmasını, etkinliklere katılım isteği göndermesini ve güvenli şekilde yeni insanlarla buluşmasını sağlayan web/PWA uygulamasıdır.

Bu uygulama admin panelden tamamen ayrıdır.

```txt
/        → Landing page
/app     → User App
/admin   → Admin Dashboard
```

Backend mevcut .NET API olacaktır. Frontend Next.js ile geliştirilecektir.

---

## Ürün Cümlesi

> Yapacak şey var, insan yoksa Sosyolobi var.

User App'in ana deneyimi:

```txt
Konum al → Yakındaki etkinlikleri göster → Katıl / oluştur → Onaylan → Buluş
```

---

## Kritik Tasarım Yaklaşımı

Bu bir klasik dashboard değildir.

Bu bir sosyal keşif uygulamasıdır.

Referans hissiyat:

- Airbnb
- Swarm/Foursquare keşif mantığı
- Apple Maps sadeliği
- Linear kalitesi
- Modern consumer app UI

Olmaması gerekenler:

- ERP görünümü
- CRM görünümü
- Bootstrap görünümü
- Ağır admin panel havası
- Gereksiz tablo ağırlığı

---

## Teknoloji

```txt
Framework: Next.js App Router
Language: TypeScript
Styling: Tailwind CSS
UI: shadcn/ui
Icons: lucide-react
Map: MapLibre GL JS
Map Data: OpenStreetMap
State/Data: TanStack Query
Forms: React Hook Form + Zod
Animations: Framer Motion
Auth: JWT Cookie
PWA: Enabled later
```

---

## Renk Sistemi

Logo renkleri korunacaktır.

```css
Primary Navy: #081B4B
Accent Orange: #FF9D23
Background: #FAFBFD
Card: #FFFFFF
Border: #EEF2F7
Text: #111827
Muted Text: #6B7280
Success: #22C55E
Warning: #F59E0B
Danger: #EF4444
```

Kural:

- Turuncu sadece ana aksiyonlarda kullanılmalı.
- Lacivert başlık, navbar ve güçlü alanlarda kullanılmalı.
- Çok renkli dashboard hissi verilmemeli.

---

## Tipografi

```css
font-family: Inter, ui-sans-serif, system-ui;
```

Ölçek:

```txt
Hero title: 48-64px / 700
Page title: 32-40px / 700
Section title: 24-28px / 700
Card title: 18-20px / 600
Body: 15-16px / 400
Small: 13-14px / 400
```

---

## Layout Yapısı

```txt
src/app
 ├─ page.tsx                       → landing page
 ├─ auth
 │   ├─ login/page.tsx
 │   └─ verify/page.tsx
 │
 ├─ app
 │   ├─ layout.tsx                 → user app layout
 │   ├─ page.tsx                   → redirect to /app/map
 │   ├─ map/page.tsx               → ana keşif ekranı
 │   ├─ activities/page.tsx        → liste görünümü
 │   ├─ activities/create/page.tsx → etkinlik oluştur
 │   ├─ activities/[id]/page.tsx   → etkinlik detay
 │   ├─ requests/page.tsx          → katılım istekleri
 │   ├─ profile/page.tsx           → profilim
 │   ├─ notifications/page.tsx     → bildirimler
 │   └─ settings/page.tsx          → ayarlar
 │
 └─ admin                          → admin tarafı ayrı kalacak
```

---

## User App Ana Navigasyon

Desktop:

```txt
Üst navbar:
- Logo
- Keşfet
- Etkinlikler
- Oluştur
- İstekler
- Bildirimler
- Profil
```

Mobile:

```txt
Bottom tab bar:
- Keşfet
- Liste
- Oluştur
- İstekler
- Profil
```

Mobile-first ama desktop kalitesi yüksek olacak.

---

## Ana Ekran: /app/map

Bu uygulamanın kalbi harita ekranıdır.

### Desktop düzeni

```txt
-------------------------------------------------------
Topbar: Logo | Search | Filters | Notifications | Profile
-------------------------------------------------------
Left panel: Nearby activity cards       Right: MapLibre Map
-------------------------------------------------------
```

Sol panel genişliği: 420px.

Harita kalan alanı kaplar.

### Mobile düzeni

```txt
Top search/filter
Map full screen
Bottom sheet activity cards
Bottom tab navigation
```

### Harita Davranışı

- Kullanıcı konum izni ister.
- İzin verilirse harita kullanıcı konumuna odaklanır.
- İzin verilmezse varsayılan olarak İstanbul gösterilir.
- Haritada kullanıcıların canlı konumu gösterilmez.
- Sadece etkinlik pinleri gösterilir.
- Pinler kategori ikonlarıyla gösterilir.
- Çok fazla pin varsa cluster kullanılır.

### Harita Pinleri

Kategori ikonları:

```txt
⚽ Futbol
🏀 Basketbol
🏕️ Kamp
🎿 Kayak
🎵 Konser
☕ Kahve
🎲 Masa Oyunu
🏃 Koşu
🚴 Bisiklet
```

Pin tıklanınca küçük preview kartı açılır:

```txt
Halı Saha Maçı
Bugün 20:00
2 kişi eksik
850 m yakında
[Detay]
```

---

## Activity Card Component

Dosya:

```txt
components/app/ActivityCard.tsx
```

İçerik:

```txt
Kategori ikonu
Başlık
Tarih/saat
Mesafe
Eksik kişi sayısı
Ücret bilgisi
Creator adı/avatar
Katılmak istiyorum CTA
```

Görsel stil:

```txt
border-radius: 24px
background: white
border: 1px solid #EEF2F7
shadow: çok hafif
padding: 20-24px
```

---

## Etkinlik Liste Ekranı: /app/activities

Harita kullanmak istemeyen kullanıcılar için liste görünümü.

Özellikler:

- Arama
- Kategori filtreleri
- Tarih filtresi
- Mesafe filtresi
- Ücretli/ücretsiz filtresi
- Skill level filtresi

Liste kart formatında olmalı, tablo kullanılmamalı.

---

## Etkinlik Detay: /app/activities/[id]

İçerik:

```txt
Başlık
Kategori
Tarih/saat
Yaklaşık konum
Mesafe
Eksik kişi sayısı
Katılım ücreti
Açıklama
Oluşturan kişi profil özeti
Katılımcılar
Katılma isteği gönder butonu
Şikayet et butonu
```

Gizlilik kuralı:

- Tam adres herkese gösterilmez.
- Kullanıcı katılım isteği onaylandıktan sonra detay adres gösterilir.

---

## Etkinlik Oluşturma: /app/activities/create

Form alanları:

```txt
Başlık
Kategori
Açıklama
Tarih/saat
Konum seçimi
Eksik kişi sayısı
Toplam kişi sayısı opsiyonel
Katılım ücreti opsiyonel
Seviye
Cinsiyet tercihi opsiyonel
Adres açıklaması
Gizli adres detayı
```

Konum seçimi:

- Haritadan pin bırakma
- Mevcut konumu kullanma
- Adres arama

Validasyon:

```txt
Başlık zorunlu
Kategori zorunlu
Tarih gelecekte olmalı
Konum zorunlu
Eksik kişi sayısı minimum 1
```

---

## Katılım İstekleri: /app/requests

İki sekme:

```txt
Benim gönderdiğim istekler
Bana gelen istekler
```

Bana gelen isteklerde:

```txt
Kullanıcı adı
Avatar
Bio kısa metin
Trust score
Tamamlanan etkinlik sayısı
Ortalama puan
Onayla
Reddet
```

---

## Profil: /app/profile

İçerik:

```txt
Avatar
Display name
Bio
Telefon doğrulandı badge
Trust score
Ortalama puan
Tamamlanan etkinlik sayısı
İlgi alanları
Yorumlar
Oluşturduğu etkinlikler
Katıldığı etkinlikler
```

Telefon numarası asla herkese açık gösterilmez.

---

## Bildirimler: /app/notifications

Bildirim tipleri:

```txt
Katılım isteği geldi
Katılım isteğin onaylandı
Etkinlik iptal edildi
Yeni yorum geldi
Şikayet sonucu
Yakındaki önerilen etkinlik
```

Başlangıçta polling/TanStack Query yeterli.

Sonra SignalR ile realtime yapılabilir.

---

## Auth Flow

Telefon numarasıyla giriş:

```txt
/auth/login
/auth/verify
```

Akış:

```txt
Telefon gir
OTP gönder
Kodu doğrula
JWT cookie yaz
/app/map yönlendir
```

Cookie adı admin ile karışmamalı:

```txt
user_token
```

Admin token:

```txt
admin_token
```

---

## API Client

Dosya:

```txt
lib/user-api-client.ts
```

Kural:

- `user_token` cookie okunur.
- Authorization Bearer header eklenir.
- 401 olursa `/auth/login` yönlendirilir.
- Response wrapper `ApiResponse<T>` beklenir.

---

## Backend Endpoint Beklentileri

Mevcut backend endpointleri kullanılacaktır.

User App için beklenen endpointler:

```txt
POST /api/auth/login
POST /api/auth/verify
GET  /api/activities/nearby
GET  /api/activities/map
GET  /api/activities/{id}
POST /api/activities
POST /api/activities/{id}/join-request
GET  /api/participation-requests/mine
GET  /api/participation-requests/incoming
POST /api/participation-requests/{id}/approve
POST /api/participation-requests/{id}/reject
GET  /api/profile/me
PUT  /api/profile/me
GET  /api/notifications
PATCH /api/notifications/{id}/read
```

---

## MapLibre Entegrasyonu

Paket önerileri:

```bash
npm install maplibre-gl react-map-gl
```

CSS:

```ts
import "maplibre-gl/dist/maplibre-gl.css";
```

Harita style başlangıç:

```txt
https://demotiles.maplibre.org/style.json
```

Production için daha sonra özel tile provider seçilebilir.

---

## Konum Kullanımı

Browser API:

```ts
navigator.geolocation.getCurrentPosition();
```

Kural:

- Kullanıcıdan açık izin alınır.
- İzin verilmezse manuel konum seçme sunulur.
- Kullanıcının tam canlı konumu başka kullanıcılara gösterilmez.
- Backend'e sadece yakındaki etkinlikleri bulmak için gönderilir.

---

## Components

```txt
components/app/AppTopbar.tsx
components/app/AppBottomNav.tsx
components/app/AppShell.tsx
components/app/ActivityCard.tsx
components/app/ActivityMarker.tsx
components/app/MapView.tsx
components/app/FilterChips.tsx
components/app/LocationPermissionCard.tsx
components/app/CreateActivityForm.tsx
components/app/UserAvatar.tsx
components/app/TrustBadge.tsx
components/app/EmptyState.tsx
components/app/LoadingState.tsx
components/app/BottomSheet.tsx
```

---

## Hooks

```txt
hooks/useCurrentLocation.ts
hooks/useNearbyActivities.ts
hooks/useMapActivities.ts
hooks/useCreateActivity.ts
hooks/useJoinRequest.ts
hooks/useProfile.ts
hooks/useNotifications.ts
```

---

## Tasarım Kuralları

- Kartlar yuvarlak ve ferah olmalı.
- Harita ekranı kalabalık hissettirmemeli.
- CTA butonları turuncu olmalı.
- Lacivert güçlü alanlarda kullanılmalı.
- Kullanıcı uygulaması sosyal, canlı ve sıcak hissettirmeli.
- Admin panel gibi soğuk olmamalı.

---

## Responsive Kuralları

### Desktop

```txt
Topbar + left panel + map
```

### Tablet

```txt
Topbar + map + floating cards
```

### Mobile

```txt
Topbar search
Full map
Bottom sheet
Bottom navigation
```

---

## İlk Fazda Geliştirilecekler

Faz 1:

```txt
User auth pages
User app layout
Map page
Nearby activities list
Activity detail
Create activity
Join request
Profile page
```

Faz 2:

```txt
Notifications
Incoming/outgoing requests
Reviews
Settings
SignalR
PWA install prompt
```

Faz 3:

```txt
Clubs/groups
Follow/friend system
Feed
Messaging
Premium features
```

---

## Claude İçin Kritik Talimat

```txt
Do not create a generic dashboard.
Do not use tables for user-facing activity lists.
Do not make the app look like admin panel.
Do not use random colors.
Do not show user live locations on map.
Use MapLibre for map.
Use Sosyolobi brand colors.
Build /app separately from /admin.
```

---

## Başarı Kriteri

İlk açılışta kullanıcı şunu hissetmeli:

```txt
Yakınımda yapılacak şeyler var.
Bunlara güvenle katılabilirim.
Ben de kolayca etkinlik oluşturabilirim.
```

Sosyolobi User App'in merkezi:

```txt
Harita + Etkinlik Kartları + Güvenli Katılım
```
