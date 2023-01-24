import ballerina/test;

@test:Config {}

function getUsersTest() {
    User[]|error users = getUsers();

    if (users is error) {
        test:assertFail("Error!");
    }
    else {
        test:assertEquals(users[0], <User>{

            id: 1,
            username: "user1",
            password: "12345",
            name: "Sample User 1",
            date_of_birth: "1999-8-22T00:00:00.00Z",
            categories: [
                <Category>{
                    id: 2,
                    title: "Category 2",
                    description: "Duis amet cupidatat ipsum pariatur cupidatat cillum dolore id."
                },
                <Category>{
                    id: 3,
                    title: "Category 3",
                    description: "Duis amet cupidatat ipsum pariatur cupidatat cillum dolore id."
                }
            ]
        });
    }

}
