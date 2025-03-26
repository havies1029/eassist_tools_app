class ListHelper {
  static List<Map<String, dynamic>> filterListByKey (
    List<Map<String, dynamic>> list,
    String key
  ) {
    Set ids = <String>{};
    
    return list.where((e) {
      if (ids.contains(e[key].toString())) {
        return false;
      }
      
      ids.add(e[key].toString());
      return true;
    }).toList();
  }
}