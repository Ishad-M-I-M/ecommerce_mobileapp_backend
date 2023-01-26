import ballerina/graphql;

public type UserDetails record {
    string name;
    string password;
    string username;
    string date_of_birth;
};

service on new graphql:Listener(4000) {

    resource function get users() returns User[]|error {
        json data = check getUsers();
        return data.cloneWithType();
    }

    remote function storeUser(UserDetails user) returns int|error {
        json data = check getUsers();
        json[] users = check data.cloneWithType();

        User u = {
            id: users.length(),
            name: user.name,
            username: user.username,
            date_of_birth: user.date_of_birth,
            password: user.password,
            categories: []
        };

        int id = check saveUser(u);
        return id;
    }
}
