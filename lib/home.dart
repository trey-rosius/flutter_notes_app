

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/create/create_note.dart';
import 'package:notes/getNote/view_note.dart';
import 'package:notes/query/list_notes_model.dart';
import 'package:notes/query/query_repo.dart';
import 'package:notes/registration_and_login/login_screen.dart';
import 'package:notes/utils/app_theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen(this.userId);
  final String? userId;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.bgColor,
     appBar: PreferredSize(
       preferredSize: Size(double.infinity, 100),
       child: SafeArea(
         child: Container(

          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 child: Text("Notes",style: TextStyle(fontSize: 30,color: Colors.white),),
               ),
               Container(


                 decoration: BoxDecoration(
                     color: Colors.grey.withOpacity(0.4),
                     borderRadius: BorderRadius.circular(10)
                 ),
                 padding:EdgeInsets.all(10),
                 child: SvgPicture.asset(
                   'assets/svg/search.svg',
                   fit: BoxFit.cover,
                   height: 24,
                   width: 24,
                   color: Colors.white,

                 ),
               ),
             ],),
         ),
       ),
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: (){
      if(widget.userId == null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePostScreen()));
      }

       },
       child: Icon(Icons.add),
     ),

     body:  Amplify.isConfigured? FutureProvider<ListNoteModel>(create:(context)=> QueryRepository.instance().getNotesList(),
       initialData: ListNoteModel(),
       catchError: (context,error){
       print(error.toString());
      return ListNoteModel();
       },

       child:Consumer(builder: (_,ListNoteModel listNotesModel,child){
         if(listNotesModel.listNotes == null){
           return  Container(
             child: Center(child: CircularProgressIndicator(),),
           );
         }else{
          
           if(listNotesModel.listNotes!.isEmpty){
             return Container(
               child: Center(child: Text("No notes available ",style: TextStyle(fontSize: 20,color: Colors.white),),),

             );
           }else{
             // return SliverToBoxAdapter(child: Text(listNotesModel.listNotes![0].description!,style: TextStyle(color: Colors.white),),);

             return StaggeredGridView.countBuilder(
               crossAxisCount: 4,
               itemCount:listNotesModel.listNotes!.length,
               itemBuilder: (BuildContext context, int index) =>
                   InkWell(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return ViewNoteScreen(listNotesModel.listNotes![index]);
                       }));
                     },
                     child: Card(
                         elevation: 10,
                         color: Color(int.parse('0xFF${listNotesModel.listNotes![index].color}')),
                         child:
                         Container(
                           padding: EdgeInsets.all(10),
                           child:
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Container(
                                   padding: EdgeInsets.all(10),
                                   child: Text(listNotesModel.listNotes![index].title!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                               Text(listNotesModel.listNotes![index].description!,),
                               Container(
                                 padding: EdgeInsets.all(10),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Text(timeago.format(DateTime.fromMicrosecondsSinceEpoch(listNotesModel.listNotes![index].createdOn!)),
                                       style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                                   ],
                                 ),
                               )
                             ],
                           ),)),
                   ),

               staggeredTileBuilder: (int index) =>
                   StaggeredTile.fit(2),

               mainAxisSpacing: 4.0,
               crossAxisSpacing: 4.0,
             );


           }
         }
       },),): Container(),

    );
  }
}
