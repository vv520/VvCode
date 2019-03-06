package com.vv.entity;

import java.math.BigDecimal;

public class RoleAuthority {
    private BigDecimal authId;

    private Long roleId;

    private Long resourceId;

    public BigDecimal getAuthId() {
        return authId;
    }

    public void setAuthId(BigDecimal authId) {
        this.authId = authId;
    }

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getResourceId() {
        return resourceId;
    }

    public void setResourceId(Long resourceId) {
        this.resourceId = resourceId;
    }
}