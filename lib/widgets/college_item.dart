import 'package:flutter/material.dart';
import 'package:ibb_university_images/pages/photoes_page.dart';

class CollegeItem extends StatelessWidget {
  String id;
  String title;
  String ImageUrl;

  CollegeItem(this.id, this.title, this.ImageUrl);

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(PhotoesPage.PAGE_ROUTE, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              ImageUrl,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
