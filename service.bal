import ballerina/constraint;
import ballerina/io;

// functions to read the json filres and return the data

const string basePath = "./database/";

type User_category record {|
    int user_id;
    int category_id;
|};

public function getUsers() returns User[]|error {
    json data = check io:fileReadJson(basePath + "users.json");
    json interested_categories = check io:fileReadJson(basePath + "user_Categories.json");

    User[] users = check data.cloneWithType();
    User_category[] user_cat = check interested_categories.cloneWithType();

    foreach var user in users {
        User|error validatedUser = constraint:validate(user);
        if (validatedUser is error) {
            return error("Validation failed");
        }

        user.categories = user_cat.filter(e => e.user_id == user.id).'map(e => check getCategoryById(e.category_id));
    }

    return users;
}

public function saveUser(User user) returns int|error {
    json data = check io:fileReadJson(basePath + "users.json");
    User[] users = check data.cloneWithType();

    User validatedUser = check constraint:validate(user);

    users.push(validatedUser);

    _ = check io:fileWriteJson(basePath + "users.json", users);
    return user.id;
}

function getUserById(int id) returns User|error {
    User[] users = check getUsers();
    table<User> key(id) userTable = table [];

    foreach var user in users {
        userTable.add(user);
    }

    return userTable.get(id);
}

public function getProducts() returns Product[]|error {
    json data = check io:fileReadJson(basePath + "products.json");
    Product[] products = check data.cloneWithType();

    return products;
}

public function getCategories() returns Category[]|error {
    json data = check io:fileReadJson(basePath + "categories.json");
    Category[] categories = check data.cloneWithType();

    return categories;
}

function getCategoryById(int id) returns Category|error {
    Category[] categories = check getCategories();
    foreach var c in categories {
        if (c.id == id) {
            return c;
        }
    }
    return error("Not found");
}
