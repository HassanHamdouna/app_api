class StudentImage {
  String? image;
  int? studentId;
  int? id;
  String? imageUrl;

  StudentImage({this.image, this.studentId, this.id, this.imageUrl});

  StudentImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    studentId = json['student_id'];
    id = json['id'];
    imageUrl = json['image_url'];
  }

}