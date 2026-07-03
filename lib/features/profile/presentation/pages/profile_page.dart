import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/native/native_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int clickCount = 0;

  // Ganti dengan digit terakhir NIM Anda
  static const int secretClick = 9;

  bool showAnimation = false;

  String reverseResult = "";

  Future<void> reverseNim() async {
    try {
      // GANTI DENGAN NIM ANDA
      const nim = "20123059";

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

  void checkSecret() {
    clickCount++;

    if (clickCount >= secretClick) {
      clickCount = 0;

      setState(() {
        showAnimation = true;
      });

      Timer(const Duration(seconds: 3), () {
        if (!mounted) return;

        setState(() {
          showAnimation = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                    onTap: checkSecret,
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Mahasiswa Informatika",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "DigiNews Indonesia",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Klik foto profil beberapa kali 😉",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: reverseNim,
                      icon: const Icon(Icons.android),
                      label: const Text(
                        "Test MethodChannel",
                      ),
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
        ),

        if (showAnimation)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.85),
            child: Center(
              child: Lottie.asset(
                "assets/lottie/easter_egg.json",
                repeat: true,
              ),
            ),
          ),
      ],
    );
  }
}