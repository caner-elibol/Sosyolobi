import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/domain/enums.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/category_icons.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/image_url.dart';
import '../../../core/widgets/async_value_widget.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/user_link.dart';
import '../../auth/application/auth_notifier.dart';
import '../../chat/presentation/chat_panel.dart';
import '../../requests/application/requests_providers.dart';
import '../../users/presentation/widgets/participant_actions_menu.dart';
import '../application/activities_providers.dart';
import '../domain/activity.dart';

const _skillLabels = {
  SkillLevel.any: 'Herkes',
  SkillLevel.beginner: 'Başlangıç',
  SkillLevel.intermediate: 'Orta',
  SkillLevel.advanced: 'İleri',
};
const _genderLabels = {
  GenderPreference.any: 'Herkes',
  GenderPreference.male: 'Erkek',
  GenderPreference.female: 'Kadın',
  GenderPreference.mixed: 'Karışık',
};

/// Ports `sosyolobi-web-2/src/app/(user)/app/activities/[id]/page.tsx`.
class ActivityDetailScreen extends ConsumerWidget {
  const ActivityDetailScreen({required this.activityId, super.key});

  final String activityId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityAsync = ref.watch(activityDetailProvider(activityId));

    return Scaffold(
      body: AsyncValueWidget<ActivityDetail>(
        value: activityAsync,
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 120),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stack) => const EmptyStateWidget(
          icon: Icons.error_outline,
          title: 'Etkinlik bulunamadı',
          description: '',
        ),
        data: (activity) =>
            _ActivityDetailBody(activityId: activityId, activity: activity),
      ),
    );
  }
}

class _ActivityDetailBody extends ConsumerStatefulWidget {
  const _ActivityDetailBody({required this.activityId, required this.activity});

  final String activityId;
  final ActivityDetail activity;

  @override
  ConsumerState<_ActivityDetailBody> createState() =>
      _ActivityDetailBodyState();
}

class _ActivityDetailBodyState extends ConsumerState<_ActivityDetailBody> {
  bool _showMessageInput = false;
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleJoin() async {
    await ref
        .read(requestActionsControllerProvider.notifier)
        .join(
          widget.activityId,
          message: _messageController.text.trim().isEmpty
              ? null
              : _messageController.text.trim(),
        );
    if (!mounted) return;
    final error = ref.read(requestActionsControllerProvider).hasError;
    if (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('İstek gönderilemedi.')));
      return;
    }
    setState(() => _showMessageInput = false);
    _messageController.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Katılım isteği gönderildi!')));
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;
    final authState = ref.watch(authProvider).value;
    final currentUserId = authState?.userId;
    final color = CategoryIcons.colorFor(activity.categoryName);
    final totalSpots = activity.neededPeopleCount + 1;
    final dist = Formatters.distanceMeters(activity.distanceMeters);
    final isCancelled = activity.status == ActivityStatus.cancelled;
    final isFull = activity.status == ActivityStatus.full;
    final isParticipant =
        currentUserId != null &&
        activity.participants.any((p) => p.userId == currentUserId);
    final hasPendingRequest =
        activity.myRequestStatus == ActivityRequestStatus.pending;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: false,
          expandedHeight: 180,
          leading: const BackButton(color: Colors.white),
          flexibleSpace: FlexibleSpaceBar(
            background: activity.categoryImageUrl.resolved != null
                ? Image.network(
                    activity.categoryImageUrl.resolved!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        _CategoryHeroFallback(activity: activity, color: color),
                  )
                : _CategoryHeroFallback(activity: activity, color: color),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CategoryBadge(name: activity.categoryName, color: color),
                    if (isCancelled)
                      const _InfoChip(
                        icon: Icons.cancel_outlined,
                        label: 'İptal edildi',
                        tone: _ChipTone.muted,
                      )
                    else if (isFull)
                      const _InfoChip(
                        icon: Icons.people_outline,
                        label: 'Dolu',
                        tone: _ChipTone.muted,
                      )
                    else
                      const _InfoChip(
                        icon: Icons.people_outline,
                        label: 'Açık',
                        tone: _ChipTone.success,
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  activity.title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      Formatters.eventDate(activity.eventDate),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.place_outlined,
                      size: 14,
                      color: AppColors.mutedForeground,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        dist.isNotEmpty
                            ? '${activity.addressText} · $dist'
                            : activity.addressText,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.mutedForeground,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (activity.participants.isNotEmpty)
                      SizedBox(
                        width:
                            26.0 +
                            (activity.participants.length.clamp(0, 4) - 1) *
                                18.0,
                        height: 26,
                        child: Stack(
                          children: [
                            for (
                              var i = 0;
                              i < activity.participants.take(4).length;
                              i++
                            )
                              Positioned(
                                left: i * 18.0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        color: AppColors.background,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: UserAvatar(
                                    displayName:
                                        activity.participants[i].displayName,
                                    avatarUrl:
                                        activity.participants[i].avatarUrl,
                                    size: 26,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      '${activity.currentPeopleCount} / $totalSpots katılıyor',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  children: [
                    _InfoChip(
                      icon: Icons.emoji_events_outlined,
                      label: _skillLabels[activity.skillLevel]!,
                    ),
                    _InfoChip(
                      icon: Icons.people_outline,
                      label: _genderLabels[activity.genderPreference]!,
                    ),
                  ],
                ),
                if (activity.description != null &&
                    activity.description!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const _SectionTitle('Hakkında'),
                  Text(
                    activity.description!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF374151),
                      height: 1.5,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                const _SectionTitle('Detaylar'),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.6,
                  children: [
                    _DetailBox(
                      icon: Icons.account_balance_wallet_outlined,
                      label: 'Kişi Başı Ücret',
                      value: (activity.pricePerPerson ?? 0) > 0
                          ? '${activity.pricePerPerson} ₺'
                          : 'Ücretsiz',
                    ),
                    _DetailBox(
                      icon: Icons.people_outline,
                      label: 'Kontenjan',
                      value: '$totalSpots kişi',
                    ),
                    _DetailBox(
                      icon: Icons.groups_outlined,
                      label: 'Şu an',
                      value: '${activity.currentPeopleCount} kişi',
                    ),
                    _DetailBox(
                      icon: Icons.emoji_events_outlined,
                      label: 'Seviye',
                      value: _skillLabels[activity.skillLevel]!,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const _SectionTitle('Etkinlik Sahibi'),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: UserLink(
                          userId: activity.createdByUserId,
                          child: Row(
                            children: [
                              UserAvatar(
                                displayName: activity.createdByDisplayName,
                                avatarUrl: activity.createdByAvatarUrl,
                                size: 42,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      activity.createdByDisplayName,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 12,
                                          color: Color(0xFFF59E0B),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          'Etkinlik sahibi',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.mutedForeground,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (currentUserId != null &&
                          currentUserId != activity.createdByUserId)
                        ParticipantActionsMenu(
                          userId: activity.createdByUserId,
                          displayName: activity.createdByDisplayName,
                        ),
                    ],
                  ),
                ),
                if (activity.addressDetailPrivate != null &&
                    activity.addressDetailPrivate!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const _SectionTitle('Konum'),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.vpn_key_outlined,
                              size: 12,
                              color: AppColors.success,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              activity.addressDetailPrivate!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Bu adres detayı sadece onaylı katılımcılara gösterilir.',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (activity.participants.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const _SectionTitle('Katılımcılar', noMargin: true),
                      Text(
                        '${activity.participants.length} kişi',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Column(
                      children: [
                        for (var i = 0; i < activity.participants.length; i++)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: i == 0
                                  ? null
                                  : const Border(
                                      top: BorderSide(color: AppColors.border),
                                    ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: UserLink(
                                    userId: activity.participants[i].userId,
                                    child: Row(
                                      children: [
                                        UserAvatar(
                                          displayName: activity
                                              .participants[i]
                                              .displayName,
                                          avatarUrl: activity
                                              .participants[i]
                                              .avatarUrl,
                                          size: 28,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            activity
                                                .participants[i]
                                                .displayName,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (currentUserId != null &&
                                    currentUserId !=
                                        activity.participants[i].userId)
                                  ParticipantActionsMenu(
                                    userId: activity.participants[i].userId,
                                    displayName:
                                        activity.participants[i].displayName,
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                if (!isCancelled && !isFull && !isParticipant)
                  _JoinCard(
                    showMessageInput: _showMessageInput,
                    hasPendingRequest: hasPendingRequest,
                    messageController: _messageController,
                    onStart: () => setState(() => _showMessageInput = true),
                    onCancel: () => setState(() => _showMessageInput = false),
                    onSubmit: _handleJoin,
                  ),
                if (isFull && !isCancelled)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Text(
                      'Kontenjan doldu',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.mutedForeground),
                    ),
                  ),
                if (isCancelled)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppColors.destructiveBg,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: const Text(
                      'Bu etkinlik iptal edildi',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.destructive),
                    ),
                  ),
                if (isParticipant) ChatPanel(activityId: widget.activityId),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _JoinCard extends StatelessWidget {
  const _JoinCard({
    required this.showMessageInput,
    required this.hasPendingRequest,
    required this.messageController,
    required this.onStart,
    required this.onCancel,
    required this.onSubmit,
  });

  final bool showMessageInput;

  /// Backend'in `myRequestStatus` alanından türetiliyor — istek gönderildikten
  /// sonra sayfa yenilense/yeniden açılsa bile kalıcı olarak "İstek Bekliyor"
  /// devre dışı durumuna geçiyor (önceden istek gönderilince buton hiçbir
  /// zaman değişmiyordu, sadece geçici bir snackbar gösteriliyordu).
  final bool hasPendingRequest;
  final TextEditingController messageController;
  final VoidCallback onStart;
  final VoidCallback onCancel;
  final Future<void> Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: hasPendingRequest
          ? SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.hourglass_empty, size: 18),
                label: const Text('İstek Bekliyor'),
              ),
            )
          : showMessageInput
          ? Column(
              children: [
                TextField(
                  controller: messageController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Kendinizi tanıtın (opsiyonel)...',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onSubmit,
                        child: const Text('İstek Gönder'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: onCancel,
                      child: const Text('İptal'),
                    ),
                  ],
                ),
              ],
            )
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onStart,
                icon: const Icon(Icons.people_outline, size: 18),
                label: const Text('Katılmak İstiyorum'),
              ),
            ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text, {this.noMargin = false});

  final String text;
  final bool noMargin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: noMargin ? 0 : 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _DetailBox extends StatelessWidget {
  const _DetailBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: AppColors.mutedForeground),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.mutedForeground,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

enum _ChipTone { none, success, muted }

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    this.tone = _ChipTone.none,
  });

  final IconData icon;
  final String label;
  final _ChipTone tone;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      _ChipTone.success => AppColors.success,
      _ChipTone.muted => AppColors.mutedForeground,
      _ChipTone.none => const Color(0xFF374151),
    };
    final background = tone == _ChipTone.success
        ? AppColors.successBg
        : const Color(0xFFF3F4F6);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: tone == _ChipTone.none
                  ? FontWeight.normal
                  : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryHeroFallback extends StatelessWidget {
  const _CategoryHeroFallback({required this.activity, required this.color});

  final ActivityDetail activity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, Color.lerp(color, Colors.black, 0.3)!],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        CategoryIcons.iconFor(activity.categoryName),
        size: 56,
        color: Colors.white.withValues(alpha: 0.85),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 3, 10, 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
