global class LeadProcessor implements Database.Batchable <SObject> {
    
    //Start Method
    global Database.QueryLocator Start(Database.BatchableContext bc) {
        
        String Query = 'SELECT Id, LeadSource FROM Lead';
        return Database.getQueryLocator(Query);
    }
    
    //Execute Method
    global void execute(Database.BatchableContext bc, List<Lead> scope) {
        
        if(scope != null && !scope.isEmpty()) {
            
            for(Lead L : scope) {
                
            	L.LeadSource = 'DreamForce';
            }
            
            update scope;
        }
    }
    //Finish Method
    global void finish(Database.BatchableContext bc) {
        Id BatchId = bc.getJobId();
        system.debug('BatchId::'+ BatchId);
    }

}