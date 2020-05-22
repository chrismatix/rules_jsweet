package com.github.rules_jswet.examples;

import def.js.JSON;
import def.js.Object;


public class User {
    private String firstName;
    private String lastName;

    public User(String firstName, String lastName) {
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public String render() {
        final Object userObj = new Object();

        userObj.$set("firstName", firstName);
        userObj.$set("lastName", lastName);
        return JSON.stringify(userObj);
    }

    public static User fromObj(Object payload) {
        if(!payload.hasOwnProperty("firstName") || !payload.hasOwnProperty("lastName") ) {
            throw new IllegalArgumentException("Given payload is not a User object");
        }

        return new User(payload.$get("firstName"), payload.$get("lastName"));
    }
}
