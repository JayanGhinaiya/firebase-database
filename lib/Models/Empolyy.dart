class Employy {

  String? name;
  String? age;
  String? salary;
  String? city;
  String? docid;
  Employy({this.name,this.age,this.city,this.salary,this.docid});

  Employy.fromJson(Map<String,dynamic> json){
    name = json['name'];
    age = json['age'];
    salary = json['salary'];
    city = json['city'];
    docid =json['docid'];
  }

  Map<String,dynamic> toJson() => {'name' : name , 'age' : age,'salary' : salary,'city' : city,'docid' : docid};
}