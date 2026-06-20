# Sosyolobi Admin Dashboard Frontend Blueprint

## Amaç

Bu doküman, mevcut Sosyolobi Backend API iskeletini değiştirmeden, admin dashboard tarafının frontend ağırlıklı tasarımını ve geliştirme kapsamını tanımlar.

Backend tarafında yalnızca eksikse gerekli admin endpointleri için Controller/Service eklenebilir. Ana odak Next.js admin panelidir.

---

## Teknoloji Kararı

```txt
Frontend: Next.js
UI: TailwindCSS + shadcn/ui
State/Data: TanStack Query
Form: React Hook Form + Zod
Charts: Recharts
Table: TanStack Table
Auth: JWT / Role based guard
Map: MapLibre + OpenStreetMap
```

Admin panel ayrı proje olmayacak.

Önerilen yapı:

```txt
sosyolobi-web
 └─ app
    ├─ (public)
    ├─ (app)
    └─ admin
```

veya route group ile:

```txt
app/(admin)/admin/...
```

---

## VISUAL REFERENCE 01

Bu görseller yalnızca referanstır.

- Sosyolobi_Admin_User_Screen.png
- Sosyolobi_Admin_Dashboard_Screen.png
- Sosyolobi_Admin_Activities_Screen.png

Birebir kopyalanmayacaktır.

Amaç:

- Sol sidebar
- Üst navbar
- İstatistik kartları
- Son aktiviteler
- Son şikayetler
- Temiz spacing sistemi

Tasarım dili:

- Modern SaaS
- Minimal
- Apple + Linear + Stripe karışımı

Kesinlikle:

- Bootstrap görünümü olmayacak
- Ağır gölgeler olmayacak
- Çok fazla renk kullanılmayacak

## Admin Panelin Ana Rolü

Sosyolobi sosyal ve konum tabanlı bir platform olduğu için admin panel sadece veri yönetimi değil, aynı zamanda güvenlik ve moderasyon merkezidir.

Admin panel şunları sağlamalı:

- Kullanıcıları izleme
- Etkinlikleri denetleme
- Şikayetleri yönetme
- Yorum ve puanları inceleme
- Kategorileri yönetme
- Platform metriklerini görme
- Riskli davranışları takip etme

---

## Route Yapısı

```txt
/admin/login
/admin/dashboard
/admin/users
/admin/users/[id]
/admin/activities
/admin/activities/[id]
/admin/reports
/admin/reports/[id]
/admin/reviews
/admin/categories
/admin/notifications
/admin/settings
```

---

## Layout

Admin panel layout'u kullanıcı uygulamasından daha sade ve operasyon odaklı olmalı.

### Sol Sidebar

```txt
Dashboard
Kullanıcılar
Etkinlikler
Şikayetler
Yorumlar
Kategoriler
Bildirimler
Ayarlar
Çıkış
```

### Üst Bar

```txt
Arama
Admin adı
Rol bilgisi
Bildirim ikonu
Tema butonu
```

### Görsel Stil

Sosyolobi marka renkleri korunacak:

```txt
Primary Navy: #081B4B
Accent Orange: #FF9D23
Background: #F8FAFC
Card: #FFFFFF
Border: #E5E7EB
Success: #22C55E
Danger: #EF4444
Warning: #F59E0B
```

Admin panelde turuncu vurgu az kullanılmalı. Ana aksiyonlarda ve uyarılarda güçlü görünmeli.

---

## 1. Admin Login

### Amaç

Sadece Admin ve SuperAdmin rollerinin giriş yapabilmesi.

### Ekran Bileşenleri

- Sosyolobi logo
- Telefon/e-posta alanı
- Şifre veya OTP alanı
- Giriş butonu
- Hata mesajı

### Kontroller

- Admin rolü yoksa giriş reddedilir.
- Token localStorage yerine mümkünse httpOnly cookie ile saklanır.
- Yetkisiz kullanıcı `/admin/login` sayfasına yönlenir.

---

## 2. Dashboard Ana Sayfa

### Amaç

Platformun genel durumunu tek bakışta göstermek.

### KPI Kartları

```txt
Toplam Kullanıcı
Doğrulanmış Kullanıcı
Aktif Etkinlik
Bugünkü Etkinlik
Bekleyen Şikayet
Ortalama Puan
```

### Grafikler

```txt
Son 7 Gün Kullanıcı Kaydı
Son 7 Gün Etkinlik Oluşturma
Kategori Bazlı Etkinlik Dağılımı
Şehir/İlçe Dağılımı
```

### Listeler

```txt
Son Oluşturulan Etkinlikler
Son Kayıt Olan Kullanıcılar
Acil Şikayetler
```

### Kullanılacak Bileşenler

- StatCard
- LineChart
- PieChart
- DataTable
- StatusBadge

---

## 3. Kullanıcı Yönetimi

Route:

```txt
/admin/users
```

### Liste Kolonları

```txt
Avatar
Ad Soyad / Display Name
Telefon Doğrulandı mı?
Ortalama Puan
Tamamlanan Etkinlik
Durum
Kayıt Tarihi
Aksiyonlar
```

### Filtreler

```txt
Arama
Durum
Telefon doğrulama
Puan aralığı
Kayıt tarihi
```

### Aksiyonlar

```txt
Detay Gör
Askıya Al
Banla
Banı Kaldır
Profil Notu Ekle
```

---

## 4. Kullanıcı Detay Sayfası

Route:

```txt
/admin/users/[id]
```

### Bölümler

```txt
Profil Özeti
Telefon Doğrulama Durumu
Katıldığı Etkinlikler
Oluşturduğu Etkinlikler
Aldığı Yorumlar
Verdiği Yorumlar
Şikayet Geçmişi
Admin Notları
```

### Güvenlik Göstergeleri

```txt
Trust Score
Review Count
Completed Activity Count
Report Count
Last Login
Account Status
```

### Aksiyonlar

```txt
Kullanıcıyı askıya al
Kullanıcıyı banla
Telefon doğrulamasını sıfırla
Admin notu ekle
```

---

## 5. Etkinlik Yönetimi

Route:

```txt
/admin/activities
```

### Liste Kolonları

```txt
Başlık
Kategori
Oluşturan Kullanıcı
Tarih/Saat
Konum
Kişi Sayısı
Durum
Oluşturulma Tarihi
Aksiyonlar
```

### Filtreler

```txt
Kategori
Durum
Tarih aralığı
Şehir/ilçe
Oluşturan kullanıcı
```

### Aksiyonlar

```txt
Detay Gör
Yayından Kaldır
İptal Et
Öne Çıkar
Sil
```

---

## 6. Etkinlik Detay Sayfası

Route:

```txt
/admin/activities/[id]
```

### Bölümler

```txt
Etkinlik Bilgileri
Harita Konumu
Oluşturan Kullanıcı
Katılımcı Listesi
Katılım İstekleri
Şikayetler
Yorumlar
```

### Harita Alanı

Admin detay sayfasında etkinliğin konumu pin olarak gösterilir.

Gösterilecek bilgiler:

```txt
Latitude
Longitude
Adres metni
Yaklaşık lokasyon
Gizli adres detayı admin tarafından görülebilir
```

---

## 7. Şikayet Yönetimi

Route:

```txt
/admin/reports
```

### Şikayet Tipleri

```txt
Kullanıcı şikayeti
Etkinlik şikayeti
Yorum şikayeti
Güvenlik ihlali
Spam / sahte hesap
Rahatsız edici davranış
```

### Liste Kolonları

```txt
Şikayet Tipi
Şikayet Eden
Şikayet Edilen
Öncelik
Durum
Tarih
Aksiyonlar
```

### Durumlar

```txt
Bekliyor
İnceleniyor
Çözüldü
Reddedildi
```

### Aksiyonlar

```txt
İncelemeye Al
Çözüldü İşaretle
Reddet
Kullanıcıyı Askıya Al
Etkinliği Kaldır
Admin Notu Ekle
```

Bu ekran admin panelin en önemli ekranlarından biridir.

---

## 8. Yorum ve Puan Yönetimi

Route:

```txt
/admin/reviews
```

### Liste Kolonları

```txt
Yorum Yapan
Yorum Alan
Etkinlik
Puan
Yorum
Tarih
Durum
Aksiyonlar
```

### Aksiyonlar

```txt
Yorumu Gizle
Yorumu Geri Aç
Kullanıcı Detayına Git
Etkinlik Detayına Git
```

---

## 9. Kategori Yönetimi

Route:

```txt
/admin/categories
```

### Alanlar

```txt
Ad
Slug
İkon
Renk
Sıralama
Aktif/Pasif
```

### Varsayılan Kategoriler

```txt
Futbol
Basketbol
Voleybol
Koşu
Bisiklet
Kamp
Doğa Yürüyüşü
Kayak
Konser
Masa Oyunu
Kahve & Sohbet
Sinema
Yemek
Teknoloji
```

### Aksiyonlar

```txt
Kategori oluştur
Kategori düzenle
Aktif/Pasif yap
Sıralama değiştir
```

---

## 10. Bildirim Yönetimi

Route:

```txt
/admin/notifications
```

### Amaç

Adminin kullanıcılara sistem bildirimi gönderebilmesi.

### Bildirim Tipleri

```txt
Genel duyuru
Etkinlik hatırlatma
Güvenlik bildirimi
Kategori duyurusu
Kampanya / özellik duyurusu
```

### Form Alanları

```txt
Başlık
Mesaj
Hedef kitle
Kategori
Şehir/ilçe
Gönderim zamanı
```

---

## 11. Ayarlar

Route:

```txt
/admin/settings
```

### Ayar Grupları

```txt
Platform Ayarları
Güvenlik Ayarları
Moderasyon Ayarları
Harita Ayarları
Bildirim Ayarları
```

### Örnek Ayarlar

```txt
Maksimum etkinlik oluşturma limiti
Günlük katılım isteği limiti
Şikayet eşiği
Otomatik askıya alma eşiği
Minimum yaş sınırı
```

---

## Frontend Dosya Yapısı

```txt
src/
 ├─ app/
 │  └─ (admin)/
 │     └─ admin/
 │        ├─ layout.tsx
 │        ├─ login/page.tsx
 │        ├─ dashboard/page.tsx
 │        ├─ users/page.tsx
 │        ├─ users/[id]/page.tsx
 │        ├─ activities/page.tsx
 │        ├─ activities/[id]/page.tsx
 │        ├─ reports/page.tsx
 │        ├─ reports/[id]/page.tsx
 │        ├─ reviews/page.tsx
 │        ├─ categories/page.tsx
 │        ├─ notifications/page.tsx
 │        └─ settings/page.tsx
 │
 ├─ components/
 │  └─ admin/
 │     ├─ AdminSidebar.tsx
 │     ├─ AdminTopbar.tsx
 │     ├─ AdminPageHeader.tsx
 │     ├─ StatCard.tsx
 │     ├─ StatusBadge.tsx
 │     ├─ DataTable.tsx
 │     ├─ ConfirmDialog.tsx
 │     ├─ EmptyState.tsx
 │     └─ AdminMapPreview.tsx
 │
 ├─ features/
 │  └─ admin/
 │     ├─ users/
 │     ├─ activities/
 │     ├─ reports/
 │     ├─ reviews/
 │     ├─ categories/
 │     └─ dashboard/
 │
 ├─ lib/
 │  ├─ api-client.ts
 │  ├─ auth.ts
 │  ├─ format.ts
 │  └─ constants.ts
 │
 └─ types/
    └─ admin.ts
```

---

## API Client Yapısı

Frontend tarafında endpoint çağrıları tek merkezden yapılmalı.

```ts
// lib/api-client.ts
export async function apiClient<T>(
  url: string,
  options?: RequestInit,
): Promise<T> {
  const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}${url}`, {
    ...options,
    credentials: "include",
    headers: {
      "Content-Type": "application/json",
      ...(options?.headers || {}),
    },
  });

  if (!response.ok) {
    throw new Error("API request failed");
  }

  return response.json();
}
```

---

## Gerekebilecek Backend Endpointleri

Mevcut backend iskeleti değişmeyecek. Ancak admin dashboard için aşağıdaki endpointler eksikse eklenebilir.

```txt
GET    /api/admin/dashboard/stats
GET    /api/admin/users
GET    /api/admin/users/{id}
PATCH  /api/admin/users/{id}/status
GET    /api/admin/activities
GET    /api/admin/activities/{id}
PATCH  /api/admin/activities/{id}/status
GET    /api/admin/reports
GET    /api/admin/reports/{id}
PATCH  /api/admin/reports/{id}/status
GET    /api/admin/reviews
PATCH  /api/admin/reviews/{id}/visibility
GET    /api/admin/categories
POST   /api/admin/categories
PUT    /api/admin/categories/{id}
PATCH  /api/admin/categories/{id}/status
POST   /api/admin/notifications
```

---

## Yetkilendirme

Frontend guard mantığı:

```txt
/admin/* route'ları sadece Admin veya SuperAdmin rolü ile açılır.
Normal kullanıcı admin paneline erişemez.
Token yoksa login sayfasına yönlendirilir.
Rol yetersizse 403 sayfası gösterilir.
```

---

## Admin Dashboard Öncelik Sırası

### Faz 1

```txt
Admin layout
Admin login
Dashboard istatistikleri
Kullanıcı listesi
Etkinlik listesi
Şikayet listesi
```

### Faz 2

```txt
Kullanıcı detay
Etkinlik detay
Yorum yönetimi
Kategori yönetimi
```

### Faz 3

```txt
Bildirim gönderimi
Admin notları
Risk skoru
Gelişmiş grafikler
Moderasyon otomasyonları
```

---

## UI Karakteri

Admin panel landing page kadar eğlenceli olmamalı.

Daha çok:

```txt
Temiz
Hızlı
Okunabilir
Operasyonel
Güven veren
```

Ama Sosyolobi kimliği hissedilmeli.

Küçük detaylarda marka kullanılabilir:

```txt
Logo göz animasyonu sadece sidebar üstünde hafif çalışabilir.
Turuncu vurgu kritik aksiyonlarda kullanılabilir.
Boş durumlarda eğlenceli mikro metinler olabilir.
```

Örnek empty state:

```txt
Henüz bekleyen şikayet yok. Gözlerimiz açık ama ortalık sakin. 👀
```

---

## Claude İçin Uygulama Talimatı

Bu blueprint'e göre Next.js admin dashboard geliştir.

Kurallar:

1. Backend mimarisini değiştirme.
2. Admin tarafını Next.js içinde `/admin` route grubu olarak oluştur.
3. UI için TailwindCSS ve shadcn/ui kullan.
4. Data fetching için TanStack Query kullan.
5. Her liste ekranında filtreleme, arama, pagination ve loading state olsun.
6. Admin panel mobilde çalışsın ama ana hedef desktop/tablet olsun.
7. Kullanıcı uygulamasıyla aynı marka renklerini kullan, fakat admin tarafında daha sade ve operasyonel tasarım yap.
8. Eksik API endpointleri varsa sadece gerekli Controller/Service methodlarını öner.
9. Kod okunabilir, feature bazlı ve componentlere ayrılmış olsun.
10. Güvenlik için admin route guard zorunlu olsun.
