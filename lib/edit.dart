import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'produk.dart'; // Sesuaikan dengan path file produk.dart

class Update extends StatefulWidget {
  final String id;
  final Map<String, dynamic> data;

  const Update({Key? key, required this.id, required this.data}) : super(key: key);

  @override
  _UpdateDataPageState createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<Update> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nama_barang = TextEditingController();
  final TextEditingController harga = TextEditingController();
  final TextEditingController jumlah = TextEditingController();
  final TextEditingController deskripsi = TextEditingController();

  @override
  void initState() {
    super.initState();
    nama_barang.text = widget.data['nama_barang'];
    harga.text = widget.data['harga'].toString();
    jumlah.text = widget.data['jumlah'].toString();
    deskripsi.text = widget.data['deskripsi'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Datanya'),
        backgroundColor: Color.fromARGB(255, 29, 91, 248),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nama_barang,
                decoration: InputDecoration(labelText: 'Nama Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: harga,
                decoration: InputDecoration(labelText: 'Harga'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: jumlah,
                decoration: InputDecoration(labelText: 'Jumlah'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stock tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: deskripsi,
                decoration: InputDecoration(labelText: 'Deskripsi'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Info tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateData();
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    var url = Uri.parse("http://localhost/ukk_amri/update.php");
    var response = await http.post(url, body: {
      "id": widget.id.toString(),
      "nama_barang": nama_barang.text,
      "harga": harga.text,
      "jumlah": jumlah.text,
      "deskripsi": deskripsi.text,
    });

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Succes'),
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProdukBarang(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Gagal memperbarui data'),
      ));
    }
  }
}
