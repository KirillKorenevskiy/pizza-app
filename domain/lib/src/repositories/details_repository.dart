import '../../domain.dart';

abstract interface class DetailsRepository{
  Future<void> addDetails(DetailPayload payload);
  
  Future<List<Details>> getDetails();

  Future<Details?> getDetailById(String id);

  Future<void> updateDetail(DetailPayload payload);

  Future<void> deleteDetail(String id);
}