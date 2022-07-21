import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ViewReviews extends StatefulWidget {
  const ViewReviews({Key? key}) : super(key: key);

  @override
  _ViewReviewsState createState() => _ViewReviewsState();
}

class _ViewReviewsState extends State<ViewReviews> {
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('reviews');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('User Reviews'),
      ),
      body: StreamBuilder(
          stream: dataref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,

                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
                  final date = documentSnapshot['Date'];
                  final username = documentSnapshot['userName'];
                  final pic = documentSnapshot['userimage'];
                  final review = documentSnapshot['Review'];
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    margin: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: ListTile(
                        trailing: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(pic),
                        ),
                        title: Text("$review ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        subtitle: Align(
                            alignment:Alignment.topRight,child: Text("\n- $username \n   $date", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,fontStyle: FontStyle.italic,),)),
                      ),
                    ),
                  );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),

    );
  }
}
