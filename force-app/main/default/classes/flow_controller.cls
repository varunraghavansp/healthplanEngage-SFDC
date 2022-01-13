/**
 * Created by varun on 7/1/2019.
 */

public class flow_controller {

    @InvocableMethod(label='Set Quote Line Benefits SG')
    public static void setQuoteLineBenefitsSG(List<Quote> quotes) {
        setQuoteLineRatesSG(quotes);
        Map<Id,Id> qliToMarketingPlanIds = new Map<Id,Id>();
        Map<Id, List<Marketing_Plan_Benefit__c>> marketingPlanToBenefitMap = new Map<Id, List<Marketing_Plan_Benefit__c>>();
        List<Quote_Line_Benefit__c> qliBenefits = new List<Quote_Line_Benefit__c>();
        Set<Id> quoteIds = new Set<Id>();
        for(Quote quote : quotes){
            quoteIds.add(quote.Id);
        }
        List<QuoteLineItem> quoteLineItems = [SELECT Id, Marketing_Plan__c FROM QuoteLineItem WHERE QuoteId IN : quoteIds ];
        for(QuoteLineItem qli : quoteLineItems){
            qliToMarketingPlanIds.put(qli.Id, qli.Marketing_Plan__c);
        }
        //Create a Map of Benefits for each MarketingPlan for mapping to QLI Benefits
        for(Marketing_Plan_Benefit__c mktPlanDisplayBenefit: [SELECT Id, Marketing_Plan_Name__c,Marketing_Plan__c, Out_Of_Network_Display_Value__c,Limits_And_Exceptions__c
        ,Is_Rate_Impacting__c,Is_Key_Benefit__c, Is_Base_Component_Benefit__c, In_Network_Display_Name__c, Component_Type__c, Component_Name__c, Attribute_Value_Amount__c
        , Attribute_Long_Code__c,Attribute_Display_Name__c, Attribute_Code__c, Attribute_Category__c, CPQ_Disp_Sort__c
        FROM Marketing_Plan_Benefit__c WHERE Marketing_Plan__c IN : qliToMarketingPlanIds.values() ]) {
            List<Marketing_Plan_Benefit__c> planBenefits = marketingPlanToBenefitMap.get(mktPlanDisplayBenefit.Marketing_Plan__c);
            if (planBenefits == null ){
                planBenefits = new List<Marketing_Plan_Benefit__c>();
            }
            planBenefits.add(mktPlanDisplayBenefit);
            marketingPlanToBenefitMap.put(mktPlanDisplayBenefit.Marketing_Plan__c, planBenefits);
        }
        //Map MarketingPlanBenefits to QLI Benefits
        for(Id qliId : qliToMarketingPlanIds.keySet()){
            for(Id marketingPlanId : marketingPlanToBenefitMap.keySet()){
                for(Marketing_Plan_Benefit__c marketingPlanBenefitRec : marketingPlanToBenefitMap.get(marketingPlanId)){
                    System.debug(marketingPlanId);
                    system.debug(qliToMarketingPlanIds.get(qliId));
                    if(marketingPlanId == qliToMarketingPlanIds.get(qliId)){

                        Quote_Line_Benefit__c qliBenefit = new Quote_Line_Benefit__c(Parent_Quote_Line__c = qliId, Out_of_Network_Display_Value__c = marketingPlanBenefitRec.Out_Of_Network_Display_Value__c,
                                Limits_and_Exceptions__c = marketingPlanBenefitRec.Limits_And_Exceptions__c, Is_Rate_Impacting__c = marketingPlanBenefitRec.Is_Rate_Impacting__c,Is_Key_Benefit__c = marketingPlanBenefitRec.Is_Key_Benefit__c,
                                Is_Base_Component_Benefit__c = marketingPlanBenefitRec.Is_Base_Component_Benefit__c, In_Network_Display_Name__c = marketingPlanBenefitRec.In_Network_Display_Name__c,
                                Component_Type__c = marketingPlanBenefitRec.Component_Type__c,Component_Name__c = marketingPlanBenefitRec.Component_Name__c,Attribute_Value_Amount__c = marketingPlanBenefitRec.Attribute_Value_Amount__c,
                                Attribute_Long_Code__c = marketingPlanBenefitRec.Attribute_Long_Code__c,Attribute_Display_Name__c = marketingPlanBenefitRec.Attribute_Display_Name__c,Attribute_Code__c = marketingPlanBenefitRec.Attribute_Code__c,Attribute_Category__c= marketingPlanBenefitRec.Attribute_Category__c,
                                CPQ_Disp_Sort__c = marketingPlanBenefitRec.CPQ_Disp_Sort__c);
                        qliBenefits.add(qliBenefit);
                    }

                }
            }

        }
        system.debug(qliBenefits.size());
        insert(qliBenefits);

    }

    public static void setQuoteLineRatesSG(List<Quote> quotes) {
        Map<Id,String> qliToMarketingPlanPackageCodes = new Map<Id,String>();
        Map<String, Base_Rate_Variant__c> packageCodeToBaseRateVariant = new Map<String, Base_Rate_Variant__c>();
        List<Quote_Line_Benefit__c> qliBenefits = new List<Quote_Line_Benefit__c>();
        Set<Id> quoteIds = new Set<Id>();
        for(Quote quote : quotes){
            quoteIds.add(quote.Id);
        }
        List<QuoteLineItem> quoteLineItems = [SELECT Id, Marketing_Plan__c,Marketing_Plan_Package_Code__c, Tier_Code__c, Subscriber__c, Subscriber_And_Spouse__c, Subscriber_And_Child__c, Subscriber_And_Children__c, Subscriber_And_Family__c FROM QuoteLineItem WHERE QuoteId IN : quoteIds ];
        for(QuoteLineItem qli : quoteLineItems){
            qliToMarketingPlanPackageCodes.put(qli.Id, qli.Marketing_Plan_Package_Code__c);
        }

        //Fetch Relevant Base Rate Variants
        for (Base_Rate_Variant__c baseRateVariant : [Select Id, Tier_Code__c, Base_Rate_Schedule__c, Subscriber__c, Subscriber_And_Child__c, Subscriber_And_Children__c, Subscriber_And_Family__c, Subscriber_And_Spouse__c, Variant_Code__c
        FROM Base_Rate_Variant__c WHERE Variant_Code__c IN : qliToMarketingPlanPackageCodes.values()]){
            packageCodeToBaseRateVariant.put(baseRateVariant.Variant_Code__c, baseRateVariant);
        }

        //Map Base Rate Variants to QLI
        for(QuoteLineItem quoteLineItem : quoteLineItems){
            Base_Rate_Variant__c baseRateVariantForQLI = packageCodeToBaseRateVariant.get(qliToMarketingPlanPackageCodes.get(quoteLineItem.Id));
            if(baseRateVariantForQLI != null){
                quoteLineItem.Tier_Code__c = baseRateVariantForQLI.Tier_Code__c;
                quoteLineItem.Subscriber__c = baseRateVariantForQLI.Subscriber__c;
                quoteLineItem.Subscriber_And_Spouse__c = baseRateVariantForQLI.Subscriber_And_Spouse__c;
                quoteLineItem.Subscriber_And_Child__c = baseRateVariantForQLI.Subscriber_And_Child__c;
                quoteLineItem.Subscriber_And_Children__c = baseRateVariantForQLI.Subscriber_And_Children__c;
                quoteLineItem.Subscriber_And_Family__c = baseRateVariantForQLI.Subscriber_And_Family__c;
            }

        }
        update(quoteLineItems);

    }

    /**
   * Generic Commit which returns context object id for navigation
   *
   * commit_generic
   *
   * @param List <Object> jsonMap
   * @return List < Map < String, Object >> returnList
   */
    public static List < Map < String, Object >> commit_generic(List <Object> jsonList) {
        List < Map < String, Object >> returnList = new List < Map < String, Object >> ();
        Map<String, Object> commitEntityMap = commitListToMap(jsonList);
        String contextRecordId = tooling_controller.asNonNullString((String) commitEntityMap.get('context_record_id'));
        //For Navigation Keep Respective Object Id keep as first in response List
        returnList.add(new Map<String, Object>{
                'objectId' => contextRecordId
        });
        return returnList;
    }

    /**
   * Generic Commit which returns context object id for navigation
   *
   * commit_generic
   *
   * @param List <Object> jsonMap
   * @return List < Map < String, Object >> returnList
   */
    public static List < Map < String, Object >> create_group_quote(List <Object> jsonList) {
        List < Map < String, Object >> returnList = new List < Map < String, Object >> ();
        Map<String, Object> commitEntityMap = commitListToMap(jsonList);
        String contextRecordId = tooling_controller.asNonNullString((String) commitEntityMap.get('context_record_id'));
        //For Navigation Keep Respective Object Id keep as first in response List
        returnList.add(new Map<String, Object>{
                'objectId' => contextRecordId
        });
        return returnList;
    }


    /**
    * Converts JSON List to Object Map
    *
    * commitListToMap
    *
    * @param List<Object> jsonList
    * @return Map<String, Object>
    */
    private static Map<String, Object> commitListToMap(List<Object> jsonList){
        Map<String, Object> commitEntityMap = new Map<String, Object>();
        for (Object obj : jsonList) {
            Map <String, Object> objRecord = (Map <String, Object>) JSON.deserializeUntyped(JSON.serialize(obj));
            String objType = String.escapeSingleQuotes(tooling_controller.asNonNullString((String) objRecord.get('objectType')));
            String objName = String.escapeSingleQuotes(tooling_controller.asNonNullString((String) objRecord.get('name')));
            String dataType = String.escapeSingleQuotes(tooling_controller.asNonNullString((String) objRecord.get('dataType')));
            Object objValue = (Object) objRecord.get('value');
            if(dataType == 'SOBJECT'){
                if (objType == 'Account') {
                    //commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(addFieldNamespaces(objValue)), Account.class));
                }else if(objType == 'Quote'){
                    commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(tooling_controller.addFieldNamespaces(objValue)), Quote.class));
                }else if(objType =='Quote_Census__c'){
                    //commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(tooling_controller.addListFieldNamespaces(objValue, false)), List<Quote_Census__c>.class));
                }else if(objType =='Quote_Line_Census__c'){
                    // system.debug(objValue);
                    //commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(Tooling_Controller.addListFieldNamespaces(objValue, false)), List<Quote_Line_Census__c>.class));
                }else if(objType =='Product2'){
                    commitEntityMap.put(objName, JSON.deserialize(JSON.serialize(tooling_controller.addListFieldNamespaces(objValue, false)), List<Product2>.class));
                }
            }else if(dataType == 'STRING'){
                commitEntityMap.put(objName, tooling_controller.asNonNullString((String) objValue));
            }
        }
        return commitEntityMap;
    }
}