import 'package:flutter/material.dart';
import '../../../core_ui.dart';

class UpDownButton extends StatefulWidget {
  final int quantity;
  final ValueChanged<int> onValueChanged;

  const UpDownButton({
    Key? key,
    required this.quantity,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  _UpDownButtonState createState() => _UpDownButtonState();
}

class _UpDownButtonState extends State<UpDownButton> {
  int _value;

  _UpDownButtonState() : _value = 0;

  void _increment() {
    setState(() {
      _value++;
    });
    widget.onValueChanged(_value);
  }

  void _decrement() {
    if (_value > 0) {
      setState(() {
        _value--;
      });
      widget.onValueChanged(_value);
    }
  }

  @override
  void initState() {
    super.initState();
    _value = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      decoration: BoxDecoration(
        color: AppColors.of(context).grey,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.remove,
              size: 18,
            ),
            onPressed: _decrement,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$_value',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.of(context).black,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 18,
            ),
            onPressed: _increment,
          ),
        ],
      ),
    );
  }
}
