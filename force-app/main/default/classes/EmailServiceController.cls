global class EmailServiceController implements Messaging.InboundEmailHandler
{
    //Overriding handleInboundEmail Method of Messaging.InboundEmailHandler to process email message and to insert records based on it.
global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope)
{
 
List<Handle_Attachment__c> customSetting = [Select DoctorPatient__object_Name__c,DoctorPatient__FieldName__c,DoctorPatient__field_value__c from Handle_Attachment__c Limit 1] ;
 
if(customSetting != null && customSetting.size() > 0) {
 
//Map having all object exists in organization.
Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();
 
SObjectType objType = gd.get(customSetting[0].DoctorPatient__object_Name__c ) ;
 
String fldValue = customSetting[0].Field_Value__c ;
 
List<Sobject> parentRecord = Database.query(' Select Id,'+customSetting[0].DoctorPatient__FieldName__c +' from '+objType +' where '+customSetting[0].DoctorPatient__FieldName__c +'= :fldValue Limit 1') ;
 
    if(parentRecord != null && parentRecord.size() > 0) 
    {
     
        List<Attachment> attachmentToInsert = new List<Attachment>();
     
        //Fetching Binary attachment from Email and adding them to attachmentToInsert list
        if (email.binaryAttachments != null && email.binaryAttachments.size() > 0) 
        {
            for (Integer i = 0 ; i < email.binaryAttachments.size() ; i++) 
            {
                Attachment attachment = new Attachment();
                attachment.ParentId = parentRecord[0].Id;
                attachment.Name = email.binaryAttachments[i].filename;
                attachment.Body = email.binaryAttachments[i].body;
                attachmentToInsert.add(attachment) ;
                System.debug('attachment'+attachment);
            }
        }
     
        //Fetching Text attachment from Email and adding them to attachmentToInsert list
        if (email.textAttachments != null && email.textAttachments.size() > 0) 
        {
            for (Integer i = 0 ; i < email.textAttachments.size() ; i++) {
            Attachment attachment = new Attachment();
            attachment.ParentId = parentRecord[0].Id;
            attachment.Name = email.textAttachments[i].filename;
            attachment.Body = Blob.valueOf(email.textAttachments[i].body);
            attachmentToInsert.add(attachment) ;
            System.debug('attachment2::'+attachment);
            }
        }
     
        // Inserting Attachmets
        if(attachmentToInsert.size() > 0)
        insert attachmentToInsert ;
        }
    }
    return new Messaging.InboundEmailresult();
    }
}