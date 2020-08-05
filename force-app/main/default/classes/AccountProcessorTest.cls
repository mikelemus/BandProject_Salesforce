@isTest
public class AccountProcessorTest {
    
    @isTest
    public static void testAccountProcessorTest() {
        
        Account a = new Account();
        a.Name = 'Test Account';
        insert a;
        
        Contact c = new Contact();
        c.FirstName = 'Smith';
        c.LastName = 'John';
        c.Email = 'info@test.com';
        c.AccountId = a.Id;
        insert c;
        
        List<Id> accIds = new List<id>();
        accIds.add(a.Id);
        
        Test.startTest();
        	AccountProcessor.countContacts(accIds);
        Test.stopTest();
        
        Account acc = [SELECT Number_of_Contacts__c FROM Account WHERE Id =: a.Id LIMIT 1];
        System.assertEquals(Integer.valueOf(acc.Number_of_Contacts__c), 1);
        
    }

}