import 'package:flutter/material.dart';

import '../../../../core/native/native_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int clickCount = 0;

  // Digit terakhir NIM untuk Easter Egg
  static const int secretClick = 5;

  // GANTI DENGAN NIM ASLI
  static const String nim = "20123059";

  String reverseResult = "";

  Future<void> reverseNim() async {
    try {
      final result = await NativeService.reverseNim(nim);

      setState(() {
        reverseResult = result;
      });
    } catch (e) {
      setState(() {
        reverseResult = "Error : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  clickCount++;

                  if (clickCount == secretClick) {
                    clickCount = 0;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("🎉 Easter Egg Berhasil!"),
                      ),
                    );
                  }
                },
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      AssetImage("assets/images/profile.jpg"),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Yulianti Awaliyah",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Mahasiswa Informatika",
              ),

              const SizedBox(height: 8),

              const Text(
                "DigiNews Indonesia",
              ),

              const SizedBox(height: 30),

              Text(
                "NIM : $nim",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: reverseNim,
                  icon: const Icon(Icons.android),
                  label: const Text("Test MethodChannel"),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                reverseResult.isEmpty
                    ? "Hasil Reverse NIM akan tampil di sini"
                    : reverseResult,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}