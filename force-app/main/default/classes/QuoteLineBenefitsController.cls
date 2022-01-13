/**
 * Created by varun on 2/22/2021.
 */

public with sharing class QuoteLineBenefitsController {

    @AuraEnabled(cacheable=true)
    public static QuoteLineBenefitsResponseWrapper getQuoteLineBenefits(List<String> quoteLineIds) {
        QuoteLineBenefitsResponseWrapper quoteLinePlanBenefitsResWrap = new QuoteLineBenefitsResponseWrapper();
        Map<String,List<Quote_Line_Benefit__c>>  attrCatToQuoteLineBenefitMap = new Map<String,List<Quote_Line_Benefit__c>>();
        List<QuoteLineItem> quoteLinesList = new List<QuoteLineItem>();
        Map<String,List<String>> attrCatToAttrDispNameMap = new Map<String,List<String>>();
        String querySOQL = '';
        System.debug(quoteLineIds.size());
        if(quoteLineIds != null && quoteLineIds.size() > 0){
            querySOQL = 'Select Id, Marketing_Plan_Name__c FROM QuoteLineItem WHERE Id IN (\'' + String.join(quoteLineIds, '\',\'') + '\')';
            system.debug(querySOQL);
        }else{
            querySOQL = 'SELECT Id, Marketing_Plan_Name__c FROM QuoteLineItem LIMIT 5';
        }

        try {
            List<QuoteLineItem> quoteLineList = Database.query(querySOQL);
            Map<ID, QuoteLineItem> quoteLineMap = new Map<ID, QuoteLineItem>();
            for(QuoteLineItem quoteLine : quoteLineList){
                quoteLineMap.put(quoteLine.Id, quoteLine);
            }
            //Map<ID, QuoteLineItem> quoteLineMap = new Map<ID, QuoteLineItem>([SELECT Id, Name FROM QuoteLineItem LIMIT 5]);
            if(quoteLineMap!=null && !quoteLineMap.isEmpty()) {
                for(Quote_Line_Benefit__c quoteLineBenefit: [SELECT Id, Attribute_Code__c,Parent_Quote_Line__c,
                        Attribute_Category__c, Attribute_Display_Name__c,
                        In_Network_Display_Name__c, Out_Of_Network_Display_Value__c, Marketing_Plan_Name__c, Limits_and_Exceptions__c
                FROM Quote_Line_Benefit__c
                WHERE Parent_Quote_Line__c IN : quoteLineMap.keySet()]) {
                    if(attrCatToQuoteLineBenefitMap.containsKey(quoteLineBenefit.Attribute_Category__c)) {
                        List<Quote_Line_Benefit__c> quoteLineBenefitsList = attrCatToQuoteLineBenefitMap.get(quoteLineBenefit.Attribute_Category__c);
                        quoteLineBenefitsList.add(quoteLineBenefit);
                        attrCatToQuoteLineBenefitMap.put(quoteLineBenefit.Attribute_Category__c,quoteLineBenefitsList);

                        //attribute category to attribute display name map.
                        if(!attrCatToAttrDispNameMap.get(quoteLineBenefit.Attribute_Category__c).contains(quoteLineBenefit.Attribute_Display_Name__c)) {
                            List<String> attrDispNameList = attrCatToAttrDispNameMap.get(quoteLineBenefit.Attribute_Category__c);
                            attrDispNameList.add(quoteLineBenefit.Attribute_Display_Name__c);
                            attrCatToAttrDispNameMap.put(quoteLineBenefit.Attribute_Category__c,attrDispNameList);
                        }
                    } else {
                        attrCatToQuoteLineBenefitMap.put(quoteLineBenefit.Attribute_Category__c,new List<Quote_Line_Benefit__c>{quoteLineBenefit});
                        attrCatToAttrDispNameMap.put(quoteLineBenefit.Attribute_Category__c,new List<String>{quoteLineBenefit.Attribute_Display_Name__c});
                    }

                    if(quoteLineMap!=null && !quoteLineMap.isEmpty()) {
                        quoteLinesList = quoteLineMap.values();
                    }
                }
                quoteLinePlanBenefitsResWrap.attrCategoryToMKTPBMap = attrCatToQuoteLineBenefitMap;
                quoteLinePlanBenefitsResWrap.attrCatToAttrDispNameMap = attrCatToAttrDispNameMap;
                quoteLinePlanBenefitsResWrap.quoteLines = quoteLinesList;
                //count the total Marketing Plans.
                quoteLinePlanBenefitsResWrap.totalMKTPlans = quoteLinesList.size();
            }
            if(attrCatToQuoteLineBenefitMap.isEmpty()) {
                System.debug(System.Label.No_MKT_Plan_Benefits_Available);
                quoteLinePlanBenefitsResWrap.errorMsg = System.Label.No_MKT_Plan_Benefits_Available;
            }
        } catch(Exception ex) {
            System.debug('exception occured:::::'+ex.getMessage());
            quoteLinePlanBenefitsResWrap.errorMsg = System.Label.Internal_Error;
        }
        return quoteLinePlanBenefitsResWrap;
    }

    //Inner class returns the Marketing Plan Benefits.
    public class QuoteLineBenefitsResponseWrapper {
        @AuraEnabled
        public Map<String,List<Quote_Line_Benefit__c>> attrCategoryToMKTPBMap;//attribute category to MKT Plan Benefits.
        @AuraEnabled
        public Map<String,List<String>> attrCatToAttrDispNameMap;//attribute Category to attribute display name map.
        @AuraEnabled
        public List<QuoteLineItem> quoteLines;//Marketing Plans
        @AuraEnabled
        public Integer totalMKTPlans;//total number of Marketing Plans
        @AuraEnabled
        public String errorMsg;//error message in case there are no Marketing Plan Benefits or Exception occured.
    }
}