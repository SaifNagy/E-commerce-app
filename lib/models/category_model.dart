  // ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:ecommerce_app/utils/app_colors.dart';

class CategoryModel {
    final String id;
    final String name;
    final int productsCount;
    final Color bgColor;
    final Color textColor;

    CategoryModel({
      required this.id,
      required this.name,
      required this.productsCount,
      this.bgColor = AppColors.primary,
      this.textColor = AppColors.white,
    });

  



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'productsCount': productsCount,
      'bgColor': bgColor,
      'textColor': textColor,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      productsCount: int.tryParse(map['productsCount'].toString()) ?? 0,
    bgColor: hexToColor(map['bgColor']),
    textColor: hexToColor(map['textColor']),
    );
  }


  }
  Color hexToColor(String hexColor) {
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor'; 
  }
  return Color(int.parse(hexColor, radix: 16));
}


  List<CategoryModel> dummyCategories = [
    CategoryModel(
      id: '1',
      name: 'New Arrivals',
      productsCount: 208,
      bgColor: AppColors.grey,
      textColor: AppColors.black,
    ),
    CategoryModel(
      id: '2',
      name: 'Clothes',
      productsCount: 358,
      bgColor: AppColors.green,
      textColor: AppColors.white,
    ),
    CategoryModel(
      id: '3',
      name: 'Bags',
      productsCount: 160,
      bgColor: AppColors.black,
      textColor: AppColors.white,
    ),
    CategoryModel(
      id: '4',
      name: 'Shoes',
      productsCount: 230,
      bgColor: AppColors.grey,
      textColor: AppColors.black,
    ),
    CategoryModel(
      id: '5',
      name: 'Electronics',
      productsCount: 101,
      bgColor: AppColors.blue,
      textColor: AppColors.white,
    ),
  ];
