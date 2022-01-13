public with sharing class IHA_CompareMKTPlansController {

    @AuraEnabled(cacheable=true)
    public static MKTPlanBenefitsResponseWrapper getMarketingPlanBenefits(List<String> marketingplanids) {
        MKTPlanBenefitsResponseWrapper mktPlanBenefitsResWrap = new MKTPlanBenefitsResponseWrapper();
        Map<String,List<Marketing_Plan_Benefit__c>>  attrCatToMKTPBMap = new Map<String,List<Marketing_Plan_Benefit__c>>();
        List<Marketing_Plan__c> marketingPlansList = new List<Marketing_Plan__c>();
        Map<String,List<String>> attrCatToAttrDispNameMap = new Map<String,List<String>>();
        String querySOQL = '';
        System.debug(marketingplanids.size());
        if(marketingplanids != null && marketingplanids.size() > 0){
            querySOQL = 'Select Id, Name FROM Marketing_Plan__c WHERE Id IN (\'' + String.join(marketingplanids, '\',\'') + '\')';
            system.debug(querySOQL);
        }else{
            querySOQL = 'SELECT Id, Name FROM Marketing_Plan__c LIMIT 5';
        }

        try {
            List<Marketing_Plan__c> marketingPlanList = Database.query(querySOQL);
            Map<ID, Marketing_Plan__c> mktPlansMap = new Map<ID, Marketing_Plan__c>();
            for(Marketing_Plan__c marketingPlan : marketingPlanList){
                mktPlansMap.put(marketingPlan.Id, marketingPlan);
            }
            //Map<ID, Marketing_Plan__c> mktPlansMap = new Map<ID, Marketing_Plan__c>([SELECT Id, Name FROM Marketing_Plan__c LIMIT 5]);
            if(mktPlansMap!=null && !mktPlansMap.isEmpty()) {
                for(Marketing_Plan_Benefit__c mktPlanBenefit: [SELECT Id, Marketing_Plan_Name__c, 
                                                            Attribute_Category__c, Attribute_Display_Name__c, 
                                                            In_Network_Display_Name__c, Out_Of_Network_Display_Value__c 
                                                            FROM Marketing_Plan_Benefit__c 
                                                            WHERE Marketing_Plan__c IN : mktPlansMap.keySet()]) {
                    if(attrCatToMKTPBMap.containsKey(mktPlanBenefit.Attribute_Category__c)) {
                        List<Marketing_Plan_Benefit__c> mktPlanBenefitsList = attrCatToMKTPBMap.get(mktPlanBenefit.Attribute_Category__c);
                        mktPlanBenefitsList.add(mktPlanBenefit);
                        attrCatToMKTPBMap.put(mktPlanBenefit.Attribute_Category__c,mktPlanBenefitsList);

                        //attribute category to attribute display name map.
                        if(!attrCatToAttrDispNameMap.get(mktPlanBenefit.Attribute_Category__c).contains(mktPlanBenefit.Attribute_Display_Name__c)) {
                            List<String> attrDispNameList = attrCatToAttrDispNameMap.get(mktPlanBenefit.Attribute_Category__c);
                            attrDispNameList.add(mktPlanBenefit.Attribute_Display_Name__c);
                            attrCatToAttrDispNameMap.put(mktPlanBenefit.Attribute_Category__c,attrDispNameList);
                        }
                    } else {
                        attrCatToMKTPBMap.put(mktPlanBenefit.Attribute_Category__c,new List<Marketing_Plan_Benefit__c>{mktPlanBenefit});
                        attrCatToAttrDispNameMap.put(mktPlanBenefit.Attribute_Category__c,new List<String>{mktPlanBenefit.Attribute_Display_Name__c});
                    }
                    
                    if(mktPlansMap!=null && !mktPlansMap.isEmpty()) {
                        marketingPlansList = mktPlansMap.values();
                    }                                  
                }
                mktPlanBenefitsResWrap.attrCategoryToMKTPBMap = attrCatToMKTPBMap;
                mktPlanBenefitsResWrap.attrCatToAttrDispNameMap = attrCatToAttrDispNameMap;
                mktPlanBenefitsResWrap.marketingPlans = marketingPlansList;
                //count the total Marketing Plans.
                mktPlanBenefitsResWrap.totalMKTPlans = marketingPlansList.size();
            }
            if(attrCatToMKTPBMap.isEmpty()) {
                System.debug(System.Label.No_MKT_Plan_Benefits_Available);
                mktPlanBenefitsResWrap.errorMsg = System.Label.No_MKT_Plan_Benefits_Available;
            }
        } catch(Exception ex) {
            System.debug('exception occured:::::'+ex.getMessage());
            mktPlanBenefitsResWrap.errorMsg = System.Label.Internal_Error;
        }
        return mktPlanBenefitsResWrap;
    }
    
    //Inner class returns the Marketing Plan Benefits.
    public class MKTPlanBenefitsResponseWrapper {
        @AuraEnabled
        public Map<String,List<Marketing_Plan_Benefit__c>> attrCategoryToMKTPBMap;//attribute category to MKT Plan Benefits.
        @AuraEnabled
        public Map<String,List<String>> attrCatToAttrDispNameMap;//attribute Category to attribute display name map.
        @AuraEnabled
        public List<Marketing_Plan__c> marketingPlans;//Marketing Plans
        @AuraEnabled
        public Integer totalMKTPlans;//total number of Marketing Plans
        @AuraEnabled
        public String errorMsg;//error message in case there are no Marketing Plan Benefits or Exception occured.
    }

}