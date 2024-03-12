import 'package:flutter/material.dart';

class CustomCart extends StatelessWidget {
  const CustomCart({super.key,required this.child,required this.number});
  final Widget child;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(right: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          Positioned(
            top: 0,
            bottom: 28,
            left: 25,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle
              ),
              child: Center(
                child: Text(number,style: const TextStyle(
                  color: Colors.white,
                    fontSize: 10,
                  fontWeight: FontWeight.w900
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}
