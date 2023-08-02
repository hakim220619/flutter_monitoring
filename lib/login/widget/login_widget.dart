import 'package:flutter/material.dart';
class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 13, 219, 6)),
                    ),
                    onPressed: () {
                    },
                    child: const Text(
                      'Registrasi',
                      style: TextStyle(),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 12, 12, 7)),
                    ),
                    onPressed: () {
                    },
                    child: const Text('Cetak Tiket'),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 231, 3, 3)),
                    ),
                    onPressed: () {
                    },
                    child: const Text('Pesan Tiket'),
                  ),
                ],
              ),
            ],
          );
  }
}