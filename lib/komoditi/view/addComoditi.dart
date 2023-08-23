import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monitoring/komoditi/service/service.dart';
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class CountComoditi extends StatefulWidget {
  const CountComoditi({
    Key? key,
    required this.id,
    // ignore: non_constant_identifier_names
    required this.nama_komoditi,
    // ignore: non_constant_identifier_names
    required this.status_pengusahaan_tanaman,
  }) : super(key: key);
  final String id;
  // ignore: non_constant_identifier_names
  final String nama_komoditi;
  // ignore: non_constant_identifier_names
  final String status_pengusahaan_tanaman;

  @override
  State<CountComoditi> createState() => _CountComoditiState();
}

class _CountComoditiState extends State<CountComoditi> {
  List provinsi = [];
  // ignore: non_constant_identifier_names
  Future Getprovinsi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var baseUrl = "https://monitoring.dlhcode.com/api/provinsi";
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        provinsi = jsonData['data'];
        // print(provinsi);
      });
    }
  }

  List kabupaten = [];
  // ignore: non_constant_identifier_names
  Future GetKabupaten() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var baseUrl = "https://monitoring.dlhcode.com/api/kabupaten";
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        kabupaten = jsonData['data'];
      });
    }
  }

  // ignore: non_constant_identifier_names
  List Kecamatan = [];
  // ignore: non_constant_identifier_names
  Future GetKecamatan(param) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var baseUrl = "https://monitoring.dlhcode.com/api/kecamatan_by_kabupaten/$param";
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        Kecamatan = jsonData['data'];
      });
    }
  }

  // ignore: non_constant_identifier_names
  List Tahun = [];
  // ignore: non_constant_identifier_names
  Future GetTahun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    var baseUrl = "https://monitoring.dlhcode.com/api/tahun";
    http.Response response = await http.get(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        Tahun = jsonData['data'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // GetKecamatan();
    Getprovinsi();
    GetKabupaten();
    GetTahun();
  }

  Future refresh() async {
    setState(() {
      // GetKecamatan();
      Getprovinsi();
      GetKabupaten();
      GetTahun();
    });
  }

  var toProvinsi = 1;
  String? tokecamatan;
  String? toKabupaten;
  String? toTahun;
  late String tbm;
  late String tm;
  late String tr;
  late String produksi;
  // ignore: non_constant_identifier_names
  late String Pekebun;
  late String hasilPanen;
  late String keterangan;
  bool changebutton = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 20,
                height: MediaQuery.of(context).size.height * 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Komoditi ${widget.nama_komoditi.toString()}",
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "SPT: ${widget.status_pengusahaan_tanaman.toString()}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    SafeArea(
                      child: Form(
                        key: _formkey,
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: SizedBox(
                                width: 400,
                                height: 80,
                                child: Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: TextFormField(
                                      enabled: false,
                                      initialValue: "Kalimantan Tengah",
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Provinsi';
                                        }
                                        return null;
                                      },
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          labelText: 'Provinsi',
                                          hintText: 'Provinsi'),
                                      onChanged: (value) {
                                        setState(() {
                                          toProvinsi = 1;
                                        });
                                      },
                                      
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Kabupaten: ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  hintText: 'Pilih Kabupaten'),
                              isExpanded: true,
                              items: kabupaten.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child:
                                      Text(item['nama_kabupaten'].toString()),
                                );
                              }).toList(),
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == false) return 'Masukan Provinsi';
                                return null;
                              },
                              onChanged: (newVal) {
                                setState(() {
                                  toKabupaten = newVal;
                                  GetKecamatan(newVal);
                                  tokecamatan = null;
                                  // print(newVal);
                                });
                              },
                              value: toKabupaten,
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Kecamatan: ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  hintText: 'Pilih Kecamatan'),
                              isExpanded: true,
                              items: Kecamatan.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child:
                                      Text(item['nama_kecamatan'].toString()),
                                );
                              }).toList(),
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == false)
                                  return 'Masukan Kecamatan';
                                return null;
                              },
                              onChanged: (newVal) {
                                setState(() {
                                  tokecamatan = newVal;
                            
                                });
                              },
                              value: tokecamatan,
                            ),
                          ),
const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Tahun: ",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),

                        
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  hintText: 'Pilih Tahun'),
                              isExpanded: true,
                              items: Tahun.map((item) {
                                return DropdownMenuItem(
                                  value: item['id'].toString(),
                                  child:
                                      Text(item['tahun'].toString()),
                                );
                              }).toList(),
                              validator: (value) {
                                // ignore: unrelated_type_equality_checks
                                if (value == false) return 'Masukan Tahun';
                                return null;
                              },
                              onChanged: (newVal) {
                                setState(() {
                                  toTahun = newVal;
                                
                                });
                              },
                              value: toTahun,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            children: [
                              Text(
                                "Luas Area: ",
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
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
                              const Text(
                                "TM: ",
                                style: TextStyle(fontSize: 17)
                              ),
                              SizedBox(
                                width: 260,
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
                              const Text(
                                "TR: ",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                width: 263,
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
                              const Text(
                                "Produksi: ",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                width: 220,
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
                              const Text(
                                "Pekebun: ",
                                style: TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                width: 220,
                                height: 60,
                                child: Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      obscureText: false,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Masukan Pekebun';
                                        }
                                        return null;
                                      },
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          labelText: 'Masukan Pekebun',
                                          hintText: 'Masukan Pekebun'),
                                      onChanged: (value) {
                                        setState(() {
                                          Pekebun = value;
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
                              const Text(
                                "Keterangan: ",
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
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Masukan Keterangan';
                                        }
                                        return null;
                                      },
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          labelText: 'Masukan Keterangan',
                                          hintText: 'Masukan Keterangan'),
                                      onChanged: (value) {
                                        setState(() {
                                          keterangan = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
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
                                    toProvinsi = 1,
                                    toKabupaten,
                                    tokecamatan,
                                    tbm,
                                    tm,
                                    tr,
                                    produksi,
                                    Pekebun,
                                    toTahun,
                                    keterangan,
                                    context);
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: changebutton ? 50 : 150,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(
                                      changebutton ? 50 : 8)),
                              child: changebutton
                                  ? const Icon(Icons.done)
                                  : const Text(
                                      "Input Data",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                            ),
                          ),
                        ]),
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
