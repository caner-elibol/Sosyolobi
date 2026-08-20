import 'package:riverpod/riverpod.dart';

import '../../map/application/map_activities_provider.dart';
import '../../map/application/nearby_activities_slider_provider.dart';
import 'activities_providers.dart';

/// Invalidates every cached instance of the nearby/map activity family
/// providers — the Riverpod analog of web's
/// `qc.invalidateQueries({queryKey:["nearby-activities"|"map-activities"]})`
/// after a successful create/cancel/complete mutation.
void invalidateMapActivityCaches(Ref ref) {
  ref.invalidate(nearbyActivitiesProvider);
  ref.invalidate(mapActivitiesProvider);
  ref.invalidate(nearbyActivitiesSliderProvider);
  ref.invalidate(joinedUpcomingActivitiesProvider);
}
