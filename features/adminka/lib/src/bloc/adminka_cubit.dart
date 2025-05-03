import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

part 'adminka_state.dart';

class AdminkaCubit extends Cubit<AdminkaState> {
  final GetPizzasUseCase _getPizzasUseCase;

  AdminkaCubit(this._getPizzasUseCase) : super(AdminkaState()) {
    loadPizzas();
  }

  Future<void> loadPizzas() async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );
    try {
      final List<Pizza> pizzas = await _getPizzasUseCase.execute();

      emit(
        state.copyWith(
          pizzas: pizzas,
          loading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> addPizza(Pizza pizza) async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );

    try {
      final CollectionReference<Map<String, dynamic>> collection =
          FirebaseFirestore.instance.collection('pizzas');

      final DocumentReference<Map<String, dynamic>> docRef = collection.doc();

      final String generatedId = docRef.id;

      await docRef.set(<String, dynamic>{
        'pizzaId': generatedId,
        'picture': pizza.picture,
        'isVegetarian': pizza.isVegetarian,
        'spicy': pizza.spicy,
        'name': pizza.name,
        'description': pizza.description,
        'price': pizza.price,
        'discount': pizza.discount,
        'macros': <String, int>{
          'calories': pizza.macros.calories,
          'proteins': pizza.macros.proteins,
          'fat': pizza.macros.fat,
          'carbs': pizza.macros.carbs,
        },
      });

      await loadPizzas();
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> updatePizza(Pizza pizza) async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );
    try {
      await FirebaseFirestore.instance
          .collection('pizzas')
          .doc(pizza.pizzaId)
          .update(
        <String, dynamic>{
          'picture': pizza.picture,
          'isVegetarian': pizza.isVegetarian,
          'spicy': pizza.spicy,
          'name': pizza.name,
          'description': pizza.description,
          'price': pizza.price,
          'discount': pizza.discount,
          'macros': <String, int>{
            'calories': pizza.macros.calories,
            'proteins': pizza.macros.proteins,
            'fat': pizza.macros.fat,
            'carbs': pizza.macros.carbs,
          },
        },
      );

      await loadPizzas();
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> deletePizza(String pizzaId) async {
    emit(
      state.copyWith(
        loading: true,
      ),
    );
    try {
      await FirebaseFirestore.instance
          .collection('pizzas')
          .doc(pizzaId)
          .delete();

      await loadPizzas();
    } catch (e) {
      emit(
        state.copyWith(
          loading: false,
          error: e.toString(),
        ),
      );
    }
  }
}
