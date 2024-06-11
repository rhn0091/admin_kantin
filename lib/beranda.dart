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
      // Navigasi ke halaman "Tambah Produk"
      if (_selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Tambah()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor, // Warna latar belakang bottom navigation bar
        selectedItemColor: Colors.white, // Warna ikon terpilih
        unselectedItemColor: Colors.grey[300], // Warna ikon tidak terpilih
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
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


