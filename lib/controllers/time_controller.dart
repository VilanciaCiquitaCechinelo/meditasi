import 'dart:async';

class TimeController {
  int remainingHours = 0;
  int remainingMinutes = 0;
  bool isCountingDown = false;

  void startCountdown(int hours, int minutes, Function onCountdownFinished) {
    if (isCountingDown) return;

    isCountingDown = true;
    remainingHours = hours;
    remainingMinutes = minutes;

    const oneMinute = Duration(minutes: 1);
    Timer.periodic(oneMinute, (Timer timer) {
      if (remainingMinutes > 0) {
        remainingMinutes--;
      } else if (remainingHours > 0) {
        remainingHours--;
        remainingMinutes = 59;
      } else {
        isCountingDown = false;
        timer.cancel();
        onCountdownFinished(); // Panggil callback saat penghitungan selesai
      }
    });
  }
}
