class Category {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final int? parentId;
  final List<Category>? children;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.parentId,
    this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
        parentId: json['parent_id'],
        children: json['children'] != null
            ? (json['children'] as List)
                .map((child) => Category.fromJson(child))
                .toList()
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'image': image,
        'parent_id': parentId,
        'children': children?.map((child) => child.toJson()).toList(),
      };
}
