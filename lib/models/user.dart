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
    id = json['id'] ?? int;
    firstName = json['first_name'] ?? String;
    lastName = json['last_name'] ?? String;
    email = json['email'] ?? String;
    mobile = json['mobile'] ?? String;
    bio = json['bio'] ?? String;
    jobTitle = json['job_title'] ?? String;
    latitude = json['latitude'] ?? double;
    longitude = json['longitude'] ?? double;
    country = json['country'] ?? String;
    image = json['image'] ?? String;
    active = json['active'] ?? int;
    emailVerifiedAt = json['email_verified_at'] ?? String;
    imagesCount = json['images_count'] ?? 0;
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
