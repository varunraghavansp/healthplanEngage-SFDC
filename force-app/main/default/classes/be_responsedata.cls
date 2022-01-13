/**
 * Created by varun on 10/14/2019.
 */

public with sharing class be_responsedata {
    public Boolean isSuccess;
    public Map<String, Object> results;
    public String errMsg;

    public be_responsedata() {
        this.isSuccess = true;
        this.results = new Map<String, Object>();
    }

    public void addError(String errMsg){
        this.errMsg = errMsg;
        this.isSuccess = false;
    }

    public String getJsonString() {
        return be_utilities.serializeWithNamespace(this);
    }

    public String getJsonStringWoNamespace() {
        return be_utilities.serializeWithoutNamespace(this);
    }
}