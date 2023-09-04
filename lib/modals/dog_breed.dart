class DogBreedList {
  String? message;
  String? status;

  DogBreedList({
    required this.message,
    required this.status,
  });

  factory DogBreedList.fromJson(Map<String, dynamic> json) {
    return DogBreedList(
      message: json['message'] as String,
      status: json['status'] as String,
    );
  }
}
