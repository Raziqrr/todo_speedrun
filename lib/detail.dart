import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.task, required this.index});
  final Map<String,dynamic> task;
  final int index;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
          child: Icon(CupertinoIcons.trash, color: CupertinoColors.white,),
          backgroundColor: Colors.red,
          onPressed: (){
        Navigator.pop(context, widget.index);
      }),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context,widget.task["completed"]);
        }, icon: Icon(CupertinoIcons.back)),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              widget.task["completed"]=!widget.task["completed"];
            });
          }, icon: Icon(CupertinoIcons.checkmark_alt, color:widget.task["completed"]==false?CupertinoColors.white:CupertinoColors.systemGreen,size: 40,))
        ],
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: Text("${widget.task["name"]}", style: GoogleFonts.lobster(
          color: Colors.lightGreenAccent,
          fontSize: 30
        ),),
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: CupertinoColors.activeOrange,
                        width: 1.0
                      )
                    ),
                    child: Text("${widget.task["date"]}", style: GoogleFonts.robotoMono(
                      color: CupertinoColors.activeOrange
                    ),)),
                AnimatedContainer(duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color:  widget.task["completed"]==false ? CupertinoColors.systemRed:CupertinoColors.systemGreen,
                            width: 1.0
                        )
                    ),
                    child: widget.task["completed"]==false ?Text("Not completed", style: GoogleFonts.robotoMono(
                        color: CupertinoColors.systemRed
                    ),):
                  Text("Completed", style: GoogleFonts.robotoMono(
                    color: CupertinoColors.systemGreen
                ),)
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: CupertinoColors.activeBlue,
                            width: 1.0
                        )
                    ),
                    child: Text("${widget.task["category"]}", style: GoogleFonts.robotoMono(
                        color: CupertinoColors.activeBlue
                    ),))
                ,
              ],
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: CupertinoColors.white,
                  width: 2.0
                )
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(Uint8List.fromList((widget.task["image"] as List<dynamic>).cast<int>()), fit: BoxFit.fitWidth,))),
                  SizedBox(height: 20,),
                  Text("${widget.task["description"]}", style: GoogleFonts.roboto(
                    color: CupertinoColors.white
                  ),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
