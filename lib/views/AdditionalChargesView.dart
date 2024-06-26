import 'package:assignment/views/SummaryView.dart';
import 'package:flutter/material.dart';

import '../services/invoice_services.dart';

// Page to check additional options

class AdditionalCharges extends StatefulWidget {
  final Reservation details;
  final Customer information;
  final Car selected;
  const AdditionalCharges({super.key, required this.details, required this.information, required this.selected});

  @override
  State<AdditionalCharges> createState() => _AdditionalChargesState();
}

class _AdditionalChargesState extends State<AdditionalCharges> {
  var damage = false;
  var insurance = false;
  var tax = false;

  @override
  Widget build(BuildContext context) {
    final details = widget.details;
    final information = widget.information;
    final selected = widget.selected;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              height: 2.0,
              color: const Color.fromRGBO(93, 92, 255, 1),
            )
        ),
        title: const Text("Additional Charges", style: TextStyle(fontFamily: 'Roboto-Bold')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: const Color.fromRGBO(223, 223, 255, 1)),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              children: [
                CheckboxListTile(
                  title: const Text('Collision Damage Waiver'),
                  secondary: const Text('\$9.00', style: TextStyle(fontSize: 16)),
                  activeColor: const Color.fromRGBO(93, 92, 255, 1),
                  checkColor: const Color.fromRGBO(93, 92, 255, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: damage,
                  onChanged: (bool? value) {
                    setState(() {
                      damage = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Liability Insurance'),
                  secondary: const Text('\$15.00', style: TextStyle(fontSize: 16)),
                  activeColor: const Color.fromRGBO(93, 92, 255, 1),
                  checkColor: const Color.fromRGBO(93, 92, 255, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: insurance,
                  onChanged: (bool? value) {
                    setState(() {
                      insurance = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text('Rental tax'),
                  secondary: const Text('11.5%', style: TextStyle(fontSize: 16)),
                  activeColor: const Color.fromRGBO(93, 92, 255, 1),
                  checkColor: const Color.fromRGBO(93, 92, 255, 1),
                  controlAffinity: ListTileControlAffinity.leading,
                  value: tax,
                  onChanged: (bool? value) {
                    setState(() {
                      tax = value!;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
            child: Container(
              height: 55,
              width: 170,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(92, 93, 255, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                  onPressed: () async {
                    try {
                      final additional = Charges(damage, insurance, tax);
                      print(details);
                      print(information);
                      print(selected);
                      print(additional);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SummaryView(details: details, information: information, selected: selected, additional: additional,)
                        ),
                      );
                    } catch (e) {
                      throw Exception('Could not make reservation');
                    }
                  },
                  child: const Text('Next', style: TextStyle(color: Colors.white),)
              ),
            )
        )
      ],
    );
  }
}
