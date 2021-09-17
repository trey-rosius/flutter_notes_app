
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/create/color_item.dart';
import 'package:notes/utils/app_theme.dart';

import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'colors_model.dart';
import 'create_notes_repo.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen();

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  int _selectedColorIndex = 0;

  void _selectedTab(int index) {
    setState(() {
     // _selectedTabIndex = index;
      //print("Selected Index"+_selectedTabIndex.toString());
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(create: (_)=>CreateNoteRepository.instance(),
      child: Consumer(builder: (_,CreateNoteRepository createNoteRepo,child){
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
          Container(


            decoration: BoxDecoration(
                color:  ThemeColor.primary ,
                borderRadius: BorderRadius.circular(10)
            ),
            padding:EdgeInsets.symmetric(horizontal: 20),
            child: TextButton(
              onPressed: (){
                if (_formKey.currentState!.validate()) {

                  createNoteRepo.createNote(context);

                }

              },
              child: createNoteRepo.loading ? CircularProgressIndicator() : Text('Save',style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
        ],
      ),
  ),
    ),
  ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(

                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                child: Column(
                  children: [
                    Container(

                      child: TextFormField(
                        style: TextStyle(color: Colors.white,fontSize: 30),
                        maxLines: 2,

                        validator: (value) {
                          if(value!.isEmpty){
                            return "Type Something";
                          }else{
                            return null;
                          }

                        },
                        controller:  createNoteRepo.noteTitleController,


                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: ThemeColor.textfieldColor,
                          labelText: 'Title',
                          labelStyle: TextStyle(color: ThemeColor.primary),

                          hintText: 'Title',
                          hintStyle: TextStyle(color:Colors.grey.withOpacity(0.3)),

                        ),
                      ),
                    ),
                    Container(

                      child: TextFormField(
                        style: TextStyle(color: Colors.white,fontSize: 20),

                        maxLines: null,

                        validator: (value) {
                          if(value!.isEmpty){
                            return "Type Something";
                          }else{
                            return null;
                          }

                        },
                        controller:  createNoteRepo.noteDescriptionController,


                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(int.parse('0xFF${createNoteRepo.colorSelected}')).withOpacity(0.7),
                          labelText: 'Type Something',
                          labelStyle: TextStyle(color: ThemeColor.primary),
                          hintText: 'Type Something',
                          hintStyle: TextStyle(color:Colors.grey.withOpacity(0.3)),

                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(left: 10.0),

                      height: 80.0,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: colorList.length,
                          itemBuilder: (context, index) {
                            return ColorItem(colorList[index],createNoteRepo,index);
                          }),
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },),);
  }
}
