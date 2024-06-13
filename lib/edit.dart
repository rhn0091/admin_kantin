import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final String id;
  final String initialNamaBarang;
  final String initialHarga;
  final String initialJumlah;
  final String initialDeskripsi;

  const Edit({
    Key? key,
    required this.id,
    required this.initialNamaBarang,
    required this.initialHarga,
    required this.initialJumlah,
    required this.initialDeskripsi,
  }) : super(key: key);

  @override
  EditBarang createState() => EditBarang();
}

class EditBarang extends State<Edit> {
  final TextEditingController namaBarang = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final TextEditingController jumlah = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    namaBarang.text = widget.initialNamaBarang;
    harga.text = widget.initialHarga;
    jumlah.text = widget.initialJumlah;
    deskripsi.text = widget.initialDeskripsi;
  }

  @override
  void dispose() {
    namaBarang.dispose();
    harga.dispose();
    jumlah.dispose();
    deskripsi.dispose();
    super.dispose();
  }

  Future<void> _editItem() async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.http("localhost", "/ukk_amri/update.php");
    var response = await http.post(url, body: {
      "id": widget.id,
      "nama_barang": namaBarang.text,
      "harga": harga.text,
      "jumlah": jumlah.text,
      "deskripsi": deskripsi.text,
    });

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        if (data['status'] == "Success") {
          _showMessageDialog("Success", "Item updated successfully.");
        } else {
          _showMessageDialog("Error", data['message']);
        }
      } catch (e) {
        _showMessageDialog("Error", "Error parsing JSON: $e");
      }
    } else {
      _showMessageDialog("Error", "Server error: ${response.statusCode}");
    }
  }

  void _showMessageDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Barang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: namaBarang,
              decoration: InputDecoration(labelText: "Nama Barang"),
            ),
            TextField(
              controller: harga,
              decoration: InputDecoration(labelText: "Harga"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: jumlah,
              decoration: InputDecoration(labelText: "Jumlah"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: deskripsi,
              decoration: InputDecoration(labelText: "Deskripsi"),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _editItem,
                    child: Text("Simpan Perubahan"),
                  ),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';

// class EditBarang extends StatefulWidget {
//   final int id;
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
//   // Implementasi halaman edit barang
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Barang'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('ID: ${widget.id}'), // Contoh penggunaan widget.id
//             TextFormField(
//               initialValue: widget.initialNamaBarang,
//               decoration: InputDecoration(labelText: 'Nama Barang'),
//               onChanged: (value) {
//                 // Implementasi logika perubahan nama barang
//               },
//             ),
//             TextFormField(
//               initialValue: widget.initialHarga,
//               decoration: InputDecoration(labelText: 'Harga'),
//               onChanged: (value) {
//                 // Implementasi logika perubahan harga
//               },
//             ),
//             TextFormField(
//               initialValue: widget.initialJumlah,
//               decoration: InputDecoration(labelText: 'Jumlah'),
//               onChanged: (value) {
//                 // Implementasi logika perubahan jumlah
//               },
//             ),
//             TextFormField(
//               initialValue: widget.initialDeskripsi,
//               decoration: InputDecoration(labelText: 'Deskripsi'),
//               maxLines: null, // Untuk membuat input field dapat menampilkan beberapa baris
//               onChanged: (value) {
//                 // Implementasi logika perubahan deskripsi
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Implementasi logika simpan perubahan
//               },
//               child: Text('Simpan'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

