
import 'package:ethio_calend/catagories/historical.dart';
import 'package:ethio_calend/catagories/museums.dart';
import 'package:ethio_calend/catagories/national.dart';
import 'package:ethio_calend/catagories/natrual.dart';
import 'package:ethio_calend/catagories/religious.dart';
import 'package:ethio_calend/screens/money.dart';
import 'package:ethio_calend/services/weather_api_client.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ethio_calend/LanguageDropdown.dart';

import '../model/weather_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> items = [
    "Historical Sites",
    "Natural Wonders",
    "National Parks",
    "Religious Sites",
    "Museums"
  ];
  static final List<Widget> _widgetRoom = <Widget>[
    Historical(),
    Natural(),
    National(),
    Religious(),
    Museum()
  ];

  int current = 0;
  WeatherApiClient client = WeatherApiClient();
  Weather? data;
  Future<void> get_weather_data() async {
    data = await client.getCurrentweather("Addis Ababa");
  }

  @override
  void initState() {
    super.initState();
    get_weather_data();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>_onBackPressed(context),
      child: Scaffold(
        backgroundColor: HexColor('#093A3E'),
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            flex: 3,
                            child: FutureBuilder(
                                future: get_weather_data(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Row(
                                      children: [
                                        Container(
                                          child: const Icon(
                                            Icons.cloudy_snowing,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${data!.temp} c',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily: 'Oxanium',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${data!.cityName}',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontFamily: 'Oxanium',
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container(
                                      child: Text("something wrong"),
                                    );
                                  }
                                 }
                             ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.monetization_on_outlined,
                                  color: Colors.white,
                                ),
                                TextButton(
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                                      return CurrencyConverterScreen();
                                    }));
                                  },
                                  child: Text('Currency'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Oxanium'),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 270, 0),
                        child: Text(
                          "Catagories".tr(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        // width: double.infinity,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: items.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (cxt, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    current = index;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  decoration: BoxDecoration(
                                      color:
                                          current == index ? Colors.white : null,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20.0)),
                                      border: Border.all(
                                          color: Colors.white, width: 1)),
                                  child: Text(
                                    items[index].tr(),
                                    style: TextStyle(
                                      color: current == index
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Oxanium',
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                      // -------- // Catagory Display Section //------
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(0),
                        width: double.infinity,
                        height: 610,
                        child: _widgetRoom[current],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit App'),
        content: Text('Are you sure you want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }
}
