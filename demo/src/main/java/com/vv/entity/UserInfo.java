package com.vv.entity;

import java.math.BigDecimal;

public class UserInfo {
    private BigDecimal userId;

    private String userName;

    private BigDecimal iId;

    private String email;

    private String telNum;

    private String mobileNum;

    private String employeeCardNo;

    private String fullChineseSpell;

    private String password;

    private String account;

    private String birthDay;

    private BigDecimal flag;

    private BigDecimal status;

    private String headChineseSpell;

    private String createTime;

    private String updateTime;

    private String isFirstLogin;

    private String pwdUpdateDate;

    private Short inputPwdErrorTimes;

    private String passwordHistory;

    private BigDecimal dId;

    private String virtualOperatorNo;

    public BigDecimal getUserId() {
        return userId;
    }

    public void setUserId(BigDecimal userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public BigDecimal getiId() {
        return iId;
    }

    public void setiId(BigDecimal iId) {
        this.iId = iId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getTelNum() {
        return telNum;
    }

    public void setTelNum(String telNum) {
        this.telNum = telNum == null ? null : telNum.trim();
    }

    public String getMobileNum() {
        return mobileNum;
    }

    public void setMobileNum(String mobileNum) {
        this.mobileNum = mobileNum == null ? null : mobileNum.trim();
    }

    public String getEmployeeCardNo() {
        return employeeCardNo;
    }

    public void setEmployeeCardNo(String employeeCardNo) {
        this.employeeCardNo = employeeCardNo == null ? null : employeeCardNo.trim();
    }

    public String getFullChineseSpell() {
        return fullChineseSpell;
    }

    public void setFullChineseSpell(String fullChineseSpell) {
        this.fullChineseSpell = fullChineseSpell == null ? null : fullChineseSpell.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(String birthDay) {
        this.birthDay = birthDay == null ? null : birthDay.trim();
    }

    public BigDecimal getFlag() {
        return flag;
    }

    public void setFlag(BigDecimal flag) {
        this.flag = flag;
    }

    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }

    public String getHeadChineseSpell() {
        return headChineseSpell;
    }

    public void setHeadChineseSpell(String headChineseSpell) {
        this.headChineseSpell = headChineseSpell == null ? null : headChineseSpell.trim();
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime == null ? null : createTime.trim();
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime == null ? null : updateTime.trim();
    }

    public String getIsFirstLogin() {
        return isFirstLogin;
    }

    public void setIsFirstLogin(String isFirstLogin) {
        this.isFirstLogin = isFirstLogin == null ? null : isFirstLogin.trim();
    }

    public String getPwdUpdateDate() {
        return pwdUpdateDate;
    }

    public void setPwdUpdateDate(String pwdUpdateDate) {
        this.pwdUpdateDate = pwdUpdateDate == null ? null : pwdUpdateDate.trim();
    }

    public Short getInputPwdErrorTimes() {
        return inputPwdErrorTimes;
    }

    public void setInputPwdErrorTimes(Short inputPwdErrorTimes) {
        this.inputPwdErrorTimes = inputPwdErrorTimes;
    }

    public String getPasswordHistory() {
        return passwordHistory;
    }

    public void setPasswordHistory(String passwordHistory) {
        this.passwordHistory = passwordHistory == null ? null : passwordHistory.trim();
    }

    public BigDecimal getdId() {
        return dId;
    }

    public void setdId(BigDecimal dId) {
        this.dId = dId;
    }

    public String getVirtualOperatorNo() {
        return virtualOperatorNo;
    }

    public void setVirtualOperatorNo(String virtualOperatorNo) {
        this.virtualOperatorNo = virtualOperatorNo == null ? null : virtualOperatorNo.trim();
    }
}