// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:covid_app_new/Services/Utilities/styles.dart';
import 'package:covid_app_new/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/state_services.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices stateServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: stateServices.countriesListApi(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if (!snapshot.hasData) {
                        return ListView.builder(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                      subtitle: Container(
                                        height: 10,
                                        width: 80,
                                        color: Colors.white,
                                      ),
                                      leading: Container(
                                        height: 50,
                                        width: 50,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String name = snapshot.data![index]['country'];
                              if (searchController.text.isEmpty) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot.data![index]
                                                        ['cases'],
                                                    totalDeaths: snapshot.data![index]
                                                        ['deaths'],
                                                    totalRecovered: snapshot.data![index]
                                                        ['recovered'],
                                                    active: snapshot.data![index]
                                                        ['active'],
                                                    critical: snapshot.data![index]
                                                        ['critical'],
                                                    todayRecovered: snapshot.data![index]
                                                        ['todayRecovered'],
                                                    test: snapshot.data![index]['tests'])));
                                      },
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data![index]['country'],
                                          style: kTitleStyle,
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              'Cases:    ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              snapshot.data![index]['cases']
                                                  .toString(),
                                              style: kSubtitleStyle,
                                            ),
                                          ],
                                        ),
                                        leading: Image(
                                            height: 80,
                                            width: 80,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else if (name.toLowerCase().contains(
                                  searchController.text.toLowerCase())) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => DetailScreen(
                                                    image: snapshot.data![index]
                                                        ['countryInfo']['flag'],
                                                    name: snapshot.data![index]
                                                        ['country'],
                                                    totalCases: snapshot.data![index]
                                                        ['cases'],
                                                    totalDeaths: snapshot.data![index]
                                                        ['deaths'],
                                                    totalRecovered: snapshot.data![index]
                                                        ['recovered'],
                                                    active: snapshot.data![index]
                                                        ['active'],
                                                    critical: snapshot.data![index]
                                                        ['critical'],
                                                    todayRecovered: snapshot.data![index]
                                                        ['todayRecovered'],
                                                    test: snapshot.data![index]['tests'])));
                                      },
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data![index]['country'],
                                          style: kTitleStyle,
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Text(
                                              'Cases:    ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              snapshot.data![index]['cases']
                                                  .toString(),
                                              style: kSubtitleStyle,
                                            ),
                                          ],
                                        ),
                                        leading: Image(
                                            height: 80,
                                            width: 80,
                                            image: NetworkImage(
                                                snapshot.data![index]
                                                    ['countryInfo']['flag'])),
                                        trailing: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            });
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
