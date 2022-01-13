/**
 * Created by varun on 10/14/2019.
 * Standard Controller for LWC and Aura Components implementing
 * methods for CRUD from UI Components
 */

/***
 * Standard Component Controller Aura and LWC with exposed methods for GET Records, GET record Types & GET Picklist Values
 *
 */
public with sharing class be_standardComponentController {

    /**
    * Entry Point for Read Operation
    * Fetches SObject records for input JSON String request
    *
    * getRecords
    *
    * @param String jsonString
    *  {'object': 'SObjectName', 'queryFields': 'Field1,Field2', 'searchField': 'Field3', 'searchTerm': 'value', filter : 'Field4 = 'value''}
    * @return String responseData
    */
    @AuraEnabled(cacheable=true)
    public static String getRecords(String jsonString) {
        system.debug(jsonString);
        be_responsedata responseData = new be_responsedata();
        try {
            Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            responseData.results = getData(jsonMap);
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }
        return responseData.getJsonString();
    }

    /**
    * Entry Point for Un-cached Read Operation
    * Fetches SObject records for input JSON String request
    *
    * getRecords
    *
    * @param String jsonString
    *  {'object': 'SObjectName', 'queryFields': 'Field1,Field2', 'searchField': 'Field3', 'searchTerm': 'value', filter : 'Field4 = 'value''}
    * @return String responseData
    */
    @AuraEnabled
    public static String getUncachedRecords(String jsonString) {
        be_responsedata responseData = new be_responsedata();
        try {
            Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            responseData.results = getData(jsonMap);
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }
        return responseData.getJsonString();
    }

    /**
    * Returns Picklist Values
    *
    * getRecords
    *
    * @param String jsonString
    * {'object': 'SObjectName', 'picklistfield': 'Field1,Field2', 'searchField': 'Field3', 'searchTerm': 'value', filter : 'Field4 = 'value''}
    * @return String responseData
    */
    @AuraEnabled(cacheable=true)
    public static String getPicklistValues(String jsonString)
    {
        be_responsedata responseData = new be_responsedata();
        Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
        String objectType;
        String picklistField;
        try{
            List<Map<String, String>> options = new List<Map<String, String>>();
            if(checkReadFLS(jsonMap)){
                if (be_utilities.fieldNotEmpty(jsonMap, 'object') && be_utilities.fieldNotEmpty(jsonMap, 'picklistfield')) {
                    objectType = be_utilities.addNamespace(String.escapeSingleQuotes((String) jsonMap.get('object')));
                    picklistField = be_utilities.addNamespace(String.escapeSingleQuotes((String) jsonMap.get('picklistfield')));
                }
                Schema.SObjectType schemaObject= Schema.getGlobalDescribe().get(objectType);
                Schema.DescribeFieldResult fieldResult = schemaObject.getDescribe().fields.getMap().get(picklistField).getDescribe();

                List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                for( Schema.PicklistEntry f : ple)
                {
                    options.add(new Map<String,String> {
                            'label' => f.getLabel(),
                            'value' =>  f.getValue(),
                            'fieldName' => picklistField
                    }
                    );
                }
                responseData.results = new Map < String, Object > {
                        'data' => options
                };
            }else{
                throw new be_customException('FLS Check Failed for queried object ');
            }

        }
        catch(Exception e){
            responseData.addError(e.getMessage());
        }
        return responseData.getJsonString();
    }

    /**
     *  Returns Map string of SObject fields passed in input json string
     *  getSObjectFields
     *
     * @param jsonString
     *
     * @return String
     */
    @AuraEnabled(cacheable=true)
    public static String getSObjectFields(String jsonString) {
        be_responsedata responseData = new be_responsedata();
        List<Map<String, Object>> data = new List<Map<String, Object>>();
        try {
            Map<String, Object> jsonMap = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
            if(checkReadFLS(jsonMap)){
                SObjectType schemaType = Schema.getGlobalDescribe().get(be_utilities.addNamespace((String)jsonMap.get('object')));
                Map<String,Schema.SObjectField> fieldMap = schemaType.getDescribe().fields.getMap();

                for (Schema.SObjectField field : fieldMap.values()){
                    data.add(new Map<String, Object>{
                            'label' => field.getDescribe().getLabel(),
                            'name' => field.getDescribe().getName(),
                            'type' => field.getDescribe().getType()
                    });
                }

                responseData.results = new Map<String, Object>{
                        'data' => data};
            }else{
                throw new be_customException('FLS Check Failed for queried object ');
            }
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }

        return responseData.getJsonString();
    }

    /**
     * Unmarshals Json Map for construction of dynamic soql for retreiving object values
     *
     * getData
     *
     * @param Map < String, Object > jsonMap
     * @return Map < String, Object >
     */
    private static Map < String, Object > getData(Map < String, Object > jsonMap) {
        List < Map < String, Object >> data = new List < Map < String, Object >> ();
        String searchTerm = '';
        if(checkReadFLS(jsonMap)){
            String objType = String.escapeSingleQuotes((String) jsonMap.get('object'));
            String query = getQuery(jsonMap);
            if (be_utilities.fieldNotEmpty(jsonMap, 'searchField')) {
                String searchField = String.escapeSingleQuotes((String) jsonMap.get('searchField'));
            }

            if (be_utilities.fieldNotEmpty(jsonMap, 'searchTerm')) {
                searchTerm = String.escapeSingleQuotes((String) jsonMap.get('searchTerm'));
            }

            if (be_utilities.fieldNotEmpty(jsonMap, 'queryFields')) {
                String queryString =  (String) jsonMap.get('queryFields');

                String[] queryList = queryString.split('\\,');
                Map<String, Object> objRow = new Map<String, Object>();
                List <Object > objectRecords = new List<Object>();
                for (SObject obj: Database.query(query)) {
                    objectRecords.add(be_utilities.addFieldNamespaces(obj));
                }
                objRow.put(objType, objectRecords);
                data.add(objRow);
            }
        }else{
            throw new be_customException('FLS Check Failed for queried object ');
        }
        return new Map < String, Object > {
                'data' => data,
                'searchTerm' => searchTerm
        };
    }

    /**
    * Constructs SOQL Query For Input JSON Map
    *
    * getQuery
    *
    * @param Map < String, Object > jsonMap
    * @return String query
    */
    private static String getQuery(Map < String, Object > jsonMap) {
        Set < String > queryFields = new Set < String > {
                'Id'
        };
        List < String > filters = new List < String > ();
        List < String > orders = new List < String > ();

        String query;
        String obj = be_utilities.addNamespace(String.escapeSingleQuotes((String) jsonMap.get('object')));

        if (be_utilities.fieldNotEmpty(jsonMap, 'queryFields')) {
            String queryString =  String.escapeSingleQuotes((String) jsonMap.get('queryFields'));
            String[] queryList = queryString.split(',');
            for(String queryFld : queryList){
                queryFields.add(be_utilities.addNamespace( queryFld.trim()));
            }

            if (be_utilities.fieldNotEmpty(jsonMap, 'searchTerm')) {
                String searchField = be_utilities.addNamespace( String.escapeSingleQuotes((String) jsonMap.get('searchField')));
                String searchTerm = be_utilities.addNamespace(String.escapeSingleQuotes((String) jsonMap.get('searchTerm')));
                if (searchField.contains('Id')) {
                    filters.add(searchField + ' = \'' + searchTerm + '\'');
                }
                //Specific Check for Agency Master Detail Relationship on Commission
                else if(searchField.contains('__c')){
                    filters.add(searchField + ' = \'' + searchTerm + '\'');
                }
                else {
                    filters.add(searchField + ' LIKE \'%' + searchTerm + '%\'');
                }
            }
        }

        if (be_utilities.fieldNotEmpty(jsonMap, 'filter')) {
            String filter =  (String) jsonMap.get('filter');
            filters.add('(' + filter + ')');
        }

        if (be_utilities.fieldNotEmpty(jsonMap, 'order')) {
            String orderby = be_utilities.addNamespace( String.escapeSingleQuotes((String) jsonMap.get('order')));
            orders.add(orderby);
        }

        query = 'SELECT ' + String.join(new List < String > (queryFields), ', ');
        query += ' FROM ' + obj;

        if (filters.size() > 0) {
            query += ' WHERE ' + String.join(filters, ' AND ');
        }

        if (orders.size() > 0) {
            query += ' ORDER BY ' + String.join(orders, ', ');
        }

        if (be_utilities.fieldNotEmpty(jsonMap, 'limit')) {
            query += ' LIMIT ' + String.escapeSingleQuotes((String) jsonMap.get('limit'));
        }

        return query;
    }

    /**
    *
    *
    * checksFLSSecurity on Input Fields
    *
    * @param Object objDetails
    * @return Boolean
    */
    private static Boolean checkReadFLS(Map < String, Object > jsonMap) {
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