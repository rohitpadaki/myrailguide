import 'package:flutter/material.dart';
import 'package:myrailguide/padding.dart';
import 'package:myrailguide/widgets/customappbar.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({super.key});

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  @override
  void initState() {
    super.initState();
    getValue();
    getv();
  }

  String phoneValue = "";
  String pvalue = "";
  static const String pho1 = "01";
  static const String pho2 = "02";
  void showAlert(String tex, QuickAlertType quickAlertType) {
    QuickAlert.show(context: context, type: quickAlertType, text: tex);
  }

  TextEditingController phn = TextEditingController();
  TextEditingController phn1 = TextEditingController();
  static String phone = "";
  static String phone1 = "";
  void getv() async {
    var sprefs = await SharedPreferences.getInstance();
    var getN = sprefs.getString(pho2);
    pvalue = getN ?? '';
    setState(() {
      phn1.text = pvalue;
      phone1 = pvalue;
    });
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString(pho1);
    phoneValue = getName ?? "";
    setState(() {
      phn.text = phoneValue;
      phone = phoneValue;
    });
  }

  Future openDialog() async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: const Text("Phone Number"),
                content: TextField(
                  autofocus: true,
                  controller: phn,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) async {
                    phone = value;
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setString(pho1, phone);
                  },
                  decoration:
                      const InputDecoration(hintText: 'Enter your Phone No.'),
                ),
                actions: [
                  TextButton(onPressed: submit, child: const Text("SUBMIT"))
                ]));
  }

  Future openDialog1() async => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text("Phone Number"),
              content: TextField(
                autofocus: true,
                controller: phn1,
                keyboardType: TextInputType.phone,
                onChanged: (value) async {
                  phone1 = value;
                  var sprefs = await SharedPreferences.getInstance();
                  sprefs.setString(pho2, phone1);
                },
                decoration:
                    const InputDecoration(hintText: 'Enter your Phone No.'),
              ),
              actions: [
                TextButton(onPressed: submit, child: const Text("SUBMIT"))
              ]));
  void submit() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Emergency Contacts", true),
      body: SafeArea(
        child: Padding(
          padding: Paddings.maincontent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 35)),
                Container(
                  height: 70,
                  width: 450,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 15,
                          color: Colors.white10,
                          blurStyle: BlurStyle.outer),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text('Railway Police Dept.',
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: "100",
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {}
                          },
                          child: Ink(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //2
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 70,
                  width: 450,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 15,
                          color: Colors.white10,
                          blurStyle: BlurStyle.outer),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text('Fire Department',
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: "101",
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {}
                          },
                          child: Ink(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //3
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 70,
                  width: 450,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 15,
                          color: Colors.white10,
                          blurStyle: BlurStyle.outer),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text('Railway Helpline Number',
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: "102",
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {}
                          },
                          child: Ink(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //4
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 70,
                  width: 450,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 15,
                          color: Colors.white10,
                          blurStyle: BlurStyle.outer),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text('Child Helpline Number',
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                        InkWell(
                          onTap: () async {
                            final Uri url = Uri(
                              scheme: 'tel',
                              path: "1098",
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            } else {}
                          },
                          child: Ink(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              border: Border.all(
                                width: 1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(
                              Icons.call,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                InkWell(
                  onTap: () async {
                    openDialog();
                  },
                  child: Ink(
                    height: 70,
                    width: 450,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 15,
                            color: Colors.white10,
                            blurStyle: BlurStyle.outer),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('Emergency Contact 1',
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                          InkWell(
                            onTap: () async {
                              var flag = 0;
                              if (phone == "") {
                                flag = 1;
                                showAlert("Please Enter Your Phone No.",
                                    QuickAlertType.error);
                              } else if (phone.length != 10) {
                                flag = 1;
                                showAlert("Please Enter 10 digits Phone No.",
                                    QuickAlertType.error);
                              }
                              if (flag == 0) {
                                final Uri url = Uri(
                                  scheme: 'tel',
                                  path: phone,
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {}
                              }
                            },
                            child: Ink(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.call,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                InkWell(
                  onTap: () {
                    openDialog1();
                  },
                  child: Ink(
                    height: 70,
                    width: 450,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 15,
                            color: Colors.white10,
                            blurStyle: BlurStyle.outer),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text('Emergency Contact 2',
                                  style:
                                      Theme.of(context).textTheme.titleMedium)),
                          InkWell(
                            onTap: () async {
                              var flag = 0;
                              if (phone1 == "") {
                                flag = 1;
                                showAlert("Please Enter Your Phone No.",
                                    QuickAlertType.error);
                              } else if (phone1.length != 10) {
                                flag = 1;
                                showAlert("Please Enter 10 digits Phone No.",
                                    QuickAlertType.error);
                              }
                              if (flag == 0) {
                                final Uri url = Uri(
                                  scheme: 'tel',
                                  path: phone1,
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {}
                              }
                            },
                            child: Ink(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(
                                Icons.call,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
