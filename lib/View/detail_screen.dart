// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:covid_app_new/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
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
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .069),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        ReuseableGrid(
                          title: 'Cases',
                          value: widget.totalCases.toString(),
                          kcolor: Colors.orange,
                        ),
                        ReuseableGrid(
                          title: 'Active Cases',
                          value: widget.active.toString(),
                          kcolor: Colors.redAccent,
                        ),
                        ReuseableGrid(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString(),
                          kcolor: Colors.green,
                        ),
                        ReuseableGrid(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString(),
                          kcolor: Colors.deepPurple,
                        ),
                        ReuseableGrid(
                          title: 'Critical',
                          value: widget.critical.toString(),
                          kcolor: Colors.blueGrey,
                        ),
                        ReuseableGrid(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString(),
                          kcolor: Colors.teal,
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
