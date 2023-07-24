import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monitoring/komoditi/service/service.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/material/dropdown.dart';

class CountComoditi extends StatefulWidget {
  const CountComoditi({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<CountComoditi> createState() => _CountComoditiState();
}

class _CountComoditiState extends State<CountComoditi> {
  List provinsi = [];
  Future Getprovinsi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var baseUrl = "https://monitoring.dlhcode.com/api/provinsi";
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer " + token.toString(),
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        provinsi = jsonData['data'];
        // print(Kecamatan);
      });
    }
  }
  List Kecamatan = [];
  Future GetKecamatan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var baseUrl = "https://monitoring.dlhcode.com/api/kecamatan";
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer " + token.toString(),
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        Kecamatan = jsonData['data'];
        // print(Kecamatan);
      });
    }
  }

  void initState() {
    super.initState();
    GetKecamatan();
    Getprovinsi();
  }

  Future refresh() async {
    setState(() {
      GetKecamatan();
      Getprovinsi();
    
    });
  }

  String? tokecamatan;
  String? toprovinsi;
  late String tbm;
  late String tm;
  late String tr;
  late String produksi;
  late String pekerja;
  late String tahun;
  bool changebutton = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: new EdgeInsets.all(20.0),
          child: ListView(children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 20,
                height: MediaQuery.of(context).size.height * 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Komoditi Sawit",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: SafeArea(
                        child: Form(
                          key: _formkey,
                          child: Column(children: [
                            Row(children: [
                              Text(
                                "Prov: ",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                width: 250,
                                height: 60,
                                child: Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          hintText: 'Pilih Provinsi', labelText: 'Masukan Provinsi',
                                            ),
                                      isExpanded: true,
                                      items: provinsi.map((item) {
                                        return DropdownMenuItem(
                                          value: item['id'].toString(),
                                          child: Text(item['nama_provinsi']
                                              .toString()),
                                        );
                                      }).toList(),
                                      validator: (value) {
                                        if (value == false)
                                          return 'Masukan Provinsi';
                                        return null;
                                      },
                                      onChanged: (newVal) {
                                        setState(() {
                                          toprovinsi = newVal;
                                          // print(newVal);
                                        });
                                      },
                                      value: tokecamatan,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            Row(children: [
                              Text(
                                "Kec: ",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                width: 250,
                                height: 60,
                                child: Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: DropdownButtonFormField(
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          hintText: 'Pilih Kecamatan', labelText: 'Masukan Kecamatan',
                                            ),
                                      isExpanded: true,
                                      items: Kecamatan.map((item) {
                                        return DropdownMenuItem(
                                          value: item['id'].toString(),
                                          child: Text(item['nama_kecamatan']
                                              .toString()),
                                        );
                                      }).toList(),
                                      validator: (value) {
                                        if (value == false)
                                          return 'Masukan Kecamatan';
                                        return null;
                                      },
                                      onChanged: (newVal) {
                                        setState(() {
                                          tokecamatan = newVal;
                                          // print(newVal);
                                        });
                                      },
                                      value: tokecamatan,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            //------Textformfiled code-------------

                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Luas Area: ",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "TBM: ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 60,
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukan TBM';
                                          }
                                          return null;
                                        },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Masukan TBM',
                                            hintText: 'Masukan TBM'),
                                        onChanged: (value) {
                                          setState(() {
                                            tbm = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "TM: ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 60,
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukan TM';
                                          }
                                          return null;
                                        },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Masukan TM',
                                            hintText: 'Masukan TM'),
                                        onChanged: (value) {
                                          setState(() {
                                            tm = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "TR: ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 60,
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukan TR';
                                          }
                                          return null;
                                        },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Masukan TR',
                                            hintText: 'Masukan TR'),
                                        onChanged: (value) {
                                          setState(() {
                                            tr = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Hasil Panen: ",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Produksi: ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 60,
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukan Produksi';
                                          }
                                          return null;
                                        },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Masukan Produksi',
                                            hintText: 'Masukan Produksi'),
                                        onChanged: (value) {
                                          setState(() {
                                            produksi = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "PEKEBUN: ",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Pekerja: ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 60,
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        obscureText: false,
                                         keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukan Pekerja';
                                          }
                                          return null;
                                        },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Masukan Pekerja',
                                            hintText: 'Masukan Pekerja'),
                                        onChanged: (value) {
                                          setState(() {
                                            pekerja = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "KETERANGAN: ",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Tahun: ",
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  width: 200,
                                  height: 60,
                                  child: Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        obscureText: false,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukan Tahun';
                                          }
                                          return null;
                                        },
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            labelText: 'Masukan Tahun',
                                            hintText: 'Masukan Tahun'),
                                        onChanged: (value) {
                                          setState(() {
                                            tahun = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  changebutton = true;
                                });
                                if (_formkey.currentState!.validate()) {
                                  await KomoditiService.send_data(
                                      widget.id,
                                      tokecamatan,
                                      tbm,
                                      tm,
                                      tr,
                                      produksi,
                                      pekerja,
                                      tahun,
                                      context);

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (
                                  //         context,
                                  //       ) =>
                                  //           ListOutPage(
                                  //         KecamatanValue: KecamatanValue,
                                  //         toAgentValue: toAgentValue,
                                  //         dateofJourney:
                                  //             dateofJourney.text,
                                  //         email: "",
                                  //       ),
                                  //     ));
                                }
                              },
                              child: AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: changebutton ? 50 : 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: changebutton
                                    ? Icon(Icons.done)
                                    : Text(
                                        "Input Data",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(
                                        changebutton ? 50 : 8)),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
