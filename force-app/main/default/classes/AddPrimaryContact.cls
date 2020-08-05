public class AddPrimaryContact implements Queueable {
    
    public contact c;
    public String state;
    
    public AddPrimaryContact(Contact c, String state) {
        this.c = c;
        this.state = state;
    }
    
    public void execute(QueueableContext qc) {
        
        system.debug('this.c = '+this.c+' this.state = '+this.state);
        List<Account> accList = new List<account>([SELECT Id, Name, BillingState FROM Account WHERE account.BillingState = :this.state LIMIT 200]);
        List<Contact> contactList = new List<Contact>();
        
        for(account a: accList) {
            
            Contact c = new Contact();
            c = this.c.clone(false, false, false, false);
            c.AccountId = a.Id;
            contactList.add(c);
        }
        
        insert contactList;
    }

}