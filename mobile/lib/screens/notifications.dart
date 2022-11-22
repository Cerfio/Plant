import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF9FAF7),
        elevation: 0,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xff293B1C),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 50),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: 10,
            padding: const EdgeInsets.only(top: 20),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xffEDF7FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18.0)),
                            ),
                            child: const Icon(
                              Icons.notifications,
                              size: 40,
                              color: Color(0xff2263A8),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Plant Alert",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff1A1D1E),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "Missing Water",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff6A6A6A),
                                  ),
                                ),
                                SizedBox(
                                  height: 28,
                                ),
                                Text(
                                  "Please watering plant Aznard",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff6A6A6A),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
