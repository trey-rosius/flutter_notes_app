import 'package:flutter/material.dart';
import 'package:notes/query/list_notes_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/utils/app_theme.dart';
import 'package:timeago/timeago.dart' as timeago;
class ViewNoteScreen extends StatelessWidget {
  const ViewNoteScreen(this.listNote);
  final ListNotes listNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.textfieldColor,
      appBar: PreferredSize(

        preferredSize: const Size(double.infinity, 100), child:SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(


                  decoration: BoxDecoration(
                      color: ThemeColor.secondary,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding:EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/svg/back.svg',
                    fit: BoxFit.cover,
                    height: 24,
                    width: 24,
                    color: Colors.white,

                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(


                  decoration: BoxDecoration(
                      color: ThemeColor.secondary,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding:EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    'assets/svg/edit.svg',
                    fit: BoxFit.cover,
                    height: 24,
                    width: 24,
                    color: Colors.white,

                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: Text(listNote.title!,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),)),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(timeago.format(DateTime.fromMicrosecondsSinceEpoch(listNote.createdOn!)),
                  style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 20),),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                child: Text(listNote.description!,style: TextStyle(color: Colors.white,fontSize: 16,height: 1.5),),
              ),

            ],
          ),
        ),
      ),

    );
  }
}
