class Modelh {
  late String date;
  late String day;
  late String icon;
  late String description;
  late String status;
  late String degree;
  late String min;
  late String max;
  late String night;
  late String humidity;

  Modelh(Map json) {
    date = json['date'] ?? "error";
    day = json['day'] ?? "error";
    icon = json['icon'] ?? "error";
    description = json['description'] ?? "error";
    status = json['status'] ?? "error";
    degree = json['degree'] ?? "error";
    min = json['min'] ?? "error";
    max = json['max'] ?? "error";
    night = json['night'] ?? "error";
    humidity = json['humidity'] ?? "error";
  }
}
