import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool _pakaiExpress = false;
  String? _selectedPackage;
  bool _antarJemput = false;
  final TextEditingController _noteController = TextEditingController();

  final List<String> paketLaundry = [
    'Cuci Kering',
    'Cuci + Setrika',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      if (args.contains("Express")) _pakaiExpress = true;
      if (args.contains("Cuci Kering")) {
        _selectedPackage = "Cuci Kering";
      } else if (args.contains("Setrika")) {
        _selectedPackage = "Cuci + Setrika";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Pesan Laundry'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            Navigator.pop(context);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Pilih Jenis Layanan',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  RadioMenuButton<bool>(
                    value: false,
                    groupValue: _pakaiExpress,
                    onChanged: (val) => setState(() => _pakaiExpress = val!),
                    child: const Text('Reguler (2–3 Hari)'),
                  ),
                  RadioMenuButton<bool>(
                    value: true,
                    groupValue: _pakaiExpress,
                    onChanged: (val) => setState(() => _pakaiExpress = val!),
                    child: const Text('Express (1 Hari)'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Pilih Paket Laundry',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _selectedPackage,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Paket Laundry',
              ),
              items: paketLaundry.map((paket) {
                return DropdownMenuItem(value: paket, child: Text(paket));
              }).toList(),
              onChanged: (val) => setState(() => _selectedPackage = val),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Antar Jemput'),
                Switch(
                  value: _antarJemput,
                  onChanged: (val) => setState(() => _antarJemput = val),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Catatan Tambahan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Tulis catatan Anda...',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_selectedPackage == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silakan pilih paket laundry terlebih dahulu'),
                    ),
                  );
                  return;
                }

                String pesanan = _pakaiExpress
                    ? "${_selectedPackage!} (Express)"
                    : _selectedPackage!;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pesanan $pesanan berhasil dibuat')),
                );

                Navigator.pop(context, pesanan);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                'Kirim Pesanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
