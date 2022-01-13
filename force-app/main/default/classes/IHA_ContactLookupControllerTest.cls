/**
 * Created by varun on 2/9/2021.
 */

@IsTest(isParallel=true)
private class IHA_ContactLookupControllerTest {
    @isTest
    static void search_should_return_Contact() {
        List<Id> fixedResults = new List<Id>(2);
        Contact contact = createContact('Test');
        fixedResults.add(contact.Id);
        Test.setFixedSearchResults(fixedResults);
        List<String> selectedIds = new List<String>();

        List<LookupSearchResult> results = IHA_ContactLookupController.search('Tes', selectedIds);

        System.assertEquals(1, results.size());
        System.assertEquals(contact.Id, results.get(0).getId());
    }

    @isTest
    static void getRecentResults() {
        List<Id> fixedResults = new List<Id>(2);
        Contact contact = createContact('Test');
        fixedResults.add(contact.Id);
        Test.setFixedSearchResults(fixedResults);
        List<String> selectedIds = new List<String>();

        List<LookupSearchResult> results = IHA_ContactLookupController.getRecentlyViewed();

    }


    private static Contact createContact(String name) {
        Contact contact = new Contact(FirstName = name, LastName = name);
        insert contact;
        return contact;
    }

}