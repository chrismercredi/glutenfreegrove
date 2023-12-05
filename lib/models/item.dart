class Item {
  final int id;
  final String name;
  final String description;
  final double price;
  final String category;
  final DateTime createdAt;
  final DateTime? editedAt;
  final DateTime? deletedAt;
  final bool isDraft;
  final bool isPublished;
  final bool isSale;
  final double? salePrice;
  final Map<String, dynamic> additionalAttributes;
  final List<String> images; // To store image URLs or paths

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.createdAt,
    this.editedAt,
    this.deletedAt,
    this.isDraft = false,
    this.isPublished = true,
    this.isSale = false,
    this.salePrice,
    this.additionalAttributes = const {},
    this.images = const [],
  });

  // Add copyWith method
  Item copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? category,
    DateTime? createdAt,
    DateTime? editedAt,
    DateTime? deletedAt,
    bool? isDraft,
    bool? isPublished,
    bool? isSale,
    double? salePrice,
    Map<String, dynamic>? additionalAttributes,
    List<String>? images,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      editedAt: editedAt ?? this.editedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isDraft: isDraft ?? this.isDraft,
      isPublished: isPublished ?? this.isPublished,
      isSale: isSale ?? this.isSale,
      salePrice: salePrice ?? this.salePrice,
      additionalAttributes: additionalAttributes ?? this.additionalAttributes,
      images: images ?? this.images,
    );
  }

  // Implement a method to easily convert an Item to a Map, for sending data to the backend
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'editedAt': editedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'isDraft': isDraft,
      'isPublished': isPublished,
      'isSale': isSale,
      'salePrice': salePrice,
      'additionalAttributes': additionalAttributes,
      'images': images,
    };
  }

  // Optional: Implement a factory method to create an Item from a Map (e.g., when retrieving data from the backend)
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      category: map['category'],
      createdAt: DateTime.parse(map['createdAt']),
      editedAt:
          map['editedAt'] != null ? DateTime.parse(map['editedAt']) : null,
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      isDraft: map['isDraft'] ?? false,
      isPublished: map['isPublished'] ?? true,
      isSale: map['isSale'] ?? false,
      salePrice: map['salePrice'],
      additionalAttributes: map['additionalAttributes'] ?? {},
      images: List<String>.from(map['images'] ?? []),
    );
  }
}
