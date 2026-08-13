# Sosyolobi — Landing Page Frontend Blueprint

## 1. Amaç

Mevcut landing page tamamen yeniden tasarlanacaktır.

Mevcut ekran:
- Koyu lacivert tam ekran arka plan
- Ortada küçük logo/ikon
- Küçük başlık ve iki buton
- Fazla boş alan
- Sosyolobi'nin asıl ürün fikrini anlatmıyor
- Kullanıcının neden kayıt olması gerektiğini göstermiyor
- Harita, etkinlik, insan eşleşmesi ve güven unsurları görünmüyor
- Marka kimliği ve mevcut Sosyolobi logosuyla yeterince örtüşmüyor

Yeni landing page'in amacı yalnızca "giriş yap" demek değildir.

Ana amaç:
> Kullanıcıya Sosyolobi'nin ne olduğunu 5–10 saniyede anlatmak, gerçek kullanım senaryosunu göstermek ve kullanıcıyı etkinlik keşfetmeye / kayıt olmaya yönlendirmek.

---

# 2. Marka Kimliği

## Ana renkler

Logo ile uyumlu kullanılacak:

- Primary Navy: `#081B4B`
- Primary Orange: `#FF9D23`
- White: `#FFFFFF`
- Soft Orange: `#FFF3E2`
- Soft Navy: `#EEF2FA`
- Text Dark: `#101828`
- Text Muted: `#667085`
- Border: `#E7EAF0`

Kullanım:
- Lacivert: ana metin, footer, güçlü alanlar
- Turuncu: CTA, vurgu, aktif durumlar
- Beyaz: ana yüzey
- Soft Orange: section arka planları
- Soft Navy: bilgi/özellik alanları

Landing page'in tamamı koyu lacivert olmayacak. Ana yüzey beyaz ağırlıklı olacak.

---

# 3. Logo

Kullanıcının verdiği mevcut Sosyolobi HTML/CSS logosu kullanılacaktır.

Logo:
`sosyolobi`

İki "o" karakteri göz olarak kullanılmaktadır. Göz animasyonu korunabilir.

Logo:
- Header'da gerçek marka logosu olarak
- Hero'da gerekiyorsa küçük destekleyici kullanım
- CTA/footer'da kontrollü kullanım

Devasa logo kullanımı yapılmayacak.

---

# 4. Font

Öncelik:
`Nunito`

Alternatif:
`Inter`

Başlıklar:
- 700 / 800

Body:
- 400 / 500

Button:
- 600 / 700

---

# 5. Genel Layout

Desktop:

```text
┌──────────────────────────────────────────────────────────────┐
│ LOGO       Nasıl Çalışır  Etkinlikler  Hakkımızda   Giriş Yap │
│                                                [Kayıt Ol]     │
├──────────────────────────────────────────────────────────────┤
│ HERO                                                         │
│                                                              │
│ Yapacak şey var.                                             │
│ İnsan yoksa                                                  │
│ Sosyolobi var.                    [APP / MAP MOCKUP]          │
│                                                              │
│ Açıklama                                                     │
│ [Etkinlikleri Keşfet] [Nasıl Çalışır?]                      │
├──────────────────────────────────────────────────────────────┤
│ Nasıl Çalışır?                                               │
│       1             2             3             4            │
├──────────────────────────────────────────────────────────────┤
│ Harita / Etkinlik keşfi                                     │
├──────────────────────────────────────────────────────────────┤
│ Problem / kullanım senaryoları                              │
├──────────────────────────────────────────────────────────────┤
│ Güvenli Sosyalleşme                                         │
├──────────────────────────────────────────────────────────────┤
│ Kategoriler                                                  │
├──────────────────────────────────────────────────────────────┤
│ CTA                                                          │
├──────────────────────────────────────────────────────────────┤
│ Footer                                                       │
└──────────────────────────────────────────────────────────────┘
```

Mobile:
Header → Hero → Mockup → CTA → Nasıl Çalışır → Harita → Senaryolar → Güven → Kategoriler → CTA → Footer

---

# 6. Header

Desktop:

Sol:
`[Sosyolobi Logo]`

Menü:
- Nasıl Çalışır
- Etkinlikler
- Hakkımızda

Sağ:
- Giriş Yap
- `[Kayıt Ol]`

Header:
- white
- maksimum genişlik 1200–1280px
- yatay padding 24px
- sticky olabilir
- hafif backdrop blur kullanılabilir

Mobile:
`[Sosyolobi Logo] [☰]`

Hamburger drawer kullanılabilir.

---

# 7. HERO

Hero landing page'in en önemli bölümüdür.

Mevcut ekranın aksine çok fazla boşluk bırakılmayacak.

## Başlık

Birincil öneri:

> Yapacak şey var.  
> İnsan yoksa **Sosyolobi var.**

Alternatif:

> Yalnız plan yapma,  
> **beraber yaşa.**

Ana headline olarak ilk versiyon tercih edilir.

Orange vurgu:
`Sosyolobi var.`

## Açıklama

> Yapmak istediğin etkinliği oluştur, yakınındaki insanları bul ve birlikte gerçekleştirin.

## CTA

Primary:
`Etkinlikleri Keşfet →`

Secondary:
`Nasıl Çalışır?`

---

# 8. HERO VISUAL

Hero'nun sağ tarafında gerçek ürün hissi veren büyük bir mockup bulunmalıdır.

Telefon mockup + harita görünümü.

Telefon ekranında örnek:

```text
Yakınındaki Etkinlikler

⚽ Halı Saha
Çekmeköy
Bugün · 20:00
2 kişi aranıyor

🏃 Akşam Koşusu
Üsküdar
Yarın · 19:30
4 kişi katıldı

🥾 Hafta Sonu Doğa Yürüyüşü
Beykoz
Cumartesi · 09:00
3 kişi aranıyor
```

Arka planda:
- Soft orange blob
- Harita parçaları
- Etkinlik pinleri
- Küçük avatarlar

Görsel karmaşık olmamalıdır.

---

# 9. HARİTA / ETKİNLİK KEŞFİ

Sosyolobi'nin temel farklılaştırıcısı harita olduğu için landing page'de mutlaka gösterilmelidir.

Başlık:

> Yakınında ne var?

Açıklama:

> Konumuna göre sana yakın etkinlikleri keşfet. Haritadan bak, etkinliği seç ve katıl.

Örnek:

```text
┌─────────────────────────────────────────────┐
│ Yakınındaki etkinlikleri keşfet             │
│                                             │
│ [Kategori] [Tarih] [Mesafe]                 │
│                                             │
│ ┌───────────────────────────────────────┐   │
│ │               MAP                     │   │
│ │       ●       ●                       │   │
│ │                ●                      │   │
│ │     ●                                 │   │
│ └───────────────────────────────────────┘   │
└─────────────────────────────────────────────┘
```

Landing page'de gerçek MapLibre entegrasyonu zorunlu değildir. Ürün hissi veren mockup kullanılabilir. Gerçek harita User App'te kullanılacaktır.

---

# 10. NASIL ÇALIŞIR?

Başlık:
> Sosyolobi nasıl çalışır?

### 01 — Ne yapmak istediğini seç
Futbol, yürüyüş, masa tenisi, kamp, oyun, konser veya başka bir etkinlik.

### 02 — Etkinliği oluştur veya keşfet
Yakınındaki etkinlikleri haritadan keşfet veya kendi etkinliğini oluştur.

### 03 — İnsanlarla eşleş
Katılmak istediğin etkinliğe başvur. Etkinlik sahibi başvurunu onaylasın.

### 04 — Birlikte yap
Planı netleştir. Buluş. Etkinliği gerçekleştir. Yeni insanlarla tanış.

İkonlar:
- Calendar
- MapPin
- Users
- Sparkles / Party

---

# 11. PROBLEM / KULLANIM SENARYOLARI

Başlık:

> Bazen tek eksik şey bir kişi.

Senaryolar:

```text
Bu akşam halı saha var.
Ama 2 kişi eksik.

↓

Sosyolobi

↓

Yakınında oynayacak 2 kişi bulundu.
```

Diğer örnekler:

- Hafta sonu Uludağ'a gitmek istiyorsun ama tek başına gitmek istemiyorsun.
- Yeni bir şehre taşındın ve çevrende kimseyi tanımıyorsun.
- Konser bileti aldın ama beraber gidecek kimse yok.
- Akşam koşmak istiyorsun ama tek başına motivasyon yok.

Bu bölüm ürünün neden var olduğunu anlatmalıdır.

---

# 12. KATEGORİLER

Başlık:
> Ne yapmak istersin?

Kartlar:

```text
⚽ Spor
🥾 Doğa
🎮 Oyun
🎵 Müzik
🎬 Sinema
☕ Sosyal
✈ Seyahat
🎨 Sanat
```

Kart:
- white
- subtle border
- rounded 20px
- hover'da orange accent

---

# 13. GÜVEN

Başlık:
> Yeni insanlarla tanış. Güvenle.

### Telefon doğrulama
Gerçek kullanıcılar için telefon doğrulaması.

### Profil ve puan sistemi
Etkinliklerden sonra kullanıcılar birbirlerini değerlendirebilir.

### Yorumlar
Topluluk deneyimini kullanıcı yorumlarıyla görünür hale getir.

### Gizlilik
Telefon numaranı herkese göstermek zorunda değilsin. Konum yalnızca gerekli durumlarda kullanılır.

Güvenlik iddiaları abartılmayacak.

---

# 14. SOSYAL KANIT

Gerçek kullanıcı sayısı yoksa sahte istatistik kullanılmayacak.

Örneğin gerçek veri oluşana kadar:
- İlk etkinliğini oluştur.
- İlk insanını bul.

Gerçek testimonial geldiğinde:
> “Tek başıma gitmek istemediğim etkinlikleri artık Sosyolobi'den insanlarla yapıyorum.”

Sahte kullanıcı yorumu oluşturulmayacak.

---

# 15. FINAL CTA

Başlık:

> Tek başına plan yapma.

Alt metin:

> Yapmak istediğin şey için doğru insanları bul.

Butonlar:
- `Etkinlikleri Keşfet`
- `Etkinlik Oluştur`

Arka plan:
`#FFF3E2`

veya white → soft orange gradient.

---

# 16. FOOTER

Footer koyu lacivert:

```text
sosyolobi
İnsanlarla birlikte yaşa.

Keşfet
- Etkinlikler
- Kategoriler

Sosyolobi
- Hakkımızda
- Nasıl Çalışır

Destek
- İletişim
- SSS

Gizlilik Politikası
Kullanım Koşulları

© 2026 Sosyolobi
```

Gerçek sosyal medya hesapları oluşmadan sahte link eklenmeyecek.

---

# 17. RESPONSIVE

Desktop:
- max-width 1280px
- Hero 2 kolon
- geniş harita
- kategori grid

Tablet:
- kontrollü stack
- 2 kolon kart

Mobile:
- Hero tek kolon
- başlık 42–48px
- telefon mockup altında
- CTA full width
- kategori 2 kolon
- hamburger
- harita 360–450px

---

# 18. ANİMASYON

Kullanılabilir:
- Logo eye blink
- Hero fade-up
- CTA hover
- Map pin subtle pulse
- Card hover
- Scroll reveal
- Avatar floating

Kaçınılacak:
- sürekli hareket eden her şey
- ağır parallax
- uzun intro
- aşırı bounce
- gereksiz gradient animation

Animasyonlar ürünün önüne geçmeyecek.

---

# 19. NEXT.JS COMPONENT STRUCTURE

```text
src/
├── app/
│   ├── page.tsx
│   ├── layout.tsx
│   └── globals.css
│
├── components/
│   └── landing/
│       ├── LandingHeader.tsx
│       ├── HeroSection.tsx
│       ├── HeroMockup.tsx
│       ├── HowItWorks.tsx
│       ├── ProblemSection.tsx
│       ├── MapDiscoverySection.tsx
│       ├── CategoriesSection.tsx
│       ├── TrustSection.tsx
│       ├── FinalCta.tsx
│       └── LandingFooter.tsx
│
└── components/
    └── ui/
```

---

# 20. ROUTING

Landing:
`/`

Public event discovery:
`/events`

Login:
`/login`

Register:
`/register`

Authenticated User App:
`/app`

Admin:
`/admin`

Landing page admin dashboard ile karıştırılmayacak.

---

# 21. UX FLOW

İlk ziyaret:

```text
/
↓
Hero
↓
Etkinlikleri Keşfet
↓
/events
```

Kayıt:

```text
/
↓
Kayıt Ol
↓
/register
↓
Telefon doğrulama
↓
/app
```

Etkinlik oluşturma:

```text
/
↓
Etkinlik Oluştur
↓
Login/Register
↓
/app/activities/create
```

---

# 22. TASARIMDA KESİN KURALLAR

Aşağıdaki mevcut tasarım yaklaşımı kaldırılacak:

```text
❌ Koyu lacivert full-screen
❌ Ortada küçük login ekranı hissi
❌ Aşırı boş alan
❌ Generic SaaS dashboard görünümü
❌ Generic AI startup tasarımı
❌ Rastgele gradientler
❌ Stock illustration ağırlığı
```

Bunun yerine:

```text
✓ Sosyolobi markasına özel
✓ Beyaz ağırlıklı
✓ Lacivert + turuncu
✓ İnsan odaklı
✓ Harita ve etkinlik odaklı
✓ Modern sosyal platform hissi
✓ Gerçek ürün ekranlarıyla desteklenen
✓ Premium ama samimi
✓ Mobile-first responsive
```

---

# 23. REFERANS TASARIM MANTIĞI

Hedef:

```text
Sosyolobi Landing

White background
        ↓
Brand Header
        ↓
Strong Hero
        ↓
Product Mockup
        ↓
How It Works
        ↓
Map Discovery
        ↓
Problem / Use Cases
        ↓
Categories
        ↓
Trust
        ↓
CTA
        ↓
Dark Footer
```

Mevcut screenshot'taki lacivert full-screen yapı korunmayacak.

Logo ve marka renkleri korunacak; sayfa yapısı tamamen yenilenecek.

---

# 24. CLAUDE / CURSOR UYGULAMA TALİMATI

1. Mevcut landing page'i analiz et.
2. Mevcut dashboard tasarımını landing page'e kopyalama.
3. Sosyolobi'nin mevcut logo HTML/CSS yapısını koru.
4. Renkleri logo üzerinden al.
5. Landing page'i tamamen yeniden oluştur.
6. Component bazlı geliştir.
7. Responsive tasarım yap.
8. Mobile görünümü ayrıca optimize et.
9. Gereksiz backend entegrasyonu yapma.
10. Mockup verileri kullanılabilir; sahte kullanıcı istatistikleri kullanılmayacak.
11. Harita bölümünde gerçek MapLibre entegrasyonu zorunlu değil; gerçek ürün hissi veren bir mockup yeterli.
12. Gerçek API hazır olduğunda bağlanabilecek componentler tasarla.
13. Accessibility kurallarına uy.
14. SEO metadata ekle.
15. OpenGraph metadata ekle.
16. Semantic HTML kullan.
17. Performansı gözet.
18. Gereksiz JavaScript kullanma.
19. Animasyonları hafif tut.
20. Sonuç Sosyolobi'nin gelecekte büyüyebilecek bir sosyal platform olduğu hissini vermeli.

---

# 25. BAŞARI KRİTERİ

Landing page'e giren kullanıcı 5 saniye içinde şunları anlayabilmeli:

1. Sosyolobi nedir?
   → İnsanları birlikte etkinlik yapmaları için buluşturuyor.

2. Ben burada ne yapabilirim?
   → Etkinlik keşfedebilir veya oluşturabilirim.

3. Bana ne faydası var?
   → Tek başıma yapmak istemediğim şeyleri insanlarla yapabilirim.

4. Güvenli mi?
   → Telefon doğrulama + profil + puan + yorum sistemi var.

5. Şimdi ne yapmalıyım?
   → Etkinlikleri keşfet.

Landing page'in temel hedefi budur.
