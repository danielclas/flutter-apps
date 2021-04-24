import 'package:intl/intl.dart';

class DateParser {
  static const WeekDays = {
    1: 'Lunes',
    2: 'Martes',
    3: 'Miercoles',
    4: 'Jueves',
    5: 'Viernes',
    6: 'Sábado',
    7: 'Domingo'
  };

  static const Months = {
    1: 'Enero',
    2: 'Febrero',
    3: 'Marzo',
    4: 'Abril',
    5: 'Mayo',
    6: 'Junio',
    7: 'Julio',
    8: 'Agosto',
    9: 'Septiembre',
    10: 'Octubre',
    11: 'Noviembre',
    12: 'Diciembre'
  };

  static formatDate(DateTime date) {
    final now = DateTime.now();
    if (now.difference(date) < Duration(days: 7)) {
      if (now.difference(date) < Duration(days: 1) || now.day - date.day == 1) {
        return now.day == date.day ? 'Hoy' : 'Ayer';
      } else {
        return WeekDays[date.weekday];
      }
    }
    return '${DateFormat('dd').format(date)} de ${Months[date.month]} de ${date.year}';
  }
}
