import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:admin/edit.dart'; // Ensure this path is correct

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
      final response = await http.get(Uri.parse('http://localhost/ukk_amri/read.php')); // Adjust URL for emulator
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception caught: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  Future<void> _confirmDeleteDialog(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Hapus"),
          content: const Text("Apakah Anda yakin ingin menghapus barang ini?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Batal"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Hapus"),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteItem(index);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem(int index) async {
    var id = _listdata[index]['id'].toString();
    var url = Uri.parse("http://localhost/ukk_amri/delete.php?id=$id"); // Adjust URL for emulator

    try {
      var response = await http.delete(url, headers: {
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      });

      if (response.statusCode == 200) {
        setState(() {
          _listdata.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Barang berhasil dihapus")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menghapus barang. Error: ${response.statusCode}")),
        );
        print("Delete request failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      print("Exception caught: $e");
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
                        MaterialPageRoute(
                          builder: (context) => Update(
                            id: _listdata[index]['id'],
                            data: {
                              'nama_barang': _listdata[index]['nama_barang'],
                              'harga': _listdata[index]['harga'],
                              'jumlah': _listdata[index]['jumlah'],
                              'deskripsi': _listdata[index]['deskripsi'],
                            },
                          ),
                        ),
                      ).then((value) {
                        if (value == true) {
                          _getdata();
                        }
                      });
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
