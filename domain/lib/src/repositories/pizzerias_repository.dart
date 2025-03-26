import '../../domain.dart';

abstract interface class PizzeriasRepository{
  Future<List<Address>> getPizzeriasAddresses();
}