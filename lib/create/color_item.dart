import 'package:flutter/material.dart';
import 'package:notes/create/colors_model.dart';

import 'create_notes_repo.dart';

class ColorItem extends StatefulWidget {
  const ColorItem(this.colorModel,this.createNoteRepo,this.index);
  final ColorModel colorModel;
  final int index;
  final CreateNoteRepository createNoteRepo;


  @override
  _ColorItemState createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){

         widget.createNoteRepo.colorSelected = widget.colorModel.codeHex!;
         widget.createNoteRepo.colorSelectedIndex = widget.index;


      },
      child: Container(
        margin: EdgeInsets.all(10),

           width: 50,
        height: 50,


        decoration: BoxDecoration(
          shape: BoxShape.circle,
            border:widget.createNoteRepo.colorSelectedIndex==widget.index? Border.all(width: 2,color: Colors.white): Border.all(),
            color: Color(widget.colorModel.colorId!),

        ),
      ),
    );
  }
}
