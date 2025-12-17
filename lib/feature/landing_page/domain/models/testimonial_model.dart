class TestimonialModel {
  bool? status;
  String? message;
  List<TestimonialItem>? data;


  TestimonialModel({this.status, this.message, this.data});

  TestimonialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TestimonialItem>[];
      json['data'].forEach((v) {
        data!.add(TestimonialItem.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class TestimonialItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? userId;
  String? description;
  int? status;
  User? user;

  TestimonialItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.userId,
        this.description,
        this.status,
        this.user});

  TestimonialItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    userId = json['user_id'];
    description = json['description'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['user_id'] = userId;
    data['description'] = description;
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;

  User({this.id, this.name, this.phone, this.email, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}

final sampleTestimonial = {
  "status": true,
  "message": "Mighty School transformed our school operations! Mighty School transformed our school operations! Mighty School transformed our school operations!",
  "data": [
    {
      "id": 1,
      "institute_id": 101,
      "branch_id": 202,
      "user_id": 303,
      "description": "Great experience with the platform! The features are user-friendly and the support team is very responsive. Highly recommend it for any educational institution looking to streamline their operations.",
      "status": 1,
      "user": {
        "id": 303,
        "name": "John Doe",
        "phone": "1234567890",
        "email": "johndoe@example.com",
        "image": "https://example.com/images/johndoe.jpg"
      }
    },
    {
      "id": 2,
      "institute_id": 102,
      "branch_id": 203,
      "user_id": 304,
      "description": "The platform has made managing our school so much easier. The attendance tracking and fee management features are particularly useful. The customer support is also top-notch.",
      "status": 1,
      "user": {
        "id": 304,
        "name": "Jane Smith",
        "phone": "0987654321",
        "email": "janesmith@example.com",
        "image": "https://example.com/images/janesmith.jpg"
      }
    },
    {
      "id": 3,
      "institute_id": 103,
      "branch_id": 204,
      "user_id": 305,
      "description": "Mighty School has revolutionized the way we manage our school. The interface is intuitive and easy to navigate. The reporting features are incredibly helpful for tracking student progress and performance. I can't imagine going back to our old system.",
      "status": 1,
      "user": {
        "id": 305,
        "name": "Alice Johnson",
        "phone": "1122334455",
        "email": "alicejohnson@example.com",
        "image": "https://example.com/images/alicejohnson.jpg"
      }
    },
    {
      "id": 4,
      "institute_id": 104,
      "branch_id": 205,
      "user_id": 306,
      "description": "The platform is very user-friendly and has a lot of features that help us manage our school efficiently. The support team is always available to assist with any issues we encounter. Overall, a great investment for our institution.",
      "status": 1,
      "user": {
        "id": 306,
        "name": "Bob Brown",
        "phone": "6677889900",
        "email": "bobbrown@example.com",
        "image": "https://example.com/images/bobbrown.jpg"
      }
    },
    {
      "id": 5,
      "institute_id": 105,
      "branch_id": 206,
      "user_id": 307,
      "description": "Mighty School has transformed our school operations! The platform is easy to use and has all the features we need to manage our school effectively. The customer support is also very helpful and responsive. I highly recommend it to any educational institution looking for a comprehensive management solution.",
      "status": 1,
      "user": {
        "id": 307,
        "name": "Charlie Davis",
        "phone": "9988776655",
        "email": "charliedavis@example.com",
        "image": "https://example.com/images/charliedavis.jpg"
      }
    }
  ]
};
