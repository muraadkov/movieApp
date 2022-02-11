import 'package:flutter/material.dart';

class AdultBar extends StatelessWidget {
  const AdultBar({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50.0,
        height: 45.0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(7.0),
            ),
            const Text(
              "18+",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
    );
  }
}