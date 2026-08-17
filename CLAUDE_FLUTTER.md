Mevcut projeye Flutter Mobile Agent olarak dahil ol.

Projenin mevcut yapısı:

- Web: Next.js
- Mobile: Flutter
- Backend: ASP.NET Core 10 / C#
- Database: PostgreSQL 13
- Containerization: Docker / Docker Compose

Sen yalnızca Flutter Mobile tarafının geliştirilmesinden sorumlusun.

Mevcut backend API'lerini, veri modellerini ve authentication yapısını değiştirme. Flutter uygulamasını mevcut ASP.NET Core 10 backend ile entegre et.

Görevlerin:

- Flutter uygulamasını geliştirmek ve sürdürmek.
- Mevcut API sözleşmelerine uymak.
- Web uygulamasındaki iş kurallarını ve kullanıcı akışlarını mümkün olduğunca Flutter tarafında tutarlı şekilde uygulamak.
- Backend'de ihtiyaç duyulan değişiklikleri kendin uygulama; yalnızca gerekli API değişikliğini açıkça belirt.
- Flutter tarafında temiz, sürdürülebilir ve production-ready kod yaz.
- Gereksiz paket, abstraction ve complexity ekleme.
- Mevcut proje mimarisini değiştirmeden önce analiz et.
- Mevcut kodu anlamadan yeniden tasarlama.
- Authentication, token yönetimi, navigation, state management, API error handling ve local persistence konularında tutarlı bir yapı kullan.
- Android ve iOS platformlarını birlikte dikkate al.
- Environment/configuration ayrımını koru.
- Docker ve backend ortamlarını Flutter tarafında bozacak değişiklikler yapma.
- Web ve Mobile arasında ortak backend davranışını esas al; platforma özgü UI/UX gerektiğinde Flutter'a uygun şekilde uygula.
- Güvenlik, performans, erişilebilirlik ve test edilebilirliği dikkate al.
- Kullanıcı gereksinimi net değilse varsayım yapma, soru sor.
- Kod yazmadan önce mevcut yapıyı ve ilgili dosyaları incele.
- Gereksiz açıklama yapma; teknik ve doğrudan ilerle.

Öncelik sırası:

1. Mevcut proje mimarisini koru.
2. Mevcut backend API sözleşmesine uy.
3. Flutter kod kalitesini koru.
4. Web ve Mobile davranışlarını tutarlı tut.
5. Gereksiz değişikliklerden kaçın.

---

## 2026-08-15: Web tarafında yapılan güncellemeler — mobilde karşılığı uygulanmalı

Backend'e yeni endpoint'ler eklendi ve web (Next.js) tarafında bunlara karşılık gelen ekranlar/davranışlar yapıldı. Aşağıdakileri Flutter tarafında da mevcut mimariye (auth, state management, API client, navigation) uygun şekilde uygula. Backend'de herhangi bir değişiklik gerekmiyor, sözleşmeler hazır.

### 1. Arkadaşlık modülü (yeni backend uçları, web'de yeni)

Yeni endpoint'ler:
- `POST /api/friends/requests` body `{ addresseeUserId }` — istek gönder
- `GET /api/friends/requests/incoming` — gelen bekleyen istekler
- `GET /api/friends/requests/sent` — gönderdiğim bekleyen istekler
- `POST /api/friends/requests/{id}/accept`
- `POST /api/friends/requests/{id}/reject`
- `DELETE /api/friends/requests/{id}` — gönderileni iptal et
- `GET /api/friends` — arkadaş listesi (`{ friendsSinceUtc, user: PublicProfile }[]`)
- `DELETE /api/friends/{friendUserId}` — arkadaşlıktan çıkar
- `GET /api/friends/{friendUserId}/activities` — arkadaşın oluşturduğu etkinlikler (sadece arkadaşsan veya kendinse 200 döner, değilse 401)

Web'de yapılanlar (mobilde karşılığı):
- Yeni "Arkadaşlar" sekmesi: Arkadaşlarım / Gelen İstekler / Gönderdiğim, üç sekmeli liste ekranı (bkz. `src/app/(user)/app/friends/page.tsx`).
- Yeni herkese açık profil ekranı `/app/profile/{userId}` (bkz. `src/app/(user)/app/profile/[userId]/page.tsx`): profil bilgisi + duruma göre buton ("Arkadaş Ekle" / "İsteği İptal Et" / "İsteği Kabul Et" / "Arkadaşsınız") + **arkadaşsan** o kişinin oluşturduğu etkinlikler listesi, değilsen kilitli/uyarı mesajı.
- Etkinlik detayındaki katılımcı listesindeki her isim artık bu profil ekranına link veriyor — mobilde de katılımcı/istek kartlarındaki kullanıcı adları profile tıklanabilir olmalı.
- Arkadaşlık durumu (`none` / `pending-sent` / `pending-incoming` / `friends`) tek bir backend ucu yok; mevcut `/api/friends`, `/api/friends/requests/incoming`, `/api/friends/requests/sent` listeleri client-side taranarak türetiliyor (bkz. web `useFriendStatus`). Mobilde de aynı yaklaşım kullanılabilir.

### 2. Arama kutusu artık sadece etkinlik listeleme alanlarında

Önceden global üst barda her sayfada görünüyordu, etkinlikle alakasız yerlerde de gözüküyordu. Kaldırıldı; arama artık sadece Etkinlikler listesi ve Harita sayfası içinde, o sayfaya özel bir input olarak var (client-side başlık/kategori/adres filtreleme). Mobilde de arama kutusunu global bir yerde değil, sadece etkinlik listeleme ekranlarında (liste + harita) göster.

### 3. Harita: kullanıcı konumu, etkinlik pin'leri ve cluster (küme) işaretçileri

- Kullanıcının kendi konum işaretçisi büyütüldü ve etrafına pulse (nabız) animasyonlu bir halka eklendi — "buradasın" hissini netleştirmek için.
- Etkinlik pin ikonları büyütüldü, seçili pin daha da büyük ve belirgin.
- **Cluster işaretçileri**: Uzaklaşınca birden çok etkinlik tek bir "12" gibi bare sayıya toplanıyordu. Artık `supercluster`'ın `map`/`reduce` seçenekleriyle her cluster'a kategori bazlı kırılım ekleniyor (örn. "Futbol 4, Basketbol 2, Voleybol 3") ve cluster'a hover/tıklandığında bu kırılım gösteriliyor (bkz. `src/components/app/ClusterMarker.tsx`, `src/components/app/MapView.tsx`).

**Mobilde de aynısı yapılmalı**: Flutter tarafında kullanılan harita/cluster kütüphanesi (örn. `google_maps_cluster_manager`, `flutter_map` + `flutter_map_marker_cluster` ya da mevcut ne kullanılıyorsa) ile cluster marker'lar bare sayı yerine kategori kırılımı göstermeli — örneğin cluster'a dokunulduğunda açılan bir bottom sheet veya tooltip'te "Futbol 4, Basketbol 2, Voleybol 3" gibi bir liste. Kullanıcı konum işaretçisi de web'deki gibi büyük ve pulse animasyonlu/belirgin olmalı, etkinlik pin'leri de yeterince büyük ve tıklanabilir olmalı.

### 4. Tarih ve hafta sonu filtreleri

Etkinlikler ve Harita sayfalarına "Bugün / Bu Hafta / Bu Ay / Tümü" tarih filtresi ile ayrı bir "Sadece Hafta Sonu" toggle eklendi. Backend zaten `fromDate`/`toDate` destekliyor (`/api/activities/nearby`, `/api/activities/map`), hafta sonu filtresi client-side (`eventDate` günü Cmt/Paz mi) uygulanıyor. Mobilde aynı filtre seçenekleri eklenmeli.

### 5. Kategori chip'lerinde sayı rozeti

Kategori filtre çiplerinin üzerinde (örn. "Futbol") o kategoride kaç etkinlik olduğunu gösteren küçük bir sayı rozeti var. Bunun için backend'e yeni bir count endpoint'i eklenmedi; tüm kategorilerdeki sonuçlar birlikte çekilip client-side kategoriye göre gruplanıyor. Mobilde de aynı client-side yaklaşım kullanılabilir.

### 6. Bildirimler: ayrı sayfa değil, açılır panel

`/app/notifications` route'u kaldırıldı. Bunun yerine bir zil ikonu + üstünde okunmamış sayısı rozeti var; tıklanınca yerinde açılan bir dropdown panel geliyor. Panel açıldığı an o an listede görünen bildirimler otomatik "okundu" işaretleniyor (ayrı bir "tümünü okundu yap" aksiyonuna gerek yok). Mobilde de bildirim ekranı ayrı bir sayfa yerine (mevcutsa) bu davranışa çekilebilir; en azından panel/sheet açılınca görünenlerin otomatik okundu işaretlenmesi mantığı uygulanmalı.

### 7. İstek kartlarında etkinlik önizlemesi

Gelen/gönderilen katılım isteği kartlarında artık sadece "Etkinliğe Git" linki değil, ilgili etkinliğin küçük bir önizlemesi de var (kategori ikonu + başlık + kategori/tarih). Mobilde de istek kartlarına benzer bir mini önizleme eklenmeli.

### 8. "Katıldıklarım" sekmesi

İstekler ekranına, onaylanmış ve henüz geçmemiş etkinlikleri listeleyen üçüncü bir sekme eklendi (backend'de yeni endpoint yok; `/api/activity-requests/sent` + onaylı olanlar için `/api/activities/{id}` birleştirilerek elde ediliyor). Mobilde aynı ekranda benzer bir sekme/liste eklenebilir.

### 9. Review/Report backend polish (kural sıkılaştırma + bildirim)

Bunlar backend davranış değişiklikleri, mobil UI'da özel bir ekran şart değil ama dikkat edilmeli:
- Kendine yorum/rapor gönderilemiyor artık (400 döner).
- Etkinliğe katılmamış birine yorum yapılamıyor (400).
- Yorum eklenince yorumu alan kullanıcıya bildirim gidiyor (`NewReview`), rapor oluşunca admin'lere bildirim gidiyor (`NewReport`) — önceden bu bildirim tipleri tanımlıydı ama hiç tetiklenmiyordu.
- Aynı hedefe (kullanıcı/etkinlik) tekrar "pending" rapor açılamıyor (400 — "zaten incelenmekte olan bir raporunuz var").
- Yeni: `GET /api/reports/mine` — kullanıcının kendi gönderdiği raporları (durumlarıyla) listeler. Mobilde bir "Raporlarım" görünümü varsa/eklenecekse bu uç kullanılabilir.
