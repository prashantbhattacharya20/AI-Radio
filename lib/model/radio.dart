// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyRadioList {
  final List<MyRadio> radios;
  MyRadioList({
    required this.radios,
  });

  MyRadioList copyWith({
    List<MyRadio>? radios,
  }) {
    return MyRadioList(
      radios: radios ?? this.radios,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'radios': radios.map((x) => x.toMap()).toList(),
    };
  }

  factory MyRadioList.fromMap(Map<String, dynamic> map) {
    return MyRadioList(
      radios: List<MyRadio>.from(
        map['radios']?.map(
          (x) => MyRadio.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadioList.fromJson(String source) =>
      MyRadioList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MyRadioList(radios: $radios)';

  @override
  bool operator ==(covariant MyRadioList other) {
    if (identical(this, other)) return true;

    return listEquals(other.radios, radios);
  }

  @override
  int get hashCode => radios.hashCode;
}

class MyRadio {
  final int id;
  final int order;
  final String name;
  final String tagline;
  final String desc;
  final String color;
  final String url;
  final String category;
  final String lang;
  final String image;
  final String icon;
  MyRadio({
    required this.id,
    required this.order,
    required this.name,
    required this.tagline,
    required this.desc,
    required this.color,
    required this.url,
    required this.category,
    required this.lang,
    required this.image,
    required this.icon,
  });

  MyRadio copyWith({
    int? id,
    int? order,
    String? name,
    String? tagline,
    String? desc,
    String? color,
    String? url,
    String? category,
    String? lang,
    String? image,
    String? icon,
  }) {
    return MyRadio(
      id: id ?? this.id,
      order: order ?? this.order,
      name: name ?? this.name,
      tagline: tagline ?? this.tagline,
      desc: desc ?? this.desc,
      color: color ?? this.color,
      url: url ?? this.url,
      category: category ?? this.category,
      lang: lang ?? this.lang,
      image: image ?? this.image,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'order': order,
      'name': name,
      'tagline': tagline,
      'desc': desc,
      'color': color,
      'url': url,
      'category': category,
      'lang': lang,
      'image': image,
      'icon': icon,
    };
  }

  factory MyRadio.fromMap(Map<String, dynamic> map) {
    return MyRadio(
      id: map['id'] as int,
      order: map['order'] as int,
      name: map['name'] as String,
      tagline: map['tagline'] as String,
      desc: map['desc'] as String,
      color: map['color'] as String,
      url: map['url'] as String,
      category: map['category'] as String,
      lang: map['lang'] as String,
      image: map['image'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyRadio.fromJson(String source) =>
      MyRadio.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyRadio(id: $id, order: $order, name: $name, tagline: $tagline, desc: $desc, color: $color, url: $url, category: $category, lang: $lang, image: $image, icon: $icon)';
  }

  @override
  bool operator ==(covariant MyRadio other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.order == order &&
        other.name == name &&
        other.tagline == tagline &&
        other.desc == desc &&
        other.color == color &&
        other.url == url &&
        other.category == category &&
        other.lang == lang &&
        other.image == image &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        order.hashCode ^
        name.hashCode ^
        tagline.hashCode ^
        desc.hashCode ^
        color.hashCode ^
        url.hashCode ^
        category.hashCode ^
        lang.hashCode ^
        image.hashCode ^
        icon.hashCode;
  }
}
