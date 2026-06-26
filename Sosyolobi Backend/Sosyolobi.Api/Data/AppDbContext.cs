using Microsoft.EntityFrameworkCore;
using Sosyolobi.Api.Entities;

namespace Sosyolobi.Api.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

    public DbSet<User> Users => Set<User>();
    public DbSet<UserProfile> UserProfiles => Set<UserProfile>();
    public DbSet<PhoneVerificationCode> PhoneVerificationCodes => Set<PhoneVerificationCode>();
    public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();
    public DbSet<ActivityCategory> ActivityCategories => Set<ActivityCategory>();
    public DbSet<Activity> Activities => Set<Activity>();
    public DbSet<ActivityRequest> ActivityRequests => Set<ActivityRequest>();
    public DbSet<ActivityParticipant> ActivityParticipants => Set<ActivityParticipant>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<Report> Reports => Set<Report>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<UserBlock> UserBlocks => Set<UserBlock>();
    public DbSet<ChatRoom> ChatRooms => Set<ChatRoom>();
    public DbSet<ChatMessage> ChatMessages => Set<ChatMessage>();

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

        modelBuilder.Entity<UserBlock>()
            .HasIndex(x => new { x.BlockerUserId, x.BlockedUserId })
            .IsUnique();

        modelBuilder.Entity<Review>()
            .HasOne(r => r.ReviewerUser)
            .WithMany()
            .HasForeignKey(r => r.ReviewerUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Review>()
            .HasOne(r => r.ReviewedUser)
            .WithMany()
            .HasForeignKey(r => r.ReviewedUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<UserBlock>()
            .HasOne(b => b.BlockerUser)
            .WithMany()
            .HasForeignKey(b => b.BlockerUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<UserBlock>()
            .HasOne(b => b.BlockedUser)
            .WithMany()
            .HasForeignKey(b => b.BlockedUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Report>()
            .HasOne(r => r.ReporterUser)
            .WithMany()
            .HasForeignKey(r => r.ReporterUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Report>()
            .HasOne(r => r.ReportedUser)
            .WithMany()
            .HasForeignKey(r => r.ReportedUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<ChatRoom>()
            .HasIndex(x => x.ActivityId)
            .IsUnique();

        modelBuilder.Entity<ChatMessage>()
            .HasOne(m => m.SenderUser)
            .WithMany()
            .HasForeignKey(m => m.SenderUserId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<ChatMessage>()
            .HasOne(m => m.ReplyToMessage)
            .WithMany()
            .HasForeignKey(m => m.ReplyToMessageId)
            .OnDelete(DeleteBehavior.SetNull);

        modelBuilder.Entity<ChatMessage>()
            .HasIndex(m => new { m.ChatRoomId, m.SenderUserId, m.CreatedAt });
    }
}
