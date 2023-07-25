
import 'package:flutter/material.dart';
import 'package:monitoring/login/models/jumlah_produksi_model.dart';
import 'package:monitoring/login/models/luas_lahan_model.dart';
import 'package:monitoring/login/models/tahun_model.dart.dart';
import 'package:monitoring/login/service/grafik_service.dart';
import 'package:monitoring/login/view/login.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GrafikPage extends StatefulWidget {
  const GrafikPage({Key? key}) : super(key: key);

  @override
  GrafikPageState createState() => GrafikPageState();
}

class GrafikPageState extends State<GrafikPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final service = GrafikService();

  String dropdownValue = '1';

  @override
  void initState() {
    service.fetchTahun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Dynamic'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginPage(),
                ),
                (route) => false,
              );
            },
            child: Center(
                child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 5),
                  child: const Text(
                    'Selection Stream coupling',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '- The above and below heatmaps share the same selection stream. Tap either one to try.',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: getTahunFutureBuilderWidget(),
                ),
                const SizedBox(height: 8,),
                getLuasLahanFutureBuilderWidget(),
                getJumlahProduksiFutureBuilderWidget()
              ],
            ))),
      ),
    );
  }

  FutureBuilder<JumlahProduksi> getJumlahProduksiFutureBuilderWidget() {
    return FutureBuilder<JumlahProduksi>(
      future: service.fetchJumlahProduksi(dropdownValue),
      builder: (context, snapshot) {
        if(snapshot.hasData){
         return Column(
          children: [
            SfCircularChart(
              title: ChartTitle(
                text: 'Pie Chart Jumlah Produksi'
              ),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom
              ),
              series: <CircularSeries>[
                PieSeries<JumlahProduksiData, String>(
                  dataSource: snapshot.data!.data,
                  xValueMapper: (JumlahProduksiData luasLahan, _) => luasLahan.namaKomoditi,
                  yValueMapper: (JumlahProduksiData luasLahan, _) => double.parse(luasLahan.jumlahProduksi),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: Colors.white
                    )
                  )
                )
              ],
            )
          ],
         );
        } else if (snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        return const SizedBox();
      },
    );
  }

  FutureBuilder<LuasLahan> getLuasLahanFutureBuilderWidget() {
    return FutureBuilder<LuasLahan>(
      future: service.fetchLuasLahan(dropdownValue),
      builder: (context, snapshot) {
        if(snapshot.hasData){
         return Column(
          children: [
            SfCircularChart(
              title: ChartTitle(
                text: 'Pie Chart Luas Lahan'
              ),
              legend: const Legend(
                isVisible: true,
                position: LegendPosition.bottom
              ),
              series: <CircularSeries>[
                PieSeries<LuasLahanData, String>(
                  dataSource: snapshot.data!.data,
                  xValueMapper: (LuasLahanData luasLahan, _) => luasLahan.namaKomoditi,
                  yValueMapper: (LuasLahanData luasLahan, _) => double.parse(luasLahan.luasArea),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      color: Colors.white
                    )
                  )
                )
              ],
            )
          ],
         );
        } else if (snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        return const SizedBox();
      },
    );
  }

  FutureBuilder<Tahun> getTahunFutureBuilderWidget() {
    return FutureBuilder<Tahun>(
      future: service.fetchTahun(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return DropdownButtonFormField(
            hint: const Text('Pilih tahun'),
            items: snapshot.data!.data.map<DropdownMenuItem<String>>((TahunData value) {
              return DropdownMenuItem<String>(
                value: value.id,
                child: Text(value.tahun),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                dropdownValue = value!;
              });
              service.fetchLuasLahan(dropdownValue);
            },
          );
        } else if (snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
