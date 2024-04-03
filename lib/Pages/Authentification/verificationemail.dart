import 'package:flutter/material.dart';
import 'package:flutter_verification_code_field/flutter_verification_code_field.dart';


class Verificationemail extends StatelessWidget {
  const Verificationemail({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: Verifieremail(),
        ),
      ),
    );
  }
}

class Verifieremail extends StatelessWidget {
  const Verifieremail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerificationCodeField(
            length: 5,
            spaceBetween: 10,
            onFilled: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$value Submitted successfully! '),
                ),
              );
            }),
        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


              Text(
                'Vous ne recevez pas de code ? ',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),


            TextButton(
              onPressed: () {


              },
              child: const Text(
                "Renvoyer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust the color as needed
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}