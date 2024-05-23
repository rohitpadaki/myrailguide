import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';

class BookingForm extends StatefulWidget {
  final Map<String, dynamic> train;
  final String departure;
  final String arrival;
  const BookingForm(
      {super.key,
      required this.train,
      required this.departure,
      required this.arrival});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  TextEditingController passenger1 = TextEditingController();
  TextEditingController passenger2 = TextEditingController();
  TextEditingController passenger3 = TextEditingController();
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Booking Form", true),
      body: SafeArea(
        child: Padding(
          padding: Paddings.maincontent.copyWith(top: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Text(
                  "${widget.train['train']['trainname']} - ${widget.train['train']['trainno']}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 28),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 16),
                          child: Text(
                            widget.train['train']['schedule']
                                [widget.train['fromIndex']]['departureTime'],
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Text(
                            widget.departure,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.east_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 16),
                          child: Text(
                            widget.train['train']['schedule']
                                [widget.train['toIndex']]['arrivalTime'],
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: Text(
                            widget.arrival,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  style: const TextStyle(fontSize: 20, fontFamily: "Urbanist"),
                  controller: passenger1,
                  cursorColor: Theme.of(context).dividerColor,
                  decoration: InputDecoration(
                    hintText: "Passenger 1",
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Expanded widget to ensure equal space distribution
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "Urbanist"),
                        controller: passenger1,
                        cursorColor: Theme.of(context).dividerColor,
                        decoration: InputDecoration(
                          hintText: "Age",
                          counterText: "",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            100.0), // Add spacing between TextField and Radio buttons
                    // Expanded widget to ensure equal space distribution
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: <String>['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  style: const TextStyle(fontSize: 20, fontFamily: "Urbanist"),
                  controller: passenger2,
                  cursorColor: Theme.of(context).dividerColor,
                  decoration: InputDecoration(
                    hintText: "Passenger 2",
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Expanded widget to ensure equal space distribution
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "Urbanist"),
                        controller: passenger1,
                        cursorColor: Theme.of(context).dividerColor,
                        decoration: InputDecoration(
                          hintText: "Age",
                          counterText: "",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            100.0), // Add spacing between TextField and Radio buttons
                    // Expanded widget to ensure equal space distribution
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: <String>['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                TextField(
                  style: const TextStyle(fontSize: 20, fontFamily: "Urbanist"),
                  controller: passenger1,
                  cursorColor: Theme.of(context).dividerColor,
                  decoration: InputDecoration(
                    hintText: "Passenger 1",
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  children: [
                    // Expanded widget to ensure equal space distribution
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        style: const TextStyle(
                            fontSize: 20, fontFamily: "Urbanist"),
                        controller: passenger1,
                        cursorColor: Theme.of(context).dividerColor,
                        decoration: InputDecoration(
                          hintText: "Age",
                          counterText: "",
                          hintStyle: const TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        width:
                            100.0), // Add spacing between TextField and Radio buttons
                    // Expanded widget to ensure equal space distribution
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedGender,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: <String>['Male', 'Female'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGender = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
