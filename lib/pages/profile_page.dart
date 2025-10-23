import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  bool isEditing = false; 

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.username);
    _phoneController = TextEditingController(text: '+62 ');
    _addressController = TextEditingController(text: 'Jl. jalan kali');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveProfile() {
    setState(() {
      isEditing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: const Text('Profil Pengguna'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.blue),
            onPressed: () {
              if (isEditing) {
                _saveProfile();
              } else {
                _toggleEdit();
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              _nameController.text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),

          // NAMA
          TextField(
            controller: _nameController,
            enabled: isEditing,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
          ),
          const SizedBox(height: 20),

          // TELEPON
          TextField(
            controller: _phoneController,
            enabled: isEditing,
            decoration: const InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: 20),

          // ALAMAT
          TextField(
            controller: _addressController,
            enabled: isEditing,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Alamat',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
          ),

          const SizedBox(height: 30),

          // Tombol logout
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Konfirmasi Logout'),
                  content: const Text('Yakin ingin keluar dari akun?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Batal'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: const Text('Keluar'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Keluar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
