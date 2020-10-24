class Person {
  String apellidos;
  String clave;
  String correo;
  String nombre;
  int dni;

  Person(this.correo, this.clave, this.apellidos, this.nombre, this.dni);

  Person.fromJson(Map<String, dynamic> json)
      : correo = json['correo'],
        clave = json['clave'],
        apellidos = json['apellidos'],
        nombre = json['nombre'],
        dni = json['dni'];

  Map<String, dynamic> toJson() => {
        'correo': correo,
        'clave': clave,
        'nombre': nombre,
        'apellidos': apellidos,
        'dni': dni
      };
}
