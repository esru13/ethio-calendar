import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:ethio_calend/size_config.dart';
import 'package:hexcolor/hexcolor.dart';




class Year_Converter extends StatefulWidget {
  @override
  _Year_ConverterState createState() => _Year_ConverterState();
}

class _Year_ConverterState extends State<Year_Converter> {
  int selectedETDay = 1;
  int selectedETMonth = 1;
  int selectedETYear = 1990;

  int selectedGRDay = 1;
  int selectedGRMonth = 1;
  int selectedGRYear = 1990;

  List<int> DAYS = List<int>.generate(30, (index) => index + 1);
  List<String> ETMONTHS = [
    "መስከረም",
    "ጥቅምት",
    "ህዳር",
    "ታህሳስ",
    "ጥር",
    "የካቲት",
    "መጋቢት",
    "ሚያዝያ",
    "ግንቦት",
    "ሰኔ",
    "ሀምሌ",
    "ነሃሴ",
    "ጳጉሜ"
  ];
  List<String> gregorianMonth = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  List<int> YEARS = List<int>.generate(61, (index) => index + 1990);

  int converted_year = 0;
  String converted_month = '';
  int converted_day = 0;

  int converted_year_greg = 0;
  String converted_month_greg = '';
  int converted_day_greg = 0;

  void getresult(String gregorian){

  }


  @override
  Widget build(BuildContext context) {
    String gregorian;
    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 4.63 * SizeConfig.widthMultiplier,
                  right: 4.63 * SizeConfig.widthMultiplier,
                  top: 2.45 * SizeConfig.heightMultiplier,
                  bottom: 1.2255 * SizeConfig.heightMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "ከኢትዮጵያ ወደ ጎርጎሮሳውያን",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 2.06 * SizeConfig.textMultiplier),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Divider(
                          color: Colors.black,
                          indent: 3.47 * SizeConfig.widthMultiplier,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<int>(
                  value: selectedETDay,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedETDay = newValue!;
                    });
                  },
                  items: DAYS.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.0),
                DropdownButton<int>(
                  value: selectedETMonth,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedETMonth = newValue!;
                    });
                  },
                  items: ETMONTHS.asMap().entries.map<DropdownMenuItem<int>>((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key + 1,
                      child: Text(entry.value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.0),
                DropdownButton<int>(
                  value: selectedETYear,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedETYear = newValue!;
                    });
                  },
                  items: YEARS.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    // From Ethiopian TO Gregorian
                    EtDatetime etConvert = new EtDatetime(year: selectedETYear, month: selectedETMonth, day: selectedETDay);
                    DateTime gregorian = new DateTime.fromMillisecondsSinceEpoch(etConvert.moment);
                    converted_year = gregorian.year;
                    converted_month = gregorianMonth[gregorian.month-1];
                    converted_day = gregorian.day;
                  });
                },
                child: Text("ቀይር"),
              style: ElevatedButton.styleFrom(
                primary: HexColor('#093A3E'),

              ),
            ),
            SizedBox(height: 10,),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("$converted_month - $converted_day - $converted_year ",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),

            //  Gregorian TO Ethiopia
            Padding(
              padding: EdgeInsets.only(
                  left: 4.63 * SizeConfig.widthMultiplier,
                  right: 4.63 * SizeConfig.widthMultiplier,
                  top: 2.45 * SizeConfig.heightMultiplier,
                  bottom: 1.2255 * SizeConfig.heightMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Date Converter",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 2.06 * SizeConfig.textMultiplier),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Divider(
                          color: Colors.black,
                          indent: 3.47 * SizeConfig.widthMultiplier,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<int>(
                  value: selectedGRDay,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedGRDay = newValue!;
                    });
                  },
                  items: DAYS.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.0),
                DropdownButton<int>(
                  value: selectedGRMonth,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedGRMonth = newValue!;
                    });
                  },
                  items: gregorianMonth.asMap().entries.map<DropdownMenuItem<int>>((entry) {
                    return DropdownMenuItem<int>(
                      value: entry.key + 1,
                      child: Text(entry.value),
                    );
                  }).toList(),
                ),
                SizedBox(width: 16.0),
                DropdownButton<int>(
                  value: selectedGRYear,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedGRYear = newValue!;
                    });
                  },
                  items: YEARS.map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  // From Ethiopian TO Gregorian
                  DateTime gregorian1 = new DateTime(selectedGRYear,selectedGRMonth,selectedGRDay);
                  // EtDatetime greConvert = new EtDatetime(year: selectedETYear, month: selectedETMonth, day: selectedETDay);
                  EtDatetime ethiopian1 = new EtDatetime.fromMillisecondsSinceEpoch(gregorian1.millisecondsSinceEpoch);
                  converted_year_greg = ethiopian1.year;
                  converted_month_greg = ETMONTHS[ethiopian1.month - 1];
                  converted_day_greg = ethiopian1.day + 1;

                });
              },
              child: Text("convert"),
              style: ElevatedButton.styleFrom(
                primary: HexColor('#093A3E'),
              ),
            ),
            SizedBox(height: 10,),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("$converted_month_greg - $converted_day_greg - $converted_year_greg ዓ.ም",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
            ),
          ],
        ),
    );
  }
}

