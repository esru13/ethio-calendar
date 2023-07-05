import 'package:ethio_calend/LanguageDropdown.dart';
import 'package:ethio_calend/screens/Home.dart';
import 'package:ethio_calend/screens/year_converter_screen.dart';
import 'package:flutter/material.dart';
import 'package:abushakir/abushakir.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ethio_calend/blocs/blocs.dart';
import 'package:ethio_calend/screens/calendar.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:ethio_calend/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales:const [Locale('en',"US"),Locale('am', 'ET')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en','US'),
     child:  MyApp(),
    ),
  );
}

const List<String> _weekdays = [
  "ሰ",
  "ማ",
  "ረ",
  "ሐ",
  "አ",
  "ቅ",
  "እ",
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              title: 'Ethiopian Calendar',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: MultiBlocProvider(
                providers: [
                  BlocProvider<CalendarBloc>(
                    create: (BuildContext context) =>
                        CalendarBloc(currentMoment: ETC.today()),
                  ),
                ],
                child: MyHomePage(title: "A Land of Beauty and Wonder",),
              ),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<_MyHomePageState> _pageKey = GlobalKey<_MyHomePageState>();
  EtDatetime a = new EtDatetime.now();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[Home(), MyCalendar(), Year_Converter()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#093A3E'),
        elevation: 0.0,
        title: Text("welcome").tr(),
          //style: TextStyle(
        //       color: Colors.white, fontSize: 2.5 * SizeConfig.textMultiplier),
        // ),
        actions: <Widget>[
          LanguageDropdown(onLanguageChanged: () {
            _pageKey.currentState?.setState(() {});
          }),
        ],
      ),
      body: RefreshIndicator(
        key: _pageKey,
        onRefresh: () async {
          setState(() {});
          },
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home".tr(),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "calendar".tr(),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              label: "etho_holidays".tr()
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor('#093A3E'),
        onTap: _onItemTapped,
      ),
    );
  }
}
