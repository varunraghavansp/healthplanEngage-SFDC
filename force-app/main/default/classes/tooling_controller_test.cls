/**
 * Created by varun on 6/28/2019.
 */
@IsTest(SeeAllData=true)
public class tooling_controller_test {

    static testMethod  void getPicklistValues_Positive(){
        Test.startTest();
        String jsonString;
        String jsonResponse;
        String isSuccess;
        Map<String, Object> jsonMap;
        jsonString = '{"objecttype":"Account","picklistfield":"Type"}';
        jsonResponse = tooling_controller.getPicklistValues(jsonString);
        jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonResponse);
        isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        //System.assertEquals(isSuccess, 'true');
        Test.stopTest();
    }

    static testMethod  void getRecordType_Positive(){
        Test.startTest();
        String jsonString;
        String jsonResponse;
        String isSuccess;
        Map<String, Object> jsonMap;
        jsonString = '{"objecttype":"Contact","recordType":"Authorized_Contact"}';
        jsonResponse = tooling_controller.getRecordTypeId(jsonString);
        jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonResponse);
        system.debug(jsonMap);
        isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        //System.assertEquals(isSuccess, 'true');
        Test.stopTest();
    }

    static testMethod void getAccountRecords_Positive(){
        Test.startTest();
        Account accnt = new Account(Name = 'Long John Silvers LLC', Phone = '3016249985', Sic = '333');
        Database.insert(accnt);
        String jsonString = '{'
                + '"object": "Account",'
                + '"queryFields": "Name,Phone,Sic",'
                + '"filter": "Id IN (\'' + accnt.Id + '\')"'
                + '}';
        String jsonData = tooling_controller.getRecords(jsonString);
        System.debug(jsonData);
        Map < String, Object > jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonData);
        String isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        //System.assertEquals(isSuccess,'true');
        Test.stopTest();
    }

    static testMethod void createContact_Positive(){
        Test.startTest();
        String jsonString;
        String jsonResponse;
        String isSuccess;
        Map < String, Object > jsonMap;
        jsonString = createContactData();
        jsonResponse = tooling_controller.commitRecords(jsonString);
        jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonResponse);
        isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        //System.assertEquals(isSuccess,'true');
        Test.stopTest();
    }

    /*static testMethod void createGroupQuote_Positive(){
        Test.startTest();
        String jsonString;
        String jsonResponse;
        String isSuccess;
        Map < String, Object > jsonMap;
        jsonString = groupquoteflowdata();
        jsonResponse = tooling_controller.commitRecords(jsonString);
        jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonResponse);
        isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        System.assertEquals(isSuccess,'true');
        Test.stopTest();
    }*/

    static testMethod void createAgency_Positive(){
        Test.startTest();
        String jsonString;
        String jsonResponse;
        String isSuccess;
        Map < String, Object > jsonMap;
        Account accnt = new Account(Name = 'Long John Silvers LLC', Phone = '3016249985', Sic = '333');
        Database.insert(accnt);
        jsonString = createAgencyTestData(accnt.Id);
        jsonResponse = tooling_controller.commitRecords(jsonString);
        jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonResponse);
        isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        //System.assertEquals(isSuccess,'true');
        Test.stopTest();
    }

   /* static testMethod  void calculateRates_Positive(){
        Test.startTest();
        String jsonString;
        String jsonResponse;
        String isSuccess;
        Map < String, Object > jsonMap;
        List<Contact> contacts;
        //Add Group Contact
        jsonString = createContactData();
        jsonResponse = tooling_controller.commitRecords(jsonString);
        jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonResponse);
        isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        System.assertEquals(isSuccess,'true');
        contacts =  (List<Contact>) JSON.deserialize(JSON.serialize((List<Object>) ((Map<String,Object>) ((List<Object>) ((Map<String, Object>) jsonMap.get('results')).get('data'))[0]).get('contact')), List<Contact>.class);
        // Create Prospect
        Account accnt = new Account(Name = 'Long John Silvers LLC', Phone = '3016249985', Sic = '333',Account_Status__c='Prospect');
        Database.insert(accnt);
        Opportunity opty = new Opportunity(Name='Test_New_Opty',AccountId=accnt.Id,StageName='Prospecting',CloseDate=Date.parse('07/01/2019'));
        Database.insert(opty);
        // Create Quote
        jsonString = calculateRatesTestData(opty.Id);
        jsonResponse = tooling_controller.calculateRates(jsonString);
        System.debug(jsonResponse);
        jsonMap = (Map < String, Object > ) JSON.deserializeUntyped(jsonResponse);
        isSuccess = String.valueOf(jsonMap.get('isSuccess'));
        System.assertEquals(isSuccess,'true');
        Test.stopTest();
    }*/

    static String createContactData(){
        String contactData = '['
                + '{'
                + '"taskdevname":"contactsfrmcmp",'
                + '"objectTyp":"contact",'
                + '"object":['
                + '{'
                + '"Id":"",'
                + '"Salutation":"Mr",'
                + '"FirstName":"Abra",'
                + '"LastName":"Cadabra",'
                + '"Birthdate":"1986-07-01",'
                + '"Contact_Status__c":"Active",'
                + '"Phone":"3016249985",'
                + '"MobilePhone":"",'
                + '"MailingStreet":"9201 First Fields Rd.",'
                + '"MailingState":"FL",'
                + '"MailingCountry":"USA",'
                + '"MailingCity":"Hialeah",'
                + '"MailingPostalCode":"a014P00001tiRTgQAM",'
                + '"Description":"",'
                + '"Contact_Type__c":"Executive",'
                + '"Email":"loganhopkins@mail.com"'
                + '}'
                + ']'
                + '}'
                + ']';
        return contactData;
    }

    static String createAgencyTestData(String agencyId){
        String agencyTestData = '['
                + ' {'
                + '   "taskdevname": "New_Agency_Setup",'
                + '   "objectType": "Account",'
                + '   "name": "Agency_Record",'
                + '   "value": {'
                + '     "Id": "' + agencyId + '"'
                + '   },'
                + '   "dataType": "SOBJECT"'
                + ' },'
                + ' {'
                + '   "taskdevname": "Initial_Questionnaire",'
                + '   "objectType": null,'
                + '   "name": "flow_records",'
                + '   "value": null,'
                + '   "dataType": "STRING"'
                + ' }'
                +']';
        return agencyTestData;
    }

   /* static String calculateRatesTestData(String opportunityId){
        String calculateRatesInput = '{'
                +'  "quotecensus": ['
                +'    {'
                +'      "Task_GUId__c": "d60dbe2e-c465-3433-c686-b1c657ee0a29",'
                +'      "Employee_Number__c": "A001",'
                +'      "First_Name__c": "Mark",'
                +'      "Last_Name__c": "Levingston",'
                +'      "Date_Of_Birth__c": "1986-11-09T00:00:00.000Z",'
                +'      "Gender__c": "Male",'
                +'      "Relation__c": "Self",'
                +'      "Tobacco_Use__c": false,'
                +'      "Status__c": "Active"'
                +'    },'
                +'    {'
                +'      "Task_GUId__c": "d60dbe2e-c465-3433-c686-b1c657ee0a29",'
                +'      "Employee_Number__c": "A001",'
                +'      "First_Name__c": "Jane",'
                +'      "Last_Name__c": "Levingston",'
                +'      "Date_Of_Birth__c": "1986-11-11",'
                +'      "Gender__c": "Female",'
                +'      "Relation__c": "Spouse",'
                +'      "Tobacco_Use__c": false,'
                +'      "Status__c": "Active"'
                +'    },'
                +'    {'
                +'      "Task_GUId__c": "d60dbe2e-c465-3433-c686-b1c657ee0a29",'
                +'      "Employee_Number__c": "A001",'
                +'      "First_Name__c": "Jacob",'
                +'      "Last_Name__c": "Levingston",'
                +'      "Date_Of_Birth__c": "2010-05-05",'
                +'      "Gender__c": "Male",'
                +'      "Relation__c": "Dependent",'
                +'      "Tobacco_Use__c": false,'
                +'      "Status__c": "Active"'
                +'    },'
                +'    {'
                +'      "Task_GUId__c": "d60dbe2e-c465-3433-c686-b1c657ee0a29",'
                +'      "Employee_Number__c": "A002",'
                +'      "First_Name__c": "Fred",'
                +'      "Last_Name__c": "Therou",'
                +'      "Date_Of_Birth__c": "1989-03-04",'
                +'      "Gender__c": "Male",'
                +'      "Relation__c": "Self",'
                +'      "Tobacco_Use__c": false,'
                +'      "Status__c": "Active"'
                +'    },'
                +'    {'
                +'      "Task_GUId__c": "d60dbe2e-c465-3433-c686-b1c657ee0a29",'
                +'      "Employee_Number__c": "A002",'
                +'      "First_Name__c": "Katie",'
                +'      "Last_Name__c": "Therou",'
                +'      "Date_Of_Birth__c": "1990-06-07",'
                +'      "Gender__c": "Female",'
                +'      "Relation__c": "Spouse",'
                +'      "Tobacco_Use__c": false,'
                +'      "Status__c": "Active"'
                +'    }'
                +'  ],'
                +'  "ratingregion": "Miami-Dade",'
                +'  "product": ['
                +'    {'
                +'      "attributes": {'
                +'        "type": "Product2",'
                +'        "url": "/services/data/v43.0/sobjects/Product2/01tf4000003OnOEAA0"'
                +'      },'
                +'      "Id": "01tf4000003OnOEAA0",'
                +'      "Name": "Small Group Achieve $6000/12000 Ded 30%",'
                +'      "Business_Package_ID__c": "Small Group Achieve MB700",'
                +'      "ProductCode": "[COINS30,DED6000/12000]",'
                +'      "Line_of_Business__c": "HMO",'
                +'      "Business_Type__c": "Commercial SG"'
                +'    },'
                +'    {'
                +'      "attributes": {'
                +'        "type": "Product2",'
                +'        "url": "/services/data/v43.0/sobjects/Product2/01tf4000003OnOIAA0"'
                +'      },'
                +'      "Id": "01tf4000003OnOIAA0",'
                +'      "Name": "Small Group Agility $500/1000 Ded",'
                +'      "Business_Package_ID__c": "Small Group Agility MG 100",'
                +'      "ProductCode": "[DED500/1000]",'
                +'      "Line_of_Business__c": "POS",'
                +'      "Business_Type__c": "Commercial SG"'
                +'    }'
                +'  ],'
                +'  "ratingmethodology": "Member Level Rating",'
                +'  "effectivedate": "2019-07-01",'
                +'  "opportunityid": "' + opportunityId + '"'
                +'}';
        return calculateRatesInput;
    }*/

   /* static String groupquoteflowdata(){
        String grpQuoteFlowInput = '['
                + '  {'
                + '     "taskdevname":"Create_Group_Quote",'
                + '     "objectType":"Contact",'
                + '     "name":"Contact_Records",'
                + '     "value":['
                + '        {'
                + '           "Contact_Status__c":"Active",'
                + '           "Email":"rogerjameson@stoneworks.cin",'
                + '           "Phone":"3016249985",'
                + '           "Contact_Type__c":"Billing Contact",'
                + '           "attributes":{'
                + '              "type":"Contact",'
                + '              "url":"/services/data/v46.0/sobjects/Contact/0034P00002YIb6xQAD"'
                + '           },'
                + '           "Id":"0034P00002YIb6xQAD",'
                + '           "Name":"Roger Jameson"'
                + '        }'
                + '     ],'
                + '     "dataType":"SOBJECT"'
                + '  },'
                + '  {'
                + '     "taskdevname":"Create_Group_Quote",'
                + '     "objectType":"Quote",'
                + '     "name":"Employer_Group_Quote",'
                + '     "value":{'
                + '        "OpportunityId":"0064P00000lfv53QAA",'
                + '        "ba_EffectiveDate__c":"2019-08-01T00:00:00.000Z",'
                + '        "Id":""'
                + '     },'
                + '     "dataType":"SOBJECT"'
                + '  },'
                + '  {'
                + '     "taskdevname":"Create_Group_Quote",'
                + '     "objectType":"Account",'
                + '     "name":"Group_Record",'
                + '     "value":{'
                + '        "Termination_Reason__c_values":['
                + '           {'
                + '              "value":"Sales/VP Request",'
                + '              "label":"Sales/VP Request"'
                + '           },'
                + '           {'
                + '              "value":"Non receipt of license",'
                + '              "label":"Non receipt of license"'
                + '           },'
                + '           {'
                + '              "value":"Non receipt of E&O",'
                + '              "label":"Non receipt of E&O"'
                + '           },'
                + '           {'
                + '              "value":"No longer doing business with us",'
                + '              "label":"No longer doing business with us"'
                + '           },'
                + '           {'
                + '              "value":"Transfer",'
                + '              "label":"Transfer"'
                + '           },'
                + '           {'
                + '              "value":"Deceased",'
                + '              "label":"Deceased"'
                + '           },'
                + '           {'
                + '              "value":"Retired",'
                + '              "label":"Retired"'
                + '           },'
                + '           {'
                + '              "value":"Unethical business practice",'
                + '              "label":"Unethical business practice"'
                + '           },'
                + '           {'
                + '              "value":"Agency Request",'
                + '              "label":"Agency Request"'
                + '           },'
                + '           {'
                + '              "value":"Other",'
                + '              "label":"Other"'
                + '           },'
                + '           {'
                + '              "value":"Unknown",'
                + '              "label":"Unknown"'
                + '           },'
                + '           {'
                + '              "value":"Missing CE requirements",'
                + '              "label":"Missing CE requirements"'
                + '           },'
                + '           {'
                + '              "value":"No active business",'
                + '              "label":"No active business"'
                + '           }'
                + '        ],'
                + '        "BillingCity":null,'
                + '        "Effective_Date__c":"2019-08-01T00:00:00.000Z",'
                + '        "Website":null,'
                + '        "Account_Status__c":"Prospect",'
                + '        "Sic":null,'
                + '        "Rating_Zip__c":"a014P00001tiRTgQAM",'
                + '        "Name":"Roger Stoneworks",'
                + '        "TIN_EIN__c":null,'
                + '        "Agency__c":"0014P00002Arvx2QAB",'
                + '        "BillingCountry":null,'
                + '        "BillingStreet":null,'
                + '        "Termination_Origin__c_values":['
                + '           {'
                + '              "value":"Agency Request",'
                + '              "label":"Agency Request"'
                + '           },'
                + '           {'
                + '              "value":"Other",'
                + '              "label":"Other"'
                + '           },'
                + '           {'
                + '              "value":"Sr. Management Request",'
                + '              "label":"Sr. Management Request"'
                + '           },'
                + '           {'
                + '              "value":"Legal Request",'
                + '              "label":"Legal Request"'
                + '           },'
                + '           {'
                + '              "value":"Business Process",'
                + '              "label":"Business Process"'
                + '           },'
                + '           {'
                + '              "value":"Agent Request",'
                + '              "label":"Agent Request"'
                + '           },'
                + '           {'
                + '              "value":"Department of Financial Services",'
                + '              "label":"Department of Financial Services"'
                + '           },'
                + '           {'
                + '              "value":"Non-Renewal",'
                + '              "label":"Non-Renewal"'
                + '           }'
                + '        ],'
                + '        "Agent__c":"0034P00002YHpRgQAL",'
                + '        "Legal_Entity_Name__c":"Roger Stoneworks LLC",'
                + '        "Phone":"3016249985",'
                + '        "Termination_Date__c":null,'
                + '        "Rating_City__c":"Hialeah",'
                + '        "Id":"0014P00002AsyZGQAZ",'
                + '        "Billing_Zipcode_Lookup__c":null,'
                + '        "Termination_Reason__c":null,'
                + '        "Fax":null,'
                + '        "BillingState":null,'
                + '        "Rating_County__c":"Miami-Dade"'
                + '     },'
                + '     "dataType":"SOBJECT"'
                + '  },'
                + '  {'
                + '     "taskdevname":"Create_Group_Quote",'
                + '     "objectType":"Quote_Census__c",'
                + '     "name":"Quote_Census",'
                + '     "value":['
                + '        {'
                + '           "Employee_Number__c":"A001",'
                + '           "Task_GUId__c":"9354b696cd4e7f95db2828a253b916c4dc3444b-1d0f",'
                + '           "Tobacco_Use__c":false,'
                + '           "Date_Of_Birth__c":"1986-11-09T00:00:00.000Z",'
                + '           "First_Name__c":"David",'
                + '           "Gender__c":"Male",'
                + '           "Relation__c":"Self",'
                + '           "Status__c":"Active",'
                + '           "Last_Name__c":"Wilkinson"'
                + '        },'
                + '        {'
                + '           "Employee_Number__c":"A001",'
                + '           "Task_GUId__c":"9354b696cd4e7f95db2828a253b916c4dc3444b-1d0f",'
                + '           "Tobacco_Use__c":false,'
                + '           "Date_Of_Birth__c":"1986-11-11T00:00:00.000Z",'
                + '           "First_Name__c":"Jane",'
                + '           "Gender__c":"Female",'
                + '           "Relation__c":"Spouse",'
                + '           "Status__c":"Active",'
                + '           "Last_Name__c":"Wilkinson"'
                + '        },'
                + '        {'
                + '           "Employee_Number__c":"A001",'
                + '           "Task_GUId__c":"9354b696cd4e7f95db2828a253b916c4dc3444b-1d0f",'
                + '           "Tobacco_Use__c":false,'
                + '           "Date_Of_Birth__c":"2010-05-05T00:00:00.000Z",'
                + '           "First_Name__c":"Jacob",'
                + '           "Gender__c":"Male",'
                + '           "Relation__c":"Dependent",'
                + '           "Status__c":"Active",'
                + '           "Last_Name__c":"Wilkinson"'
                + '        },'
                + '        {'
                + '           "Employee_Number__c":"A002",'
                + '           "Task_GUId__c":"9354b696cd4e7f95db2828a253b916c4dc3444b-1d0f",'
                + '           "Tobacco_Use__c":false,'
                + '           "Date_Of_Birth__c":"1989-03-04T00:00:00.000Z",'
                + '           "First_Name__c":"Henry",'
                + '           "Gender__c":"Male",'
                + '           "Relation__c":"Self",'
                + '           "Status__c":"Active",'
                + '           "Last_Name__c":"Caville"'
                + '        },'
                + '        {'
                + '           "Employee_Number__c":"A002",'
                + '           "Task_GUId__c":"9354b696cd4e7f95db2828a253b916c4dc3444b-1d0f",'
                + '           "Tobacco_Use__c":false,'
                + '           "Date_Of_Birth__c":"1990-06-07T00:00:00.000Z",'
                + '           "First_Name__c":"Nancy",'
                + '           "Gender__c":"Female",'
                + '           "Relation__c":"Spouse",'
                + '           "Status__c":"Active",'
                + '           "Last_Name__c":"Caville"'
                + '        }'
                + '     ],'
                + '     "dataType":"SOBJECT"'
                + '  },'
                + '  {'
                + '     "taskdevname":"Create_Group_Quote",'
                + '     "objectType":"Quote_Line_Census__c",'
                + '     "name":"Quote_Line_Census",'
                + '     "value":['
                + '        {'
                + '           "01t4P000002z1ujQAA":['
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A001",'
                + '                 "Name":"David Wilkinson",'
                + '                 "MemberDOB__c":"1986-11-09",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Male",'
                + '                 "Relation__c":"Self",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":32,'
                + '                 "Rate__c":397.7,'
                + '                 "FamilyRate__c":1052.58'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A001",'
                + '                 "Name":"Jane Wilkinson",'
                + '                 "MemberDOB__c":"1986-11-11",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Female",'
                + '                 "Relation__c":"Spouse",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":32,'
                + '                 "Rate__c":397.7,'
                + '                 "FamilyRate__c":1052.58'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A001",'
                + '                 "Name":"Jacob Wilkinson",'
                + '                 "MemberDOB__c":"2010-05-05",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Male",'
                + '                 "Relation__c":"Dependent",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":9,'
                + '                 "Rate__c":257.18,'
                + '                 "FamilyRate__c":1052.58'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A002",'
                + '                 "Name":"Henry Caville",'
                + '                 "MemberDOB__c":"1989-03-04",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Male",'
                + '                 "Relation__c":"Self",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":30,'
                + '                 "Rate__c":381.56,'
                + '                 "FamilyRate__c":757.74'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A002",'
                + '                 "Name":"Nancy Caville",'
                + '                 "MemberDOB__c":"1990-06-07",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Female",'
                + '                 "Relation__c":"Spouse",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":29,'
                + '                 "Rate__c":376.18,'
                + '                 "FamilyRate__c":757.74'
                + '              }'
                + '           ],'
                + '           "01t4P000002z1uiQAA":['
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A001",'
                + '                 "Name":"David Wilkinson",'
                + '                 "MemberDOB__c":"1986-11-09",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Male",'
                + '                 "Relation__c":"Self",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":32,'
                + '                 "Rate__c":419.16,'
                + '                 "FamilyRate__c":1109.38'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A001",'
                + '                 "Name":"Jane Wilkinson",'
                + '                 "MemberDOB__c":"1986-11-11",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Female",'
                + '                 "Relation__c":"Spouse",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":32,'
                + '                 "Rate__c":419.16,'
                + '                 "FamilyRate__c":1109.38'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A001",'
                + '                 "Name":"Jacob Wilkinson",'
                + '                 "MemberDOB__c":"2010-05-05",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Male",'
                + '                 "Relation__c":"Dependent",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":9,'
                + '                 "Rate__c":271.06,'
                + '                 "FamilyRate__c":1109.38'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A002",'
                + '                 "Name":"Henry Caville",'
                + '                 "MemberDOB__c":"1989-03-04",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Male",'
                + '                 "Relation__c":"Self",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":30,'
                + '                 "Rate__c":402.16,'
                + '                 "FamilyRate__c":798.65'
                + '              },'
                + '              {'
                + '                 "attributes":{'
                + '                    "type":"Quote_Line_Census__c"'
                + '                 },'
                + '                 "EmployeeNumber__c":"A002",'
                + '                 "Name":"Nancy Caville",'
                + '                 "MemberDOB__c":"1990-06-07",'
                + '                 "TobbaccoUsage__c":false,'
                + '                 "CensusEffectiveDate__c":"2019-08-01",'
                + '                 "MemberGender__c":"Female",'
                + '                 "Relation__c":"Spouse",'
                + '                 "Status__c":"Pending",'
                + '                 "Age__c":29,'
                + '                 "Rate__c":396.49,'
                + '                 "FamilyRate__c":798.65'
                + '              }'
                + '           ]'
                + '        }'
                + '     ],'
                + '     "dataType":"SOBJECT"'
                + '  },'
                + '  {'
                + '     "taskdevname":"Create_Group_Quote",'
                + '     "objectType":"Product2",'
                + '     "name":"Selected_Products",'
                + '     "value":['
                + '        {'
                + '           "Line_of_business__c":"POS",'
                + '           "Business_Package_ID__c":"Small Group Agility LG200",'
                + '           "ProductCode":"[DED1000IN/3000OUT]",'
                + '           "Business_Type__c":"Commercial SG",'
                + '           "attributes":{'
                + '              "type":"Product2",'
                + '              "url":"/services/data/v46.0/sobjects/Product2/01t4P000002z1uiQAA"'
                + '           },'
                + '           "Id":"01t4P000002z1uiQAA",'
                + '           "Name":"Small Group Agility $1000IN/3000OUT Ded"'
                + '        },'
                + '        {'
                + '           "Line_of_business__c":"HMO",'
                + '           "Business_Package_ID__c":"Small Group Achieve MS 100",'
                + '           "ProductCode":"[COINS0,DED1000/2000]",'
                + '           "Business_Type__c":"Commercial SG",'
                + '           "attributes":{'
                + '              "type":"Product2",'
                + '              "url":"/services/data/v46.0/sobjects/Product2/01t4P000002z1ujQAA"'
                + '           },'
                + '           "Id":"01t4P000002z1ujQAA",'
                + '           "Name":"Small Group Achieve $1000/2000 Ded 0%"'
                + '        }'
                + '     ],'
                + '     "dataType":"SOBJECT"'
                + '  },'
                + '  {'
                + '     "taskdevname":"Create_Group_Quote",'
                + '     "objectType":null,'
                + '     "name":"context_record_id",'
                + '     "value":"0014P00002AsyZGQAZ",'
                + '     "dataType":"STRING"'
                + '  }'
                +']';
                return grpQuoteFlowInput;
    }*/

}