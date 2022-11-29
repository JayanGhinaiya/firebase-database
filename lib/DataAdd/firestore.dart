import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Models/Student.dart';
import 'package:flutter/material.dart';

class firestorescreen extends StatefulWidget {
  const firestorescreen({Key? key}) : super(key: key);

  @override
  State<firestorescreen> createState() => _firestorescreenState();
}

class _firestorescreenState extends State<firestorescreen> {
  bool isupdate = false;

  /// value add karva mate firebasema
  addFirestore( String name,String age ) {
    final docstudent = FirebaseFirestore.instance.collection("student").doc();
    docstudent.set({"name": name ,"age" :age,"docid" : docstudent.id});
  }

  edit({required String name, required String age, required String docid}){
    print("docedit docid--> ${docid}");
    final docedit = FirebaseFirestore.instance.collection("student").doc(docid);
    print("docedit --> ${docedit.id}");
    docedit.update({"name" : name,"age" : age,"docid" : docid});
  }

  delete(String docid){
    FirebaseFirestore.instance.collection("student").doc(docid).delete();
  }

   Stream<List<Student>> getFirestore() {
    print('getFirestore');
    return FirebaseFirestore.instance.collection("student").snapshots().map((snapshot) {
      List<Student> lstStudent = snapshot.docs.map((e) {
        Student student = Student.fromJson(e.data());
        print('e ->>>>  $e');
        return student;
      }).toList();
      return lstStudent;
    });
  }

  String  doc = "";
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Container(
                // color: Colors.yellow,
                child: Row(
                  children: [
                    Container(
                      width: 250,
                      // color: Colors.green,
                      child: Column(
                        children: [
                          TextField(
                            controller:name ,
                            decoration: InputDecoration(
                              labelText: "Student name"
                            ),
                          ),
                          TextField(
                            controller: age,
                            decoration: InputDecoration(
                                labelText: "Age"
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 80,
                      width: 120,
                      child: ElevatedButton(
                          onPressed: (){
                            print("isupdate --> ${isupdate}");
                            if(isupdate == true){
                              print("docid --> ${doc}");
                              edit(age: age.text,docid: doc,name: name.text);
                            }else{
                              addFirestore(name.text, age.text);
                            }
                            setState(() {
                              isupdate = false;
                            });
                            name.clear();
                            age.clear();
                          },child: isupdate == false ? Text("Add") : Text("Update")),
                    )
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
                child: StreamBuilder<List<Student>>(
                  // stream: FirebaseFirestore.instance.collection("student").snapshots(),
                  stream: getFirestore(),
                  builder: (BuildContext context,AsyncSnapshot<List<Student>> snapshot){
                    if(snapshot.hasData){
                      List<Student> lstStudent = snapshot.data!;
                      return  ListView.builder(
                          shrinkWrap: false,
                          itemCount: lstStudent.length,
                          itemBuilder:(context, int index){
                            Student student = lstStudent[index];
                            return Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  // color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1,color: Colors.black)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    Text("Student name"),
                                    Text("Age"),
                                    Text("Docid"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(":"),
                                      Text(":"),
                                      Text(":"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(student.name!),
                                      Text(student.age!),
                                      Text(student.docid!),
                                    ],
                                  ),

                                  IconButton(
                                      onPressed: (){
                                        setState(() {
                                          isupdate = true;
                                          name.text = student.name!;
                                          age.text = student.age!;
                                          doc = student.docid!;
                                        });
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: (){
                                        // print("docid -----> ${student.docid}");
                                        delete(student.docid!);
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
                            );
                          });

                    }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
