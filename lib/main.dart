import 'package:flutter/material.dart';
import 'package:offlinedb/Provider.dart';
import 'package:offlinedb/db_helper.dart';
import 'package:offlinedb/detailspage.dart';
import 'package:offlinedb/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) =>
        DataFeederProvider(databaseProvider: Db_helper.getInstance()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/homepage",
      routes: {
        "/homepage": (context) => Homepage(),
        "/detailspage": (context) => Detailspage(),
      },
    ),
  ));
}
