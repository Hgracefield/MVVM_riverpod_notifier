// import 'package:flutter/material.dart';

// class SeatSelectionPage extends StatefulWidget {
//   const SeatSelectionPage({super.key});

//   @override
//   State<SeatSelectionPage> createState() => _SeatSelectionPageState();
// }

// class _SeatSelectionPageState extends State<SeatSelectionPage> {
//   List<String> selectedSeats = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('좌석 선택')),
//       body: Center(
//         child: Column(
//           children: [
//             Expanded(
//               child: BookMySeat(
//                 rows: 5,
//                 columns: 8,
//                 selectedColor: Colors.green,
//                 availableColor: Colors.grey[300]!,
//                 bookedColor: Colors.red,
//                 onSeatTap: (row, col) {
//                   final seat = "${String.fromCharCode(65 + row)}${col + 1}";
//                   setState(() {
//                     if (selectedSeats.contains(seat)) {
//                       selectedSeats.remove(seat);
//                     } else {
//                       selectedSeats.add(seat);
//                     }
//                   });
//                 },
//                 selectedSeatBuilder: (row, col) => Text(
//                   "${String.fromCharCode(65 + row)}${col + 1}",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 "선택된 좌석: ${selectedSeats.join(', ')}",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
