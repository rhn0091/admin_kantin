import 'package:admin/produk.dart';
import 'package:admin/tambah.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Halaman Beranda',
      theme: ThemeData(
        primaryColor: Colors.deepPurple, // Warna utama aplikasi
        hintColor: Colors.amber, // Warna aksen
        scaffoldBackgroundColor: Colors.grey[200], // Warna latar belakang
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Colors.black87, // Warna teks utama
          ),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      
      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tambah()),
        );
      }
      
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProdukBarang()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selamat Datang'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'di Aplikasi Manajemen Produk',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor, // Warna latar belakang bottom navigation bar
        selectedItemColor: Colors.white, // Warna ikon terpilih
        unselectedItemColor: Colors.grey[300], // Warna ikon tidak terpilih
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility),
            label: 'Lihat Produk',
          ),
        ],
      ),
    );
  }
}
