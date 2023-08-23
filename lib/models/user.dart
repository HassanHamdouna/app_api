class User {
  late int id;
  late String firstName;
  late String lastName;
  late String email;
  late String mobile;
  late String bio;
  late String jobTitle;
  late double latitude;
  late double longitude;
  late String country;
  late String image;
  late int active;
  late String emailVerifiedAt;
  late int imagesCount;

  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    bio = json['bio'];
    jobTitle = json['job_title'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    country = json['country'];
    image = json['image'];
    active = json['active'];
    emailVerifiedAt = json['email_verified_at'];
    imagesCount = json['images_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['bio'] = bio;
    data['job_title'] = jobTitle;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['country'] = country;
    data['image'] = image;
    data['active'] = active;
    data['email_verified_at'] = emailVerifiedAt;
    data['images_count'] = imagesCount;
    return data;
  }
}
