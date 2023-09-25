import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/data/constands/constands.dart';
import 'package:get/get.dart';

class ReportDetails extends StatelessWidget {
  const ReportDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text('Report Details'),
        actions: [Icon(Icons.share)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ksizedbox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activity Log',
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold, color: kblue),
                ),
                InkWell(
                  onTap: () {
                    //  Get.to(ReportDetails());
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: kwhite),
                  ),
                )
              ],
            ),
            ksizedbox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Overal CPR time',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      'Actual Time',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                  ],
                )
              ],
            ),
            ksizedbox20,
            Row(
              children: [
                Text(
                  'Cycle 1',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, color: kblue),
                ),
              ],
            ),
            ksizedbox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ECG',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      'Medicine',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'PVT',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      'Epinephrine',
                      style: minfont,
                    ),
                  ],
                ),
              ],
            ),
            ksizedbox20,
            Row(
              children: [
                Text(
                  'Cycle 2',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, color: kblue),
                ),
              ],
            ),
            ksizedbox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ECG',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      'Medicine',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'PVT',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      'Epinephrine',
                      style: minfont,
                    ),
                  ],
                ),
              ],
            ),
            ksizedbox20,
            Row(
              children: [
                Text(
                  'Cycle 3',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, color: kblue),
                ),
              ],
            ),
            ksizedbox10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ECG',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      'Medicine',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      '00:00:00',
                      style: minfont,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'PVT',
                      style: minfont,
                    ),
                    ksizedbox10,
                    Text(
                      'Epinephrine',
                      style: minfont,
                    ),
                  ],
                ),
              ],
            ),
            ksizedbox20,
            Row(
              children: [
                Text(
                  'Efficiency',
                  style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18, color: kblue),
                ),
              ],
            ),
            ksizedbox10,
            Text(
              'Chest Compression Fraction(CCF):(Actual Time /Overall CPR Time)x100',
              style: minfont,
            )
          ],
        ),
      ),
    );
  }
}
