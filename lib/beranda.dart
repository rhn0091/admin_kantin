
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


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class EditBarang extends StatefulWidget {
//   final String id;
//   final String initialNamaBarang;
//   final String initialHarga;
//   final String initialJumlah;
//   final String initialDeskripsi;

//   const EditBarang({
//     Key? key,
//     required this.id,
//     required this.initialNamaBarang,
//     required this.initialHarga,
//     required this.initialJumlah,
//     required this.initialDeskripsi,
//   }) : super(key: key);

//   @override
//   _EditBarangState createState() => _EditBarangState();
// }

// class _EditBarangState extends State<EditBarang> {
//   final TextEditingController namaBarangController = TextEditingController();
//   final TextEditingController hargaController = TextEditingController();
//   final TextEditingController jumlahController = TextEditingController();
//   final TextEditingController deskripsiController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     namaBarangController.text = widget.initialNamaBarang;
//     hargaController.text = widget.initialHarga;
//     jumlahController.text = widget.initialJumlah;
//     deskripsiController.text = widget.initialDeskripsi;
//   }

//   @override
//   void dispose() {
//     namaBarangController.dispose();
//     hargaController.dispose();
//     jumlahController.dispose();
//     deskripsiController.dispose();
//     super.dispose();
//   }

//   Future<void> _editItem() async {
//     setState(() {
//       _isLoading = true;
//     });

//     var url = Uri.http("localhost", "/ukk_amri/update.php");
//     var response = await http.post(url, body: {
//       "id": widget.id.toString(),
//       "nama_barang": namaBarangController.text,
//       "harga": hargaController.text,
//       "jumlah": jumlahController.text,
//       "deskripsi": deskripsiController.text,
//     });

//     setState(() {
//       _isLoading = false;
//     });

//     if (response.statusCode == 200) {
//       try {
//         var data = json.decode(response.body);
//         if (data['status'] == "Success") {
//           _showMessageDialog("Success", "Item updated successfully.");
//         } else {
//           _showMessageDialog("Error", data['message']);
//         }
//       } catch (e) {
//         _showMessageDialog("Error", "Error parsing JSON: $e");
//       }
//     } else {
//       _showMessageDialog("Error", "Server error: ${response.statusCode}");
//     }
//   }

//   void _showMessageDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: Text(title),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Barang"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               controller: namaBarangController,
//               decoration: InputDecoration(labelText: "Nama Barang"),
//             ),
//             TextFormField(
//               controller: hargaController,
//               decoration: InputDecoration(labelText: "Harga"),
//               keyboardType: TextInputType.number,
//             ),
//             TextFormField(
//               controller: jumlahController,
//               decoration: InputDecoration(labelText: "Jumlah"),
//               keyboardType: TextInputType.number,
//             ),
//             TextFormField(
//               controller: deskripsiController,
//               decoration: InputDecoration(labelText: "Deskripsi"),
//               keyboardType: TextInputType.multiline,
//               maxLines: null,
//             ),
//             SizedBox(height: 20),
//             _isLoading
//                 ? CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: _editItem,
//                     child: Text("Simpan Perubahan"),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }