/**
 * Created by varun on 6/28/2019.
 */

public with sharing class tooling_controller {

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
        strike_responseData responseData = new strike_responseData();
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
    * Returns Picklist Values
    *
    * getRecords
    *
    * @param String jsonString
    * @return String responseData
    */
    @AuraEnabled
    public static String getPicklistValues(String jsonString)
    {
        strike_responseData responseData = new strike_responseData();
        Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
        String objectType;
        String picklistField;
        try{
            String nameSpacePrefix = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;
            List<Map<String, String>> options = new List<Map<String, String>>();
            if (fieldNotEmpty(jsonMap, 'objecttype') && fieldNotEmpty(jsonMap, 'picklistfield')) {
                objectType = addNamespace(nameSpacePrefix, String.escapeSingleQuotes((String) jsonMap.get('objecttype')));
                picklistField = addNamespace(nameSpacePrefix, String.escapeSingleQuotes((String) jsonMap.get('picklistfield')));
            }
            Schema.SObjectType schemaObject= Schema.getGlobalDescribe().get(objectType);
            Schema.DescribeFieldResult fieldResult = schemaObject.getDescribe().fields.getMap().get(picklistField).getDescribe();

            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry f : ple)
            {
                //System.debug(f.getLabel() + ' ' +  f.getValue());
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
    * Commits Records
    *
    * commit records based on flow type
    *
    * @param String jsonString
    * @return String responseData
    */
    @AuraEnabled
    public static String commitRecords(String jsonString) {
        strike_responseData responseData = new strike_responseData();
        jsonString = jsonString.replace('T00:00:00.000Z', '');
        try{
            List < Map < String, Object >> data = new List < Map < String, Object >> ();
            List <Object> jsonMap = (List <Object> ) JSON.deserializeUntyped(jsonString);
            if(jsonMap.size() > 0) {
                String taskDevName = String.escapeSingleQuotes((String) ((Map <String, Object>) JSON.deserializeUntyped(JSON.serialize(jsonMap[0]))).get('taskdevname'));
                //For Commiting New Contact Added in Flows
                if (taskDevName == 'contactsfrmcmp') {
                    data = commitContact(jsonMap);
                }
                else if(taskDevName =='Create_Group_Quote'){
                    data = flow_controller.create_group_quote(jsonMap);
                }
                else{
                    data = flow_controller.commit_generic(jsonMap);
                }

            }
            responseData.results = new Map < String, Object > {
                    'data' => data
            };
        }
        catch(Exception e){
            System.debug(e.getMessage());
            responseData.addError(e.getMessage());
        }
        return responseData.getJsonString();
    }

    /**
     * Returns JSON String of recordType passing in Object API Name and RecordTypeName
     *
     * getRecords
     *
     * @param String jsonString
     * @return String responseData
     */
    @AuraEnabled
    public static String getRecordTypeId(String jsonString) {
        strike_responseData responseData = new strike_responseData();
        String objectType;
        try {
            Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            if (fieldNotEmpty(jsonMap, 'objecttype') && fieldNotEmpty(jsonMap, 'recordType')) {
                String nameSpacePrefix = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;
                objectType = addNamespace(nameSpacePrefix, String.escapeSingleQuotes((String) jsonMap.get('objecttype')));
                String recordTypeName = String.escapeSingleQuotes((String) jsonMap.get('recordType'));
                Id devRecordTypeId = Schema.getGlobalDescribe().get(objectType).getDescribe().getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
                responseData.results = new Map < String, Object >{
                        'data' => new Map<String, String>{
                                'recordTypeId' => devRecordTypeId
                        }
                };
            }
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }
        return responseData.getJsonString();
    }

    /**
    * Converts JSON List to Object Map
    *
    * commitListToMap
    *
    * @param List<Object> jsonList
    * @return Map<String, Object>
    */
    public static Map<String, Object> commitListToMap(List<Object> jsonList){
        Map<String, Object> commitEntityMap = new Map<String, Object>();
        for (Object obj : jsonList) {
            Map <String, Object> objRecord = (Map <String, Object>) JSON.deserializeUntyped(JSON.serialize(obj));
            String objType = String.escapeSingleQuotes(asNonNullString((String) objRecord.get('objectType')));
            String objName = String.escapeSingleQuotes(asNonNullString((String) objRecord.get('name')));
            String dataType = String.escapeSingleQuotes(asNonNullString((String) objRecord.get('dataType')));
            Object objValue = (Object) objRecord.get('value');
            if(dataType == 'SOBJECT'){
                if (objType == 'Account') {
                    //commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(addFieldNamespaces(objValue)), Account.class));
                }else if(objType == 'Quote'){
                    commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(addFieldNamespaces(objValue)), Quote.class));
                }/*else if(objType =='Quote_Census__c'){
                    commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(Tooling_Controller.addListFieldNamespaces(objValue, false)), List<Quote_Census__c>.class));
                }else if(objType =='Quote_Line_Census__c'){
                   // system.debug(objValue);
                    //commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(Tooling_Controller.addListFieldNamespaces(objValue, false)), List<Quote_Line_Census__c>.class));
                }*/else if(objType =='Product2'){
                    commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(Tooling_Controller.addListFieldNamespaces(objValue, false)), List<Product2>.class));
                }
            }else if(dataType == 'STRING'){
                commitEntityMap.put(objName, asNonNullString((String) objValue));
            }
        }
        return commitEntityMap;
    }

    /**
     * Calculates Rate for Group
     *
     * calculateRate
     *
     * @param String jsonString
     * @return String responseData
     */
    /*@AuraEnabled
    public static String calculateRates(String jsonString) {
        // ToDo Check with Cachable true
        //ToDo Add Account Id to QuoteCensus
        strike_responseData responseData = new strike_responseData();
        try {
            //Workaround to remove appending Timestamp to Date Field
            jsonString = jsonString.replace('T00:00:00.000Z', '');

            Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonString);
            List<Product2> products = (List<Product2>) JSON.deserialize( JSON.serialize(Tooling_Controller.addListFieldNamespaces((Object) jsonMap.get('product'), false)), List<Product2>.class );
            List<Quote_Census__c> quoteCensuses = (List<Quote_Census__c>) JSON.deserialize( JSON.serialize(Tooling_Controller.addListFieldNamespaces((Object) jsonMap.get('quotecensus'), false)), List<Quote_Census__c>.class );
            String ratingMethodology = (String) jsonMap.get('ratingmethodology');
            String ratingRegion = (String) jsonMap.get('ratingregion');
            Date effectiveDate = Date.valueOf((String) jsonMap.get('effectivedate'));
            Set<Id> productIdSet = new Set<Id>();
            for(Product2 product : products){
                productIdSet.add(product.Id);
            }
            Map<String, Object> productRateQuery = new Map<String, Object>();
            productRateQuery.put('productIdSet',productIdSet );
            productRateQuery.put('effectiveDate',effectiveDate );
            productRateQuery.put('ratingRegion',ratingRegion );
            productRateQuery.put('ratingMethodology', ratingMethodology);
            productRateQuery.put('productRateMap', GroupACARateService.getProductRateFlat(productRateQuery) );
            productRateQuery.put('quoteCensuses', quoteCensuses);

            responseData.results = GroupACARateService.calculateACARate(productRateQuery);
        } catch (Exception e) {
            responseData.addError(e.getMessage());
        }
        return responseData.getJsonString();
    }*/

    /**
    * Returns type safe instance of string, mapping null to ''
    *
    * asNonNullString
    *
    * @param  String toSafe
    * @return String toSafe
    */
    public static String asNonNullString(String toSafe) {
        return toSafe == null ? '' : toSafe;
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
        String nameSpacePrefix = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;
        if(nameSpacePrefix == null){
            nameSpacePrefix = '';
        }
        Map<String, Object> objMapwithNS = new Map<String, Object>();
        Map<String, Object> objMap = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(objDetails));
        for (String key : objMap.keySet()) {
            if (objMap.get(key) == null || objMap.get(key) == '') {
                //Ignore Null Tags
            } else {
                if (key.contains(nameSpacePrefix)) {
                    objMapwithNS.put(key, objMap.get(key));
                }else if(key.contains('__c_values')){
                    //Ignore Picklist values added to object for persisting
                }
                else if (key.contains('__c')) {
                    objMapwithNS.put(nameSpacePrefix + key, objMap.get(key));
                }
                else {
                    objMapwithNS.put(key, objMap.get(key));
                }
            }
        }
        return(objMapwithNS);
    }

    /**
    * Adds Org Namespace to List Object Fields
    *
    * addListFieldNamespaces
    *
    * @param Object objDetails
    * @return List<Map<String, Object>>
    */
    public static List<Map<String, Object>> addListFieldNamespaces(Object objDetails, Boolean removeId) {
        //ToDO Check if OrgNamespace specific code is needed
        String nameSpacePrefix = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;
        if(nameSpacePrefix == null){
            nameSpacePrefix = '';
        }
        List<Object> objList = (List<Object>) JSON.deserializeUntyped(JSON.serialize(objDetails));
        Map<String, Object> objMapwithNS = new Map<String, Object>();
        List<Map<String, Object>> objListwithNS = new List<Map<String, Object>>();

        for (Object obj : objList) {
            Map<String, Object> objRecord = (Map<String, Object>) JSON.deserializeUntyped(JSON.serialize(obj));
            objMapwithNS = new Map<String, Object>();
            for (String key : objRecord.keySet()) {
                if (objRecord.get(key) == null || objRecord.get(key) == '') {
                    //Ignore Null Tags
                } else {
                    if (key.contains(nameSpacePrefix + '__')) {
                        objMapwithNS.put(key, objRecord.get(key));
                    }else if(key.contains('__c_values')){
                        //Ignore Picklist values added to object for persisting
                    }
                    else if (key.contains('__c')) {
                        objMapwithNS.put(nameSpacePrefix + '__' + key, objRecord.get(key));
                    }
                    else {
                        objMapwithNS.put(key, objRecord.get(key));
                    }
                }
            }
            if (removeId == true && objMapwithNS.get('Id') != null) {
                objMapwithNS.remove('Id');
            }
            objListwithNS.add(objMapwithNS);
        }
        return(objListwithNS);
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
        System.debug(query);
        if (fieldNotEmpty(jsonMap, 'searchField')) {
            String searchField = String.escapeSingleQuotes((String) jsonMap.get('searchField'));
        }
        String searchTerm = '';

        if (fieldNotEmpty(jsonMap, 'searchTerm')) {
            searchTerm = String.escapeSingleQuotes((String) jsonMap.get('searchTerm'));
        }

        if (fieldNotEmpty(jsonMap, 'queryFields')) {
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
        String nameSpacePrefix = [SELECT NamespacePrefix FROM Organization].NamespacePrefix;
        String obj = tooling_controller.addNamespace(nameSpacePrefix, String.escapeSingleQuotes((String) jsonMap.get('object')));

        if (fieldNotEmpty(jsonMap, 'queryFields')) {
            String queryString =  String.escapeSingleQuotes((String) jsonMap.get('queryFields'));
            String[] queryList = queryString.split(',');
            for(String queryFld : queryList){
                queryFields.add(tooling_controller.addNamespace(nameSpacePrefix, queryFld.trim()));
            }

            if (fieldNotEmpty(jsonMap, 'searchTerm')) {
                String searchField = tooling_controller.addNamespace(nameSpacePrefix, String.escapeSingleQuotes((String) jsonMap.get('searchField')));
                String searchTerm = tooling_controller.addNamespace(nameSpacePrefix, String.escapeSingleQuotes((String) jsonMap.get('searchTerm')));
                if (searchField.contains('Id')) {
                    filters.add(searchField + ' = \'' + searchTerm + '\'');
                }
                //Specific Check for Agency Master Detail Relationship on Commission
                else if(searchField == 'Marketing_Plan__c' || searchField == 'Agency__c' || searchField == 'Commission_Summary__c' || searchField == 'Agent_Commission__c' || searchField == 'Commissions_and_Chargebacks__c'){
                    filters.add(searchField + ' = \'' + searchTerm + '\'');
                }
                else {
                    filters.add(searchField + ' LIKE \'%' + searchTerm + '%\'');
                }
            }
        }

        if (fieldNotEmpty(jsonMap, 'filter')) {
            String filter =  (String) jsonMap.get('filter');
            filters.add('(' + filter + ')');
        }

        if (fieldNotEmpty(jsonMap, 'order')) {
            String orderby = tooling_controller.addNamespace(nameSpacePrefix, String.escapeSingleQuotes((String) jsonMap.get('order')));
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

        if (fieldNotEmpty(jsonMap, 'limit')) {
            query += ' LIMIT ' + String.escapeSingleQuotes((String) jsonMap.get('limit'));
        }

        return query;
    }

        /**
    * Commits a New Contact Created from contactsfrmcmp
    *
    * commitContact
    *
    * @param List <Object> jsonMap
    * @return List < Map < String, Object >> prospectData
    */
    private static List < Map < String, Object >> commitContact(List <Object> jsonMap) {
        List < Map < String, Object >> contactData = new List < Map < String, Object >> ();
        List<Contact> contacts;
        for (Object obj : jsonMap) {
            Map <String, Object> objRecord = (Map <String, Object>) JSON.deserializeUntyped(JSON.serialize(obj));
            String objType = String.escapeSingleQuotes((String) objRecord.get('objectTyp'));
            Object objDetails = (Object) objRecord.get('object');
            if (objType == 'contact') {
                contacts = (List<Contact>) JSON.deserialize(JSON.serialize(tooling_controller.addListFieldNamespaces(objDetails, true)), List<Contact>.class);
                Database.insert(contacts);
            }
        }
        contactData.add(new Map < String, Object >{
                'contact' => contacts
        });

        return contactData;
    }

    /**
 * Checks if json value if string is not empty
 *
 * fieldNotEmpty
 *
 * @param Map < String, Object > jsonMap, String field
 * @return Boolean
 */
    private static Boolean fieldNotEmpty(Map < String, Object > jsonMap, String field) {
        return jsonMap.containsKey(field) && !String.isEmpty((String) jsonMap.get(field));
    }

    /**
    * Adds Org Namespace to Passed in Entity
    *
    * addListFieldNamespaces
    *
    * @param Object objDetails
    * @return List<Map<String, Object>>
    */
    private static String addNamespace(String nameSpace, String obj) {
        if (nameSpace != null) {
            if (obj.contains('__c') || obj.contains('__r')) {
                return nameSpace + '__' + obj;
            } else {
                return obj;
            }
        } else {
            return obj;
        }
    }

}