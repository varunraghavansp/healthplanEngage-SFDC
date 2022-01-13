/**
 * Created by varun on 1/7/2021.
 */

@IsTest
private class IHA_CompareMKTPlansController_Test {
    @IsTest(SeeAllData=true)
    static void IHA_CompareMKTPlans_Positive() {
        List<String> marketingplanids = new List<String>();
        //marketingplanids.add('a1M4x000000eLldEAE');
        //marketingplanids.add('1M4x000000eNPhEAM');
        IHA_CompareMKTPlansController.MKTPlanBenefitsResponseWrapper mktPlanBenefitsResWrap = IHA_CompareMKTPlansController.getMarketingPlanBenefits(marketingplanids);
        system.debug(mktPlanBenefitsResWrap);
    }
}