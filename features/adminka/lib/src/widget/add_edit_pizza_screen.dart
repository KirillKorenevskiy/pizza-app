import 'dart:io';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../bloc/adminka_cubit.dart';
import 'macros_widget.dart';

class AddOrEditPizzaScreen extends StatefulWidget {
  final Pizza? initialPizza;
  final VoidCallback? onPizzaAdded;

  const AddOrEditPizzaScreen({super.key, this.initialPizza, this.onPizzaAdded});

  @override
  State<AddOrEditPizzaScreen> createState() => _AddOrEditPizzaScreenState();
}

class _AddOrEditPizzaScreenState extends State<AddOrEditPizzaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController discountController;
  late final TextEditingController calorieController;
  late final TextEditingController proteinController;
  late final TextEditingController fatController;
  late final TextEditingController carbsController;

  late Pizza pizza;

  String? localImagePath;

  @override
  void initState() {
    super.initState();
    pizza = widget.initialPizza ?? Pizza.empty;

    nameController = TextEditingController(
      text: pizza.name,
    );
    descriptionController = TextEditingController(
      text: pizza.description,
    );
    priceController = TextEditingController(
      text: pizza.price.toString(),
    );
    discountController = TextEditingController(
      text: pizza.discount.toString(),
    );
    calorieController = TextEditingController(
      text: pizza.macros.calories.toString(),
    );
    proteinController = TextEditingController(
      text: pizza.macros.proteins.toString(),
    );
    fatController = TextEditingController(
      text: pizza.macros.fat.toString(),
    );
    carbsController = TextEditingController(
      text: pizza.macros.carbs.toString(),
    );
  }

  ImageProvider _getImageProvider() {
    if (localImagePath != null) {
      return FileImage(File(localImagePath!));
    } else if (pizza.picture.startsWith('http')) {
      return NetworkImage(pizza.picture);
    } else {
      return AssetImage('core_ui/assets/${pizza.picture}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.initialPizza != null;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          isEditing ? 'Edit Pizza' : 'Create Pizza',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    setState(() {
                      pizza = pizza.copyWith(
                        picture: image.name,
                      );
                      localImagePath = image.path;
                    });
                  }
                },
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: pizza.picture.isNotEmpty
                        ? DecorationImage(
                            image: _getImageProvider(),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: Colors.grey.shade200,
                  ),
                  child: pizza.picture.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FormTextField(
                      controller: nameController,
                      hintText: 'Name',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FormTextField(
                      controller: descriptionController,
                      hintText: 'Description',
                      obscureText: false,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: FormTextField(
                            controller: priceController,
                            hintText: 'Price',
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FormTextField(
                            controller: discountController,
                            hintText: 'Discount',
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            suffixIcon: const Icon(
                              CupertinoIcons.percent,
                              color: Colors.grey,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Is Vegetarian:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Checkbox(
                          value: pizza.isVegetarian,
                          onChanged: (bool? value) {
                            setState(() {
                              pizza = pizza.copyWith(
                                isVegetarian: value ?? false,
                              );
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        const Text(
                          'Is Spicy:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ...<int>[1, 2, 3].map(
                          (int level) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  pizza = pizza.copyWith(
                                    spicy: level,
                                  );
                                });
                              },
                              child: Ink(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: pizza.spicy == level
                                      ? Border.all(width: 2)
                                      : null,
                                  color: <MaterialColor>[
                                    Colors.green,
                                    Colors.orange,
                                    Colors.red,
                                  ][level - 1],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Macros:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 19),
                    Row(
                      spacing: 3,
                      children: <Widget>[
                        MyMacroWidget(
                          title: 'Calories',
                          value: pizza.macros.calories,
                          icon: Icons.local_fire_department_rounded,
                          controller: calorieController,
                        ),
                        MyMacroWidget(
                          title: 'Protein',
                          value: pizza.macros.proteins,
                          icon: Icons.sports_gymnastics,
                          controller: proteinController,
                        ),
                        MyMacroWidget(
                          title: 'Fat',
                          value: pizza.macros.fat,
                          icon: Icons.fastfood,
                          controller: fatController,
                        ),
                        MyMacroWidget(
                          title: 'Carbs',
                          value: pizza.macros.carbs,
                          icon: Icons.breakfast_dining_rounded,
                          controller: carbsController,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 40,
                child: TextButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final Pizza updatedPizza = pizza.copyWith(
                      name: nameController.text,
                      description: descriptionController.text,
                      price: int.tryParse(priceController.text) ?? 0,
                      discount: int.tryParse(discountController.text) ?? 0,
                      macros: Macros(
                        calories: int.tryParse(calorieController.text) ?? 0,
                        proteins: int.tryParse(proteinController.text) ?? 0,
                        fat: int.tryParse(fatController.text) ?? 0,
                        carbs: int.tryParse(carbsController.text) ?? 0,
                      ),
                    );

                    if (localImagePath != null) {
                      final File file = File(localImagePath!);
                      final Uint8List fileBytes = await file.readAsBytes();
                      final String fileName = pizza.picture;

                      await Supabase.instance.client.storage
                          .from('pizzas')
                          .uploadBinary(fileName, fileBytes);
                    }

                    if (isEditing) {
                      await context
                          .read<AdminkaCubit>()
                          .updatePizza(updatedPizza);
                    } else {
                      await context.read<AdminkaCubit>().addPizza(updatedPizza);
                    }

                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    elevation: 3.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: Text(
                    isEditing ? 'Save Changes' : 'Create Pizza',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
