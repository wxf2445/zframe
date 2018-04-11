package com.zlzkj.app.model;

import java.io.Serializable;

public class Permission implements Serializable {
    private String id;
    private String roleId;
    private String authorityId;

    private static final long serialVersionUID = 1L;

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}