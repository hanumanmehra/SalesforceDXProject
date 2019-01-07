Public Class SharePointFileStructure_v2{
  /*  public String JsonString;
    public String AccountInformationString{get;set;} 
    public List<String> listOfString{get;set;}
    Map<id, List<String>> mapOfFolderPathAndFolder;
    public list<folder__c> folderList;
    public String JsonData{get;set;}
    public Map<id,folder__c> mapOfFolderandFolderIds;
    public  Map<Id,list<folder__c>> mapofParentChildFirstLevel;
    public List<FolderWrapper> listOfFolderWrapper{get;set;}
    
    public SharePointFileStructure_v2(ApexPages.standardController Controller) {
        listOfString =  new  List<String>();
        mapOfFolderPathAndFolder =  new Map<id, List<String>>();
        mapOfFolderandFolderIds = new Map<id,folder__c>();
        AccountInformationString ='';
        Id accountsId=Controller.getId(); 
        folderList = new  list<folder__c>();
        mapofParentChildFirstLevel=  new Map<Id,list<folder__c>> ();
        JsonString  ='';
        List<String> listOfJsonStrings =  new  List<String>();
        listOfFolderWrapper =new List<FolderWrapper>();
        
        Account   Acc = [SELECT id, name FROM Account WHERE id=: accountsId Limit 1];
          
        String recordId = acc.Id;
         if(recordId .length() > 15)
              recordId= recordId .substring(0,15);
              
          list<Folder__c> FolderOrderList =[SELECT id, name, Element_Number__c, Levels__c, Node_Number__c, Parent_Folder__c, Parent_Folder__r.Node_Number__c, sObject_Record_ID__c
                                    FROM Folder__c WHERE Element_Number__c != null AND sObject_Record_ID__c = :recordId  ORDER BY Node_Number__c];  
              
         list<folder__c> parentFolderList = [SELECT id, name, Parent_Folder__c, Parent_Folder__r.name,Levels__c, sObject_Record_ID__c, (select id, name, Parent_Folder__c,Levels__c, sObject_Record_ID__c from  folders__r order by createddate ) FROM folder__c WHERE sObject_Record_ID__c =:recordId order BY createddate limit 1000];
        
         if(parentFolderList  != null && parentFolderList.size() > 0 && parentFolderList[0].folders__r.size() >0){
             for(folder__c parFol:parentFolderList ){
                 mapofParentChildFirstLevel.put(parFol.Id,parFol.folders__r );
             }
         }
        
        for(folder__c fc :  [SELECT id, name, Parent_Folder__c, Parent_Folder__r.name, sObject_Record_ID__c,Levels__c,Folder_Path__c, (select id, name, Parent_Folder__c, Levels__c, Folder_Path__c,  sObject_Record_ID__c from  folders__r order by createddate  ) FROM folder__c  order BY createddate   limit 1000]){
            listOfString= fc.Folder_Path__c.split('/'); 
            if(listOfString != null   && listOfString.size() > 1){
                if(listOfString[1] ==Acc.Name) {  
                    folderList.add(fc );
                    mapOfFolderPathAndFolder.put(fc.Id,listOfString);
                    mapOfFolderandFolderIds .put(fc.Id,fc);
                 }
            }
         } 
         if(folderList != null && folderList.size()  >0) {
             Decimal orderNum=0;
               for(folder__c  fol : folderList ){
                   if(fol.Levels__c ==1){
                      orderNum =+orderNum+ fol.Levels__c;
                   }
                   FolderWrapper fcWrap =  new FolderWrapper();
                   fcWrap.fold =fol;
                   fcWrap.sequenceNo=+String.valueof(orderNum )+'.'+fol.Levels__c ;
                   fcWrap.mainParent = mapOfFolderPathAndFolder.get(fol.Id)[mapOfFolderPathAndFolder.get(fol.Id).size()-2];
                   listOfFolderWrapper.add(fcWrap);
               }
           
         }
         
        
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'FolderOrderList :'+FolderOrderList )); 
         //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'listOfFolderWrapper:'+listOfFolderWrapper)); 
        // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'parentFolderList :'+parentFolderList  +'mapofParentChildFirstLevel'+mapofParentChildFirstLevel)); 
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'mapOfFolderPathAndFolder:'+mapOfFolderPathAndFolder));
        
         
        if(mapOfFolderPathAndFolder != null   && mapOfFolderPathAndFolder.size() > 0) {
            String preFolderName;
            integer count=0;
            integer childCount=0;
            integer size0fPreParent =0;
            integer  sizeOfPreviousChildsOfAllparents =0;
          try{
            // Write data to the JSON string.
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartArray();
            gen.writeStartObject();
            gen.writeNumberField(Acc.Id,1);
            gen.writeStringField('text', Acc.Name);
            gen.writeFieldName('children');
            integer listsize = listOfFolderWrapper.size();
            Boolean isNextchild=false;
            for(FolderWrapper folWr: listOfFolderWrapper){
               // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,' folWr.fold.Name:'+ folWr.fold.Name));
                String nextChildId ;
                if(childCount < listsize-1){
                    nextChildId = listOfFolderWrapper[childCount +1].fold.id;
                }
                integer order=mapOfFolderPathAndFolder.get(folWr.fold.Id).size()-1;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,' order:'+ order));
                  if((preFolderName != null && childCount < listsize-1) ){
                         //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'next child Name'+listOfFolderWrapper[childCount+1].fold.Name)); 
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'present Name'+mapOfFolderPathAndFolder.get(folWr.fold.Id)[order]+'presents  parent child  '+mapOfFolderPathAndFolder.get(nextChildId )[mapOfFolderPathAndFolder.get(nextChildId ).size()-2 ] )); 
                        if(isNextchild  != true){
                             gen.writeStartArray();
                         }
                         gen.writeStartObject();
                         gen.writeNumberField(folWr.fold.Id, childCount+2);
                         gen.writeStringField('text', folWr.fold.Name);
                         if(mapOfFolderPathAndFolder.get(folWr.fold.Id)[order]== mapOfFolderPathAndFolder.get(nextChildId )[mapOfFolderPathAndFolder.get(nextChildId ).size()-2 ] ){
                             if(childCount ==  listsize-2){
                                   gen.writeBooleanField('children', true);
                             }
                             else{
                                 gen.writeFieldName('children');
                             }
                             isNextchild  = false;
                             //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'childCount :'+childCount ));
                         }
                        else{
                            size0fPreParent  = childCount-sizeOfPreviousChildsOfAllparents;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'preFolderName  else of first if when have parent :'+preFolderName +'size0fPreParent  :::'+size0fPreParent )); 
                            gen.writeBooleanField('children', true);
                            for(integer i=0;i<size0fPreParent-1;i++){
                                     gen.writeEndObject();
                                     gen.writeEndArray();
                             }
                            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'size0fPreParent  :'+preFolderName )); 
                            gen.writeEndObject();
                            isNextchild  = true;
    
                            sizeOfPreviousChildsOfAllparents  = sizeOfPreviousChildsOfAllparents  +size0fPreParent ;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'size0fPreParent   after loop:'+size0fPreParent  )); 
                        }
                   
                    preFolderName =  mapOfFolderPathAndFolder.get(folWr.fold.Id)[order];
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'preFolderName  if:'+preFolderName )); 
                    childCount++;
                }
    
                else{
                    if(preFolderName == null){
                        gen.writeStartArray();
                        gen.writeStartObject();
                        gen.writeNumberField(folWr.fold.Id, 2);
                        gen.writeStringField('text', folWr.fold.Name);
                        gen.writeFieldName('children');
                        
                         preFolderName =  mapOfFolderPathAndFolder.get(folWr.fold.Id)[order];
                         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'preFolderName  in else:'+preFolderName )); 
                         childCount++;
                    }
                   //else{
                     //   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'preFolderName not equal null  in else:'+preFolderName )); 
                       // gen.writeEndObject();
                        //isNextchild =true;   
                   
                //}
                count++;
            }  
          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'gen:'+gen)); 
            String pretty = gen.getAsString();
             JsonData =  pretty ;
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'pretty '+pretty )); 
            }
            catch(Exception e){
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'error of pcontroller:'+e.getMessage() +'line number'+e.getLineNumber())); 
            }
        }
    }
     
    public class FolderWrapper{
        public folder__c fold {get;set;}
        public String sequenceNo;
        Public String  mainParent;
        
        public FolderWrapper(){
             sequenceNo= '';
             fold= new folder__c ();
             mainParent ='';
        }
    }*/
}