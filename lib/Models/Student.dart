class Student {

  String? name;
  String? age;
  String? docid;

  Student({this.name,this.age,this.docid});

  ///net pr thi data store thay
  Student.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    docid =json['docid'];
  }

  ///data ne net pr moklay
  Map<String, dynamic> toJson() => {'name' : name, 'age' : age,'docid' : docid};

}