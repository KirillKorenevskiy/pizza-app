import '../../domain.dart';

abstract interface class DetailsRepository {
  Future<void> addDetails(DetailPayload payload);

  Future<List<Details>> getDetails(String userId);

  Future<Details?> getDetailById(GetDeleteDetailPayload payload);

  Future<void> updateDetail(DetailPayload payload);

  Future<void> deleteDetail(GetDeleteDetailPayload payload);

  Future<void> clearDetails(String userId);
}
