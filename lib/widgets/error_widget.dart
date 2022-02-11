import 'package:flutter/material.dart';
import 'package:movie_application/screens/home_screen.dart';

class ErrorWidgetMovie extends StatelessWidget {
  const ErrorWidgetMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15141F),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const Text(
             'Произошла ошибка',
             style: TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.w500,
               fontSize: 16.0
             ),
           ),
            const SizedBox(height: 40.0,),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
                },
                child: const Text(
                  'Попробовать снова',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0
                  ),
                ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                primary: Colors.white12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}