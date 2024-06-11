import 'dart:convert';

import 'package:admin/beranda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 import 'package:http/http.dart' as http;
// import 'package:kantin_wk/beranda.dart';

void main() => runApp(MaterialApp(
      home: LoginPage(),
    ));
   

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  TextEditingController NIP = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> _login() async {
    print("\n=======|> memanggil fungsi _login() ");

    var url = Uri.parse("http://localhost/rehan/login_admin.php"); // Use your machine's IP address
    var response = await http.post(url, body: {"NIP": NIP.text, "password": password.text});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == "Success") {
        print("Data 'log in' ditemukan!\n");
        setState(() {
          NIP.clear();
          password.clear();
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage()
          ),
        );
      } else {
        print("Data tidak ada...\n" + data.toString());

        setState(() {
          password.clear();
        });
      }
    } else {
      print("Server error...");
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Color.fromARGB(255, 120, 194, 204)),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Kantin Wikrama",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: NIP,
                  decoration: const InputDecoration(
                      label: Text("NIP"), icon: Icon(Icons.person)),
                  onChanged: (value) {},
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      label: Text("Kata Sandi"), icon: Icon(Icons.lock)),
                  onChanged: (value) {},
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: Text("Login"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

