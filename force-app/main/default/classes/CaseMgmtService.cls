@RestResource(urlMapping='/CaseManagement/v1/*')
global with sharing class CaseMgmtService  
{

    /**
     * Post method used to create case and attachment
     **/
    @HttpPost
    global static String attachPic(){
        RestRequest req = RestContext.request;
        RestResponse res = Restcontext.response;
        Case c =new Case();

    /**
     * Retrieveing details from the url
     **/
        String name = req.params.get('name');
        if (name != null) {
        c.Subject= name;
        } 
        String status = req.params.get('status');
        if (status != null) {
        c.status= status;
        } 

    /**
     * Case Inserted
     **/

       Database.insert(c);


        /**
     * Attachment insertion for the case
     **/
        Blob picture = req.requestBody;
        Attachment a = new Attachment (ParentId = c.Id,
                                       Body = picture,
                                       ContentType = 'image/jpg',
                                       Name = 'VehiclePicture');
        insert a;
        return a.Id;
   }
}