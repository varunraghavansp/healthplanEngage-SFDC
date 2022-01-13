/**
 * Created by varun on 1/5/2021.
 */

@IsTest
private class flow_controller_test {
    @IsTest(SeeAllData=true)
    static void testQlIBenefitInsert_Positive() {
        List<Quote> quotes = new List<Quote>();
        quotes.add(new Quote(Id = '0Q04x000000h2LZCAY'));
        flow_controller.setQuoteLineBenefitsSG(quotes);
    }

    @IsTest(SeeAllData=true)
    static void testsetQuoteLineRatesSG_Positive() {
        List<Quote> quotes = new List<Quote>();
        quotes.add(new Quote(Id = '0Q04x000000h2LZCAY'));
        flow_controller.setQuoteLineRatesSG(quotes);
    }
}