/**
 * Created by varun on 2/9/2021.
 */

public with sharing class IHA_ContactLookupController {
    private final static Integer MAX_RESULTS = 5;

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> search(String searchTerm, List<String> selectedIds) {
        // Prepare query paramters
        searchTerm += '*';

        // Execute search query
        List<List<SObject>> searchResults = [
                FIND :searchTerm
                IN ALL FIELDS
                        RETURNING
                        Contact(Id, Name, Account.Name WHERE id NOT IN :selectedIds)
                LIMIT :MAX_RESULTS
        ];

        // Prepare results
        List<LookupSearchResult> results = new List<LookupSearchResult>();

        // Extract Contacts & convert them into LookupSearchResult
        String contactIcon = 'standard:contact';
        Contact[] contacts = (List<Contact>) searchResults[0];
        for (Contact contact : contacts) {
            String subtitle = 'Account' + contact.Account.Name == null ? '' : ' • ' + contact.Account.Name;
            results.add(new LookupSearchResult(contact.Id, 'Contact', contactIcon, contact.Name, subtitle));
        }

        // Optionnaly sort all results on title
        results.sort();

        return results;
    }

    @AuraEnabled(Cacheable=true)
    public static List<LookupSearchResult> getRecentlyViewed() {
        List<LookupSearchResult> results = new List<LookupSearchResult>();
        // Get recently viewed records of type Account or Opportunity
        List<RecentlyViewed> recentRecords = [
                SELECT Id, Name, Type,Title
                FROM RecentlyViewed
                WHERE Type = 'Contact'
                ORDER BY LastViewedDate DESC
                LIMIT 5
        ];
        // Convert recent records into LookupSearchResult
        for (RecentlyViewed recentRecord : recentRecords) {
            if (recentRecord.Type == 'Contact') {
                results.add(
                        new LookupSearchResult(
                                recentRecord.Id,
                                'Contact',
                                'standard:contact',
                                recentRecord.Name,
                                'Title • ' + recentRecord.Title
                        )
                );
            }
        }
        return results;
    }
}