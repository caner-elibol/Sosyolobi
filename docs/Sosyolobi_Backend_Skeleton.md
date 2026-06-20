# Sosyolobi Backend Proje İskeleti

## 1. Proje Amacı

Sosyolobi, kullanıcıların gerçek hayattaki sosyal aktiviteler için eksik kişileri bulmasını sağlayan konum tabanlı sosyal etkinlik platformudur.

Örnek kullanım senaryoları:

- Halı saha maçı için 1-2 oyuncu bulmak
- Kamp, kayak, yürüyüş, bisiklet gibi grup aktivitelerine kişi aramak
- Yakındaki sosyal etkinlikleri harita üzerinden keşfetmek
- Etkinliklere katılma isteği göndermek
- Katılımcıları onaylamak veya reddetmek
- Etkinlik sonrası yorum ve puan vermek
- Güvenli kullanıcı profili oluşturmak

İlk backend hedefi: sağlam, sade, tek proje halinde geliştirilebilir bir .NET API oluşturmak.

---

## 2. Mimari Karar

Bu projede Clean Architecture, Application, Domain, Infrastructure gibi ayrı katman projeleri kullanılmayacak.

Tek proje kullanılacak:

```txt
Sosyolobi.Api
```

Ancak proje içinde düzenli klasörleme yapılacak.

Tercih edilen yapı:

- Controller + Service mimarisi
- EF Core
- PostgreSQL
- PostGIS
- JWT Authentication
- Telefon OTP doğrulama
- SignalR altyapısı
- Redis opsiyonel ama hazır düşünülmeli
- Swagger/OpenAPI

---

## 3. Teknoloji Stack

```txt
Backend: .NET 10 Web API
Database: PostgreSQL
Geo Extension: PostGIS
ORM: Entity Framework Core
Spatial Support: NetTopologySuite
Authentication: JWT Bearer
Realtime: SignalR
Cache/Queue: Redis, ileriki faz
Documentation: Swagger
Deployment: Docker destekli yapı
```

Önerilen NuGet paketleri:

```bash
dotnet add package Microsoft.EntityFrameworkCore.Design
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL
dotnet add package Npgsql.EntityFrameworkCore.PostgreSQL.NetTopologySuite
dotnet add package Microsoft.AspNetCore.Authentication.JwtBearer
dotnet add package Swashbuckle.AspNetCore
dotnet add package Microsoft.AspNetCore.SignalR
dotnet add package StackExchange.Redis
```

---

## 4. Klasör Yapısı

```txt
Sosyolobi.Api
│
├── Controllers
│   ├── AuthController.cs
│   ├── UsersController.cs
│   ├── ProfilesController.cs
│   ├── ActivitiesController.cs
│   ├── ActivityRequestsController.cs
│   ├── ReviewsController.cs
│   ├── ReportsController.cs
│   ├── NotificationsController.cs
│   ├── GeoController.cs
│   └── AdminController.cs
│
├── Services
│   ├── Interfaces
│   │   ├── IAuthService.cs
│   │   ├── IUserService.cs
│   │   ├── IProfileService.cs
│   │   ├── IActivityService.cs
│   │   ├── IActivityRequestService.cs
│   │   ├── IReviewService.cs
│   │   ├── IReportService.cs
│   │   ├── INotificationService.cs
│   │   ├── IGeoService.cs
│   │   └── IAdminService.cs
│   │
│   ├── AuthService.cs
│   ├── UserService.cs
│   ├── ProfileService.cs
│   ├── ActivityService.cs
│   ├── ActivityRequestService.cs
│   ├── ReviewService.cs
│   ├── ReportService.cs
│   ├── NotificationService.cs
│   ├── GeoService.cs
│   └── AdminService.cs
│
├── Data
│   ├── AppDbContext.cs
│   ├── DbInitializer.cs
│   └── SeedData.cs
│
├── Entities
│   ├── User.cs
│   ├── UserProfile.cs
│   ├── PhoneVerificationCode.cs
│   ├── Activity.cs
│   ├── ActivityCategory.cs
│   ├── ActivityRequest.cs
│   ├── ActivityParticipant.cs
│   ├── Review.cs
│   ├── Report.cs
│   ├── Notification.cs
│   ├── UserBlock.cs
│   └── RefreshToken.cs
│
├── DTOs
│   ├── Auth
│   │   ├── SendOtpRequest.cs
│   │   ├── VerifyOtpRequest.cs
│   │   ├── AuthResponse.cs
│   │   └── RefreshTokenRequest.cs
│   │
│   ├── Profiles
│   │   ├── UpdateProfileRequest.cs
│   │   ├── ProfileResponse.cs
│   │   └── PublicProfileResponse.cs
│   │
│   ├── Activities
│   │   ├── CreateActivityRequest.cs
│   │   ├── UpdateActivityRequest.cs
│   │   ├── ActivityResponse.cs
│   │   ├── ActivityDetailResponse.cs
│   │   ├── NearbyActivitiesRequest.cs
│   │   └── ActivityMapItemResponse.cs
│   │
│   ├── ActivityRequests
│   │   ├── JoinActivityRequest.cs
│   │   ├── ActivityJoinRequestResponse.cs
│   │   └── RespondActivityRequest.cs
│   │
│   ├── Reviews
│   │   ├── CreateReviewRequest.cs
│   │   └── ReviewResponse.cs
│   │
│   ├── Reports
│   │   ├── CreateReportRequest.cs
│   │   └── ReportResponse.cs
│   │
│   └── Common
│       ├── ApiResponse.cs
│       ├── PagedRequest.cs
│       ├── PagedResponse.cs
│       └── ErrorResponse.cs
│
├── Enums
│   ├── ActivityStatus.cs
│   ├── ActivityRequestStatus.cs
│   ├── NotificationType.cs
│   ├── ReportStatus.cs
│   ├── UserStatus.cs
│   ├── SkillLevel.cs
│   └── GenderPreference.cs
│
├── Hubs
│   └── NotificationHub.cs
│
├── Middlewares
│   ├── ExceptionHandlingMiddleware.cs
│   └── RequestLoggingMiddleware.cs
│
├── Options
│   ├── JwtOptions.cs
│   ├── SmsOptions.cs
│   ├── RedisOptions.cs
│   └── GeoOptions.cs
│
├── Helpers
│   ├── JwtHelper.cs
│   ├── PhoneNumberHelper.cs
│   ├── SlugHelper.cs
│   └── DistanceHelper.cs
│
├── Extensions
│   ├── ServiceCollectionExtensions.cs
│   ├── ApplicationBuilderExtensions.cs
│   └── ClaimsPrincipalExtensions.cs
│
├── Migrations
│
├── Program.cs
├── appsettings.json
└── appsettings.Development.json
```

---

## 5. Temel Entity Taslakları

### 5.1 User

```csharp
public class User
{
    public Guid Id { get; set; }
    public string PhoneNumber { get; set; } = null!;
    public bool IsPhoneVerified { get; set; }
    public string? Email { get; set; }
    public UserStatus Status { get; set; } = UserStatus.Active;
    public DateTime CreatedAt { get; set; }
    public DateTime? LastLoginAt { get; set; }

    public UserProfile? Profile { get; set; }
}
```

### 5.2 UserProfile

```csharp
public class UserProfile
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string DisplayName { get; set; } = null!;
    public string? Bio { get; set; }
    public string? AvatarUrl { get; set; }
    public DateTime? BirthDate { get; set; }
    public double AverageRating { get; set; }
    public int ReviewCount { get; set; }
    public int CompletedActivityCount { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    public User User { get; set; } = null!;
}
```

### 5.3 Activity

```csharp
using NetTopologySuite.Geometries;

public class Activity
{
    public Guid Id { get; set; }
    public Guid CreatedByUserId { get; set; }
    public Guid CategoryId { get; set; }

    public string Title { get; set; } = null!;
    public string? Description { get; set; }

    public DateTime EventDate { get; set; }
    public int NeededPeopleCount { get; set; }
    public int CurrentPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }

    public SkillLevel SkillLevel { get; set; } = SkillLevel.Any;
    public GenderPreference GenderPreference { get; set; } = GenderPreference.Any;
    public ActivityStatus Status { get; set; } = ActivityStatus.Open;

    public Point Location { get; set; } = null!;
    public string AddressText { get; set; } = null!;
    public string? AddressDetailPrivate { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    public User CreatedByUser { get; set; } = null!;
    public ActivityCategory Category { get; set; } = null!;
}
```

### 5.4 ActivityRequest

```csharp
public class ActivityRequest
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public Guid UserId { get; set; }
    public string? Message { get; set; }
    public ActivityRequestStatus Status { get; set; } = ActivityRequestStatus.Pending;
    public DateTime CreatedAt { get; set; }
    public DateTime? RespondedAt { get; set; }

    public Activity Activity { get; set; } = null!;
    public User User { get; set; } = null!;
}
```

### 5.5 ActivityParticipant

```csharp
public class ActivityParticipant
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public Guid UserId { get; set; }
    public DateTime JoinedAt { get; set; }
    public bool IsOrganizer { get; set; }
    public bool HasAttended { get; set; }

    public Activity Activity { get; set; } = null!;
    public User User { get; set; } = null!;
}
```

### 5.6 Review

```csharp
public class Review
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public Guid ReviewerUserId { get; set; }
    public Guid ReviewedUserId { get; set; }
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public DateTime CreatedAt { get; set; }
}
```

---

## 6. Enum Taslakları

```csharp
public enum ActivityStatus
{
    Open = 1,
    Full = 2,
    Completed = 3,
    Cancelled = 4
}

public enum ActivityRequestStatus
{
    Pending = 1,
    Approved = 2,
    Rejected = 3,
    Cancelled = 4
}

public enum SkillLevel
{
    Any = 0,
    Beginner = 1,
    Intermediate = 2,
    Advanced = 3
}

public enum GenderPreference
{
    Any = 0,
    Male = 1,
    Female = 2,
    Mixed = 3
}

public enum UserStatus
{
    Active = 1,
    Suspended = 2,
    Deleted = 3
}
```

---

## 7. AppDbContext Taslak Kuralları

PostGIS için `Location` alanı geography olarak tutulmalı.

```csharp
protected override void OnModelCreating(ModelBuilder modelBuilder)
{
    base.OnModelCreating(modelBuilder);

    modelBuilder.Entity<Activity>()
        .Property(x => x.Location)
        .HasColumnType("geography(Point,4326)");

    modelBuilder.Entity<User>()
        .HasIndex(x => x.PhoneNumber)
        .IsUnique();

    modelBuilder.Entity<ActivityRequest>()
        .HasIndex(x => new { x.ActivityId, x.UserId })
        .IsUnique();
}
```

DbContext registration:

```csharp
builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseNpgsql(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        npgsqlOptions => npgsqlOptions.UseNetTopologySuite()
    );
});
```

PostgreSQL tarafında extension:

```sql
CREATE EXTENSION IF NOT EXISTS postgis;
```

---

## 8. API Endpoint Planı

### Auth

```txt
POST   /api/auth/send-otp
POST   /api/auth/verify-otp
POST   /api/auth/refresh-token
POST   /api/auth/logout
GET    /api/auth/me
```

### Profiles

```txt
GET    /api/profiles/me
PUT    /api/profiles/me
GET    /api/profiles/{userId}
```

### Activities

```txt
POST   /api/activities
GET    /api/activities
GET    /api/activities/nearby
GET    /api/activities/map
GET    /api/activities/{id}
PUT    /api/activities/{id}
DELETE /api/activities/{id}
POST   /api/activities/{id}/cancel
POST   /api/activities/{id}/complete
```

### Activity Requests

```txt
POST   /api/activities/{activityId}/requests
GET    /api/activities/{activityId}/requests
POST   /api/activity-requests/{requestId}/approve
POST   /api/activity-requests/{requestId}/reject
POST   /api/activity-requests/{requestId}/cancel
```

### Reviews

```txt
POST   /api/reviews
GET    /api/users/{userId}/reviews
```

### Reports

```txt
POST   /api/reports
GET    /api/admin/reports
POST   /api/admin/reports/{id}/resolve
```

### Notifications

```txt
GET    /api/notifications
POST   /api/notifications/{id}/read
POST   /api/notifications/read-all
```

### Geo

```txt
GET    /api/geo/reverse-geocode?lat=&lng=
GET    /api/geo/search-address?query=
```

### Admin

```txt
GET    /api/admin/users
GET    /api/admin/activities
POST   /api/admin/users/{id}/suspend
POST   /api/admin/users/{id}/activate
```

---

## 9. Nearby Activity Sorgusu

Amaç: Kullanıcının bulunduğu koordinata göre yakın etkinlikleri getirmek.

Request:

```csharp
public class NearbyActivitiesRequest
{
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public int RadiusMeters { get; set; } = 5000;
    public Guid? CategoryId { get; set; }
    public DateTime? FromDate { get; set; }
    public DateTime? ToDate { get; set; }
}
```

EF Core sorgu örneği:

```csharp
var userLocation = new Point(request.Longitude, request.Latitude)
{
    SRID = 4326
};

var query = _db.Activities
    .Where(x => x.Status == ActivityStatus.Open)
    .Where(x => x.EventDate >= DateTime.UtcNow)
    .Where(x => x.Location.Distance(userLocation) <= request.RadiusMeters)
    .OrderBy(x => x.Location.Distance(userLocation));
```

Dikkat:

- Point constructor sırası `longitude, latitude` olmalı.
- SRID `4326` olmalı.
- Distance metre cinsinden çalışması için column type `geography(Point,4326)` olmalı.

---

## 10. Telefon Doğrulama Mantığı

İlk aşamada gerçek SMS sağlayıcı bağlanmadan geliştirme modu olabilir.

Akış:

1. Kullanıcı telefon girer.
2. Sistem OTP üretir.
3. OTP hashlenerek veritabanına kaydedilir.
4. SMS sağlayıcıya gönderilir.
5. Kullanıcı kodu girer.
6. Doğruysa kullanıcı oluşturulur veya login edilir.
7. JWT + Refresh Token döner.

Telefon numarası gizlilik kuralları:

- Profil response içinde telefon numarası dönülmez.
- Admin dışında telefon görünmez.
- Kullanıcı isterse etkinlik katılımcılarına telefonunu paylaşabilir.
- Varsayılan davranış: telefon gizli.

---

## 11. Güven Sistemi

İlk versiyonda güven sistemi şu sinyallerle kurulmalı:

```txt
Telefon doğrulanmış mı?
Profil fotoğrafı var mı?
Kaç etkinliğe katılmış?
Kaç etkinlik oluşturmuş?
Ortalama puanı kaç?
Şikayet sayısı var mı?
Engellenme veya suspend geçmişi var mı?
```

TrustScore ileride hesaplanabilir:

```txt
TrustScore = telefon doğrulama + profil tamlığı + başarılı etkinlik + yorum puanı - şikayet cezası
```

İlk sürümde yalnızca alanlar hazırlanabilir, karmaşık skor şart değil.

---

## 12. Harita İçin Backend Response

Haritada tüm detayları döndürme.

`/api/activities/map` sade response dönmeli:

```csharp
public class ActivityMapItemResponse
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string CategoryName { get; set; } = null!;
    public double Latitude { get; set; }
    public double Longitude { get; set; }
    public DateTime EventDate { get; set; }
    public int NeededPeopleCount { get; set; }
    public decimal? PricePerPerson { get; set; }
    public double DistanceMeters { get; set; }
}
```

---

## 13. Gizlilik Kuralları

Konum ve telefon hassas veridir.

Kurallar:

- Kullanıcının canlı konumu veritabanında gereksiz yere tutulmamalı.
- Etkinlik konumu tutulur.
- Etkinlik detay adresi sadece onaylanan katılımcılara açılabilir.
- Haritada çok hassas pin yerine opsiyonel olarak hafif yuvarlatılmış koordinat gösterilebilir.
- Telefon numarası public profile içinde asla dönülmez.
- Şikayet ve engelleme sistemi ilk sürümde bulunmalı.

---

## 14. Program.cs Temel Yapı

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseNpgsql(
        builder.Configuration.GetConnectionString("DefaultConnection"),
        npgsqlOptions => npgsqlOptions.UseNetTopologySuite()
    );
});

builder.Services.AddAuthentication();
builder.Services.AddAuthorization();

builder.Services.AddSignalR();

builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<IProfileService, ProfileService>();
builder.Services.AddScoped<IActivityService, ActivityService>();
builder.Services.AddScoped<IActivityRequestService, ActivityRequestService>();
builder.Services.AddScoped<IReviewService, ReviewService>();
builder.Services.AddScoped<IReportService, ReportService>();
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddScoped<IGeoService, GeoService>();
builder.Services.AddScoped<IAdminService, AdminService>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseMiddleware<ExceptionHandlingMiddleware>();

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();
app.MapHub<NotificationHub>("/hubs/notifications");

app.Run();
```

---

## 15. Kodlama Kuralları

Claude bu projeyi yazarken şu kurallara uymalı:

1. Tek proje kullanılacak: `Sosyolobi.Api`.
2. Controller ve Service yapısı kullanılacak.
3. Business logic controller içine yazılmayacak.
4. Entity modeller doğrudan dışarı dönülmeyecek.
5. Her response DTO ile dönecek.
6. Telefon numarası public response içinde asla dönmeyecek.
7. Konum sorguları PostGIS/NetTopologySuite ile yapılacak.
8. Tüm tarih alanları UTC tutulacak.
9. Soft delete gereken yerlerde `Status` kullanılacak.
10. Migration düzenli üretilecek.
11. Endpointler REST uyumlu olacak.
12. Swagger açıklamaları düzgün olacak.
13. Exception middleware ile standart hata response dönülecek.
14. Yetki gereken endpointlerde `[Authorize]` kullanılacak.
15. Admin endpointlerinde role kontrolü olacak.

---

## 16. İlk Geliştirme Sırası

Öncelik sırası:

```txt
1. Proje kurulumu
2. PostgreSQL + PostGIS bağlantısı
3. User/Auth/OTP altyapısı
4. Profile altyapısı
5. ActivityCategory seed
6. Activity oluşturma
7. Nearby activity sorgusu
8. Harita response endpointi
9. Activity request/onay-red sistemi
10. Review/rating sistemi
11. Report/block sistemi
12. Notification altyapısı
13. Admin panel endpointleri
```

---

## 17. Başlangıç Aktivite Kategorileri

Seed olarak şu kategoriler eklenmeli:

```txt
Futbol
Basketbol
Voleybol
Tenis
Koşu
Bisiklet
Yürüyüş
Kamp
Kayak
Masa Oyunu
Konser
Kahve & Sosyal Buluşma
Diğer
```

Her kategori için:

```txt
Id
Name
Slug
IconName
Color
IsActive
SortOrder
```

---

## 18. Claude İçin Net Görev

Bu dokümana göre tek bir .NET Web API projesi oluştur.

Proje adı:

```txt
Sosyolobi.Api
```

Mimari:

```txt
Controller + Service + EF Core + PostgreSQL/PostGIS
```

İlk çıktı olarak şunları üret:

1. Klasör yapısı
2. Entity sınıfları
3. DTO sınıfları
4. Enumlar
5. AppDbContext
6. Program.cs
7. Servis interface'leri
8. Boş servis implementasyonları
9. Controller iskeletleri
10. Swagger çalışır yapı
11. PostgreSQL/PostGIS ayarları
12. İlk migration'a hazır yapı

Kod üretirken gereksiz soyutlama yapma. Clean Architecture projeleri oluşturma. Tüm yapı tek API projesi içinde kalmalı.
