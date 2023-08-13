import 'package:flutter/material.dart';
import 'package:monitoring/home/view/home.dart';
import 'package:monitoring/komoditi/view/addComoditi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class KomodityPage extends StatefulWidget {
  const KomodityPage({super.key});

  @override
  State<KomodityPage> createState() => _KomodityPageState();
}

List _get = [];

class _KomodityPageState extends State<KomodityPage> {
  Future riwayatTiket() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      var token = preferences.getString('token');
      var _riwayatTiket =
          Uri.parse('https://monitoring.dlhcode.com/api/komoditi');
      http.Response response = await http.get(_riwayatTiket, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + token.toString(),
      });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _get = data['data'];
          // print(_get);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future refresh() async {
    setState(() {
      riwayatTiket();
    });
  }

  void initState() {
    super.initState();
    riwayatTiket();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Rekap Hasil Komoditi",
                style: TextStyle(fontSize: 30),
              ),
              
              SizedBox(height: 10),
              Row(
                children: [
                  Text("Hasil Komoditi:", style: TextStyle(fontSize: 20))
                ],
              ),
              Expanded(
                flex: 1,
                child: RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    itemCount: _get.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.all(10),
                      elevation: 8,
                      child: SizedBox(
                        height: 90,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 48, 31, 83),
                            child: Image.network(
                              'https://monitoring.dlhcode.com/images/${_get[index]['gambar']}',
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          title: Text(
                            _get[index]['nama_komoditi'].toString() +
                                ' | ' +
                                _get[index]['status_pengusahaan_tanaman']
                                    .toString(),
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            _get[index]['status_pengusahaan_tanaman']
                                .toString(),
                            maxLines: 2,
                            style: new TextStyle(fontSize: 14.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountComoditi(
                                        id: _get[index]['id'].toString(),
                                        nama_komoditi: _get[index]['nama_komoditi'].toString(),
                                        status_pengusahaan_tanaman: _get[index]['status_pengusahaan_tanaman'].toString(),
                                      ),
                                    ));
                              },
                              child: Text("Input")),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
