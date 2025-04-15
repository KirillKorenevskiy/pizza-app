import 'package:domain/domain.dart';

import '../../data.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final LocalDetailsProvider _detailsProvider;

  const DetailsRepositoryImpl(
    this._detailsProvider,
  );

  @override
  Future<List<Details>> getDetails(String userId) async {
    final List<DetailsEntity> entities =
        await _detailsProvider.getDetails(userId);

    return entities.map(DetailsMapper.fromEntity).toList();
  }

  @override
  Future<Details?> getDetailById(GetDeleteDetailPayload payload) async {
    final DetailsEntity? entity = await _detailsProvider.getDetailById(
      payload.id,
      payload.userId,
    );

    return entity != null ? DetailsMapper.fromEntity(entity) : null;
  }

  @override
  Future<void> updateDetail(DetailPayload payload) async {
    await _detailsProvider.updateDetail(
      id: payload.id,
      userId: payload.userId,
      size: payload.size,
      ingredients: payload.ingredients,
    );
  }

  @override
  Future<void> deleteDetail(GetDeleteDetailPayload payload) async {
    await _detailsProvider.deleteDetail(
      payload.id,
      payload.userId,
    );
  }

  @override
  Future<void> addDetails(DetailPayload payload) async {
    await _detailsProvider.addDetails(
      id: payload.id,
      userId: payload.userId,
      size: payload.size,
      ingredients: payload.ingredients,
    );
  }

  @override
  Future<void> clearDetails(String userId) async {
    await _detailsProvider.clearDetails();
  }
}
