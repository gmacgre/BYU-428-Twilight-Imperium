import 'package:flutter/material.dart';

class ObjectiveView extends StatelessWidget {

  final Widget? child;
  final int value;
  const ObjectiveView({
    super.key,
    this.child,
    this.value = 1
  });


  @override
  Widget build(BuildContext context) {
    String imageLocation = 'assets/icons/color/general/public_${(value == 1)? 'i' : 'ii'}.png';
    return DecoratedBox(
      decoration: BoxDecoration(
        color: (value == 1)? Colors.amberAccent : Colors.blueAccent,
        border: Border.all(
          color: Colors.black,
          width: 2.0
          )
      ),
      
      //Agendas Scored    
      child: SizedBox(
        width: 30.0,
        height: 50.0,
        child: Center(
          child: (child == null) ? Image.asset(imageLocation, fit: BoxFit.fitWidth) : child
        )
      ),
    );
  }
}/*

*/