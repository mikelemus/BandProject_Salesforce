@isTest
public class LeadProcessorTest {
    @testSetup
    static void setup() {
        
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i <200; i++) {
            
        	leads.add(new Lead(LastName = 'LastName'+i, FirstName='FirstName'+i, Email='test'+i+'@test.com', LeadSource='Web', Company='TRP'));
        }
        insert leads;
    }
    
    static testmethod void test() {
        
        Test.startTest();
        LeadProcessor lp =new LeadProcessor();
        Id BatchId = Database.executeBatch(lp);
        Test.stopTest();
        
        System.assertEquals([SELECT count() FROM Lead WHERE LeadSource='DreamForce'], 200);
    }
}