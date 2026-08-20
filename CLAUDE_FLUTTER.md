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

---

## 2026-08-18: Kategori resmi yükleme, arkadaş ekleme erişilebilirliği, kategori-bazlı cluster — mobil tarafı da bu oturumda tamamlandı

Önceki girdilerden farklı olarak, bu seferki backend/web değişikliklerinin mobil karşılığı **aynı oturumda zaten uygulandı** (aşağıda "Mobilde yapılan" olarak işaretli kısımlar TODO değil, tamamlanmış durumda). Yine de gelecekte bu alanlara dokunulduğunda tutarlılığı korumak için özetleniyor.

### 1. Admin panelde kategori resmi yükleme

Backend: `ActivityCategory`'ye `ImageIsCustom` (bool) eklendi — admin'in yüklediği resim artık Pexels'in 30 günlük otomatik yenileme döngüsü tarafından ezilmiyor (`CategoriesController.GetAll()` artık `ImageIsCustom` true olan kategorileri stale-check'ten muaf tutuyor). Yeni admin uçları: `POST /api/admin/categories/{id}/image` (multipart, `ProfilesController.UploadMyAvatar` deseniyle aynı — 5MB limit, jpeg/png/webp) ve `DELETE /api/admin/categories/{id}/image` (otomatik Pexels görseline geri döner). `AdminCategoryResponse`'a `ImageUrl`/`ImageIsCustom` eklendi. Web admin panelinde (`/admin/categories`) resim önizlemeli yükleme formu ve liste thumbnail'leri eklendi.

Mobilde yapılan: Kategori resmi zaten `Category`/`ActivityMapItem.imageUrl` alanı üzerinden çekiliyordu (`image_url.dart` `.resolved` ile) ve `ActivityCard`/`NearbyActivityCard` bunu zaten ikon yerine önceliklendiriyordu (önceki bir oturumda yapılmış). Bu oturumda eksik kalan tek yer olan `activity_detail_screen.dart`'ın üstteki `SliverAppBar` hero alanı da aynı önceliğe (resim varsa göster, yoksa ikon fallback) çekildi.

### 2. Arkadaş ekleme — katılımcı menüsüne taşındı

Arkadaşlık modülü (backend + web + mobil) zaten tam çalışıyordu — sorun UX'ti: "Arkadaş Ekle" sadece tam profil sayfasında vardı, şikayet/engelle ise katılımcı listesindeki ⋮ menüsünde tek tıkla erişilebiliyordu. Backend değişikliği yok; hem web (`ParticipantActionsMenu.tsx`) hem mobil (`participant_actions_menu.dart`) aynı ⋮ menüsüne, mevcut `useFriendStatus`/`friendStatusProvider` durumuna göre "Arkadaş Ekle" / "İsteği İptal Et" / "İsteği Kabul Et" seçeneği eklendi (zaten arkadaşsa gösterilmiyor — o zaten profil sayfasında "Arkadaşsınız" olarak görünüyor).

### 3. Harita: kategori bazlı, yan yana cluster (hem web hem mobil yeniden tasarlandı)

Önceki tasarımda (hem web `supercluster` hem mobil grid-clustering) farklı kategorilerdeki etkinlikler aynı bölgede tek bir "toplam sayı" baloncuğuna toplanıyor, kategori kırılımı sadece hover/tap ile açılan ayrı bir panelde görünüyordu. Yeni tasarım: kümeleme artık **kategori bazlı** — her kategori önce kendi içinde ayrı ayrı kümeleniyor, sonra aynı ekran-bölgesinde çakışan farklı kategori baloncukları merkez noktadan başlayarak **yatay olarak yan yana** diziliyor (örn. "⚽4 🏀4 🎾2" üç ayrı, kategori renkli baloncuk). 5'ten fazla çakışan kategori olursa son bir "+N" toplayıcı baloncuk ekleniyor.

- Web: `MapView.tsx` artık tüm etkinlikler için tek `Supercluster` index'i yerine kategori başına ayrı bir index kuruyor; çakışma tespiti Web Mercator piksel projeksiyonuyla (`projectToPixel`, harita instance'ı gerekmeden) yapılıyor. `ClusterMarker.tsx` artık homojen tek-kategorili bir baloncuk (hover-breakdown tooltip'i kalktı, artık gereksiz).
- Mobilde yapılan (`activity_map_canvas.dart`): Aynı mantık — `_MarkerGroup` artık `categoryName` taşıyor, `_cluster()` kategori bazında ayrı ayrı çağrılıyor, çakışan kümeler `_projectToPixel`/`_degLngPerPixel` (web'deki `projectToPixel` ile birebir aynı formül) kullanılarak yan yana diziliyor. `ClusterBreakdownSheet` artık tek kategori/sayı gösterecek şekilde sadeleşti.
- **Ayrıca kritik bir bug düzeltildi**: mobil cluster baloncuklarındaki sayı metni hiç render olmuyordu (kullanıcı: "mobil uygulamada sayı bile yazmıyor"). Kök neden: `SymbolOptions`'ta `textFont` belirtilmemişti ve maplibre_gl'nin varsayılan font adı, OpenFreeMap "liberty" stilinin glyph fontstack'inde (`Noto Sans Regular/Bold/Italic` — stilin gerçek `glyphs` URL'sinden doğrulandı) yoktu, metin sessizce hiç çizilmiyordu. Artık her `SymbolOptions`'a `textFont: const ['Noto Sans Regular']` veriliyor.

### Düzeltme: `SymbolOptions.textFont` yanlıştı, doğrusu `fontNames`

Yukarıdaki not yanlıştı — aynı oturumda ilerleyen bir aşamada kullanıcı Flutter SDK'yı kurup PATH'e ekledi (`C:\Users\User\develop\flutter_windows_3.47.0-stable`), `flutter analyze` çalıştırılabildi ve **`SymbolOptions`'ta `textFont` diye bir parametre yok** — derleme hatası verdi. Gerçek parametre adı `fontNames` (`maplibre_gl_platform_interface-0.26.2/lib/src/symbol.dart` kaynağından doğrulandı). `activity_map_canvas.dart`'taki her iki `SymbolOptions` çağrısı `fontNames: const ['Noto Sans Regular']` olacak şekilde düzeltildi. Cihaz/emulator üzerinde canlı test edildi (adb ile ekran görüntüleri) — cluster baloncuklarında sayı artık görünüyor, kategori bazlı baloncuklar gerçek bir 3'lü Voleybol kümesinde yan yana ayrışıp `ClusterBreakdownSheet`'i doğru tetikliyor.

---

## 2026-08-18 (devam): Konum zorunluluğu, nav değişiklikleri, bildirim paneli toggle, etkinlik oluşturma/katılma bug'ları

Aynı günün ikinci bir çalışma turu — kullanıcı "katılma isteği ve etkinlik oluşturma butonları yönlendirme yapmıyor", "profilim eski kullanıcının profili kalıyor" gibi somut bug raporları verdi. Backend + web + mobil hepsi bu turda değişti, mobil tarafı da aynı oturumda tamamlandı.

### 1. Konum izni artık zorunlu (yeni: `LocationGateScreen`)

Önceden konum izni `MapScreen`'in ilk build'inde yan etki olarak isteniyordu, reddedilirse kullanıcı uygulamayı (Istanbul fallback ile) kullanmaya devam edebiliyordu. Artık `app_router.dart`'ın `redirect`'i, giriş yapmış her kullanıcıyı — her soğuk başlatmada, sadece ilk seferde değil — `currentLocationNotifierProvider`'ın `permissionState == granted` olmasına kadar yeni `/onboarding/location` rotasına (`LocationGateScreen`) yönlendiriyor; `/app/*` hiçbir rotaya izin verilmeden önce bu ekrandan geçilmesi şart. Ekran izni otomatik ister (provider'ı `watch` etmek zaten bunu tetikliyor), reddedilirse "Tekrar Dene"/"Ayarları Aç" + "Çıkış Yap" (login'e dönüş) sunuyor. `_AuthRefreshListenable` artık `currentLocationNotifierProvider`'ı da dinliyor (hem redirect'i tetiklemek hem de bu provider'ın keepAlive olmadan asla dispose olmamasını sağlamak için). **Web tarafında bu değişiklik yapılmadı** — sadece mobil için istendi.

### 2. Bottom nav: Profil → Arkadaşlar, Profil üst bara taşındı

`app_shell.dart`: `_tabs` son elemanı Profil yerine Arkadaşlar (`RoutePaths.friends`, `Icons.people`) oldu — web zaten ayrı bir "Arkadaşlar" nav öğesine sahipti, mobil de eşleşti. Profil, üst bardaki bildirim ikonunun yanına küçük bir `IconButton` olarak taşındı. `profile_screen.dart`'taki artık gereksiz `_FriendsEntry` widget'ı kaldırıldı.

### 3. Bildirimler artık aç/kapa panel, tekrar tekrar ekran yığmıyor

Zil ikonuna her tıklamada `context.push(RoutePaths.notifications)` çağrılıyordu — tam bir route push, tıklandıkça üst üste yeni ekran istifleniyordu (web zaten dropdown panel, mobil hâlâ eski `NotificationsScreen` push deseni kalmıştı, madde 6'daki 08-15 notu tam uygulanmamıştı). `NotificationsScreen` → `NotificationsPanel`'e çevrildi (kendi `Scaffold`/`AppBar`'ı yok, `DraggableScrollableSheet` içeriği), `AppShell`'e yeni `_NotificationBellButton` (StatefulWidget, `_isOpen` bayrağı) eklendi: kapalıyken `showModalBottomSheet` ile açar, açıkken tekrar tıklanınca `Navigator.pop` ile kapatır — aynı pencere asla birden fazla kez açılmıyor. `RoutePaths.notifications` rotası kaldırıldı.

### 4. "Haritayı Büyüt" → "Haritada Görüntüle"

`map_preview_card.dart` — sadece metin değişikliği, kullanıcı isteği.

### 5. Etkinlik oluşturma "yönlendirme yapmıyor" bug'ı — gerçek kök neden bulundu

Hem web hem mobilde `_submit`/`onSubmit`'in başarı sonrası doğru şekilde yeni etkinliğin detay sayfasına yönlendirdiği (ve "Etkinlik oluşturuldu!" snackbar/toast gösterdiği) kod zaten doğruydu — kod incelemesi bunu doğruladı. **Gerçek bug web'deki `CreateActivityForm.tsx`'in "Kişi Başı Ücret (Opsiyonel)" alanındaydı**: `register("pricePerPerson", { valueAsNumber: true })` boş bırakılan input için `undefined` değil **`NaN`** üretiyordu; zod'un `z.number().optional()`'ı `NaN`'ı geçersiz sayıp reddediyordu; bu alanın `Field` sarmalayıcısı hatasını hiç render etmiyordu (`error` prop'u geçilmemişti) — yani react-hook-form'un `handleSubmit`'i **hiçbir görünür hata göstermeden** submit'i sessizce engelliyordu. Kullanıcı "fiyatı boş bırakmak opsiyonel" sanıp tam da bunu yapıyor, buton tepki vermiyormuş gibi görünüyordu. Düzeltme: `setValueAs: (v) => (v === "" || v === null ? 0 : Number(v))` (boş → 0, kullanıcının "varsayılan tutar 0 olsun" isteğiyle de örtüşüyor), şema artık `z.number().min(0)` (opsiyonel değil, her zaman bir sayı), alan etiketinden "(Opsiyonel)" kaldırıldı (artık doğru değil), `error` prop'u eklendi. Mobilde aynı varsayılan-0 davranışı `create_activity_wizard.dart`'a da uygulandı (`double.tryParse(...) ?? 0`), etiketten "(Opsiyonel)" kaldırıldı.

Ayrıca web'in `useCurrentLocation.ts`'inde ikincil bir sorun bulundu: `permission === "prompt"` durumunda (özellikle iOS Safari'de en yaygın durum) hiçbir şey yapılmıyordu, `location` sonsuza kadar `null` kalabiliyordu — `CreateActivityForm`'un 3. adımında pin hiç yerleşmezdi. Hook'un kendisi bilerek değiştirilmedi (map sayfasının dismissible `LocationPermissionCard`'ı için "prompt" durumunda otomatik istemkomiyor olması kasıtlı), bunun yerine `CreateActivityForm.tsx`'e adım 3'e gelindiğinde `permission === "prompt"` ise `requestLocation()`'ı tetikleyen ayrı bir `useEffect` eklendi.

### 6. Katılma isteği "hiçbir şey olmuyormuş gibi" görünme bug'ı — backend'e yeni alan eklendi

Hem web hem mobilde istek gönderme mutation'ı zaten başarı toast'ı gösteriyor ve `activity` query'sini invalidate/refetch ediyordu — ama **backend'in `GET /api/activities/{id}` yanıtında kullanıcının bekleyen isteği olup olmadığını gösteren hiçbir alan yoktu**. `ActivityService.GetByIdAsync` zaten bir `requestingUserId` parametresi alıyordu ama hiç kullanmıyordu. Refetch sonrası `isParticipant` (sadece onaylı katılımcılara bakıyor) hâlâ `false` kalıyor, buton aynı "Katılmak İstiyorum" durumuna geri dönüyordu — toast'ı kaçıran kullanıcı için hiçbir kalıcı geri bildirim yoktu.

- Backend: `ActivityDetailResponse`'a `MyRequestStatus` (nullable `ActivityRequestStatus`) eklendi; `GetByIdAsync` artık `requestingUserId`'nin bu etkinlik için en güncel `ActivityRequest`'ini sorgulayıp dolduruyor.
- Web: `ActivityDetail.myRequestStatus` eklendi, `hasPendingRequest = activity.myRequestStatus === ActivityRequestStatus.Pending` durumunda buton yerine devre dışı "İstek Bekliyor" gösteriliyor — refetch zaten otomatik olarak bunu tetikliyor, ekstra bir "sayfa yenile" mantığına gerek yok.
- Mobil: `ActivityDetail.myRequestStatus` alanı eklendi (`build_runner` bu ortamda `analyzer`/Dart SDK sürüm uyumsuzluğu yüzünden çöktüğü için `activity.freezed.dart`/`activity.g.dart` elle, mevcut diğer alanların desenine birebir uyarak düzenlendi — bkz. aşağıdaki not). `_JoinCard`'a `hasPendingRequest` parametresi eklendi, `true` olduğunda devre dışı "İstek Bekliyor" butonu gösteriyor.

### 7. Kullanıcı değiştirince eski profil kalıyor bug'ı

`profile_providers.dart`'taki `MyProfile` (`keepAlive: true`) sadece `ref.watch(profileApiProvider).getMe()` çağırıyordu — `authNotifierProvider`'ı hiç izlemiyordu, bu yüzden çıkış yapıp başka bir kullanıcıyla giriş yapıldığında (uygulamayı kapatmadan) asla yeniden fetch edilmiyordu, önceki kullanıcının profili sonsuza kadar önbellekte kalıyordu. Zaten doğru olan `NotificationHub`'daki desen (`await ref.watch(authNotifierProvider.future)`) buraya da uygulandı. Aynı riski taşıyan iki keepAlive provider daha vardı — `ChatUnread` ve `NotificationsController` (her ikisi de 5sn'lik timer ile kendi kendini yeniliyordu, o yüzden en fazla 5sn boyunca yanlış kullanıcının verisini gösterirdi, ama login/logout arasında sürekli 401 alarak boşuna polling de yapıyorlardı) — ikisine de aynı `authNotifierProvider` watch'ı eklendi, `isAuthenticated == false` iken boş liste dönüp timer'ı hiç başlatmıyorlar.

### Not: `dart run build_runner build` bu ortamda çöküyor — elle düzenleme gerekti

Flutter SDK'nın Dart dili sürümü (3.13.0, `flutter --version`) burada pinlenmiş `analyzer` paketi (7.6.0, `pubspec.lock`) için çok yeni — `visitDotShorthandPropertyAccess` implementasyonu eksik hatasıyla çöküyor. `--delete-conflicting-outputs` bayrağıyla çalıştırılırsa **önce tüm mevcut `.g.dart`/`.freezed.dart` dosyalarını siliyor, sonra çöküyor** — proje derlenemez hale geliyor (bu oturumda gerçekten oldu, `git checkout` ile tüm proje genelinde geri alındı, hiçbiri kayıp gitmedi çünkü hepsi git'e commit edilmiş). Bir sonraki alan eklemede: build_runner'ı **asla `--delete-conflicting-outputs` ile çalıştırmayın** bu toolchain düzelene kadar (örn. `analyzer`/`build_runner`/`riverpod_generator`/`freezed` sürümleri Dart 3.13 ile uyumlu hale gelene ya da SDK'nın Dart dili sürümü düşürülene kadar) — bunun yerine ilgili `.freezed.dart`/`.g.dart` dosyalarını, aynı dosyadaki başka bir nullable/converter'lı alanın ürettiği kodu birebir örnek alarak elle düzenleyin (bu oturumda `activity.dart`'a eklenen `myRequestStatus` alanı için yapılan tam olarak buydu, `flutter analyze` ile doğrulandı).

---

## 2026-08-20: Etkinlik detayı katılma akışı yeniden tasarlandı + arkadaşlık isteği kabul bug'ı

### 1. Etkinlik detayı: "Katıl" butonu yukarı taşındı, onay popup'ı, "Detaylar" kaldırıldı

Kullanıcı isteği: katılma butonu sayfanın çok aşağısında kalıyordu, "kendinizi tanıtın" mesaj alanına gerek yok, "Detaylar" bölümü (kontenjan/şu an/seviye/ücret grid'i) gereksiz tekrar.

- Web (`src/app/(user)/app/activities/[id]/page.tsx`): "Katılmak İstiyorum" + mesaj textarea akışı kaldırıldı. Kategori/durum rozetinin altına, başlığın üstüne kısa bir "Katıl" pill butonu eklendi (bekleyen istek varsa yerine devre dışı "İstek Bekliyor" rozeti). Tıklanınca yeni `JoinActivityModal` (`src/components/app/JoinActivityModal.tsx`, `ReportUserModal.tsx` ile aynı overlay deseni) etkinlik özeti (kategori, tarih, adres, ücret, kontenjan) + "Vazgeç"/"Onaylıyorum" gösteriyor; onaylanınca doğrudan istek gönderiliyor (mesaj alanı yok). "Detaylar" grid'i (`_DetailBox`/`DetailBox`) tamamen kaldırıldı — kişi başı ücret artık "Hakkında"nın üstündeki chip/badge satırına (seviye/cinsiyet chip'leriyle aynı yerde) eklendi; kontenjan/şu-an zaten katılımcı avatarlarının yanındaki sayaçta gösteriliyordu, tekrar yok.
- Mobil (`activity_detail_screen.dart`): Aynı değişiklikler — `_JoinCard` (mesaj `TextField` + "İstek Gönder"/"Katılmak İstiyorum") tamamen kaldırıldı, yerine kategori/durum `Row`'unun altına `ElevatedButton.icon` "Katıl" (StadiumBorder pill) veya bekleyen istek varsa devre dışı görünümlü "İstek Bekliyor" chip'i eklendi. Yeni `showJoinActivityDialog` (`presentation/widgets/join_activity_dialog.dart`, `report_user_dialog.dart`'taki `showDialog`+`AlertDialog` deseniyle birebir) aynı özet içeriğini gösteriyor. "Detaylar" `GridView`/`_DetailBox` kaldırıldı, ücret `_InfoChip` olarak seviye/cinsiyet chip satırına eklendi. `flutter analyze` ile doğrulandı, yeni hata yok.

### 2. Arkadaşlık isteğini kabul edememe bug'ı — kök neden `AuthInterceptor`'da

Kullanıcı: "arkadaşlık isteğini onaylayamadım, mobil uygulamada bir sıkıntı var gibi". Kök neden bulundu: `FriendService.AcceptAsync`/`RejectAsync`/`CancelAsync` gibi servis metodları sahiplik ihlallerinde (`request.AddresseeUserId != userId` vb.) `UnauthorizedAccessException` fırlatıyor, `ExceptionHandlingMiddleware` bunu **401**'e çeviriyor — ama bu iş kuralı 401'i, gerçek süresi dolmuş/eksik token 401'iyle aynı statü kodu. Mobildeki `AuthInterceptor.onError` her 401'i "token bayatlamış" sayıp sessizce refresh-token akışını tetikliyor ve isteği tekrarlıyordu; bu hem gereksiz bir round-trip hem de refresh başarısız olursa kullanıcıyı sebepsizce çıkışa zorluyor, hem de asıl "bu isteği kabul edemezsiniz" mesajı yerine kafa karıştırıcı bir gecikme/başarısızlık gösteriyordu (stale bir istek satırında veya kullanıcı değişimi sonrası önbellekte kalan bir `incomingFriendRequestsProvider` girdisinde tetiklenebilir).

Düzeltme (`core/network/auth_interceptor.dart`): Gerçek `[Authorize]` 401'i hiçbir zaman `ExceptionHandlingMiddleware`'den geçmediği için body'sinde `message` alanı yok; iş kuralı 401'lerinde (`ErrorResponse{message,...}`) bu alan her zaman var. Yeni `_isRealAuthChallenge` bu ayrımı yapıyor — sadece gerçek auth 401'lerinde refresh+retry tetikleniyor, iş kuralı 401'leri (friends/activities/chat/requests'teki tüm ownership check'ler) artık doğrudan gerçek backend mesajıyla kullanıcıya gösteriliyor. Ayrıca `friends_screen.dart`'taki `_RequestTile`'ın kabul/reddet/iptal butonlarına (`FriendActionButton`'da zaten olan) `busy` disable koruması eklendi — art arda hızlı tıklama "İstek zaten yanıtlandı" (400) hatasına yol açabiliyordu. `flutter analyze` ile doğrulandı (mevcut, ilgisiz iki `unawaited_return_in_try_block` uyarısı dışında yeni sorun yok).

---

## 2026-08-20 (devam): Etkinlik detayı ikinci bir yeniden tasarım turu + kategori resmi kaybolma bug'ı

Kullanıcı uygulamayı çalıştırıp bir önceki turun sonucunu test etti, iki şey buldu: "Bisiklet" etkinliğinin resmi kayboldu, ve buton/badge yerleşimi için daha somut bir düzen istedi. Web önce yapıldı ve kullanıcı onayladı ("tabi ki" mobile de yap), sonra mobile aynı oturumda uygulandı.

### 1. Kategori resmi kaybolma bug'ı — kök neden diskte, host'ta değil

Backend `localhost:5000` üzerinden çalışıyordu ve DB'deki `Bisiklet` kategorisinin `ImageUrl`'i zaten doğru host'u gösteriyordu (host mismatch değil) — ama `wwwroot/categories` klasörü tamamen boştu (sadece `.gitkeep`; bu klasör gitignore'lu, gerçek ortamda Docker volume ile kalıcı). Dosya adı bir GUID'di (slug değil) — yani bu, Pexels'ten otomatik çekilen bir görsel değil, admin panelinden yüklenmiş **custom** (`ImageIsCustom=true`) bir görseldi ve dosya yerelde diskten kaybolmuştu. Backend'de (`CategoriesController.GetAll()`) genel bir düzeltme yapıldı — staleness kontrolü artık sadece `ImageFetchedAt` yaşına değil, dosyanın diskte gerçekten var olup olmadığına da bakıyor (yeni `CategoryImageFileExists`) — ama bu düzeltme **kasıtlı olarak `ImageIsCustom` kategorileri atlıyor** (admin'in yüklediği görsel Pexels tarafından sessizce ezilmemeli), yani Bisiklet'i otomatik onarmıyor; admin panelinden yeniden yüklenmesi gerekiyor. Mobil tarafında bu bug için ekstra bir kod değişikliği gerekmedi — `image_url.dart`'taki `resolveImageUrl` zaten host mismatch'i ele alıyordu, bu spesifik olay host değil disk kaynaklıydı.

### 2. Etkinlik detayı — ikinci tur yerleşim: tarih+geri sayım, iki sütunlu başlık, katılımcılar artık dialog

Bir önceki turda "Katıl" butonu üstte popup ile açılıyordu ve "Detaylar" grid'i kalkmıştı (bkz. yukarıki giriş). Bu turda kullanıcı daha spesifik bir yerleşim istedi:

- **Tarih + geri sayım satırı**: `Formatters.countdown` (yeni, `formatters.dart`) — web'in `formatCountdown`'ıyla birebir aynı mantık ("X gün Y sa kaldı" / "X sa Y dk kaldı" / "X dk kaldı" / "Başladı"). Etkinlik başlığının üstünde, tarih solda + geri sayım sağda tek satır.
- **İki sütunlu başlık bloğu**: Sol sütun — başlık, altında konum (adres+mesafe), altında katılımcı avatar yığını + "X / Y katılıyor" sayacı. Sağ sütun — en üstte "Katıl" butonu (veya bekleyen istek varsa devre dışı "İstek Bekliyor" rozeti), altında `Wrap` ile aşağı doğru dizilen tüm badge'ler (kategori rozeti, Açık/Dolu/İptal durumu, ücret, seviye, cinsiyet — hepsi tek yerde toplandı, önceden kategori/durum ayrı bir üst satırdaydı).
- **Katılımcılar artık inline liste değil, dokunulabilir özet satırı**: avatar önizlemesi + "Katılımcılar · N kişi" + chevron, dokunulunca yeni `showParticipantsDialog` (`presentation/widgets/participants_dialog.dart`) açılıyor — `Dialog` + `ConstrainedBox` (max %80 ekran yüksekliği) içinde `ListView.separated` ile scroll edilebilir tam liste (aynı `UserLink`+`ParticipantActionsMenu` satır deseni, sadece artık ayrı bir katmanda).

`_SectionTitle`'ın artık kullanılmayan `noMargin` parametresi kaldırıldı (`flutter analyze` bunu unused-parameter olarak yakaladı). `flutter analyze` tüm proje genelinde temiz (mevcut, ilgisiz 37 info/warning dışında yeni sorun yok).

### 3. Badge sütunu düzeltmesi — AVD'de canlı test edildi, gerçek bir overflow bug'ıydı

Kullanıcı emülatörde denedi: "grid çok kötü", sol kesit (başlık) çok dar duruyordu. AVD'ye (emulator-5554) `flutter run --dart-define=API_BASE_URL=http://10.0.2.2:5000` ile bağlanıp gerçek OTP akışıyla (dev sabit kod `123456`, `AuthService.cs`) giriş yapılıp canlı ekran görüntüsü alındı — kök neden doğrulandı: sağ sütundaki `Wrap` (kategori/durum/ücret/seviye/cinsiyet, 5 badge) genişlik kısıtı olmadığı için hepsini tek satırda yan yana diziyordu, bu da `Expanded` başlık sütununu daraltıp başlığı 4 satıra bölüyor ve konum/katılımcı satırlarında **40 piksel sağa taşma (RenderFlex overflow)** hatasına yol açıyordu. Düzeltme: `Wrap`'e `direction: Axis.vertical` + `crossAxisAlignment: WrapCrossAlignment.end` eklendi (badge'ler artık gerçekten alt alta, sağa hizalı, her biri kendi genişliğinde) — sütun genişliği artık en geniş tek badge kadar, başlık sütunu bolca yer buluyor. Katılımcı sayacı da `Flexible`+ellipsis ile sarmalandı (savunma amaçlı). AVD'de tekrar derlenip doğrulandı — başlık tek satıra sığıyor, taşma hatası kayboldu, badge'ler alt alta.

### 4. Aynı gün, üçüncü tur: badge'ler yan yana+wrap, açıklama başlığın altına, "Etkinlik Sahibi" kartı kalktı

Kullanıcı tamamen alt alta değil, "sığdığı kadar yan yana, sığmazsa alta insin" istedi — yani gerçek bir `Wrap` (yatay, genişlik kısıtlı) davranışı, tam dikey stack değil. Mobil: `direction: Axis.vertical` kaldırıldı, `Wrap` yatay yönüne geri döndü ama artık `SizedBox(width: 150)` içinde (Katıl butonunun dışında, sadece badge `Wrap`'i sarıyor) — kısa badge'ler ("Diğer"+"Açık", "Ücretsiz"+"Orta" gibi) yan yana sığıyor, sığmayan alta iniyor, sütun hâlâ dar kalıp başlığa yer bırakıyor.

Ayrıca "Hakkında" başlığı kaldırıldı — açıklama artık doğrudan etkinlik başlığının altında, başlıktan (21px) biraz küçük fontta (15px) gösteriliyor. "Etkinlik Sahibi" kartı (avatar+yıldız+⋮ menü) tamamen kaldırıldı, yerine açıklamanın altında tek satırlık "Düzenleyen: **İsim**" (tıklanabilir, profile gidiyor) geldi — owner'a özel rapor/engelle/arkadaş-ekle artık bu ekrandan değil, profiline gidilerek yapılıyor.

Bu tur hem mobilde hem webde uygulandı (`activity_detail_screen.dart` + `activities/[id]/page.tsx`), ikisi de aynı içerik/sıralama mantığını izliyor. Mobil tarafı AVD'de gerçek build ile canlı doğrulandı (ekran görüntüsü: başlık tek satır, açıklama altında, "Düzenleyen: Elif Doğan" satırı, badge'ler "Diğer/Açık" ve "Ücretsiz/Orta" olarak eşleşip "Erkek" tek başına alta inmiş — istenen davranış birebir). Web tarafı `tsc --noEmit` ile doğrulandı, artık kullanılmayan `Star`/`ParticipantActionsMenu` import'ları temizlendi.

### 5. Uzun başlık + son iki küçük düzeltme (dot kaldırma, katılımcı listesinde "Profiline Git")

- **Uzun başlıkta badge sütunu bozuluyordu**: Kullanıcı auto-size text önerdi, bunun yerine daha standart bir çözüm önerildi ve onaylandı — başlık artık `maxLines: 2` + `TextOverflow.ellipsis` (mobil) / `-webkit-line-clamp: 2` (web) ile 2 satırda kesiliyor, font küçülmüyor. Spacing bozulmadı (2 satıra kadar zaten aynı satır yüksekliği).
- **4.4 piksel taşma + kategori badge'indeki nokta**: Kullanıcı kendi cihazında küçük bir taşma gördü ve "başındaki noktaları kaldırsak nasıl olur" diye sordu. `_CategoryBadge`'deki (mobil) ve detay sayfasının kategori rozetindeki (web) küçük renkli nokta + aradaki boşluk (~11-13px) kaldırıldı, padding simetrik hale getirildi — bu, dar ekranlarda badge satırının taşmasını önlüyor. AVD'de doğrulandı: "Diğer" rozeti artık noktasız, düzen bozulmadı.
- **Katılımcı listesinde isme tıklayınca artık direkt profile gitmiyor**: Önceden isim `UserLink` ile sarılıydı, tıklanınca anında profile navigate ediyordu. Artık isim sade metin; profile gitmek için ⋮ menüsüne yeni eklenen "Profiline Git" (listenin en üstünde, diğer seçeneklerden ayırıcıyla ayrılmış) kullanılıyor — seçilince önce katılımcı diyaloğu/modalı kapanıyor, sonra profil açılıyor. Mobil: `ParticipantActionsMenu`'ye `onBeforeNavigateToProfile` callback'i eklendi (`participants_dialog.dart` bunu `Navigator.pop` ile besliyor); `ParticipantActionsMenu` artık tek kullanım yeri bu diyalog olduğu için bu tasarım güvenli. Web: `ParticipantActionsMenu.tsx`'e `onBeforeNavigate` prop'u + üstte bir `Link` eklendi, `ParticipantsModal.tsx` bunu `onClose` ile besliyor. Mobil tarafı AVD'de uçtan uca test edildi (isme tıklayınca liste açık kaldı, ⋮ → "Profiline Git" → liste kapandı, Elif Doğan'ın profili açıldı).
