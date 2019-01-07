public class NlevelTreeController{
  /*  Public Class SharePointFileStructure_v2{
    public String JsonString;
    public String AccountInformationString{get;set;} 
    public List<String> listOfString{get;set;}
    Map<id, List<String>> mapOfFolderPathAndFolder;
    public list<folder__c> folderList;
    
    public SharePointFileStructure_v2(ApexPages.standardController Controller) {
        listOfString =  new  List<String>();
        mapOfFolderPathAndFolder =  new Map<id, List<String>>();
        AccountInformationString ='';
        Id accountsId=Controller.getId(); 
        folderList = new  list<folder__c>();
        JsonString  ='';
        List<String> listOfJsonStrings =  new  List<String>();
        
        Account   Acc = [SELECT id, name FROM Account WHERE id=: accountsId Limit 1];
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'accountsIds :'+Acc ));
        for(folder__c fc :  [SELECT id, name, Parent_Folder__c, Parent_Folder__r.name, sObject_Record_ID__c,Folder_Path__c, (select id, name, Parent_Folder__c,Folder_Path__c, sObject_Record_ID__c from  folders__r order by createddate ) FROM folder__c   order BY createddate limit 1000]){
            listOfString= fc.Folder_Path__c.split('/'); 
            if(listOfString != null   && listOfString.size() > 1){
                if(listOfString[1] ==Acc .Name ) {
                    folderList.add(fc );
                    mapOfFolderPathAndFolder.put(fc.Id,listOfString);
                 }
            }
         }   
        if(mapOfFolderPathAndFolder != null   && mapOfFolderPathAndFolder.size() > 0) {
            for( id ids:mapOfFolderPathAndFolder.keyset()){
                integer order=mapOfFolderPathAndFolder.get(ids).size()-1;
                JsonString  =+'[{';
                JsonString = +ids+',' + order +'text '+mapOfFolderPathAndFolder.get(ids)[mapOfFolderPathAndFolder.get(ids).size()-1];
                //JsonString =+'[{';
                listOfJsonStrings.add(JsonString);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'JsonString :'+JsonString ));
            }
        }
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'folderList :'+folderList ));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'listOfString:'+listOfString));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'mapOfFolderPathAndFolder:'+mapOfFolderPathAndFolder));
        //AccountInformationString = JSON.serialize(listOfJsonStrings);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'listOfJsonStrings:::'+listOfJsonStrings));
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'AccountInformationString :'+ AccountInformationString ));
    }
}*/
}