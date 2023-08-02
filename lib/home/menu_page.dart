import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:monitoring/komoditi/view/komoditi.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  String _email = "";
  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = (prefs.getString('email') ?? '');
    });
  }

  Widget build(BuildContext context) {
    return SizedBox(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: Image(
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png")),
              accountName: Text("Sahretech"),
              accountEmail: Text('$_email'),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://cdn.pixabay.com/photo/2016/04/24/20/52/laundry-1350593_960_720.jpg"),
                      fit: BoxFit.cover)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Komoditiy"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (
                      context,
                    ) =>
                            KomodityPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

//widget ini adalah isi dari sidebar atau drawer
