import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Models/Empolyy.dart';
import 'package:firebase/Models/Student.dart';
import 'package:flutter/material.dart';

class Employydata extends StatefulWidget {
  const Employydata({Key? key}) : super(key: key);

  @override
  State<Employydata> createState() => _EmployydataState();
}

class _EmployydataState extends State<Employydata> {
  bool isupdate = false;

  /// delete karva mate
  deletdata(String docid){
    FirebaseFirestore.instance.collection("Employy").doc(docid).delete();
  }

  ///upadate karva mate
  edit(String docid,String name,String age,String salary,String city){
    final docedit = FirebaseFirestore.instance.collection("Employy").doc(docid);
    docedit.update({"name" : name,"age" : age,"salary" : salary,"city" : city,});
  }

  /// add karva mate
  addFireStore(String name, String age, String salary, String city) {
    final docemployy = FirebaseFirestore.instance.collection("Employy").doc();
    docemployy.set({"name": name, "age": age, "salary": salary, "city": city, "docid" : docemployy.id});
  }

  Stream<List<Employy>> getFirestore() {
    print('getFirestore');
    return FirebaseFirestore.instance
        .collection("Employy")
        .snapshots()
        .map((snapshot) {
      List<Employy> lstEmployy = snapshot.docs.map((e) {
        Employy employy = Employy.fromJson(e.data());
        return employy;
      }).toList();
      return lstEmployy;
    });
  }

  String doc = "";
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            children: [
              Container(
                // color: Colors.yellow,
                child: Row(
                  children: [
                    Container(
                      // color: Colors.green,
                      width: 240,
                      child: Column(
                        children: [
                          TextField(
                            controller: name,
                            decoration:
                                InputDecoration(labelText: "Employ Name"),
                          ),
                          TextField(
                            controller: age,
                            decoration: InputDecoration(labelText: "Age"),
                          ),
                          TextField(
                            controller: salary,
                            decoration: InputDecoration(labelText: "Salary"),
                          ),
                          TextField(
                            controller: city,
                            decoration: InputDecoration(labelText: "City"),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 120,
                      height: 90,
                      child: ElevatedButton(
                              onPressed: () {
                                if (isupdate == true){
                                  edit(doc,name.text, age.text, salary.text, city.text);
                                }else{
                                  addFireStore(name.text, age.text, salary.text, city.text);
                                }
                                setState(() {
                                  isupdate = false;
                                });
                          }, child: isupdate == false ? Text("Add") : Text("Update")),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 2,
                thickness: 0.3,
                color: Colors.black,
              ),
              Expanded(
                  child: StreamBuilder<List<Employy>>(
                   stream: getFirestore(),
                   builder: (BuildContext context,
                    AsyncSnapshot<List<Employy>> snapshot) {
                  if (snapshot.hasData) {
                    List<Employy> lstEmploy = snapshot.data!.cast<Employy>();
                    print("lstEmploy-> ${snapshot.data}");
                    if(lstEmploy.isNotEmpty){
                      return ListView.builder(
                        itemCount: lstEmploy.length,
                          itemBuilder: (context, int index) {
                        Employy employy = lstEmploy[index];
                        print("doc -> ${employy.name}");
                        return Container(
                          // color: Colors.yellow,
                          child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 450,
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(width:1,color: Colors.black,),
                                    // color: Colors.green,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Name :"),
                                          Text("Age :"),
                                          Text("Salary :"),
                                          Text("City :"),
                                          Text("Docid :"),

                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(employy.name!),
                                          Text(employy.age!),
                                          Text(employy.salary!),
                                          Text(employy.city!),
                                          Text(employy.docid!),
                                        ],
                                      ),
                                     Spacer(),
                                     IconButton(
                                       splashColor: Colors.transparent,
                                       hoverColor: Colors.transparent,
                                         highlightColor: Colors.transparent,
                                         onPressed: (){
                                         setState(() {
                                           isupdate = true;
                                           name.text=employy.name!;
                                           age.text=employy.age!;
                                           salary.text=employy.salary!;
                                           city.text=employy.city!;
                                           doc = employy.docid!;
                                         });
                                         },
                                         icon: Icon(Icons.edit)),
                                      IconButton(
                                          splashColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: (){
                                           deletdata(employy.docid!);
                                          },
                                          icon:Icon(Icons.delete))
                                    ],
                                  )),
                            ],
                          ),
                        );
                      });
                    }else {
                       return SizedBox();
                    }

                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
