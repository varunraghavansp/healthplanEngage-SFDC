/**
 * Created by varun on 10/14/2019.
 */

public with sharing class be_utilities {
    private static final String MY_NAMESPACE = [SELECT NamespacePrefix FROM ApexClass WHERE Name = 'be_utilities' LIMIT 1].NamespacePrefix;
    public static final String NAMESPACE_API = String.isBlank(MY_NAMESPACE) ? '' : MY_NAMESPACE + '__';

    public static String serializeWithoutNamespace(Object myObject) {
        return JSON.serialize(myObject).replaceAll(be_utilities.NAMESPACE_API, '');
    }

    public static String serializeWithNamespace(Object myObject) {
        return JSON.serialize(myObject);
    }

    /*public static Map<String, Object> convertObjectToMap(Object myObject) {
        return (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(myObject));
    }*/

    public static Boolean fieldNotEmpty(Map < String, Object > jsonMap, String field) {
        return jsonMap.containsKey(field) && !String.isEmpty((String) jsonMap.get(field));
    }

    public static String addNamespace(String obj) {
        if (NAMESPACE_API != '') {
            if ((obj.contains('__c') || obj.contains('__r')) && !(obj.contains(NAMESPACE_API))) {
                return NAMESPACE_API + obj;
            } else {
                return obj;
            }
        } else {
            return obj;
        }
    }

    /**
    * Adds  Namespace to Object Fields
    *
    * addFieldNamespaces
    *
    * @param Object objDetails
    * @return SObject
    */
    public static Object addFieldNamespaces(SObject objDetails) {
        Map<String, Object> objMapwithNS = new Map<String, Object>();
        Object objDetailswithNS;
        Map<String, Object> objMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(objDetails));
        if (NAMESPACE_API != '') {
            for (String key : objMap.keySet()) {
                if(NAMESPACE_API != '' && !(key.contains(NAMESPACE_API)) && key.contains('__c')){
                    objMapwithNS.put(NAMESPACE_API + key, objMap.get(key));
                }else{
                    objMapwithNS.put(key, objMap.get(key));
                }
            }
            objDetailswithNS = (Object) JSON.deserialize(JSON.serialize(objMapwithNS), SObject.class);
        }else{
            objDetailswithNS = objDetails;
        }
        return(objDetailswithNS);
    }

    public static String join(List<String> values) {
        List<String> valueCopy = new List<String>(values);
        if(valueCopy.isEmpty())
            return null;
        String result = valueCopy[0];
        valueCopy.remove(0);
        while(!valueCopy.isEmpty()) {
            result += ',' + valueCopy[0];
            valueCopy.remove(0);
        }
        return result;
    }

    /**
    * Adds Org Namespace to Object Fields
    *
    * addFieldNamespaces
    *
    * @param Object objDetails
    * @return Map < String, Object >
    */
    public static Map<String, Object> addFieldNamespaces(Object objDetails) {
        Map<String, Object> objMapwithNS = new Map<String, Object>();
        Map<String, Object> objMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(objDetails));
        for (String key : objMap.keySet()) {
            if (objMap.get(key) == null || objMap.get(key) == '') {
                //Ignore Null Tags
            } else {
                if ((key.contains('__c') || key.contains('__r')) && !(key.contains(NAMESPACE_API))) {
                    objMapwithNS.put(NAMESPACE_API + key, objMap.get(key));
                }
                else {
                    objMapwithNS.put(key, objMap.get(key));
                }
            }
        }
        return(objMapwithNS);
    }

    /**
    *
    *
    * checksFLSSecurity on Input Fields
    *
    * @param Object objDetails
    * @return Boolean
    */
    public static Boolean checkReadFLS(Map < String, Object > jsonMap) {
        Boolean flsChecksPassed = false;

        Set < String > queryFields = new Set < String > {
                'Id'
        };
        List < String > filters = new List < String > ();
        List < String > orders = new List < String > ();

        String obj = be_utilities.addNamespace(String.escapeSingleQuotes((String) jsonMap.get('object')));
        SObjectType schemaType = Schema.getGlobalDescribe().get(obj);



        if (be_utilities.fieldNotEmpty(jsonMap, 'queryFields')) {
            String queryString = String.escapeSingleQuotes((String) jsonMap.get('queryFields'));
            String[] queryList = queryString.split(',');
            for (String queryFld : queryList) {
                queryFields.add(be_utilities.addNamespace(queryFld.trim()));
            }
        }
        if (be_utilities.fieldNotEmpty(jsonMap, 'searchField')) {
            String searchField = be_utilities.addNamespace( String.escapeSingleQuotes((String) jsonMap.get('searchField')));
            queryFields.add(searchField.trim());
        }
        if (be_utilities.fieldNotEmpty(jsonMap, 'picklistfield')) {
            String picklistfield = be_utilities.addNamespace( String.escapeSingleQuotes((String) jsonMap.get('picklistfield')));
            queryFields.add(picklistfield.trim());
        }

        Map<String,Schema.SObjectField> fieldMap = schemaType.getDescribe().fields.getMap();

        //Object Is Accessible
        flsChecksPassed = schemaType.getDescribe().isAccessible();
        //Fields Are Accessible
        if(flsChecksPassed){
            for(String queryField : queryFields){
                Schema.SObjectField schemaField = fieldMap.get(queryField);
                if(schemaField != null && !schemaField.getDescribe().isAccessible()){
                    flsChecksPassed = false;
                    break;
                }
            }
        }
        return flsChecksPassed;
    }


}