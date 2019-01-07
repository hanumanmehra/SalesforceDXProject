global class EmailHandlerControllerForAccount implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email,Messaging.InboundEnvelope env){
 
    // Create an InboundEmailResult object for returning the result of the 
    // Apex Email Service
    Account account;
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    System.debug('result  :::: '+result + 'email :::::'+email  +'envelope ::'+env );
    
    Try {
      // Look for account whose name is the subject and create it if necessary
      if ([select count() from Account where Name = :email.subject] == 0) {
        account = new Account();
        account.Name = email.subject;
        insert account;
        System.debug('account 1:::: '+account +'Email subject :::'+email.subject);
      } 
      else {
        account = [select Id from Account where Name = :email.subject];
        System.debug('account 2:::: '+account);
      }
      
      List<Contact>  listofContact =  new List<Contact>();
      // Convert cc'd addresses to contacts
      if((email.ccAddresses) != null)
      {
          for (String address : email.ccAddresses) {
            Contact contact = new Contact();
            Matcher matcher = Pattern.compile('<.+>').matcher(address);
            System.debug('matcher :::: '+matcher );
           
            // Parse addresses to names and emails
            if (matcher.find()) {
              String[] nameParts = address.split('[ ]*<.+>')[0].replace('"', '').split('[ ]+');
             
              contact.FirstName = nameParts.size() > 1 ? nameParts[0] : '';
              contact.LastName = nameParts.size() > 1 ? nameParts[nameParts.size()-1] : nameParts[0];
              contact.Email = matcher.group().replaceAll('[<>]', '');
              
              System.debug('contact 1:::: '+contact);
               listofContact.add(contact);
            } 
            else {
              contact.LastName = address;
              contact.Email = address;
              System.debug('contact 2:::: '+contact);
              listofContact.add(contact);
            }
           
           
            // Add if new
            if ([select count() from Contact where Email = :contact.Email] == 0) {
              contact.AccountId = account.Id;
              listofContact.add(contact);
              System.debug('contact 3:::: '+contact);
            }
             listofContact.add(contact);
         }
         if(listofContact != null && listofContact.size() >0){
             Insert listofContact;
             System.debug('listofContact after insert::::'+listofContact);
         }
      }
    }
   catch (QueryException e) {
       System.debug('Query Issue: ' + e);
   }
   
   // Set the result to true. No need to send an email back to the user 
   // with an error message
   result.success = true;
   
   // Return the result for the Apex Email Service
   return result;
  }
}