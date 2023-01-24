import ballerina/constraint;

// Defined records used to fetch data from database.

type User record {|
    int id; // database id for the user
    string username;
    @constraint:String {
        minLength: 5
    }
    string password;
    @constraint:String {
        minLength: 5
    }
    string name;
    string date_of_birth;
    Category[] categories?;
|};

type Category record {|
    int id;
    string title;
    string description;
    Product[] products?;
|};

type Product record {|
    int id;
    int category_id;
    string title;
    string short_description;
    string description;
    int price;
|};

type Reviews record {|
    int id;
    int user_id;
    int product_id;
    @constraint:Int {
        minValue: 1,
        maxValue: 5
    }
    int rating;
    string comment;
|};
