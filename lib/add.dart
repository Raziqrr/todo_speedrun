import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  DateTime date = DateTime.now();
  List<String> category = ["Work", "Rest", "Exercise", "Skincare", "Home"];
  String categoryValue = "Work";
  Uint8List? image;
  String? name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: Text("Add New Task", style: GoogleFonts.lobster(
            color: Colors.lightGreenAccent
          ),),
        ),
        backgroundColor:Colors.grey[900],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  style: GoogleFonts.roboto(
                    color: CupertinoColors.white
                  ),
                  controller: taskNameController,
                  cursorColor: CupertinoColors.white,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: CupertinoColors.white
                      )
                    ),
                    labelText: "Enter Task Name",
                    labelStyle: GoogleFonts.roboto(
                      color: CupertinoColors.white
                    ),
                    focusColor: CupertinoColors.white,
                    fillColor: CupertinoColors.white
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  cursorColor: CupertinoColors.white,
                  style: GoogleFonts.roboto(
                      color: CupertinoColors.white
                  ),
                  controller: taskDescriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: CupertinoColors.white
                          )
                      ),
                      labelStyle: GoogleFonts.roboto(
                        color: CupertinoColors.white
                      ),
                      labelText: "Enter Task Description",
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Select Task Category",
                      style: GoogleFonts.roboto(
                        color: CupertinoColors.white
                      ),),
                  ],
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    style: GoogleFonts.roboto(
                      color: CupertinoColors.white
                    ),
                    dropdownColor: Colors.blueGrey[900],
                    borderRadius: BorderRadius.circular(10),
                    value: categoryValue,
                    items: category.map<DropdownMenuItem>((value){
                  return DropdownMenuItem(
                    child: Text("${value}"), value: value,);
                }).toList(), onChanged: (value){
                  setState(() {
                    categoryValue = value;
                  });
                }),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Select Task Date",
                    style: GoogleFonts.roboto(
                      color: CupertinoColors.white
                    ),),
                  ],
                ),
                FormBuilderDateTimePicker(
                    style: GoogleFonts.roboto(
                      color: CupertinoColors.white
                    ),
                    inputType: InputType.date,
                    fieldLabelText: "Select Task Date",
                    initialDate: date,
                    lastDate: DateTime(2030),
                    firstDate: DateTime(2000),
                    controller: taskDateController,
                    initialValue: date,
                    name: "Task Date"),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Text("Upload an image",
                      style: GoogleFonts.roboto(
                        color: CupertinoColors.white
                      ),),
                  ],
                ),
                SizedBox(height: 10,),
                image!=null?Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0
                      ),
                    ),
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.memory(image!, fit: BoxFit.fitHeight,)),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Text("${name}", style: GoogleFonts.roboto(
                          
                            color: CupertinoColors.white
                          ),
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          softWrap: false,),
                        )
                      ],
                    )):SizedBox(),
                SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.white
                  ),
                    onPressed: (){
                      showDialog(context: context, builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.blueGrey[900],
                          alignment: Alignment.center,
                          title: Text("Upload image", style:  GoogleFonts.roboto(
                            color: CupertinoColors.white
                          ),),
                          actions: [
                            Container(
                              child: ElevatedButton(
                                  onPressed: ()async{
                                    final imagePicker = ImagePicker();
                                    final photo = await imagePicker.pickImage(source: ImageSource.gallery);
                                    if(photo!=null){
                                      final converted = await File(photo.path).readAsBytes();
                                      setState(() {
                                        name = photo.name;
                                        image = converted;
                                      });
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text("Pick from gallery",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black54
                                  ),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CupertinoColors.white,
                                ),
                              ),
                              width: double.infinity,
                            ),
                            SizedBox(height: 10,),
                            Container(
                              child: ElevatedButton(
                                  onPressed: ()async{
                                    final imagePicker = ImagePicker();
                                    final photo = await imagePicker.pickImage(source: ImageSource.camera);
                                    if(photo!=null){
                                      final converted = await File(photo.path).readAsBytes();
                                      setState(() {
                                        name = photo.name;
                                        image = converted;
                                      });
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Text("Take Photo",
                                  style: GoogleFonts.roboto(
                                    color: Colors.black54
                                  ),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CupertinoColors.white
                              ),),
                              width: double.infinity,
                            )
                          ],
                        );
                      });
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 20, color: Colors.black),
                          SizedBox(width: 10,),
                          Text("Upload image", style: GoogleFonts.roboto(
                            color: Colors.black
                          ),),
                          SizedBox(width: 20,),
                        ],
                      ),
                    )),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.activeGreen
                  ),
                    onPressed: (){
                      Navigator.pop(context,{
                        "name":taskNameController.text,
                        "description":taskDescriptionController.text,
                        "date":taskDateController.text,
                        "image":image,
                        "category":categoryValue,
                        "completed":false
                      });
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.save, color: CupertinoColors.white, size: 20,),
                          SizedBox(width: 10,),
                          Text("Save", style:  GoogleFonts.roboto(
                            color: CupertinoColors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5
                          ),),
                          SizedBox(width: 30,),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
