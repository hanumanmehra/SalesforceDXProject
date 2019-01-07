public with sharing class TwitterIntegration 
{
	private Map<String,String> parameters;
	public String status{get;set;}
	public String message{get;set;}
  	public  blob file{get;set;}
  	public List<String> userprofile{get;set;}
  	public String accesstoken;
  	public String filename{get;set;}
  	public String filetype{get;set;}
  	public String username{get;set;}
  	public string scrnname{get;set;}
  	public map<String,String> searchpeople{get;set;}
  	public map<String,String> followerMap{get;set;}
	
	String consumer_Key = 'zGly0LWgozlwpYWNkCXr5MIAi';
	String consumer_Secret = 'jUHZylrJOGrxqb6LpJey85dZFxB2I2v5fKtQWJuLgiOd6WOtU2';
	String callbackUrl = URL.getSalesforceBaseUrl().toExternalForm()+'/apex/TwitterIntegration';  
	
	String user_id;
	String oauth_verifier;
	String oauth_token;
	String oauth_token_secret;
	
	String nonce;
	String timestamp; 
	String oauth_signature;
	String screen_name;
	string frndId;
	
	
	
	//Constructor 
	public TwitterIntegration()
	{
		parameters= new Map<String,String>();
		userprofile= new List<String>();
		System.debug('String callbackUrl'+callbackUrl);
		user_id = '';
		oauth_verifier ='';
		oauth_token = '';
		oauth_token_secret = '';
		

		nonce = '';
		timestamp = '';
		oauth_signature = '';
		screen_name ='';
		message= '';
		frndId ='';
		username ='';
		accesstoken='';
		oauth_token = ApexPages.currentPage().getParameters().get('oauth_token');
		oauth_verifier = ApexPages.currentPage().getParameters().get('oauth_verifier');	
		
		//call method to get access token
		if(oauth_token != '' && oauth_token != null && oauth_verifier != '' && oauth_verifier != null)
		{
			accessToken();
		}
		//userdetails();
		//postTweet();
	}
	
	//method to request for token
	public pageReference requestToken()
	{
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		Http hp = new Http();
		
		req.setEndpoint('https://api.twitter.com/oauth/request_token');   
		req.setMethod('POST');
		sign(req);
		
		res = hp.send(req);
		System.debug('res'+res.getBody());
		
		//Fetch oauth _token and oauth_token_secret
		List<String> body = res.getBody().split('&');
		if(body != null)    
		{
			oauth_token = body[0].split('=')[1];
			oauth_token_secret = body[1].split('=')[1];
			System.debug('oauth_token'+oauth_token + 'oauth_token_secret'+oauth_token_secret);
		}
		pageReference pg = new PageReference(authorizeUser());
        return pg;
	}
	
	//method to call authorise user
	public String authorizeUser()
	{
		return 'https://api.twitter.com/oauth/authorize?oauth_token='+oauth_token+'&oauth_token_secret='+oauth_token_secret;
	}
	//method to get access token 
	public void accessToken()
	{
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		Http hp = new Http();
		
		req.setMethod('POST');
		req.setEndpoint('https://api.twitter.com/oauth/access_token');
		sign(req);
		
		res=hp.send(req);
		system.debug('res::accestoken:::'+res.getBody());
		//fetch oauth_token and oauth_token_secret of the user
		List<String> body = res.getBody().split('&');
		oauth_token = body[0].split('=')[1];
		oauth_token_secret =body[1].split('=')[1];
		user_id = body[2].split('=')[1];
		screen_name =body[3].split('=')[1];
		accesstoken =oauth_token;
		System.debug('access ::oauth_token'+oauth_token + 'access :::oauth_token_secret'+oauth_token_secret +'user_id'+user_id +'access:screen_name'+screen_name);
	}
	
	// method for authorize user to access the api
	
	public void refreshParameters()
	{
		parameters.clear();
		
		parameters.put('oauth_consumer_key',consumer_Key);
		if(oauth_token!=null)
		{
			 parameters.put('oauth_token',oauth_token);
		}
		if(oauth_verifier!=null)   
		{       
 			parameters.put('oauth_verifier',oauth_verifier);
		}  
		parameters.put('oauth_signature_method','HMAC-SHA1');
	    parameters.put('oauth_timestamp',timestamp);
	    parameters.put('oauth_nonce',nonce);
	    parameters.put('oauth_callback',callbackUrl);
	}
	
	private Map<String,String> getUrlParams(String value) 
	{
		
	    Map<String,String> res = new Map<String,String>();
	    if(value==null || value=='') 
	    {
	        return res;
	    }
	    for(String s : value.split('&')) 
	    {
	        System.debug('getUrlParams: '+s);
	        List<String> kv = s.split('=');
	        if(kv.size()>1)
	        {
	          // RFC 5849 section 3.4.1.3.1 and 3.4.1.3.2 specify that parameter names 
	          // and values are decoded then encoded before being sorted and concatenated
	          // Section 3.6 specifies that space must be encoded as %20 and not +
	          String encName = EncodingUtil.urlEncode(EncodingUtil.urlDecode(kv[0], 'UTF-8'), 'UTF-8').replace('+','%20');
	          String encValue = EncodingUtil.urlEncode(EncodingUtil.urlDecode(kv[1], 'UTF-8'), 'UTF-8').replace('+','%20');
	          System.debug('getUrlParams:  -> '+encName+','+encValue);
	          res.put(encName,encValue);
	        }
	    }
	    System.debug('res'+res);
	    return res;
	}
	
	
	private String createBaseString(Map<String,String> oauthParams, HttpRequest req) 
	{
	    Map<String,String> p = oauthParams.clone();
	    if(req.getMethod().equalsIgnoreCase('post') && req.getBody()!=null && 
	       req.getHeader('Content-Type')=='application/x-www-form-urlencoded') 
       {
	        p.putAll(getUrlParams(req.getBody()));
       }
	    String host = req.getEndpoint();
	    Integer n = host.indexOf('?');
	    if(n>-1) 
	    {
	        p.putAll(getUrlParams(host.substring(n+1)));
	        host = host.substring(0,n);
	    }
	    List<String> keys = new List<String>();
	    keys.addAll(p.keySet());
	    keys.sort();
	    String s = keys.get(0)+'='+p.get(keys.get(0));
	    for(Integer i=1;i<keys.size();i++) 
	    {
	        s = s + '&' + keys.get(i)+'='+p.get(keys.get(i));
	    }
	
	    // According to OAuth spec, host string should be lowercased, but Google and LinkedIn  
	    // both expect that case is preserved.
	    return req.getMethod().toUpperCase()+ '&' + 
	        EncodingUtil.urlEncode(host, 'UTF-8') + '&' +
	        EncodingUtil.urlEncode(s, 'UTF-8');
	}
	
	public void sign(HttpRequest req) 
	{
	    nonce = String.valueOf(Crypto.getRandomLong());
	    timestamp = String.valueOf(DateTime.now().getTime()/1000);
	
	    refreshParameters();
	
	    String s = createBaseString(parameters, req);
	
	    Blob sig = Crypto.generateMac('HmacSHA1', Blob.valueOf(s), 
	                   Blob.valueOf(consumer_Secret+'&'+
	                                (oauth_token_secret!=null ? oauth_token_secret : '')));
	    oauth_signature = EncodingUtil.urlEncode(EncodingUtil.base64encode(sig), 'UTF-8');
	    System.debug('Signature: '+oauth_signature);
	
	    String header = 'OAuth ';
	    for (String key : parameters.keySet()) 
	    {
	        header = header + key + '="'+parameters.get(key)+'", ';
	    }
	    header = header + 'oauth_signature="'+oauth_signature+'"';
	   // accesstoken =header;
	    System.debug('Authorization: '+header);
	    req.setHeader('Authorization',header);

		//req.setHeader('Content-Type','multipart/form-data');
	
	}
	
	public void followerlist()
	{
		String username,profileurl;
		followerMap= new map<String,String>();
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		Http hp = new Http();
		
		req.setMethod('GET');
		req.setEndpoint('https://api.twitter.com/1.1/friends/list.json?cursor=-1&screen_name='+screen_name+'&skip_status=true&include_user_entities=false');
		sign(req); 
		
		res= hp.send(req);
		System.debug('res.getbody()::'+res.getbody());	
		JSONParser parser = JSON.createParser(res.getbody());
		System.debug('parser'+parser);
		
		while (parser.nextToken() != null)
		{
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'errors')
			{	
				System.debug('error message');
				break;
			}
			if(parser.getText() == 'name')
				{
					parser.nexttoken();
					username =parser.getText() ;
					System.debug('name'+username);
				}
				else if(parser.getText() == 'profile_image_url')
				{
					parser.nexttoken();
					profileurl =parser.getText() ;
					System.debug('nameurl'+profileurl);
				}
				if(username != null && profileurl !=null )
				{
					followerMap.put(username,profileurl);
					//System.debug('searchpeople'+searchpeople.keyset());  
					//System.debug('searchpeople'+searchpeople.values());  
				}
			}
	}
	
	
	public void userdetails()
	{
		String username,followersCount,followingCount,time_zone,friends_count;
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		Http hp = new Http();
		
		req.setMethod('GET');
		req.setEndpoint('https://api.twitter.com/1.1/users/show.json?user_id='+user_id);
		sign(req); 
		
		res= hp.send(req);
		System.debug('res.getbody()::'+res.getbody());	
		JSONParser parser = JSON.createParser(res.getbody());
		System.debug('parser'+parser);
		
		while (parser.nextToken() != null)
		{
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'errors')
			{	
				System.debug('error message');
				break;
			}
			else if(parser.getCurrentToken() == JSONToken.FIELD_NAME )
			{
				if(parser.getText()=='name')
				{
					parser.nextToken();
					username= parser.getText();
					System.debug('username'+username);
				}
				else if(parser.getText()=='followers_count')
				{
					parser.nextToken();
					followersCount= parser.getText();
					System.debug('followersCount'+followersCount);
				}	
				else if(parser.getText()=='following')
				{
					parser.nextToken();
					followingCount= parser.getText();
					System.debug('followingCount'+followingCount);
				}
				else if(parser.getText()=='time_zone')
				{
					parser.nextToken();
					time_zone= parser.getText();
					System.debug('time_zone'+time_zone);
				}
				else if(parser.getText()=='friends_count')
				{
					parser.nextToken();
					friends_count= parser.getText();
					System.debug('friends_count'+friends_count);
				}	
			}
		}
	}
	public void postTweet()
	{
		if(status != null && status !='')
		{
			//encoding status 
			String tweet =EncodingUtil.urlEncode(status, 'UTF-8'); 
			
			HttpRequest req = new HttpRequest();
			HttpResponse res;
			Http hp = new Http();
			
			req.setMethod('POST');
			req.setEndpoint('https://api.twitter.com/1.1/statuses/update.json?status='+tweet);
			sign(req); 
			
			res= hp.send(req);
			System.debug('res.getbody()::'+res.getbody());
		}
	}
	
	// Method Of send a firend request
	public void friendrequest()
	{
		String screenname ;
			//encoding status 
		System.debug('scrnname'+scrnname);
	 	screenname =EncodingUtil.urlEncode(scrnname, 'UTF-8'); 
			
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		Http hp = new Http();
		
		req.setMethod('POST');
		req.setEndpoint('https://api.twitter.com/1.1/friendships/create.json?screen_name='+screenname+'&follow=true');
		sign(req); 
		
		res= hp.send(req);
		System.debug('res.getbody()::'+res.getbody());	
	}
	
	//Metod 
	public void friendlist()
	{
		String username;
		List<String> listofFriend = new List<String>();
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		Http hp = new Http();
		
		req.setMethod('GET');
		req.setEndpoint('https://api.twitter.com/1.1/friends/list.json?cursor=-1&screen_name='+screen_name +'&skip_status=true&include_user_entities=false'+user_id);
		sign(req); 
		
		res= hp.send(req);
		System.debug('res.getbody()::'+res.getbody());	
		JSONParser parser = JSON.createParser(res.getbody());
		System.debug('parser'+parser);
		
		while (parser.nextToken() != null)
		{
			if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'errors')
			{	
				System.debug('error message');
				break;
			}
			else if(parser.getCurrentToken() == JSONToken.FIELD_NAME )
			{
				if(parser.getText()=='name')
				{
					parser.nextToken();
					username= parser.getText();
					listofFriend.add(username);
					
				}
				if(parser.getText()=='screen_name')
				{
					parser.nextToken();
					frndId= parser.getText();
					//listofFriend.add(frndId);
					
				}
			}
		}
		System.debug('listofFriend'+listofFriend + 'frndId'+frndId);
	}
	
	public void directmessage() 
	{
		if(message != null && message !='')
		{
			//encoding status 
			String screen_name ;
			//encoding status 
			System.debug('scrnname'+scrnname);
	 		screen_name =EncodingUtil.urlEncode(scrnname, 'UTF-8');
			String msg =EncodingUtil.urlEncode(message, 'UTF-8'); 
			System.debug('msg'+msg);
			
			HttpRequest req = new HttpRequest();
			HttpResponse res;
			Http hp = new Http();
			
			req.setMethod('POST');
			System.debug('listofFriend[0].Id' +frndId);
			req.setEndpoint('https://api.twitter.com/1.1/direct_messages/new.json?text='+msg+'&screen_name='+screen_name);
			sign(req); 
			
			res= hp.send(req);
			System.debug('res.getbody()::'+res.getbody());
		}
	}
	

	
	public void updateProfile()

 	{
 		/*String boundary = '0246824681357ACXZabcxyz';
  		String header = '--'+boundary+'\n'
  		    			+'Content-Type: image/jpeg; name="media"'
     					+ 'Content-Disposition: form-data;filename="IMG_20160311_205115114"'
     					+'Content-Location: media'
     					+'\n--'+boundary+'--'
     					+EncodingUtil.base64Encode(file)
     					+'\n--'+boundary+'--';
 		 
 		System.debug(header); 
  		HttpRequest req = new HttpRequest();
  		HttpResponse res;
  		req.setBody(header); 
  		req.setHeader('Authorization', 'Bearer' +accesstoken);
  		req.setHeader('Content-Type','multipart/form-data;,boundary='+boundary);
  		req.setMethod('POST');
 		req.setEndpoint('https://api.twitter.com/1.1/statuses/update_with_media.json?status=hello............'); 
 		//sign(req); 
 		
 		 
  		//req.setBody(body);
  		System.debug('body.length()'+header.length());
 		Http http = new Http();
      	res= http.send(req);
      	System.debug('res'+res.getbody());*/
      	
      	
      /*	String boundary = '-------0246824681357ACXZabcxyz';
        String delimiter = '\r\n--' + boundary +'\r\n';
        String close_delim = '\r\n--' + boundary + '--';
        String bodyEncoded = EncodingUtil.base64Encode(blob.valueof('https://pbs.twimg.com/media/CdwMrJ4UIAEIAGH.jpg'));
       System.debug('--------------be-----------------'+bodyEncoded);

        String body=
        delimiter +
       'Content-Type: image/jpeg' + 
       '{ "title" : IMG_20160311_205115114"'+'",' +
        ' "MIME-Version" : 1.0"'+ '" }'  + 
        delimiter +
       'Content-Type: multipart/form-data'  + '\r\n' +
       'Content-Transfer-Encoding: base64\r\n' +
       '\r\n' +
        bodyEncoded +
        close_delim;

        System.debug('--------body is-------------'+body);

  


    HttpRequest req = new HttpRequest();
    req.setEndpoint('https://api.twitter.com/1.1/statuses/update_with_media.json?');

    System.debug('accesstoken:::::'+accesstoken);
    
   // req.setHeader('Authorization', 'Bearer' +accesstoken);
    req.setHeader('Content-Type', 'multipart/mixed; boundary="'+boundary+'"'); 
    req.setHeader('Content-length', String.valueOf(body.length()));
    //req.setHeader('Content-Encoding','base64');
    req.setBody(body);
    req.setMethod('POST');
    sign(req);
   
    //req.setTimeout(60*1000);
    // Http http = new Http();
    // HTTPResponse res = http.send(req);
     HttpResponse res = null;
     http h= new Http();
     res= h.send(req);
     System.debug('res'+res.getbody());*/
     String boundary = '-------0246824681357ACXZabcxyz'; 
       String delimiter = '\r\n--' + boundary +'\r\n';
       String close_delim = '\r\n--' + boundary + '--';
       String bodyEncoded = EncodingUtil.base64Encode(file);
       String body=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "title" : "'+ filename+'",'+' "mimeType" : "'+ filetype+ '" }'+delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+bodyEncoded+close_delim;
       Http http = new Http();
       HttpRequest req = new HttpRequest();
       req.setEndpoint('https://upload.twitter.com/1.1/media/upload.json');   //upload file to google drive and convert in google docx  
       //req.setHeader('Authorization', 'Bearer ' +accesstoken);
       req.setHeader('Content-Type', 'multipart/mixed; boundary="'+boundary+'"');    
       req.setHeader('Content-length', String.valueOf(body.length())); 
       req.setBody(body);       
       req.setMethod('POST');
       sign(req); 
       //req.setTimeout(60*1000);
       HttpResponse res = http.send(req);
        
       System.debug('--------------req-----------------'+req);
       System.debug('--------------res-----------------'+res.getbody()); 
       //file =null;
       //filetype='';
       //filename='';  
 	}
 	
 	
	public void userProfile()
	{
		String picture;
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		
		Http hp = new Http();
		
		req.setMethod('GET');
		req.setEndPoint('https://api.twitter.com/1.1/users/profile_banner.json?screen_name'+screen_name);
		sign(req); 
		res = hp.send(req);
		System.debug('res::::'+res.getbody());
		JSONParser parser = JSON.createParser(res.getbody());
		System.debug('parser'+parser);
		/*while(parser.nextToken() != null)
		{
			if(parser.getcurrentToken() == JSONToken.FIELD_NAME && parser.getText()=='error' )
			{
				break;
			}
			else if(parser.getcurrentToken() == JSONToken.FIELD_NAME)
			{
				if(parser.getText() == 'url')
				{
					parser.nextToken();
						picture= parser.getText();
						userprofile.add(picture);
					System.debug('url::::'+picture);
				}
			}
			
		}*/
	}
	
	//
	public void userStatus()
	{
		String picture;
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		
		Http hp = new Http();
		
		req.setMethod('GET');
		System.debug('user_id'+user_id);
		req.setEndPoint('https://api.twitter.com/1.1/statuses/retweet/'+user_id +'.json');
		sign(req); 
		res = hp.send(req);
		System.debug('res::::'+res.getbody());
		JSONParser parser = JSON.createParser(res.getbody());
		System.debug('parser'+parser);
		/*while(parser.nextToken() != null)
		{
			if(parser.getcurrentToken() == JSONToken.FIELD_NAME && parser.getText()=='error' )
			{
				break;
			}
			else if(parser.getcurrentToken() == JSONToken.FIELD_NAME)
			{
				if(parser.getText() == 'url')
				{
					parser.nextToken();
						picture= parser.getText();
						userprofile.add(picture);
					System.debug('url::::'+picture);
				}
			}
			
		}*/
	}
	
	public void searchUser()
	{ 
		String name;
		String nameurl;
		String user;
		searchpeople= new  map<String,String>();
		map <String,string> imageurl = new map<String,String>();
	
		user = EncodingUtil.urlEncode(username, 'UTF-8');
		HttpRequest req = new HttpRequest();
		HttpResponse res;
		Http hp = new Http();
		
		req.setMethod('GET');
		System.debug('user_id'+user_id);
		req.setEndPoint('https://api.twitter.com/1.1/users/search.json?q='+user +'&page=1&count=10');
		sign(req); 
		res = hp.send(req);
		System.debug('res::::'+res.getbody());
		JSONParser parser = JSON.createParser(res.getbody());
		System.debug('parser'+parser);
		
		while(parser.nextToken() != null)
		{
			if(parser.getcurrentToken() == JSONToken.FIELD_NAME && parser.getText()== null)	{
				break;
			}
			if(parser.getcurrentToken() == JSONToken.FIELD_NAME){
				if(parser.getText() == 'since_id')
				{
					parser.nexttoken();
					 String str =parser.getText() ;
					 System.debug('str'+str);
				}
				if(parser.getText() == 'screen_name')
				{
					parser.nexttoken();
					name =parser.getText() ;
					System.debug('name'+name);
				}
				if(parser.getText() == 'profile_image_url')
				{
					parser.nexttoken();
					nameurl =parser.getText() ;
					System.debug('nameurl'+nameurl);
				}
				if(name != null && nameurl !=null )
				{
					searchpeople.put(name,nameurl);
				}
				
			}
		}
		
	}
}