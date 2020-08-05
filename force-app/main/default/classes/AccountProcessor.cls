public class AccountProcessor {
    
	@future
	public static void countContacts(List<Id> recordIds) {
    	List<Account> accounts = [SELECT Id, Number_of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN :recordIds];
        
        if (accounts != null && !accounts.isEmpty()) {
            
            for (Account account : accounts) {
                
                account.Number_of_Contacts__c = account.Contacts.size();
            }
            
            update accounts;
        }
  	}

}