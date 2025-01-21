import 'package:domain/domain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PizzasScreenBody extends StatelessWidget {
  final LogOutUseCase _logOutUseCase;

  const PizzasScreenBody(this._logOutUseCase);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Row(
          children: <Widget>[
            Text(
              'PIZZA',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            )
          ],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.cart),
          ),
          IconButton(
            onPressed: _logOutUseCase.execute,
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          ),
        ],
      ),
    );
  }
}
