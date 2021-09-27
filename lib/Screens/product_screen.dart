import 'package:applore/Screens/upload_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final firestore=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:AppBar(
          actions: [
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadScreen()));
            },
                child: Icon(Icons.add,size: 30,color: CupertinoColors.white,))
          ],
          elevation: 0,
          backgroundColor: Colors.purple,
        ),
        backgroundColor: Colors.purple,
        body: StreamBuilder<QuerySnapshot>(
            stream:  firestore.collection('details').orderBy('timestamp', descending: true).snapshots(),
            builder: (context,snapshot) {
              List<ProductCard> productCards=[];
              if(!snapshot.hasData)
              {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              }
              List<QueryDocumentSnapshot<Object?>> messages = snapshot.data!.docs;
              for(var message in messages)
              {
                final data=message.data() as Map;
                final name=data['name'];
                final description=data['description'];
                final price=data['price'].toString();
                final URL=data['URL'];

                final productCard=ProductCard(name: name,description: description,price: price,URL: URL);
                productCards.add(productCard);
              }

              return ListView(
                reverse: true,
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                children: productCards,
              );
            }),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  ProductCard({required this.name,required this.description,required this.price,required this.URL});
  final String name;
  final String description;
  final String price;
  final String URL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.38,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ],
            color: Color(0xFF211A23),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFFFFF0F0),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 5),
                    child: Container(
                      width: 120,
                      height: 120,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(
                        '$URL',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                    child: Text(
                      'Price - $price INR',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFFFFF0F0),
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                child: Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFFFFF0F0),
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
