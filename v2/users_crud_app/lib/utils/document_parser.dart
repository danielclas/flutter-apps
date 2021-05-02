import 'package:users_crud_app/model/user_model.dart';

class DocumentParser {
  static User userFromBarCode(String barcode) {
    final data = barcode.split('@');
    return User(
        name: data[barcodeData.name.index],
        surname: data[barcodeData.surname.index],
        document: data[barcodeData.number.index],
        email: '');
  }
}

//Scanned DNI card example:
//  00123445277@CLAS@DANIEL JULIO@M@39328065@B@06/02/1996@17/07/2012
enum barcodeData { _, surname, name, gender, number, __, date_of_birth }
