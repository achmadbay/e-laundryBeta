import 'package:flutter/material.dart';
import 'order_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> pesananAktif = [];

  void _buatPesanan(String paket) {
    setState(() {
      pesananAktif.add({
        'nama': paket,
        'status': 'Sedang diproses',
        'tanggal': '${DateTime.now().day} Okt ${DateTime.now().year}'
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> paketLaundry = [
      {'title': 'Cuci Kering', 'icon': Icons.local_laundry_service},
      {'title': 'Cuci + Setrika', 'icon': Icons.iron},
      {'title': 'Express 1 Hari', 'icon': Icons.timer},
      {'title': 'Coming Soon', 'icon': Icons.more_horiz, 'disabled': true},
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("E-Laundry",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/logo.png'),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const Text("Saldo Anda: Rp 1.550.000",
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ]),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text("Top Up"),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text("Paket Laundry",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          GridView.builder(
            itemCount: paketLaundry.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final item = paketLaundry[index];
              final bool disabled = item['disabled'] == true;

              return GestureDetector(
                onTap: disabled
                    ? null
                    : () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderPage(),
                            settings:
                                RouteSettings(arguments: item['title'] as String),
                          ),
                        );
                        if (result is String) _buatPesanan(result);
                      },
                child: Opacity(
                  opacity: disabled ? 0.4 : 1,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade50, shape: BoxShape.circle),
                        child: Icon(item['icon'], color: Colors.blue, size: 28),
                      ),
                      const SizedBox(height: 5),
                      Text(item['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 25),
          const Text("Pesanan Aktif",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          pesananAktif.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text("Belum ada pesanan.",
                        style: TextStyle(color: Colors.grey)),
                  ),
                )
              : Column(
                  children: pesananAktif.map((order) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            const Icon(Icons.local_laundry_service,
                                color: Colors.blue),
                            const SizedBox(width: 10),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(order['nama']!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(order['tanggal']!,
                                      style: const TextStyle(color: Colors.grey)),
                                ]),
                          ]),
                          Text(order['status']!,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
