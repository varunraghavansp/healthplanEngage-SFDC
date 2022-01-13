/**
 * Created by varun on 10/14/2019.
 */

public with sharing class be_genericcontroller {
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

            SObjectType schemaType = Schema.getGlobalDescribe().get(be_utilities.addNamespace((String)jsonMap.get('sobject')));
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
            if (be_utilities.fieldNotEmpty(jsonMap, 'sobject') && be_utilities.fieldNotEmpty(jsonMap, 'picklistfield')) {
                objectType = be_utilities.addNamespace(String.escapeSingleQuotes((String) jsonMap.get('sobject')));
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
        }
        catch(Exception e){
            responseData.addError(e.getMessage());
        }
        return responseData.getJsonString();
    }

    /**
     * Returns JSON String of search fields
     *
     * getRecords
     *
     * @param String jsonString
     * @return String responseData
     */
    @AuraEnabled(cacheable=true)
    public static String getRecords(String jsonString) {
        be_responsedata responseData = new be_responsedata();
        try {
            Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            responseData.results = getData(jsonMap);
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }
        //system.debug(responseData.getJsonString());
        return responseData.getJsonString();
    }

    /**
     * Returns JSON String of search fields
     *
     * getRecords
     *
     * @param String jsonString
     * @return String responseData
     */
    @AuraEnabled(cacheable=false)
    public static String getUncachedRecords(String jsonString) {
        be_responsedata responseData = new be_responsedata();
        try {
            Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            responseData.results = getData(jsonMap);
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }
        //system.debug(responseData.getJsonString());
        return responseData.getJsonString();
    }

    /**
     * Returns JSON String of search fields
     *
     * getRecords
     *
     * @param String jsonString
     * @return String responseData
     */
    @AuraEnabled(cacheable=false)
    public static String upsertRecord(String jsonString) {
        be_responsedata responseData = new be_responsedata();
        try {
            Map < String, Object > jsonMap = (Map < String, Object >) JSON.deserializeUntyped(jsonString);
            responseData.results = upsertData(jsonMap);
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }
        //system.debug(responseData.getJsonString());
        return responseData.getJsonString();
    }

    /**
     * Returns JSON String of search fields
     *
     * getRecords
     *
     * @param String jsonString
     * @return String responseData
     */
    @AuraEnabled(cacheable=false)
    public static String deleteRecord(String jsonString) {
        be_responsedata responseData = new be_responsedata();
        try {
            Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            responseData.results = deleteData(jsonMap);
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
        String objType = String.escapeSingleQuotes((String) jsonMap.get('object'));
        String query = getQuery(jsonMap);
        if (be_utilities.fieldNotEmpty(jsonMap, 'searchField')) {
            String searchField = String.escapeSingleQuotes((String) jsonMap.get('searchField'));
        }
        String searchTerm = '';

        if (be_utilities.fieldNotEmpty(jsonMap, 'searchTerm')) {
            searchTerm = String.escapeSingleQuotes((String) jsonMap.get('searchTerm'));
        }

        if (be_utilities.fieldNotEmpty(jsonMap, 'queryFields')) {
            String queryString =  (String) jsonMap.get('queryFields');

            String[] queryList = queryString.split('\\,');
            Map<String, Object> objRow = new Map<String, Object>();
            List <SObject > objecRecords = new List<SObject>();
            for (SObject obj: Database.query(query)) {
                objecRecords.add(obj);
            }
            objRow.put(objType, objecRecords);
            data.add(objRow);
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
     * Unmarshals Json Map for construction of dynamic soql for retreiving object values
     *
     * getData
     *
     * @param Map < String, Object > jsonMap
     * @return Map < String, Object >
     */
    private static Map < String, Object > upsertData(Map < String, Object > jsonMap) {
        Map<String, Object> objDetails = (Map<String, Object>) jsonMap.get('objDetails');
        SObject updateObject = (SObject) JSON.deserialize( JSON.serialize( be_utilities.addFieldNamespaces(objDetails) ) ,  SObject.class );
        Database.upsert(updateObject);
        return new Map < String, Object > {
                'data' => updateObject
        };
    }

    /**
     * Unmarshals Json Map for construction of dynamic soql for retreiving object values
     *
     * getData
     *
     * @param Map < String, Object > jsonMap
     * @return Map < String, Object >
     */
    private static Map < String, Object > deleteData(Map < String, Object > jsonMap) {
        Map<String, Object> objDetails = (Map<String, Object>) jsonMap.get('objDetails');
        SObject deleteObject = (SObject) JSON.deserialize( JSON.serialize( be_utilities.addFieldNamespaces(objDetails) ) ,  SObject.class );
        Database.delete(deleteObject);
        return new Map < String, Object > {
                'data' => deleteObject
        };
    }
}