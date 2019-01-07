public with sharing class FbIntegration {
     public Blob file {get; set;}
     public String fileId {get; set;}
     public String fileType {get; set;}
     public String fileName {get; set;}
     //public List<GoogleDriveWrapper> driveWrapperList {get; set;}  
     
     //Private data member Fatched from url
     String id = '';
     String url = '';
     String code = '';
     String title = '';
     String accessToken = '';
     //Set<GoogleDriveWrapper> driveWrapperSet = new Set<GoogleDriveWrapper>();
     
     String secret = '8dc80af9393f5fd254eded11aa2f5e67';
     String redirect_uri = 'https://doctorpatient.ap2.visual.force.com/apex/FbIntegrationPage';
     String clientkey = '118376561889348';
    
    
    
    public FbIntegration(){
         //Initialize
        file = null;
        fileType = '';
        fileName = '';
       System.debug('1111');
        
        code = ApexPages.currentPage().getParameters().get('code'); 
        System.debug('code1 ::'+code); 
        //Get the access token once we have code  
        if(code != '' && code != null)
        {  
          System.debug('code'+code); 
            AccessToken();
        }
       
    } 
    
    public void authantication()
    {    
         System.debug('22222');
        HttpRequest  req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint('https://www.facebook.com/oauth/access_token?client_id=118376561889348&redirect_uri=http://salessocial-dev-ed.my.salesforce.com/apex/sts1&client_secret=8dc80af9393f5fd254eded11aa2f5e67');
        HttpResponse res = null;
        http h = new Http();
        res = h.send(req);
        System.debug('333'+res);
        System.debug('hiiiiiiii'+res.getbody()); 
    }
    public void AccessToken()
    {    
       System.debug('33333');
    }
}