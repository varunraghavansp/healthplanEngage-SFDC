public with sharing class IHA_ShoppingCartController {


    @AuraEnabled(Cacheable=true)
    public static IHAShoppingCartInfoWrapper getAllShoppingDetails(){
        IHAShoppingCartInfoWrapper shoppingCartInfo = new IHAShoppingCartInfoWrapper();
        List<Marketing_Plan__c> marketingPlansList = new List<Marketing_Plan__c>();
        Integer lowDeductible = 0;
        Integer highDeductible = 0;
        Map<String, String> planTypeFilter = new Map<String, String>();
        Map<String, String> metalLevelFilter = new Map<String, String>();
        Map<String, String> planFamilyFilter = new Map<String, String>();
        Map<String, Integer> deductibleLowHigh = new Map<String, Integer>();
        Map<Id,Map<String,String>> marketingPlanDisplayBenefits = new Map<Id,Map<String, String>>();
        Map<Id, List<Marketing_Plan_Benefit__c>> allMarketingPlanBenefits = new Map<Id, List<Marketing_Plan_Benefit__c>>();
        Map<Id,Boolean> isConfigurable = new Map<Id,Boolean>();

        try{
            Map<ID, Marketing_Plan__c> mktPlansMap = new Map<ID, Marketing_Plan__c>([SELECT Id, Name, Plan_Family__c, Plan_Template__c, Plan_Family_Name__c, Plan_Type__c, Effective_Date__c, Termination_Date__c, Status__c FROM Marketing_Plan__c ]);
            Map<Id, Plan_Family__c> planFamilyById = new Map<Id, Plan_Family__c> ([SELECT Id,(SELECT Id, Is_Base_Component__c FROM Plan_Components__r WHERE Is_Base_Component__c=FALSE LIMIT 1) FROM Plan_Family__c]);

            //Set Is Configurable Or Not Map
            for(Marketing_Plan__c mktPlan : mktPlansMap.values()){
                if (isConfigurable.containsKey(mktPlan.Id)){
                    //Do Nothing
                }else{
                    Plan_Family__c planFamily = planFamilyById.get(mktPlan.Plan_Family__c);
                    if(planFamily.Plan_Components__r.size() > 0){
                        isConfigurable.put(mktPlan.Id, true);
                    }else{
                        isConfigurable.put(mktPlan.Id, false);
                    }
                }
            }
            if(mktPlansMap!=null && !mktPlansMap.isEmpty()) {
                marketingPlansList = mktPlansMap.values();
            }
            shoppingCartInfo.totalMKTPlans = marketingPlansList.size();
            //Set Type & Family Filter Values
            for(Marketing_Plan__c marketingplan : mktPlansMap.values()){
                planTypeFilter.put(marketingplan.Plan_Type__c, marketingplan.Plan_Type__c);
                planFamilyFilter.put(marketingplan.Plan_Family_Name__c, marketingplan.Plan_Family_Name__c);
            }
            for(Marketing_Plan_Benefit__c mktPlanDisplayBenefit: [SELECT Id, Marketing_Plan_Name__c,Marketing_Plan__c, In_Network_Value__c, Attribute_Category__c, Attribute_Code__c, Attribute_Display_Name__c, In_Network_Display_Name__c, Out_Of_Network_Display_Value__c, Is_Key_Display_Benefit__c FROM Marketing_Plan_Benefit__c WHERE  Marketing_Plan__c IN : mktPlansMap.keySet() ORDER BY Marketing_Plan__c,Attribute_Code__c ]) {
                if (mktPlanDisplayBenefit.Is_Key_Display_Benefit__c == true){
                    if(mktPlanDisplayBenefit.Attribute_Code__c == 'DED') {
                        //Set Low and high deductible filters
                        if (Integer.valueOf(mktPlanDisplayBenefit.In_Network_Value__c) < lowDeductible) {
                            lowDeductible = Integer.valueOf(mktPlanDisplayBenefit.In_Network_Value__c);
                        }
                        if (Integer.valueOf(mktPlanDisplayBenefit.In_Network_Value__c) > highDeductible) {
                            highDeductible = Integer.valueOf(mktPlanDisplayBenefit.In_Network_Value__c);
                        }
                    }
                    //Set Key Display Benefits Map for Each of the Marketing Plans
                    if(marketingPlanDisplayBenefits.containsKey(mktPlanDisplayBenefit.Marketing_Plan__c)) {
                        Map<String, String> planDisplayBenefit = marketingPlanDisplayBenefits.get(mktPlanDisplayBenefit.Marketing_Plan__c);
                        planDisplayBenefit.put(mktPlanDisplayBenefit.Attribute_Display_Name__c, mktPlanDisplayBenefit.In_Network_Display_Name__c);
                        marketingPlanDisplayBenefits.put(mktPlanDisplayBenefit.Marketing_Plan__c,planDisplayBenefit);
                    } else {
                        Map<String, String> planDisplayBenefit = new Map<String, String>();
                        planDisplayBenefit.put(mktPlanDisplayBenefit.Attribute_Display_Name__c, mktPlanDisplayBenefit.In_Network_Display_Name__c);
                        marketingPlanDisplayBenefits.put(mktPlanDisplayBenefit.Marketing_Plan__c,planDisplayBenefit);
                    }
                }
                //Append to List of Marketing Plan Benefit for Marketing Plan
                if(allMarketingPlanBenefits.containsKey(mktPlanDisplayBenefit.Marketing_Plan__c)) {
                    List<Marketing_Plan_Benefit__c> currentPlanBenefits = allMarketingPlanBenefits.get(mktPlanDisplayBenefit.Marketing_Plan__c);
                    currentPlanBenefits.add(mktPlanDisplayBenefit);
                    allMarketingPlanBenefits.put(mktPlanDisplayBenefit.Marketing_Plan__c, currentPlanBenefits);
                }else{
                    List<Marketing_Plan_Benefit__c> currentPlanBenefits = new List<Marketing_Plan_Benefit__c>();
                    currentPlanBenefits.add(mktPlanDisplayBenefit);
                    allMarketingPlanBenefits.put(mktPlanDisplayBenefit.Marketing_Plan__c, currentPlanBenefits);
                }

            }

            deductibleLowHigh.put('Low', lowDeductible);
            deductibleLowHigh.put('High', highDeductible);
            shoppingCartInfo.isConfigurable = isConfigurable;
            shoppingCartInfo.marketingPlanDisplayBenefits = marketingPlanDisplayBenefits;
            shoppingCartInfo.planTypeFilter = planTypeFilter;
            shoppingCartInfo.planFamilyFilter = planFamilyFilter;
            shoppingCartInfo.deductibleLowHigh = deductibleLowHigh;
            shoppingCartInfo.marketingPlans = marketingPlansList;
            shoppingCartInfo.metalLevelFilter = metalLevelFilter;
            shoppingCartInfo.allMarketingPlanBenefits = allMarketingPlanBenefits;

        }
        catch(Exception ex) {
        System.debug('exception occured:::::'+ex.getMessage());
            shoppingCartInfo.errorMsg = System.Label.Internal_Error;
        }
        return shoppingCartInfo;
    }

    @AuraEnabled(cacheable=true)
    public static List<Marketing_Plan__c> getMarketingPlans(Integer limitSize, Integer offset) {
        List<Marketing_Plan__c> marketingPlansList = new List<Marketing_Plan__c>();
        try {
            marketingPlansList = [SELECT Id, Name, Plan_Family__c, Plan_Template__c, Plan_Family_Name__c, Plan_Type__c, Effective_Date__c, Termination_Date__c, Status__c FROM Marketing_Plan__c ORDER BY CreatedDate LIMIT :limitSize OFFSET: offset];
        } catch(Exception ex) {
            System.debug('exception occured:::::'+ex.getMessage());
        }
        return marketingPlansList;
    }


    //Inner class returns the ShoppingPlanBenefits
    public class IHAShoppingCartInfoWrapper {
        @AuraEnabled
        public Integer totalMKTPlans; //Total Number of Marketing Plans
        @AuraEnabled
        public Map<Id,Map<String,String>> marketingPlanDisplayBenefits; //Map of the Key Display Benefits on the card for each MarketingPlan <<MarketingPlanId>,<AttributeDisplayName,AttributeDisplayValue>>
        @AuraEnabled
        public List<Marketing_Plan__c> marketingPlans; // Offset Marketing Plans
        @AuraEnabled
        public Map<Id,List<Marketing_Plan_Benefit__c>> allMarketingPlanBenefits; //Map of All Marketing Plan Benefits By Marketing Plan Id
        @AuraEnabled
        public Map<String, String> planTypeFilter; // Plan Types Filter
        @AuraEnabled
        public Map<Id, Boolean> isConfigurable; // sets Component Configurability
        @AuraEnabled
        public Map<String, String> metalLevelFilter; // Metal Level Filter
        @AuraEnabled
        public Map<String, String> planFamilyFilter; // Metal Level Filter
        @AuraEnabled
        public Map<String, Integer> deductibleLowHigh; // Deductible High and Low Map [{'Low',0},{'High',10,000}]
        @AuraEnabled
        public String errorMsg;//error message in case there are no Marketing Plan Benefits or Exception occured.
    }

}