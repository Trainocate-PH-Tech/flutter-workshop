import 'package:flutter/material.dart';

Map<String, dynamic> locations = {
  "regions": [
    { 
      "name": "NCR", 
      "cities": [
        "Manila",
        "QC",
        "Makati"
      ] 
    },
    {
      "name": "Region 1",
      "cities": [
        "Pampanga",
        "Bulacan"
      ]
    },
    {
      "name": "Region 2",
      "cities": [
        "Laguna",
        "Cavite"
      ]
    }
  ]
};

List<String> getCitiesFromRegion(String? region) {
  List<String> cities = [];

  for (Map<String, dynamic> item in locations["regions"]) {
    if (item["name"].toString() == region) {
      cities = item["cities"];
    }
  }

  return cities;
}

List<String> toListFromKey(List<Map<String, dynamic>> items, String key) {
  List<String> values = [];

  for (Map<String, dynamic> item in items) {
    values.add(item[key].toString());
  }

  return values;
}

List<DropdownMenuItem<String>> toDropdownMenuItemList(List<String> items) {
  List<DropdownMenuItem<String>> values = [];

  values.add(DropdownMenuItem(value: "", child: Text("")));

  for (String item in items) {
    values.add(DropdownMenuItem(value: item, child: Text(item)));
  }

  debugPrint("Items: " + values.length.toString());

  return values;
}