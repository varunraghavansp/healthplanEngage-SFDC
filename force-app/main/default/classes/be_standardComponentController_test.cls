/**
 * Created by varun on 10/14/2019.
 */

@SuppressWarnings('ApexUnresolvableReference')
@IsTest
private class be_standardComponentController_test {

    static testMethod void getPlanFamilyRecords_Positive() {
        Test.startTest();
        Plan_Family__c planFamily = new Plan_Family__c(Name = 'iDirectSilver', Brand__c = 'IHA', Business_Type__c = 'Individual');
        Database.insert(planFamily);
        String jsonString = '{'
                + '"object": "Plan_Family__c",'
                + '"queryFields": "Name,Age_Off_Criteria__c,Brand__c,Business_Type__c",'
                + '"filter": "Id IN (\'' + planFamily.Id + '\')"'
                + '}';
        String jsonData = be_standardComponentController.getRecords(jsonString);
        System.debug(jsonData);
        Map < String, Object > jsonMap = (Map < String, Object >) JSON.deserializeUntyped(jsonData);
        String isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        System.assertEquals(isSuccess, 'true');
        Test.stopTest();
    }


    static testMethod void getPlanFamily_FLSCheckNegative() {
        Plan_Family__c planFamily = new Plan_Family__c(Name = 'iDirectSilver', Brand__c = 'IHA', Business_Type__c = 'Individual');
        Database.insert(planFamily);
        User newUser = be_testdataUtility.createUser('Chatter Free User', 'stestUser1@mail.com');
        System.runAs(newUser) {
            Test.startTest();
            String jsonString = '{'
                    + '"object": "Plan_Family__c",'
                    + '"queryFields": "Name,Age_Off_Criteria__c,Brand__c,Business_Type__c",'
                    + '"filter": "Id IN (\'' + planFamily.Id + '\')"'
                    + '}';
            String jsonData = be_standardComponentController.getRecords(jsonString);
            System.debug(jsonData);
            Map < String, Object > jsonMap = (Map < String, Object >) JSON.deserializeUntyped(jsonData);
            String isSuccess = String.valueOf(jsonMap.get('isSuccess'));
            System.assertEquals(isSuccess, 'false');
            Test.stopTest();
        }
    }

    static testMethod void getPlanFamily_Negative() {
        Plan_Family__c planFamily = new Plan_Family__c(Name = 'iDirectSilver', Brand__c = 'IHA', Business_Type__c = 'Individual');
        Database.insert(planFamily);
        Test.startTest();
        String jsonString = '{'
                + '"object": "Plan_Family__c",'
                + '"queryFields": "ForceError",'
                + '"filter": "Id IN (\'' + planFamily.Id + '\')"'
                + '}';
        String jsonData = be_standardComponentController.getRecords(jsonString);
        System.debug(jsonData);
        Map < String, Object > jsonMap = (Map < String, Object >) JSON.deserializeUntyped(jsonData);
        String isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        System.assertEquals(isSuccess, 'false');
        Test.stopTest();
    }

    static testMethod void getUncachedPlanFamily_Positive() {
        Test.startTest();
        Plan_Family__c planFamily = new Plan_Family__c(Name = 'iDirectSilver', Brand__c = 'IHA', Business_Type__c = 'Individual');
        Database.insert(planFamily);
        String jsonString = '{'
                + '"object": "Plan_Family__c",'
                + '"queryFields": "Name,Age_Off_Criteria__c,Brand__c,Business_Type__c",'
                + '"filter": "Id IN (\'' + planFamily.Id + '\')"'
                + '}';
        String jsonData = be_standardComponentController.getUncachedRecords(jsonString);
        System.debug(jsonData);
        Map < String, Object > jsonMap = (Map < String, Object >) JSON.deserializeUntyped(jsonData);
        String isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        System.assertEquals(isSuccess, 'true');
        Test.stopTest();
    }

    static testMethod void getUncachedPlanFamily_Negative() {
        Plan_Family__c planFamily = new Plan_Family__c(Name = 'iDirectSilver', Brand__c = 'IHA', Business_Type__c = 'Individual');
        Database.insert(planFamily);
        Test.startTest();
        String jsonString = '{'
                + '"object": "Plan_Family__c",'
                + '"queryFields": "ForceError",'
                + '"filter": "Id IN (\'' + planFamily.Id + '\')"'
                + '}';
        String jsonData = be_standardComponentController.getRecords(jsonString);
        System.debug(jsonData);
        Map < String, Object > jsonMap = (Map < String, Object >) JSON.deserializeUntyped(jsonData);
        String isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        System.assertEquals(isSuccess, 'false');
        Test.stopTest();
    }

    static testMethod void test_getSObjectFields() {
        String jsonString = '{"object": "Plan_Family__c"}';

        Test.startTest();
        String responseString = be_standardComponentController.getSObjectFields(jsonString);
        Test.stopTest();

        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(responseString);
        //system.debug(response);
        System.assertEquals(true, response.get('isSuccess'));
    }

    static testMethod void test_getSObjectFields_FLSCheckNegative() {
        String jsonString = '{"object": "Plan_Family__c"}';
        User newUser = be_testdataUtility.createUser('Chatter Free User', 'stestUser1@mail.com');
        System.runAs(newUser) {
            Test.startTest();
            String responseString = be_standardComponentController.getSObjectFields(jsonString);
            Test.stopTest();

            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(responseString);
            //system.debug(response);
            System.assertEquals(false, response.get('isSuccess'));
        }
    }

    static testMethod void test_getSObjectFields_negative() {
        String jsonString = '{"object": "forceerror"}';

        Test.startTest();
        String responseString = be_standardComponentController.getSObjectFields(jsonString);
        Test.stopTest();

        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(responseString);
        //system.debug(response);
        System.assertEquals(false, response.get('isSuccess'));
    }

    static testMethod void getPicklistValues() {
        String jsonString = '{"object":"Plan_Family__c","picklistfield":"Business_Type__c"}';
        Test.startTest();
        String responseString = be_standardComponentController.getPicklistValues(jsonString);
        Test.stopTest();
        //system.debug(response);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(responseString);
        System.assertEquals(true, response.get('isSuccess'));
    }

    static testMethod void getPicklistValues_FLSCheckNegative() {
        String jsonString = '{"object":"Plan_Family__c","picklistfield":"Business_Type__c"}';
        User newUser = be_testdataUtility.createUser('Chatter Free User', 'stestUser1@mail.com');
        System.runAs(newUser) {
            Test.startTest();
            String responseString = be_standardComponentController.getPicklistValues(jsonString);
            Test.stopTest();
            //system.debug(response);
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(responseString);
            System.assertEquals(false, response.get('isSuccess'));
        }
    }

    static testMethod void getPicklistValues_negative() {
        String jsonString = '{"object":"forceerror","picklistfield":"Business_Type__c"}';
        Test.startTest();
        String responseString = be_standardComponentController.getPicklistValues(jsonString);
        Test.stopTest();
        //system.debug(response);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(responseString);
        System.assertEquals(false, response.get('isSuccess'));
    }

    static testMethod void getPicklistValues_negativenoobject() {
        String jsonString = '{"sobject":"","picklistfield":""}';
        Test.startTest();
        String responseString = be_standardComponentController.getPicklistValues(jsonString);
        Test.stopTest();
        //system.debug(response);
        Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(responseString);
        System.assertEquals(false, response.get('isSuccess'));
    }


}