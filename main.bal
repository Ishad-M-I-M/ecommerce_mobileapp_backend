import ballerina/graphql;

service on new graphql:Listener(4000) {

    resource function get users() returns User[]|error {
        json data = check getUsers();
        return data.cloneWithType();
    }
}
