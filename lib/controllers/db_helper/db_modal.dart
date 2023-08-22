class student {
  int id;
  int name;

  student(this.id, this.name);

  factory student.fromMap({required Map data}) {
    return student(
      data['Id'],
      data['Name'],
    );
  }
}
