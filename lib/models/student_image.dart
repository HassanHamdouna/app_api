class StudentImage {
  late String? image;
  late int? studentId;
  late  dynamic id;
  late String? imageUrl;

  StudentImage({this.image, this.studentId, this.id, this.imageUrl});

  StudentImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    studentId = json['student_id'];
    id = json['id'];
    imageUrl = json['image_url'];
  }

}