import 'package:flutter/material.dart';

class HorizontalCalendar extends StatefulWidget {
  @override
  _HorizontalCalendarState createState() => _HorizontalCalendarState();
}

class _HorizontalCalendarState extends State<HorizontalCalendar> {
  int selectedDay = DateTime.now().day;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, // Altura ajustada para que parezca un tab
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Scroll horizontal
        itemCount: DateTime.now().month == 2 ? 28 : 31, // Asume que son los días del mes actual
        itemBuilder: (context, index) {
          int day = index + 1;
          bool isSelected = selectedDay == day;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDay = day;
              });
            },
            child: Container(
              width: 50, // Ancho ajustado para cada día
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '$day',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
