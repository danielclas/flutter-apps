class User {
  String correo;
  String clave;
  String perfil;
  String sexo;

  User(this.correo, this.clave, this.perfil, this.sexo);

  User.fromJson(Map<String, dynamic> json)
      : correo = json['correo'],
        clave = json['clave'],
        perfil = json['perfil'],
        sexo = json['sexo'];
}
