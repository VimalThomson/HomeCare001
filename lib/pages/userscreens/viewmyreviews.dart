import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ViewMyReviews extends StatefulWidget {
  const ViewMyReviews({Key? key}) : super(key: key);

  @override
  _ViewMyReviewsState createState() => _ViewMyReviewsState();
}

class _ViewMyReviewsState extends State<ViewMyReviews> {
  final CollectionReference dataref =
  FirebaseFirestore.instance.collection('reviews');
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('My Reviews'),
      ),
      body: StreamBuilder(
        stream: dataref.where('useremail',isEqualTo: user?.email).snapshots(),
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
                final id = documentSnapshot.id;
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  margin: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: ListTile(
                      trailing:  new Column(
                        children: <Widget>[
                          new Container(
                            child: new IconButton(
                              icon: new Icon(Icons.delete_forever,color: Colors.redAccent,size: 32,),
                              onPressed: () { deleteReview(id); },
                            ),
                          )
                        ],
                      ),
                      title: Text("$review ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

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
  void deleteReview(id) async {
    try {

      FirebaseFirestore.instance.collection('reviews').doc(id).delete();
      Fluttertoast.showToast(msg: "Review succesfully deleted");
    } catch(e){}
  }
}
