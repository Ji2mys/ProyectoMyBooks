enum Gender { male, female }

class User {
  String uid = "";
  String _name = "";
  String _email = "";
  String _password = "";
  Gender _gender = Gender.male;
  Map<String, bool> _favoriteGenres = {};
  DateTime _bornDate = DateTime.now();

  User(this.uid, this._name, this._email, this._password, this._gender, this._favoriteGenres, this._bornDate);

  User.fromJson(Map<String, dynamic> json) {
    _name = json["name"];
    _email = json["email"];
    _password = json["password"];
    _gender = json["gender"];
    _favoriteGenres = json["favorite_genres"];
    _bornDate = DateTime.parse(json["born_date"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      //"password": password,
      "gender": gender.name,
      "favorite_genres": favoriteGenres,
      "born_date": bornDate
    };
  }

  String get name => _name;

  DateTime get bornDate => _bornDate;

  Map<String, bool> get favoriteGenres => _favoriteGenres;

  Gender get gender => _gender;

  String get password => _password;

  String get email => _email;
}