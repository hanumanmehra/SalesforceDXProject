public class Job_App {
	public List<Job__c> joblist{set;get;}
	public List<wrapper_job> wraplist{get;set;}
	public String jobId{get;set;}
	String ac= Apexpages.currentPage().getparameters().get('Id');
	public String name {get;set;}
	public String qualification {get;set;}
	public String spoken_lang {get;set;}
	public String Technical_lang {get;set;}
	//public String Experience {get;set;}
	///set of childs
	public Set<String> qualiSet{get;set;}
	public Set<String> spokliSet{get;set;}
	public Set<String> techliSet{get;set;}
	public Set<String> expliSet{get;set;}
	//public List<Wrapclsfst> wrapfst{get;set;}
	//list of parents
	public List<String> parQuali{get;set;}
	public List<String> parspoken{get;set;}
	public List<String> partech{get;set;}
	public List<String> parexp{get;set;}
	//maps
	public map<String,String> mapofquali{get;set;}
	public map<String,String> mapofspkon{get;set;}
	public map<String,String> mapoftech{get;set;}
	public map<String,String> mapofexp{get;set;}
	
	//constructor
	public Job_App(ApexPages.StandardController setcon){
		//sc = setcon;
		jobId = setcon.getId();
		System.debug('a'+jobId);
		wraplist =new List<wrapper_job>();
		
		qualiSet = new Set<String>();
		spokliSet = new Set<String>();
		techliSet = new Set<String>();
		expliSet = new Set<String>();
		joblist = new List<Job__c>();
		
		//wrapfst = new List<Wrapclsfst>();
		parQuali = new List<String>();
		parspoken = new List<String>();
		partech = new List<String>();
		parexp = new List<String>();
		//
		 mapofquali = new  map<String,String>();
		 mapofspkon = new  map<String,String>();
		 mapoftech = new  map<String,String>();
		 mapofexp = new  map<String,String>();
		 
		joblist =[Select Name, Qualification__c, Spoken_Language__c, Technical_Language__c,(Select Name, Qualification__c, Spoken_Language__c, Technical_Language__c From Job_Applications__r) From Job__c Where Id=:jobId];
		System.debug('joblist::'+joblist);
		
		for(Job__c jb :joblist){
			parQuali = jb.Qualification__c.split(';');
			parspoken = jb.Spoken_Language__c.split(';');
			partech = jb.Technical_Language__c.split(';');
			//parexp = jb.Experience__c.split(';');
			
			for(Job_Application__c japp : jb.Job_Applications__r){
					name = japp.Name;
					//qualification = japp.Qualification__c;
					//List<string> split = japp.Qualification__c.Split(';');
					qualiSet.addAll(japp.Qualification__c.Split(';'));
					System.debug('qualiSet'+qualiSet);
					System.debug('parQuali'+parQuali);
					for(String pastr : parQuali ){						
						if(qualiSet.contains(pastr)){														
								mapofquali.put(pastr,'green');
								System.debug(mapofquali);
						}						
						else{
								mapofquali.put(pastr,'red');								
						}														
					}
					/*for(string str : qualiSet){						
						if(!parQuali.contains(str)){															
								mapofquali.put(str,'Orange');								
						}
					}*/
					System.debug(mapofquali); 
					System.debug('splitSet2'+qualiSet);
					
					spoken_lang = japp.Spoken_Language__c;
					List<string> split1 = spoken_lang.Split(';');
					spokliSet.addAll(split1);
					System.debug('splitSet3'+spokliSet);
					for(String pastr1 :parspoken){
						
							if(qualiSet.contains(pastr1)){
									mapofspkon.put(pastr1,'green');
							}
							else{
									mapofspkon.put(pastr1,'red');
							
						}
					}
					System.debug(mapofspkon);
					
					/*Technical_lang = japp.Technical_Language__c;
					List<string> split2 = Technical_lang.Split(';');
					techliSet.addAll(split2);
					System.debug('techliSet::'+techliSet);
					for(String pastr2 :partech ){
							if(qualiSet.contains(pastr2)){
								//System.debug('in this line::'+pastr2 +''+str2); 
								mapoftech.put(pastr2,'green');
								//System.debug(mapoftech);
							}
							else{
								
									mapoftech.put(pastr2,'red');	
							}
							
					}
					for(String str2 : techliSet){
								mapoftech.put(str2,'organe');
								System.debug(mapoftech);
							}
					System.debug(mapoftech);
					*/
					
					/*Experience = japp.Experience__c;
					List<string> split3 = Experience.Split(';');
					expliSet.addAll(split3);
					//System.debug('splitSet::'+expliSet);
					for(String pastr3 :parexp ){	
						
							if(qualiSet.contains(pastr3) ){
								//System.debug('in this line::'+pastr3 +''+str3); 
								mapofexp.put(pastr3,'green');
								//System.debug(mapofexp);
							}
							else{
								
									mapofexp.put(pastr3,'red');
								
									
							}	
						
					}*/
					System.debug('joblist size::'+jb.Job_Applications__r.size());
			}
			System.debug(mapofexp);
		
		System.debug('joblist1'+joblist[0].Job_Applications__r);
		//System.debug('joblist1'+joblist[1].Job_Applications__r);
		 	//System.debug('obj:::'+obj);
		 	wrapper_job wr = new wrapper_job(jb);
		 	wr.wrapjob_app = jb.Job_Applications__r;
		 	System.debug('obj1:::'+wr);
		 	wraplist.add(wr);
		 	System.debug('wraplist:::'+wraplist);
		 	//System.debug('joblist size1::'+jb.Job_Applications__r.size());
		}
	} 
	// wrapper class
	/*public Class Wrapclsfst{
		public Job__c jobwrap{set;get;}
		public Wrapclsfst(Job__c jobwrap){
			this.jobwrap =jobwrap;
			System.debug('jobwrap '+jobwrap );
		}
	}*/
	//wrapper class2
	public Class wrapper_job{
		//public Wrapclsfst wrfst{get;set;}
		public Job__c wrapjob{set;get;}
		public List<Job_Application__c> wrapjob_app{set;get;}
		/*public List<Wrapclsfst> qualification{get;set;} 
		public List<Wrapclsfst> Spoken_Language{get;set;}
		public List<Wrapclsfst> Technical_Language{get;set;}
		public List<Wrapclsfst> Experience{get;set;}
		public double score{get;set;}*/
		
		//constructor of wrapper
		public wrapper_job(Job__c jb){
		 	this.wrapjob = jb;
		 	//wrset = new set<String>();
		 	wrapjob_app = new List<Job_Application__c>();
		 	/*qualification = new List<Wrapclsfst>();
		 	Spoken_Language = new List<Wrapclsfst>();
	 	 	Technical_Language = new List<Wrapclsfst>();
	 	 	Experience = new List<Wrapclsfst>();
	 	 	System.debug('Experience'+Experience);*/
		 }
	}
	
	
	
}