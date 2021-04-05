import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uber_clone/components/bottom_sheet.dart' as sheet;

class ProfileSliver extends StatefulWidget {

  final File? picture;
  final String firstName;
  final bool hasEdit;
  ProfileSliver({required this.picture, required this.firstName, required this.hasEdit});


  @override
  _ProfileSliverState createState() => _ProfileSliverState();
}

class _ProfileSliverState extends State<ProfileSliver> {
  @override
  Widget build(BuildContext context) {
     return SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverSafeArea(
          top: false,
          sliver: SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            brightness: Brightness.dark,
            elevation: 0.0,
            expandedHeight: MediaQuery.of(context).size.height * 0.45,
            pinned: true,
            actions: [
              widget.hasEdit ? IconButton(
                onPressed: () async {
                  await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                        )
                      ),
                      builder: (context) => sheet.BottomSheet());
                },
                icon: Icon(Icons.edit),
              ) : Container()
            ],
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(widget.firstName, style: TextStyle(color: Colors.white, fontSize: 22),),
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(widget.picture!),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
  }
}
