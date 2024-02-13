abstract class HesaplarEvent {}

class EventGetHaftalikHesaplar extends HesaplarEvent {
  DateTime selectedDate;
  String selectedAtolye;
  EventGetHaftalikHesaplar({required this.selectedDate, required this.selectedAtolye});
}
