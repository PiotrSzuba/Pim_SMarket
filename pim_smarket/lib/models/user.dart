class User {

  final String email;
  final String name;
  final String password;
  final int userType; //changed to int
  final String tags;
  final String description;
  final String image;
  final bool isAccountPublic;

  int userTypeToInt(){
    if(userType == UserType.company){
      return 0;
    }
    else if(userType == UserType.student){
      return 1;
    }
    else{
      return 2;
    }
  }

  UserType userTypeInt2userTypeUT(int i){
    if(i == 0){
      return UserType.company;
    }
    else if(i == 1){
      return UserType.student;
    }
    else{
      return UserType.anonymous;
    }
  }

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
        'userType': userTypeToInt(),
        'tags': tags,
        'description': description,
        'image': image,
        'isAccountPublic': isAccountPublic,
      };

  User.empty()
      : email = '',
        name = '',
        password = '',
        userType = 2,
        tags = '',
        description = '',
        image = '',
        isAccountPublic = false;

  User.mockStudent()
      : email = 'student',
        name = 'Student debil',
        password = '1234',
        userType = 1,
        tags = 'C, Dart, Lisp',
        description = 'Generic idiot student',
        image = '',
        isAccountPublic = true;

  User.mockCompany()
      : email = 'company',
        name = 'Greedy Company',
        password = '1234',
        userType = 0,
        tags = 'Fruity fridays, sport card, dynamic teams',
        description =
            'We are looking for a student that will sell his soul to us',
        image = '',
        isAccountPublic = true;
}

enum UserType {
  company,
  student,
  anonymous,
}
