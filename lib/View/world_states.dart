// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:covid_app_new/Model/world_states_model.dart';
import 'package:covid_app_new/Services/Utilities/styles.dart';
import 'package:covid_app_new/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Services/state_services.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color.fromARGB(255, 220, 244, 3),
    Color.fromARGB(255, 221, 41, 25),
    Color.fromARGB(255, 6, 209, 111),
    Color.fromARGB(255, 247, 6, 182),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9],
            colors: [
              Color(0xFF3594DD),
              Color(0xFF4563DB),
              Color(0xFF5036D5),
              Color(0xFF5B16D0),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                FutureBuilder(
                    future: statesServices.worldStatesRecordsApi(),
                    builder:
                        (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                            flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50.0,
                              controller: _controller,
                            ));
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases!.toString()),
                                "Active": double.parse(
                                    snapshot.data!.active!.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered!.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths!.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: true,
                                  showChartValuesInPercentage: true),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.1,
                              legendOptions: LegendOptions(
                                legendTextStyle: kTitleStyle,
                                legendPosition: LegendPosition.right,
                                legendShape: BoxShape.circle,
                              ),
                              animationDuration: Duration(milliseconds: 1500),
                              chartType: ChartType.ring,
                              ringStrokeWidth: 50,
                              chartLegendSpacing: 50,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .05),
                              child: GridView(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 3,
                                        mainAxisSpacing: 1),
                                children: [
                                  ReuseableGrid(
                                    title: 'Total Cases',
                                    value: snapshot.data!.cases.toString(),
                                    kcolor: Colors.orange,
                                  ),
                                  ReuseableGrid(
                                    title: 'Deaths',
                                    value: snapshot.data!.deaths.toString(),
                                    kcolor: Colors.deepPurple,
                                  ),
                                  ReuseableGrid(
                                    title: 'Recovered',
                                    value: snapshot.data!.recovered.toString(),
                                    kcolor: Colors.green,
                                  ),
                                  ReuseableGrid(
                                    title: 'Active',
                                    value: snapshot.data!.active.toString(),
                                    kcolor: Colors.redAccent,
                                  ),
                                  ReuseableGrid(
                                    title: 'Critical',
                                    value: snapshot.data!.critical.toString(),
                                    kcolor: Colors.blueGrey,
                                  ),
                                  ReuseableGrid(
                                    title: 'Today Cases',
                                    value: snapshot.data!.todayCases.toString(),
                                    kcolor: Colors.brown,
                                  ),
                                  ReuseableGrid(
                                    title: 'Today Deaths',
                                    value:
                                        snapshot.data!.todayDeaths.toString(),
                                    kcolor: Colors.deepOrange,
                                  ),
                                  ReuseableGrid(
                                    title: 'Today Recovered',
                                    value: snapshot.data!.todayRecovered
                                        .toString(),
                                    kcolor: Colors.teal,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CountriesListScreen()));
                              },
                              child: Container(
                                height: 60,
                                width: 350,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent.shade400,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        'Track Countries',
                                        style: kTitleStyle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 30,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseableGrid extends StatelessWidget {
  final String title, value;
  final kcolor;

  const ReuseableGrid(
      {super.key,
      required this.title,
      required this.value,
      required this.kcolor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 500,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: kcolor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'CM Sans Serif',
                        fontSize: 14,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    )),
                Text(
                  value,
                  style: TextStyle(
                      color: Colors.yellowAccent, fontFamily: 'CM Sans Serif'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class ReuseableRow extends StatelessWidget {
//   String title, value;
//   ReuseableRow({super.key, required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [Text(title), Text(value)],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Divider(),
//         ],
//       ),
//     );
//   }
// }
