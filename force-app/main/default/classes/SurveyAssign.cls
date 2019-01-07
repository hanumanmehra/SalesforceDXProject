public class SurveyAssign {
    public List<Survey_Assignment__c> listassign{get;set;}
   // public String assignNumber{get;set;}
    public String QuesId{get;set;}
    //public List<Survey_Format__c> formatlist{get;set;}
    public SurveyAssign(){
        listassign = new List<Survey_Assignment__c>();
        listassign=[Select AssignNumber__c,Name From Survey_Assignment__c];
        //formatlist= new List<Survey_Format__c>();
        System.debug('listassign'+listassign);  
    }
    
}