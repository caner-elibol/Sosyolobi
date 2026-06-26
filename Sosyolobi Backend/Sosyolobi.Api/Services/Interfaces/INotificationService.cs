using Sosyolobi.Api.Entities;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.Services.Interfaces;

public interface INotificationService
{
    Task<IList<Notification>> GetUserNotificationsAsync(Guid userId);
    Task MarkAsReadAsync(Guid notificationId, Guid userId);
    Task MarkAllAsReadAsync(Guid userId);
    Task SendAsync(Guid userId, NotificationType type, string title, string? body, Guid? relatedActivityId = null);
}
