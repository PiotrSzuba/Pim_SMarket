class User {
  final String email;
  final String name;
  final String password;
  final UserType userType;
  final String tags;
  final String description;
  final String image;
  final bool isAccountPublic;

  User(this.email, this.name, this.password, this.userType, this.tags,
      this.description, this.image, this.isAccountPublic);

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        name = json['name'],
        password = json['password'],
        userType = json['userType'],
        tags = json['tags'],
        description = json['description'],
        image = json['image'],
        isAccountPublic = json['isAccountPublic'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'password': password,
        'userType': userType,
        'tags': tags,
        'description': description,
        'image': image,
        'isAccountPublic': isAccountPublic,
      };
}

enum UserType {
  company,
  student,
}
