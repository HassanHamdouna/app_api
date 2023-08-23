class User {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String mobile;
  late String bio;
  late String jobTitle;
  late String latitude;
  late String longitude;
  late String country;
  late String image;
  late String active;
  late String emailVerifiedAt;
  late String imagesCount;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    mobile = json['mobile'];
    bio = json['bio'];
    jobTitle = json['jobTitle'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    image = json['image'];
    active = json['active'];
    emailVerifiedAt = json['emailVerifiedAt'];
    imagesCount = json['imagesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['bio'] = bio;
    data['jobTitle'] = jobTitle;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['country'] = country;
    data['image'] = image;
    data['active'] = active;
    data['emailVerifiedAt'] = emailVerifiedAt;
    data['imagesCount'] = imagesCount;
    return data;
  }
}
