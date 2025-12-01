import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget child;
  const NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: Offset(-4, -4),
            color: Colors.white,
          ),
          BoxShadow(
            blurRadius: 15,
            offset: Offset(4, 4),
            color: Color.fromRGBO(189, 189, 189, 1),
          )
        ]
      ),
      child: child,
    );
  }
}
