namespace Sosyolobi.Api.Entities;

public class Review
{
    public Guid Id { get; set; }
    public Guid ActivityId { get; set; }
    public Guid ReviewerUserId { get; set; }
    public Guid ReviewedUserId { get; set; }
    public int Rating { get; set; }
    public string? Comment { get; set; }
    public DateTime CreatedAt { get; set; }

    public Activity Activity { get; set; } = null!;
    public User ReviewerUser { get; set; } = null!;
    public User ReviewedUser { get; set; } = null!;
}
