Public class FedtomTrigger{
    /*
    trigger CreateTeamingRequestTaskQuestionnaireTrigger  on TM_TOMA__Task_Order_Contact__c (after insert) {
    
    map<Id,List<TM_TOMA__Task_Order_Contact__c> > mapOfTask2=  new map<Id,List<TM_TOMA__Task_Order_Contact__c>>();
    List<TM_TOMA__Task_Order_Contact__c> listOftaskOrder = new List<TM_TOMA__Task_Order_Contact__c>();
    
    for (TM_TOMA__Task_Order_Contact__c  tsCon : Trigger.new){ 
        if(mapOfTask2.containsKey(tsCon.TM_TOMA__Task_Order__c)){
            listOftaskOrder.add(tsCon);
        }
        else{
            listOftaskOrder = new List<TM_TOMA__Task_Order_Contact__c>();
            listOftaskOrder.add(tsCon);
        }
        mapOfTask2.put(tsCon.TM_TOMA__Task_Order__c,listOftaskOrder);
    } 
    System.debug('mapOfTask2 :::'+mapOfTask2);    
    try{
        if(mapOfTask2 != null && mapOfTask2.size() > 0){
            List<TM_TOMA__Survey_Task__c>  listOfCreateToTeamingQuestionnaire = new List<TM_TOMA__Survey_Task__c >();
            List<TM_TOMA__Survey__c>  listOfTomaQuestionaries =[Select Id,Name from TM_TOMA__Survey__c Where name=: 'Interested Party Questionnaire' limit 1];
            
            for(Id idsOfTaskOrder : mapOfTask2.keySet()) {
                TM_TOMA__Survey_Task__c  toCreateNewtask =  new TM_TOMA__Survey_Task__c ();
                if(listOfTomaQuestionaries != null && listOfTomaQuestionaries.size() > 0) {
                    toCreateNewtask.TM_TOMA__Survey__c =listOfTomaQuestionaries[0].id;
                    toCreateNewtask.TM_TOMA__Task_Order__c = idsOfTaskOrder;
                    listOfCreateToTeamingQuestionnaire.add(toCreateNewtask);
                }
            }
            if(listOfCreateToTeamingQuestionnaire != null && listOfCreateToTeamingQuestionnaire.size() > 0){
                insert listOfCreateToTeamingQuestionnaire;
                
                List<Messaging.SingleEmailMessage> listOfEmails = New  List<Messaging.SingleEmailMessage>();
                
                for(TM_TOMA__Survey_Task__c  tsSurvey : listOfCreateToTeamingQuestionnaire){
                    // Who you are sending the email to
                    if(mapOfTask2.get(tsSurvey.TM_TOMA__Task_Order__c ) != null && mapOfTask2.get(tsSurvey.TM_TOMA__Task_Order__c ).size() >0 ){
                        //System.debug('ListOf contact ::::'+mapOfTaskOrContacts.get(tsSurvey.TM_TOMA__Task_Order__c ).TM_TOMA__Contact__c);
                        for(TM_TOMA__Task_Order_Contact__c  tscon : mapOfTask2.get(tsSurvey.TM_TOMA__Task_Order__c )){
                            if(tscon.TM_TOMA__Receives_Mass_Emails__c == true){
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                mail.setTargetObjectId(tscon.TM_TOMA__Contact__c);
                                // The email template ID used for the email
                                mail.setTemplateId('00X29000000MBYY');//('00X29000000HrOs');
                                mail.setWhatId(tsSurvey.id);    
                                listOfEmails.add(mail);
                                System.debug('listOfEmails::'+listOfEmails);  
                            }
                        }
                    }
                }
                if(listOfEmails != null && listOfEmails.size() > 0){
                    Messaging.SendEmailResult[] results =  Messaging.sendEmail(listOfEmails);
                    if (results[0].success) {
                        System.debug('The email was sent successfully.');
                    } else {
                        System.debug('The email failed to send: '+ results[0].errors[0].message);
                    }
                }
            } 
        } 
    }
    catch(Exception e ) {
        System.debug('Error message of trigger'+e.getMessage());
    }
}*/


/* Trigger of teaming partner and contacts

trigger CreateTeamingPartnerAndContactsTrigger on TM_TOMA__Task_Order__c (after insert) {
    Map<Id,TM_TOMA__Task_Order__c> MapOfContVechTaskIds =  new Map<Id,TM_TOMA__Task_Order__c>();
    try {
        for(TM_TOMA__Task_Order__c tsOrder: Trigger.new){           
            if(tsOrder.TM_TOMA__Contract_Vehicle__c != null)
                MapOfContVechTaskIds.put(tsOrder.TM_TOMA__Contract_Vehicle__c,tsOrder);
        }
        if(MapOfContVechTaskIds  != null && MapOfContVechTaskIds.size() > 0){
            
            //List of new create Teaming partner of task order
            List<TM_TOMA__Teaming_Partner__c> listOfNewTeamingPartner = New List<TM_TOMA__Teaming_Partner__c>();
            
            for(TM_TOMA__Vehicle_Partner__c vcPartner :[Select Id,Name,TM_TOMA__Contract_Vehicle__c,TM_TOMA__Point_of_Contact__c,TM_TOMA__Partner__c,TM_TOMA__Partner__r.name from TM_TOMA__Vehicle_Partner__c Where TM_TOMA__Contract_Vehicle__c In:MapOfContVechTaskIds.keySet()]){
                if(vcPartner.Id != null ){
                    TM_TOMA__Teaming_Partner__c toCreateTeamingPartner = new TM_TOMA__Teaming_Partner__c();
                    toCreateTeamingPartner.TM_TOMA__Vehicle_Partner__c =vcPartner.id;
                    toCreateTeamingPartner.TM_TOMA__Task_Order__c = (MapOfContVechTaskIds.get(vcPartner.TM_TOMA__Contract_Vehicle__c)).Id;
                    listOfNewTeamingPartner.add(toCreateTeamingPartner);
                    //System.debug('Before Insert listOfNewTeamingPartner:'+listOfNewTeamingPartner);
                }
            }
            if(listOfNewTeamingPartner != null && listOfNewTeamingPartner.size() > 0) {
                insert listOfNewTeamingPartner;
                System.debug('after Insert listOfNewTeamingPartner:'+listOfNewTeamingPartner);
            }
            
            //List of new create Task Order Contacts which have main poc or recieve mass email value checked of task order 
            List<TM_TOMA__Task_Order_Contact__c> listOfNewTaskOrderContacts = New List<TM_TOMA__Task_Order_Contact__c>();
            
            for(TM_TOMA__Contract_Vehicle_Contact__c  contVehileContact : [select id,Name,TM_TOMA__Contact__c,TM_TOMA__Main_POC__c,TM_TOMA__Receives_Mass_Emails__c,TM_TOMA__Contract_Vehicle__c From TM_TOMA__Contract_Vehicle_Contact__c where TM_TOMA__Contract_Vehicle__c In:MapOfContVechTaskIds.keySet() And (TM_TOMA__Receives_Mass_Emails__c =:true or TM_TOMA__Main_POC__c =: true)]){
                if(contVehileContact.Id != null ) {
                    TM_TOMA__Task_Order_Contact__c toCreateTsContact = New TM_TOMA__Task_Order_Contact__c();
                    toCreateTsContact.TM_TOMA__Contact__c = contVehileContact.TM_TOMA__Contact__c;
                    toCreateTsContact.TM_TOMA__Task_Order__c =MapOfContVechTaskIds.get(contVehileContact.TM_TOMA__Contract_Vehicle__c ).Id;
                    System.debug('contVehileContact.TM_TOMA__Main_POC__c = '+contVehileContact.TM_TOMA__Main_POC__c);
                    toCreateTsContact.TM_TOMA__Main_POC__c = contVehileContact.TM_TOMA__Main_POC__c;
                    System.debug('contVehileContact.TM_TOMA__Receives_Mass_Emails__c = '+contVehileContact.TM_TOMA__Receives_Mass_Emails__c);
                    toCreateTsContact.TM_TOMA__Receives_Mass_Emails__c =contVehileContact.TM_TOMA__Receives_Mass_Emails__c;
                    toCreateTsContact.IsTrigger_Created__c =True;
                    listOfNewTaskOrderContacts.add(toCreateTsContact);
                    //System.debug('Before Insert listOfNewTaskOrderContacts:'+listOfNewTaskOrderContacts);
                }
            }
            if(listOfNewTaskOrderContacts != null && listOfNewTaskOrderContacts.size() >0){
                insert listOfNewTaskOrderContacts;
                System.debug('After Insert listOfNewTaskOrderContacts:'+listOfNewTaskOrderContacts);
            }
        }
    }
    catch(Exception e){
        System.debug('Error message:::'+e.getMessage());
    }   
}*/
}