import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offlinedb/detailspage.dart';
import 'package:offlinedb/homepage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/homepage",
    routes: {
      "/homepage": (context) => Homepage(),
      "/detailspage": (context) => Detailspage(),
    },
  ));
}
