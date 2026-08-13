# Graph Report - Sosyolobi  (2026-08-13)

## Corpus Check
- Large corpus: 417 files · ~590,355 words. Semantic extraction will be expensive (many Claude tokens). Consider running on a subfolder.

## Summary
- 1487 nodes · 3041 edges · 101 communities (81 shown, 20 thin omitted)
- Extraction: 95% EXTRACTED · 5% INFERRED · 0% AMBIGUOUS · INFERRED: 152 edges (avg confidence: 0.8)
- Token cost: 0 input · 125,026 output

## Community Hubs (Navigation)
- Admin Controller
- Auth Service
- Activity Service
- Activity Request Service
- Hero Mockup
- Chat Service
- Profiles Controller
- I Review Service
- Report Service
- User
- Launch Settings
- Page 1
- Activity Detail Response
- Pexels Image Service
- Tsconfig
- Users Controller
- Map View
- Admin
- Use Users
- Page 2
- Activities Controller
- Auth
- Page 3
- Page 4
- Create Activity Form
- I Geo Service
- Geo Options
- Page 5
- Page 6
- Use Current Location
- Application Builder Extensions
- Naming Conventions History Repository
- Package 1
- Sosyolobi. Api.csproj
- Notification Service
- Chat Message
- Page 7
- Use User Actions
- Chat Hub
- Activity Participant
- Package 2
- App Db Context
- Refresh Token
- Page 8
- Format
- Page 9
- Activity Auto Completion Service
- Activity Join Request Response
- 20260620192559 Add Review Is Hidden
- Sosyolobi Landing Page Frontend Blueprint
- 20260620004145 Initial Create
- Db Initializer
- Exception Handling Middleware
- 20260620195142 Add User Role And Password
- 20260624144337 Add Chat Room And Messages
- 20260624181130 Add Chat Reply And Rate Limit Index
- 20260628204631 Add Chat Room Read
- 20260811162039 Add Category Image Url
- Package 3
- Sosyolobi Admin Frontend Blueprint 1
- Copilot-instructions
- Sosyolobi Backend Skeleton 1
- Sosyolobi Admin Frontend Blueprint 2
- Sosyolobi Backend Skeleton 2
- Sosyolobi User App Frontend Blueprint
- Request Logging Middleware
- Claims Principal Extensions
- Docker-compose
- Service Collection Extensions
- App Db Context Model Snapshot
- Activity Category
- Activity Request Status
- Layout
- Sosyolobi Backend Skeleton 3
- User Block
- Page 10
- Opengraph-image
- Sosyolobi Admin Frontend Blueprint 3
- Error Response
- A G E N T S
- Bottom Sheet
- Proxy
- Package 4
- Package 5
- Package 6
- Package 7
- Package 8
- Package 9
- Package 10
- Package 11
- Package 12
- Next.config
- Package 13
- Package 14
- Package 15
- Package 16
- Postcss.config.mjs

## God Nodes (most connected - your core abstractions)
1. `Sosyolobi.Api.Enums` - 44 edges
2. `Sosyolobi.Api.Services.Interfaces` - 39 edges
3. `userApiClient()` - 33 edges
4. `Sosyolobi.Api.DTOs.Common` - 32 edges
5. `AppDbContext` - 32 edges
6. `Sosyolobi.Api.Entities` - 27 edges
7. `Sosyolobi.Api.Data` - 25 edges
8. `AdminController` - 24 edges
9. `apiClient()` - 24 edges
10. `Sosyolobi.Api.DTOs.Admin` - 20 edges

## Surprising Connections (you probably didn't know these)
- `Ponytail Lazy Senior Dev Mode` --semantically_similar_to--> `Backend Coding Rules (15 Kodlama Kuralı)`  [INFERRED] [semantically similar]
  .github/copilot-instructions.md → docs/Sosyolobi_Backend_Skeleton.md
- `Create Activity Form Spec` --references--> `CreateActivityForm()`  [EXTRACTED]
  docs/Sosyolobi_User_App_Frontend_Blueprint.md → sosyolobi-web-2/src/components/app/CreateActivityForm.tsx
- `Ponytail Lazy Senior Dev Mode` --semantically_similar_to--> `Single-Project Architecture Decision (No Clean Architecture Layers)`  [INFERRED] [semantically similar]
  .github/copilot-instructions.md → docs/Sosyolobi_Backend_Skeleton.md
- `ActivityCard Component Spec` --references--> `ActivityCard()`  [EXTRACTED]
  docs/Sosyolobi_User_App_Frontend_Blueprint.md → sosyolobi-web-2/src/components/app/ActivityCard.tsx
- `User App Data Hooks (useMapActivities etc.)` --references--> `useMapActivities()`  [EXTRACTED]
  docs/Sosyolobi_User_App_Frontend_Blueprint.md → sosyolobi-web-2/src/hooks/useMapActivities.ts

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **Cross-Surface Sosyolobi Brand Color Consistency** — docs_sosyolobi_landing_page_frontend_blueprint_brand_colors, docs_sosyolobi_admin_frontend_blueprint_tech_stack, docs_sosyolobi_user_app_frontend_blueprint_tech_stack [INFERRED 0.85]
- **Platform Trust & Safety Narrative** — docs_sosyolobi_backend_skeleton_trust_score, docs_sosyolobi_landing_page_frontend_blueprint_trust_section, docs_sosyolobi_admin_frontend_blueprint_user_management, docs_sosyolobi_user_app_frontend_blueprint_profile_screen [INFERRED 0.85]
- **Location-Based Discovery Feature Across Backend & Frontends** — docs_sosyolobi_backend_skeleton_nearby_activity_query, docs_sosyolobi_landing_page_frontend_blueprint_map_discovery_section, docs_sosyolobi_user_app_frontend_blueprint_map_screen [INFERRED 0.85]

## Communities (101 total, 20 thin omitted)

### Community 0 - "Admin Controller"
Cohesion: 0.05
Nodes (46): HttpPatch, Guid, HttpGet, HttpPost, HttpPut, IActionResult, Task, AdminController (+38 more)

### Community 1 - "Auth Service"
Cohesion: 0.05
Nodes (34): Authorize, Sosyolobi.Api.Helpers, double, Regex, HttpGet, HttpPost, IActionResult, Task (+26 more)

### Community 2 - "Activity Service"
Cohesion: 0.07
Nodes (37): AllowAnonymous, Guid, HttpDelete, HttpGet, HttpPost, HttpPut, IActionResult, Task (+29 more)

### Community 3 - "Activity Request Service"
Cohesion: 0.08
Nodes (29): Guid, HttpGet, HttpPost, IActionResult, Task, ActivityRequestsController, Guid, HttpGet (+21 more)

### Community 4 - "Hero Mockup"
Cohesion: 0.06
Nodes (36): Home(), metadata, CATEGORIES, CategoriesSection(), FAQS, FaqSection(), FinalCta(), AVATAR_INITIALS (+28 more)

### Community 5 - "Chat Service"
Cohesion: 0.08
Nodes (29): int, Guid, HttpGet, HttpPost, IActionResult, Task, ChatController, Guid (+21 more)

### Community 6 - "Profiles Controller"
Cohesion: 0.08
Nodes (29): Consumes, HashSet, long, RequestSizeLimit, AllowAnonymous, Guid, HttpGet, HttpPost (+21 more)

### Community 7 - "I Review Service"
Cohesion: 0.09
Nodes (24): AllowAnonymous, Guid, HttpGet, HttpPost, IActionResult, Task, ReviewsController, DateTime (+16 more)

### Community 8 - "Report Service"
Cohesion: 0.10
Nodes (22): ControllerBase, HttpPost, IActionResult, Task, ReportsController, AdminReportFilterRequest, UpdateReportStatusRequest, Guid (+14 more)

### Community 9 - "User"
Cohesion: 0.11
Nodes (24): ChatMessageContextMenu(), ChatMessageContextMenuProps, ChatPanel(), ChatPanelProps, formatTime(), ChatReplyPreviewBar(), ChatReplyPreviewBarProps, EmojiPicker() (+16 more)

### Community 10 - "Launch Settings"
Cohesion: 0.07
Nodes (31): commandName, environmentVariables, launchUrl, publishAllPorts, useSSL, ASPNETCORE_ENVIRONMENT, ASPNETCORE_HTTP_PORTS, ASPNETCORE_HTTPS_PORTS (+23 more)

### Community 11 - "Page 1"
Cohesion: 0.11
Nodes (19): ActivityDetailPageInner(), formatDate(), GENDER_LABELS, SKILL_LABELS, IncomingRequests(), SentRequests(), STATUS_LABELS, EmptyState() (+11 more)

### Community 12 - "Activity Detail Response"
Cohesion: 0.13
Nodes (5): Sosyolobi.Api.DTOs.Admin, Sosyolobi.Api.Enums, Sosyolobi.Api.DTOs.Reports, Sosyolobi.Api.DTOs.Activities, Sosyolobi.Api.Entities

### Community 13 - "Pexels Image Service"
Cohesion: 0.08
Nodes (21): HttpClient, PexelsPhoto, PexelsPhotoSrc, HttpGet, IActionResult, IWebHostEnvironment, Task, TimeSpan (+13 more)

### Community 14 - "Tsconfig"
Cohesion: 0.07
Nodes (28): dom, dom.iterable, esnext, **/*.mts, .next/dev/types/**/*.ts, next-env.d.ts, .next/types/**/*.ts, node_modules (+20 more)

### Community 15 - "Users Controller"
Cohesion: 0.13
Nodes (16): AllowAnonymous, Guid, HttpDelete, HttpGet, HttpPost, IActionResult, Task, UsersController (+8 more)

### Community 16 - "Map View"
Cohesion: 0.16
Nodes (19): ActivityCard(), formatDate(), ActivityMarker(), ActivityMarkerProps, ClusterMarker(), ClusterMarkerProps, CategoryStep(), ActivityPreview() (+11 more)

### Community 17 - "Admin"
Cohesion: 0.12
Nodes (20): PILL_BASE, ReportsPage(), STATUS_FILTERS, ActionItem, ActionMenu(), ActionMenuProps, ReportStatusBadge(), ReportFilter (+12 more)

### Community 18 - "Use Users"
Cohesion: 0.17
Nodes (18): C, ConfirmAction, UserDetailPage(), PILL_BASE, STATUS_FILTERS, UsersPage(), BooleanBadge(), UserStatusBadge() (+10 more)

### Community 19 - "Page 2"
Cohesion: 0.15
Nodes (17): ActivityDetailPage(), C, GENDER_LABELS, SKILL_LABELS, ActivitiesPage(), PILL_BASE, STATUS_FILTERS, ConfirmDialog() (+9 more)

### Community 20 - "Activities Controller"
Cohesion: 0.25
Nodes (5): Sosyolobi.Api.DTOs.Common, Sosyolobi.Api.Extensions, Sosyolobi.Api.Services.Interfaces, Sosyolobi.Api.Controllers, Sosyolobi.Api.DTOs.Reviews

### Community 21 - "Auth"
Cohesion: 0.17
Nodes (17): AdminLayout(), qc, FormValues, LoginPage(), schema, NAV, Sidebar(), Topbar() (+9 more)

### Community 22 - "Page 3"
Cohesion: 0.15
Nodes (15): FormValues, LoginForm(), schema, FormValues, schema, VerifyPage(), qc, UserAppLayout() (+7 more)

### Community 23 - "Page 4"
Cohesion: 0.17
Nodes (13): FeedItem, NOTIF_ICONS, NotificationsPage(), AppBottomNav(), TABS, AppShell(), AppShellProps, AppTopbar() (+5 more)

### Community 24 - "Create Activity Form"
Cohesion: 0.13
Nodes (13): ActivityCardProps, CreateActivityForm(), FormValues, inputStyle, nowForDatetimeLocal(), schema, STEP_LABELS, CreateActivityPayload (+5 more)

### Community 25 - "I Geo Service"
Cohesion: 0.16
Nodes (11): HttpGet, IActionResult, Task, GeoController, IList, ILogger, Task, GeoService (+3 more)

### Community 26 - "Geo Options"
Cohesion: 0.14
Nodes (7): Sosyolobi.Api.Services, Sosyolobi.Api.DTOs.Auth, Sosyolobi.Api.Options, string, GeoOptions, string, RedisOptions

### Community 27 - "Page 5"
Cohesion: 0.15
Nodes (12): User App Data Hooks (useMapActivities etc.), MapLibre Integration Spec, GENDER_OPTIONS, MapPage(), PRICE_OPTIONS, RADIUS_OPTIONS, LocationPermissionCard(), LocationPermissionCardProps (+4 more)

### Community 28 - "Page 6"
Cohesion: 0.24
Nodes (13): CategoriesPage(), FormValues, INPUT, schema, useCategories(), useCreateCategory(), useUpdateCategory(), useUpdateCategoryStatus() (+5 more)

### Community 29 - "Use Current Location"
Cohesion: 0.18
Nodes (11): ActivitiesPageInner(), FilterChips(), FilterChipsProps, GeoLocation, PermissionState, readCachedLocation(), useCurrentLocation(), writeCachedLocation() (+3 more)

### Community 30 - "Application Builder Extensions"
Cohesion: 0.13
Nodes (8): Sosyolobi.Api.Middlewares, Sosyolobi.Api.DTOs.Chat, Sosyolobi.Api.Exceptions, Exception, HttpStatusCode, IApplicationBuilder, ApiException, ApplicationBuilderExtensions

### Community 31 - "Naming Conventions History Repository"
Cohesion: 0.15
Nodes (5): Sosyolobi.Api.Data, Sosyolobi.Api.Hubs, Sosyolobi.Api.DTOs.Notifications, NpgsqlHistoryRepository, NamingConventionsHistoryRepository

### Community 32 - "Package 1"
Cohesion: 0.13
Nodes (15): framer-motion, @hookform/resolvers, next, react-map-gl, dependencies, framer-motion, @hookform/resolvers, next (+7 more)

### Community 33 - "Sosyolobi. Api.csproj"
Cohesion: 0.14
Nodes (13): net10.0, BCrypt.Net-Next (4.2.0), EFCore.NamingConventions (10.0.1), Microsoft.AspNetCore.Authentication.JwtBearer (10.0.2), Microsoft.EntityFrameworkCore.Design (10.0.2), Microsoft.VisualStudio.Azure.Containers.Tools.Targets (1.23.0), Npgsql.EntityFrameworkCore.PostgreSQL (10.0.2), Npgsql.EntityFrameworkCore.PostgreSQL.NetTopologySuite (10.0.2) (+5 more)

### Community 34 - "Notification Service"
Cohesion: 0.22
Nodes (9): DateTime, Guid, NotificationResponse, NotificationType, Guid, IHubContext, IList, Task (+1 more)

### Community 35 - "Chat Message"
Cohesion: 0.14
Nodes (11): DateTime, Guid, ChatMessage, DateTime, Guid, ICollection, ChatRoom, DateTime (+3 more)

### Community 36 - "Page 7"
Cohesion: 0.19
Nodes (7): DashboardPage(), PIE_COLORS, StatCard(), StatCardProps, useDashboardStats(), formatDate(), DashboardStats

### Community 37 - "Use User Actions"
Cohesion: 0.24
Nodes (11): ParticipantActionsMenu(), ParticipantActionsMenuProps, REASONS, ReportUserModal(), ReportUserModalProps, ReportUserPayload, useBlockUser(), useReportUser() (+3 more)

### Community 38 - "Chat Hub"
Cohesion: 0.21
Nodes (7): Hub, Guid, Task, ChatHub, Exception, Task, NotificationHub

### Community 39 - "Activity Participant"
Cohesion: 0.15
Nodes (11): Point, DateTime, Guid, ICollection, Activity, DateTime, Guid, ActivityParticipant (+3 more)

### Community 40 - "Package 2"
Cohesion: 0.15
Nodes (13): devDependencies, tailwindcss, @tailwindcss/postcss, @types/node, @types/react, @types/react-dom, typescript, tailwindcss (+5 more)

### Community 41 - "App Db Context"
Cohesion: 0.17
Nodes (10): DbContext, DbSet, ModelBuilder, AppDbContext, DateTime, Guid, Notification, DateTime (+2 more)

### Community 42 - "Refresh Token"
Cohesion: 0.17
Nodes (10): DateTime, Guid, RefreshToken, DateTime, Guid, ICollection, User, DateTime (+2 more)

### Community 43 - "Page 8"
Cohesion: 0.21
Nodes (9): FormValues, ProfilePage(), schema, TrustBadge(), TrustBadgeProps, UpdateProfilePayload, useProfile(), usePublicProfile() (+1 more)

### Community 44 - "Format"
Cohesion: 0.27
Nodes (8): STATUS_COLORS, ACTIVITY_STATUS_COLOR, ACTIVITY_STATUS_LABEL, REPORT_STATUS_COLOR, REPORT_STATUS_LABEL, USER_STATUS_COLOR, USER_STATUS_LABEL, UserStatus

### Community 45 - "Page 9"
Cohesion: 0.33
Nodes (6): PILL_BASE, ReviewsPage(), EmptyState(), useReviews(), useUpdateReviewVisibility(), formatDateTime()

### Community 46 - "Activity Auto Completion Service"
Cohesion: 0.28
Nodes (7): BackgroundService, CancellationToken, IServiceScopeFactory, ILogger, Task, TimeSpan, ActivityAutoCompletionService

### Community 47 - "Activity Join Request Response"
Cohesion: 0.25
Nodes (3): Sosyolobi.Api.DTOs.ActivityRequests, Sosyolobi.Api.DTOs.Profiles, RespondActivityRequest

### Community 48 - "20260620192559 Add Review Is Hidden"
Cohesion: 0.28
Nodes (4): Sosyolobi.Api.Migrations, MigrationBuilder, ModelBuilder, AddReviewIsHidden

### Community 49 - "Sosyolobi Landing Page Frontend Blueprint"
Cohesion: 0.33
Nodes (9): Admin Dashboard Tech Stack (Next.js/Tailwind/shadcn/TanStack), Landing Brand Color Palette (#081B4B/#FF9D23), Landing Next.js Component Structure, Hero Section Design, How It Works Section (Nasıl Çalışır?), Map Discovery Section (Harita/Etkinlik Keşfi), Landing Page Redesign Rationale, Landing/App/Admin Routing Split (/, /app, /admin) (+1 more)

### Community 50 - "20260620004145 Initial Create"
Cohesion: 0.25
Nodes (4): Migration, MigrationBuilder, ModelBuilder, InitialCreate

### Community 51 - "Db Initializer"
Cohesion: 0.25
Nodes (5): IServiceProvider, Task, DbInitializer, Task, SeedData

### Community 52 - "Exception Handling Middleware"
Cohesion: 0.36
Nodes (6): Exception, HttpContext, ILogger, RequestDelegate, Task, ExceptionHandlingMiddleware

### Community 53 - "20260620195142 Add User Role And Password"
Cohesion: 0.29
Nodes (3): MigrationBuilder, ModelBuilder, AddUserRoleAndPassword

### Community 54 - "20260624144337 Add Chat Room And Messages"
Cohesion: 0.29
Nodes (3): MigrationBuilder, ModelBuilder, AddChatRoomAndMessages

### Community 55 - "20260624181130 Add Chat Reply And Rate Limit Index"
Cohesion: 0.29
Nodes (3): MigrationBuilder, ModelBuilder, AddChatReplyAndRateLimitIndex

### Community 56 - "20260628204631 Add Chat Room Read"
Cohesion: 0.29
Nodes (3): MigrationBuilder, ModelBuilder, AddChatRoomRead

### Community 57 - "20260811162039 Add Category Image Url"
Cohesion: 0.29
Nodes (3): MigrationBuilder, ModelBuilder, AddCategoryImageUrl

### Community 58 - "Package 3"
Cohesion: 0.25
Nodes (7): name, private, scripts, build, dev, start, version

### Community 59 - "Sosyolobi Admin Frontend Blueprint 1"
Cohesion: 0.29
Nodes (7): Admin apiClient() Fetch Wrapper Pattern, Admin Category Management Screen, Admin Default Category List, Required Admin Backend Endpoints (/api/admin/*), Backend API Endpoint Plan, Backend Seed Activity Categories, Phone OTP Auth Flow (user_token cookie)

### Community 60 - "Copilot-instructions"
Cohesion: 0.29
Nodes (7): Admin Report Management Screen (Şikayet Yönetimi), Single-Project Architecture Decision (No Clean Architecture Layers), Sosyolobi.Api Folder Structure, Lazy Decision Ladder (stdlib > platform > dependency > one-line > minimal code), ponytail: Comment Convention for Intentional Shortcuts, Ponytail Lazy Senior Dev Mode, YAGNI Principle

### Community 61 - "Sosyolobi Backend Skeleton 1"
Cohesion: 0.38
Nodes (7): Activity Entity (PostGIS Point Location), ActivityParticipant Entity, ActivityRequest Entity, AppDbContext PostGIS Mapping Rules (geography(Point,4326)), ActivityMapItemResponse Contract, Nearby Activity Query (PostGIS Distance Sort), User Entity

### Community 62 - "Sosyolobi Admin Frontend Blueprint 2"
Cohesion: 0.40
Nodes (6): Admin Activity Management Screen, Admin Panel as Security/Moderation Center, Admin Review Management Screen, Admin User Management Screen, Core Enums (ActivityStatus, ActivityRequestStatus, SkillLevel, GenderPreference, UserStatus), Review Entity

### Community 63 - "Sosyolobi Backend Skeleton 2"
Cohesion: 0.33
Nodes (6): Backend Coding Rules (15 Kodlama Kuralı), Phone OTP Verification Flow, Location & Phone Privacy Rules, Activity Detail Screen Spec, Create Activity Form Spec, No Live Location Sharing Rule

### Community 64 - "Sosyolobi User App Frontend Blueprint"
Cohesion: 0.33
Nodes (6): ActivityCard Component Spec, User App Design Rules ("Not a Generic Dashboard"), /app/map Core Discovery Screen, User App Product Sentence ("Yapacak şey var, insan yoksa Sosyolobi var"), Profile Screen Spec (/app/profile), Join Requests Screen Spec (/app/requests)

### Community 65 - "Request Logging Middleware"
Cohesion: 0.33
Nodes (5): HttpContext, ILogger, RequestDelegate, Task, RequestLoggingMiddleware

### Community 66 - "Claims Principal Extensions"
Cohesion: 0.40
Nodes (3): ClaimsPrincipal, Guid, ClaimsPrincipalExtensions

### Community 67 - "Docker-compose"
Cohesion: 0.50
Nodes (5): Program.cs Bootstrap Structure, Backend Tech Stack (.NET 10/PostgreSQL/PostGIS/EF Core/SignalR), db (postgis/postgis:16-3.4) Service, sosyolobi.api Service, Docker Named Volumes (pgdata, avatars, category-images)

### Community 68 - "Service Collection Extensions"
Cohesion: 0.50
Nodes (3): IConfiguration, IServiceCollection, ServiceCollectionExtensions

### Community 69 - "App Db Context Model Snapshot"
Cohesion: 0.40
Nodes (3): ModelSnapshot, ModelBuilder, AppDbContextModelSnapshot

### Community 70 - "Activity Category"
Cohesion: 0.40
Nodes (4): DateTime, Guid, ICollection, ActivityCategory

### Community 71 - "Activity Request Status"
Cohesion: 0.40
Nodes (4): DateTime, Guid, ActivityRequest, ActivityRequestStatus

### Community 72 - "Layout"
Cohesion: 0.40
Nodes (3): inter, metadata, nunito

### Community 73 - "Sosyolobi Backend Skeleton 3"
Cohesion: 0.50
Nodes (4): TrustScore System, UserProfile Entity, No Fake Social Proof / Testimonials Rule, Landing Trust Section (Güven)

### Community 74 - "User Block"
Cohesion: 0.50
Nodes (3): DateTime, Guid, UserBlock

### Community 77 - "Sosyolobi Admin Frontend Blueprint 3"
Cohesion: 0.67
Nodes (3): Admin Route Guard Rule (Admin/SuperAdmin only), Admin Notification Management Screen, Admin Route Structure (/admin/*)

### Community 79 - "A G E N T S"
Cohesion: 0.67
Nodes (3): Next.js Breaking-Changes Agent Rule, CLAUDE.md → AGENTS.md Reference, sosyolobi-web-2 README (create-next-app bootstrap)

## Knowledge Gaps
- **211 isolated node(s):** `RespondActivityRequest`, `commandName`, `dotnetRunMessages`, `applicationUrl`, `commandName` (+206 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **20 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `AppDbContext` connect `App Db Context` to `Admin Controller`, `Auth Service`, `Activity Service`, `Activity Request Service`, `Chat Service`, `Profiles Controller`, `I Review Service`, `Report Service`, `Pexels Image Service`, `Users Controller`, `Naming Conventions History Repository`, `Notification Service`, `Chat Message`, `Chat Hub`, `Activity Participant`, `Refresh Token`, `Db Initializer`, `Activity Category`, `Activity Request Status`, `User Block`?**
  _High betweenness centrality (0.073) - this node is a cross-community bridge._
- **Why does `Sosyolobi.Api.Data` connect `Naming Conventions History Repository` to `App Db Context Model Snapshot`, `Activity Detail Response`, `Activity Join Request Response`, `20260620192559 Add Review Is Hidden`, `20260620004145 Initial Create`, `Db Initializer`, `Activities Controller`, `20260620195142 Add User Role And Password`, `20260624144337 Add Chat Room And Messages`, `20260624181130 Add Chat Reply And Rate Limit Index`, `20260628204631 Add Chat Room Read`, `20260811162039 Add Category Image Url`, `Geo Options`, `Application Builder Extensions`?**
  _High betweenness centrality (0.062) - this node is a cross-community bridge._
- **Why does `Sosyolobi.Api.Services.Interfaces` connect `Activities Controller` to `Activity Detail Response`, `Pexels Image Service`, `Activity Join Request Response`, `I Geo Service`, `Geo Options`, `Application Builder Extensions`, `Naming Conventions History Repository`?**
  _High betweenness centrality (0.047) - this node is a cross-community bridge._
- **What connects `RespondActivityRequest`, `commandName`, `dotnetRunMessages` to the rest of the system?**
  _211 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Admin Controller` be split into smaller, more focused modules?**
  _Cohesion score 0.05183459522422831 - nodes in this community are weakly interconnected._
- **Should `Auth Service` be split into smaller, more focused modules?**
  _Cohesion score 0.05136986301369863 - nodes in this community are weakly interconnected._
- **Should `Activity Service` be split into smaller, more focused modules?**
  _Cohesion score 0.07042253521126761 - nodes in this community are weakly interconnected._