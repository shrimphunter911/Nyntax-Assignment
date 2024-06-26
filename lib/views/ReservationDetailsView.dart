import 'package:assignment/services/invoice_services.dart';
import 'package:assignment/views/CustomerInformationView.dart';
import 'package:flutter/material.dart';

class ReservationDetailsView extends StatefulWidget {
  const ReservationDetailsView({super.key});

  @override
  State<ReservationDetailsView> createState() => _ReservationDetailsViewState();
}

class _ReservationDetailsViewState extends State<ReservationDetailsView> {
  // duration properties
  int? durationHours;
  int? durationDays;
  int? durationWeeks;
  // DateTime for pickup and dropoff date and time
  // TimeOfDay for pickup and dropoff time picker
  DateTime? pickupDateTime;
  DateTime? pickupDate;
  TimeOfDay? pickupTime;
  DateTime? dropOffDateTime;
  DateTime? dropOffDate;
  TimeOfDay? dropOffTime;
  // Text Editing Controllers to control TextFields
  TextEditingController pickup = TextEditingController();
  TextEditingController dropOff = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController discount = TextEditingController();

  // Method to calculate duration with difference between pickup and dropoff time
  int durationDifference(DateTime from, DateTime to) {
    Duration duration = to.difference(from);
    int hours = duration.inHours;
    return hours;
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text("Reservation Details", style: TextStyle(fontFamily: 'Roboto-Bold')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 2, color: const Color.fromRGBO(223, 223, 255, 1)),
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text('Reservation ID*', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    controller: id,
                    decoration: InputDecoration(
                      hintText: '',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(223, 223, 255, 1)
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.5,
                          color: Color.fromRGBO(223, 223, 255, 1),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text('Pickup Date*', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    controller: pickup,
                    onTap: () async {
                      // popping up Date Picker for user to select a date
                      pickupDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      // popping up Time Picker for user to select a Time
                      pickupTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      // Combining pickup date and time into one single DateTime property
                      pickupDateTime = DateTime(
                          pickupDate!.year,
                          pickupDate!.month,
                          pickupDate!.day,
                          pickupTime!.hour,
                          pickupTime!.minute
                      );
                      setState(() {
                        // Calculating hours, days and week from duration
                        pickup.text = '$pickupDateTime';
                        durationHours = durationDifference(pickupDateTime!, dropOffDateTime!);
                        durationWeeks = (durationHours!~/168);
                        durationHours = (durationHours!%168);
                        durationDays = (durationHours!~/24);
                        durationHours = (durationHours!%24);
                        duration.text = '$durationWeeks Week $durationDays Days $durationHours Hours';
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      hintText: 'Select Date and Time',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(223, 223, 255, 1)
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.5,
                          color: Color.fromRGBO(223, 223, 255, 1),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text('Return Date*', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    controller: dropOff,
                    onTap: () async {
                      // popping up Date Picker for user to select a date
                      dropOffDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      // popping up Time Picker for user to select a time
                      dropOffTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      // Combining dropoff date and time into one single DateTime property
                      dropOffDateTime = DateTime(
                          dropOffDate!.year,
                          dropOffDate!.month,
                          dropOffDate!.day,
                          dropOffTime!.hour,
                          dropOffTime!.minute
                      );
                      setState(() {
                        // Calculating hours, days and week from duration
                        dropOff.text = '$dropOffDateTime';
                        durationHours = durationDifference(pickupDateTime!, dropOffDateTime!);
                        durationWeeks = (durationHours!~/168);
                        durationHours = (durationHours!%168);
                        durationDays = (durationHours!~/24);
                        durationHours = (durationHours!%24);
                        duration.text = '$durationWeeks Week $durationDays Days $durationHours Hours';
                      });
                    },
                    decoration: InputDecoration(
                      suffixIcon: const Icon(Icons.calendar_today_outlined),
                      hintText: 'Select Date and Time',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(223, 223, 255, 1)
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.5,
                          color: Color.fromRGBO(223, 223, 255, 1),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Duration', style: TextStyle(fontSize: 18)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextField(
                            controller: duration,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: '1 Week 2 Days',
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(223, 223, 255, 1)
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2.5,
                                  color: Color.fromRGBO(223, 223, 255, 1),
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                  child: Text('Discount', style: TextStyle(fontSize: 18)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: TextField(
                    controller: discount,
                    decoration: InputDecoration(
                      hintText: '',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(223, 223, 255, 1)
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2.5,
                          color: Color.fromRGBO(223, 223, 255, 1),
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
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
                  onPressed: () {
                    try {
                      // Constructing reservation details
                      final details = Reservation(
                        id: id.text,
                        pickupDateTime: pickupDateTime!,
                        dropOffTime: dropOffDateTime!,
                        weeks: durationWeeks,
                        days: durationDays,
                        hours: durationHours!,
                        discount: discount.text,
                      );
                      // Navigating to the next page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerInformationView(details: details)
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