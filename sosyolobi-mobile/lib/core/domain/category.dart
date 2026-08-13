import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// Mirrors the anonymous object `CategoriesController.GetAll()` returns
/// (`{id,name,slug,iconName,color,imageUrl,sortOrder}` — not a named DTO
/// server-side, but the shape is stable). Shared across map/activities/
/// create-wizard, so it lives in `core/domain` rather than one feature.
@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String slug,
    String? iconName,
    String? color,
    String? imageUrl,
    required int sortOrder,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}
