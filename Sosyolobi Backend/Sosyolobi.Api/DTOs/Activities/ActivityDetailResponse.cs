using Sosyolobi.Api.DTOs.Profiles;
using Sosyolobi.Api.Enums;

namespace Sosyolobi.Api.DTOs.Activities;

public class ActivityDetailResponse : ActivityResponse
{
    public string? AddressDetailPrivate { get; set; }
    public IList<PublicProfileResponse> Participants { get; set; } = new List<PublicProfileResponse>();

    /// <summary>
    /// İsteği gönderen kullanıcının bu etkinlik için en güncel katılım isteği durumu
    /// (yoksa null). Anonim/farklı bir kullanıcı için her zaman null. Bu sayede istemci,
    /// istek gönderildikten sonra "Katılmak İstiyorum" butonunu "İstek Bekliyor" gibi
    /// devre dışı bir duruma çevirebilir — sayfa yeniden açılsa/yenilense bile kalıcı.
    /// </summary>
    public ActivityRequestStatus? MyRequestStatus { get; set; }
}
