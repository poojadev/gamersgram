
class SearchPOJO
{

    String name;
    int id;

    SearchPOJO({this.id,this.name});






    factory SearchPOJO.fromJson(Map<String, dynamic> data) => new SearchPOJO(
      id: data["id"],
      name: data["name"],


    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,


    };
}

