import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(home: MovieSeatBookingScreen(), debugShowCheckedModeBanner: false),
);

class MovieSeatBookingScreen extends StatefulWidget {
  const MovieSeatBookingScreen({super.key});

  @override
  State<MovieSeatBookingScreen> createState() => _MovieSeatBookingScreenState();
}

class _MovieSeatBookingScreenState extends State<MovieSeatBookingScreen> {
  int adultCount = 0;
  int youthCount = 0;
  Set<String> selectedSeats = {};

  final int rows = 8;
  final int cols = 10;
  final List<String> reservedSeats = ["C-5", "C-6", "D-5", "D-6"];

  int get totalRequired => adultCount + youthCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("인원 및 좌석 선택"), backgroundColor: Colors.black),
      body: Column(
        children: [
          // 1. 인원 선택 바
          _buildPeopleSelector(),

          const SizedBox(height: 20),
          const Text("SCREEN", style: TextStyle(color: Colors.white38, letterSpacing: 8)),

          // 스크린 라인
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            height: 3,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),

          // 2. 좌석 영역 (잘림 방지 핵심)
          Expanded(
            child: InteractiveViewer(
              constrained: false, // 자식 위젯이 화면보다 커도 허용
              boundaryMargin: const EdgeInsets.all(20),
              minScale: 0.1,
              maxScale: 2.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                // 화면 너비에 맞게 좌석 전체를 조절
                child: Column(
                  children: List.generate(rows, (r) {
                    String rowLabel = String.fromCharCode(65 + r);
                    return Row(
                      mainAxisSize: MainAxisSize.min, // 필요한 만큼만 차지
                      children: [
                        Container(
                          width: 25,
                          alignment: Alignment.center,
                          child: Text(
                            rowLabel,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ...List.generate(cols, (c) {
                          String seatId = "$rowLabel-${c + 1}";
                          bool isReserved = reservedSeats.contains(seatId);
                          bool isSelected = selectedSeats.contains(seatId);

                          return GestureDetector(
                            onTap: isReserved ? null : () => _onSeatTap(seatId),
                            child: Container(
                              margin: const EdgeInsets.all(3),
                              width: 32, // 좌석 크기
                              height: 32,
                              decoration: BoxDecoration(
                                color: isReserved
                                    ? Colors.white10
                                    : (isSelected ? Colors.cyanAccent : Colors.white24),
                                borderRadius: BorderRadius.circular(6),
                                border: isSelected
                                    ? Border.all(color: Colors.white, width: 2)
                                    : null,
                              ),
                              child: Center(
                                child: Text(
                                  "${c + 1}",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: isReserved
                                        ? Colors.white24
                                        : (isSelected ? Colors.black : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),

          // 3. 하단 요약 및 결제
          _buildBottomSummary(),
        ],
      ),
    );
  }

  void _onSeatTap(String seatId) {
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else if (selectedSeats.length < totalRequired) {
        selectedSeats.add(seatId);
      }
    });
  }

  Widget _buildPeopleSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _countControl("성인", adultCount, (v) => setState(() => adultCount = v)),
          _countControl("청소년", youthCount, (v) => setState(() => youthCount = v)),
        ],
      ),
    );
  }

  Widget _countControl(String label, int count, Function(int) onUpdate) {
    return Row(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        IconButton(
          onPressed: count > 0 ? () => onUpdate(count - 1) : null,
          icon: const Icon(Icons.remove_circle, color: Colors.white54),
        ),
        Text(
          "$count",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () => onUpdate(count + 1),
          icon: const Icon(Icons.add_circle, color: Colors.cyanAccent),
        ),
      ],
    );
  }

  Widget _buildBottomSummary() {
    int price = (adultCount * 14000) + (youthCount * 10000);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "선택 좌석: ${selectedSeats.isEmpty ? '-' : selectedSeats.join(', ')}",
                  style: const TextStyle(color: Colors.cyanAccent, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  "결제금액: $price원",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: (selectedSeats.length == totalRequired && totalRequired > 0)
                ? () {}
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text("예매하기", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
