import 'package:domain/domain.dart';

import '../../data.dart';

class DetailsRepositoryImpl implements DetailsRepository {
  final LocalDetailsProvider _detailsProvider;

  const DetailsRepositoryImpl(
    this._detailsProvider,
  );

  @override
  Future<List<Details>> getDetails() async {
    final List<DetailsEntity> entities = await _detailsProvider.getDetails();

    return entities.map(DetailsMapper.fromEntity).toList();
  }

  @override
  Future<Details?> getDetailById(String id) async {
    final DetailsEntity? entity = await _detailsProvider.getDetailById(id);

    if (entity == null) {
      return null;
    }

    return DetailsMapper.fromEntity(entity);
  }

  @override
  Future<void> updateDetail(DetailPayload payload) async {
    await _detailsProvider.updateDetail(
      id: payload.id,
      size: payload.size,
      ingredients: payload.ingredients,
    );
  }

  @override
  Future<void> deleteDetail(String id) async {
    await _detailsProvider.deleteDetail(id);
  }

  @override
  Future<void> addDetails(DetailPayload payload) async {
    await _detailsProvider.addDetails(
      id: payload.id,
      size: payload.size,
      ingredients: payload.ingredients,
    );
  }
}
