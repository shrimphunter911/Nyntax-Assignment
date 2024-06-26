import 'package:assignment/views/ReservationDetailsView.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(223, 223, 255, 1)),
        ),
        home: const ReservationDetailsView(), //Leads to the first reservation details page
    ),
  );
}