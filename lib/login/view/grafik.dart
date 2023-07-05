import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:monitoring/login/view/login.dart';

import '../data.dart';

class GrafikPage extends StatefulWidget {
  const GrafikPage({Key? key}) : super(key: key);

  @override
  GrafikPageState createState() => GrafikPageState();
}

class GrafikPageState extends State<GrafikPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final rdm = Random();

  List<Map> data = [];

  late Timer timer;

  final priceVolumeStream = StreamController<GestureEvent>.broadcast();

  final heatmapStream = StreamController<Selected?>.broadcast();

  @override
  void initState() {
    data = [
      {'genre': 'Sports', 'sold': rdm.nextInt(300)},
      {'genre': 'Strategy', 'sold': rdm.nextInt(300)},
      {'genre': 'Action', 'sold': rdm.nextInt(300)},
      {'genre': 'Shooter', 'sold': rdm.nextInt(300)},
      {'genre': 'Other', 'sold': rdm.nextInt(300)},
    ];

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        data = [
          {'genre': 'Sports', 'sold': rdm.nextInt(300)},
          {'genre': 'Strategy', 'sold': rdm.nextInt(300)},
          {'genre': 'Action', 'sold': rdm.nextInt(300)},
          {'genre': 'Shooter', 'sold': rdm.nextInt(300)},
          {'genre': 'Other', 'sold': rdm.nextInt(300)},
        ];
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
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
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: 350,
                  height: 200,
                  child: Chart(
                    padding: (_) => EdgeInsets.zero,
                    data: heatmapData,
                    variables: {
                      'name': Variable(
                        accessor: (List datum) => datum[0].toString(),
                      ),
                      'day': Variable(
                        accessor: (List datum) => datum[1].toString(),
                      ),
                      'sales': Variable(
                        accessor: (List datum) => datum[2] as num,
                      ),
                    },
                    marks: [
                      PolygonMark(
                        shape: ShapeEncode(value: HeatmapShape(sector: true)),
                        color: ColorEncode(
                          variable: 'sales',
                          values: [
                            const Color(0xffbae7ff),
                            const Color(0xff1890ff),
                            const Color(0xff0050b3)
                          ],
                          updaters: {
                            'tap': {false: (color) => color.withAlpha(70)}
                          },
                        ),
                        selectionStream: heatmapStream,
                      )
                    ],
                    coord: PolarCoord(),
                    selections: {'tap': PointSelection()},
                    tooltip: TooltipGuide(
                      anchor: (_) => Offset.zero,
                      align: Alignment.bottomRight,
                    ),
                  ),
                ),
              ],
            ))),
      ),
    );
  }
}
