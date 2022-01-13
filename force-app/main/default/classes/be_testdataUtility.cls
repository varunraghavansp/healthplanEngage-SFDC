/**
 * Created by varun on 10/23/2019.
 */

@IsTest
public class be_testdataUtility {

    /*
     * This method creates a user with the given profile name and username
     * @param  Profile name and username
     * @return User record
     */
    public static user createUser(string profile, string username) {
        username = Math.random() + username;
        user newUser;
        Profile userProfile = [select Name from Profile where Name = : profile];
        newUser = new User(alias = 'test', email = 'one@testorg.com', emailencodingkey = 'UTF-8', lastname = profile + ' User', languagelocalekey = 'en_US', city = 'Stow', country = 'United States', localesidkey = 'en_US', profileid = userProfile.Id, timezonesidkey = 'America/Los_Angeles', username = username);
        insert newUser;
        return newUser;
    }


    /**
    * Creates unique guid
    *
    * createNewGuid
    *
    * @param  void void
    * @return String h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
    */
    public static String createNewGuid() {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        return h.SubString(0, 8) + '-' + h.SubString(8, 12);
    }


    /**
    * Returns a random number String
    *
    * generateRandomNumber
    *
    * @param  Integer len
    * @return String h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
    */
    public static String generateRandomNumber(Integer len) {
        final String chars = '0123456789';
        String randStr = '';
        while (randStr.length() < len){
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx + 1);
        }
        return randStr;
    }
}