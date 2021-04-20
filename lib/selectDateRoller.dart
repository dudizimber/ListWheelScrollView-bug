import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeRoller extends StatefulWidget {
  final int minimumWaitingPeriod;
  DateTimeRoller({this.minimumWaitingPeriod = 0});
  @override
  _DateTimeRollerState createState() => _DateTimeRollerState();
}

class _DateTimeRollerState extends State<DateTimeRoller> {
  FixedExtentScrollController dateController =
      FixedExtentScrollController(initialItem: 0);
  FixedExtentScrollController hourController =
      FixedExtentScrollController(initialItem: 0);

  Map<String, List<String>> dates = {};
  int dateIndex = 0;
  String selectingDate;

  @override
  void initState() {
    _fillDateMap();
    super.initState();
  }

  _fillDateMap() {
    dates['A'] = ['0', '1', '2'];
    dates['B'] = ['0'];
    dates['C'] = ['0', '1', '2', '3'];
    dates['D'] = ['0', '1'];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      constraints: BoxConstraints.tightFor(height: 300),
      child: Column(
        children: [
          Expanded(
            child: _buildPickerNew(),
          ),
          Container(
            child: Text(selectingDate != null ? selectingDate : '',
                style: TextStyle(
                  fontSize: 16,
                )),
          )
        ],
      ),
    );
  }

  _buildPickerNew() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .45,
            height: 300,
            child: ListWheelScrollView(
              controller: dateController,
              physics: FixedExtentScrollPhysics(),
              itemExtent: 50,
              magnification: 1.2,
              useMagnifier: true,
              children: dates.keys.map((v) => buildDateItem(v)).toList(),
              onSelectedItemChanged: (int index) {
                setState(() {
                  dateIndex = index;
                  String date = dates.keys.toList()[index];
                  int hourIndex = hourController.selectedItem;
                  String hour;
                  if (dates.values.toList()[dateIndex] != null &&
                      dates.values.toList()[dateIndex].length > hourIndex) {
                    hour = dates.values.toList()[dateIndex][hourIndex];
                  } else {
                    hour = dates.values.toList()[dateIndex][0];
                    hourController.jumpToItem(0);
                  }
                  selectingDate = date + ":" + hour;
                });
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .45,
            height: 300,
            child: ListWheelScrollView(
              controller: hourController,
              physics: FixedExtentScrollPhysics(),
              itemExtent: 50,
              magnification: 1.2,
              useMagnifier: true,
              children: dates[dates.keys.toList()[dateIndex]]
                  .map((v) => buildHourItem(v))
                  .toList(),
              onSelectedItemChanged: (int index) {
                setState(() {
                  int dateIndex = dateController.selectedItem;
                  int hourIndex = hourController.selectedItem;
                  String date = dates.keys.toList()[dateIndex];
                  String hour = dates.values.toList()[dateIndex][hourIndex];

                  selectingDate = date + ":" + hour;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHourItem(String t) {
    return Text(t);
  }

  Widget buildDateItem(String t) {
    return Text(t);
  }
}
