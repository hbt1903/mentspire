import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String _url;
  final double _size, elevation;

  CustomAvatar(this._url, this._size, {this.elevation = 5});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(_size / 2),
      elevation: elevation,
      child: Hero(
        tag: _url,
        child: Container(
          width: _size,
          height: _size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_size / 2),
            image: DecorationImage(
              image: NetworkImage(_url),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
