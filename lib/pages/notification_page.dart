import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Text('Notifikasi'),
      ),
      body: const Center(
        child: Text('Belum ada notifikasi',
            style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
