import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'edit.dart'; // Sesuaikan dengan path file edit.dart

class Produk extends StatelessWidget {
  const Produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Halaman Beranda',
      home: ProdukBarang(),
    );
  }
}

class ProdukBarang extends StatefulWidget {
  const ProdukBarang({Key? key}) : super(key: key);

  @override
  State<ProdukBarang> createState() => _ProdukBarangState();
}

class _ProdukBarangState extends State<ProdukBarang> {
  List _listdata = [];

  Future<void> _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost/ukk_amri/read.php'));

      if (response.statusCode == 200) {
        print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  // Fungsi untuk menampilkan dialog konfirmasi hapus
  Future<void> _confirmDeleteDialog(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Apakah Anda yakin ingin menghapus barang ini?"),
          actions: <Widget>[
            TextButton(
              child: Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Hapus"),
              onPressed: () {
                // Panggil fungsi untuk menghapus data
                _deleteItem(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus data
  Future<void> _deleteItem(int index) async {
    // Implementasikan logika penghapusan data di sini
    var id = _listdata[index]['id']; // Ganti dengan sesuai dengan atribut ID pada data Anda
    var url = Uri.http("localhost", "/ukk_amri/delete.php", {"id": id});

    var response = await http.delete(url);

    if (response.statusCode == 200) {
      // Hapus item dari _listdata setelah berhasil dihapus di server
      setState(() {
        _listdata.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Barang berhasil dihapus")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menghapus barang")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
      ),
      body: ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_listdata[index]['nama_barang']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Harga: ${_listdata[index]['harga']}"),
                  Text("Jumlah: ${_listdata[index]['jumlah']}"),
                  Text("Deskripsi: ${_listdata[index]['deskripsi']}"),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Edit(
                          id: _listdata[index]['id'],
                          initialNamaBarang: _listdata[index]['nama_barang'],
                          initialHarga: _listdata[index]['harga'],
                          initialJumlah: _listdata[index]['jumlah'],
                          initialDeskripsi: _listdata[index]['deskripsi'],
                        )),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDeleteDialog(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
