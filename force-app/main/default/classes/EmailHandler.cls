public class EmailHandler 
{
      public static void sendTriggerEmail (List<TaskCs__c> taskId,map<id,TaskCs__c> tskmap)
      { 
        Set<Id> sIds = new Set<Id>(); 
        try {
            for(TaskCs__c ts : taskId){
                sIds.add(ts.Assigned_To__c);
            }  
              
            if(tskmap !=null)
            {
                for(TaskCs__c tc :tskmap.values()) {
                    sIds .add(tc.Assigned_To__c);
                   // System.debug('tc'+tc);
                }
            }
            map<id,User> pmap2 = new map<id,User>([select id,email from User Where id IN: sIds]);
            //System.debug('pmap2 :::'+pmap2 );
            User tmm1;
            
            for(Id ids :sIds ){
                tmm1 = pmap2.get(ids);
            }
            String userEmail1 = tmm1.email; // This is the Path Where I can get the Email Id of the TaskCs__c(user)
            System.debug('userEmail'+userEmail1);
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {userEmail1}; 
            System.debug('toAddresses'+toAddresses);
            email.setToAddresses(toAddresses); 
            email.setSubject('Automated email: Task created & updated'); 
            String body = 'Task created & updated' ; 
            email.setPlainTextBody(body); 
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
        }
        
        catch(Exception de){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,de.getmessage()));    
        }       
      }
}