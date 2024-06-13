import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tambah extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}
class _AddItemPageState extends State<Tambah> {
  final TextEditingController nama_barang = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final TextEditingController jumlah = TextEditingController();
   final TextEditingController deskripsi = TextEditingController();
  bool _isLoading = false;

  Future<void> _addItem() async {
    setState(() {
      _isLoading = true;
    });

    var url = Uri.http("localhost", "/ukk_amri/simpan.php");
    var response = await http.post(url, body: {
      "nama_barang": nama_barang.text,
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
          _showMessageDialog("Success", "Item added successfully.");
          setState(() {
            nama_barang.clear();
            harga.clear();
            jumlah.clear();
          });
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
        title: Text("Tambah Barang"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nama_barang,
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
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _addItem,
                    child: Text("Tambah"),
                  ),
          ],
        ),
      ),
    );
  }
}
