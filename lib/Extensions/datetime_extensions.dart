extension StringExtension on DateTime {
  Duration get passedDuration => DateTime.now().difference(this);

  int get passedMinutes => this.passedDuration.inMinutes;
  int get passedHours => this.passedMinutes ~/ 60;
  int get passedDays => this.passedHours ~/ 24;
  int get passedWeeks => this.passedDays ~/ 7;
  int get passedMonths => this.passedWeeks ~/ 4;

  String get passedTimeString {
    int passedTime = this.passedMonths > 0
        ? this.passedMonths
        : this.passedWeeks > 1
            ? this.passedWeeks
            : this.passedDays > 1
                ? this.passedDays
                : this.passedHours > 1
                    ? this.passedHours
                    : this.passedMinutes;
    String unit = this.passedMonths > 1
        ? "months"
        : this.passedWeeks > 1
            ? "weeks"
            : this.passedDays > 1
                ? "days"
                : this.passedHours > 1
                    ? "hours"
                    : "minutes";
    return "$passedTime $unit ago";
  }
}
