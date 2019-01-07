public with sharing class JobAppController
{
	public Job__c job{set;get;}
	public String jobName{set;get;}
	public String jobQualification{set;get;}
	public String jobSpokenLang{set;get;}
	public String jobTechnicalLang{set;get;}
	public String jobExperience{set;get;}
	public Integer expNum{set;get;}
	public integer jobExpList{set;get;}
	public List<JobApplication> jobApplicationList{set;get;}
	
	
	public JobAppController(ApexPages.StandardController setcon)
	{
		String jobId = setcon.getId();
		
		
		job =[Select Name, Qualification__c, Spoken_Language__c, Technical_Language__c,Experience__c ,(Select Name, Qualification__c, Spoken_Language__c, Technical_Language__c,Experience__c From Job_Applications__r) From Job__c Where Id=:jobId limit 1];
		 //System.debug('job'+job[0].Job_Applications__r);
		jobName = job.Qualification__c!= null ? job.Name:'';
		jobQualification = job.Qualification__c!= null ? String.valueof(job.Qualification__c).replace(';',','):'';
		jobSpokenLang = job.Spoken_Language__c!= null ? String.valueof(job.Spoken_Language__c).replace(';',','):'';
		jobTechnicalLang = job.Technical_Language__c!= null ? String.valueof(job.Technical_Language__c).replace(';',','): '';
		//jobExperience = job.Experience__c!= null ? String.valueof(job.Experience__c).replace(';',','):'0';
		/*Qualification*/
		List<String> jobQualList = New List<String>();
		jobQualList = job.Qualification__c!= null ? String.valueof(job.Qualification__c).split(';'): New List<String>();
		Set<String> jobQualSet = new Set<String>();
		jobQualSet.addAll(jobQualList);
		
		/*Spoken*/
		List<String> jobSpoknList = New List<String>();
		jobSpoknList = job.Spoken_Language__c!= null ? String.valueof(job.Spoken_Language__c).split(';'):New List<String>();
		Set<String> jobSpoknSet = new Set<String>();
		jobSpoknSet.addAll(jobSpoknList);
		
		/*technical*/
		List<String> jobTechList = New List<String>();
		jobTechList = job.Technical_Language__c!= null ? String.valueof(job.Technical_Language__c).split(';'):New List<String>();
		Set<String> jobTechSet = new Set<String>();
		jobTechSet.addAll(jobTechList);
		
		/*Experience*/
		 jobExpList =job.Experience__c!= null ? integer.valueof(job.Experience__c):0;
		  
	
		jobApplicationList = new List<JobApplication>();
		for(Job_Application__c jobApp : job.Job_Applications__r)
		{
			JobApplication jApp = new JobApplication();
			jApp.name = jobApp.Name !=null ? jobApp.Name:'';
			jApp.qualification = new List<ColorClass>();
			jApp.spokenLang = new List<ColorClass>();
			jApp.techanicalLang = new List<ColorClass>();
			jApp.experience = new List<ColorClass>();
			
			decimal jobAppScore = 0.00;
			decimal score = 0.00;
			
			/*Qualification*/
			Set<String> jobAppQualSet = new Set<String>();
			if(jobApp.Qualification__c != null){
				List<String> jobAppQualList = jobApp.Qualification__c != null ? jobApp.Qualification__c.split(';'):new List<String>();
				//jApp.qualification = new List<ColorClass>();
				jobAppQualSet.addAll(jobAppQualList);
				
				for(String qual : jobQualList)
				{
					if(jobAppQualSet.contains(qual))
					{
						jApp.qualification.add(new ColorClass(qual,'green'));
						score++;
					}
					else
						jApp.qualification.add(new ColorClass(qual,'red'));
				}
				for(String qual : jobAppQualList)
					if(!jobQualSet.contains(qual))
						jApp.qualification.add(new ColorClass(qual,'orange'));
				System.debug('qual'+jobAppScore);
			}
			else{
				for(String qual : jobQualList)
				{
					jApp.qualification.add(new ColorClass(qual,'red'));
				}
				
			}
			if(jobQualList.size() > 0){
			jobAppScore += score/jobQualList.size();
			}
			
			
			
			/*Spoken*/
			Set<String> jobAppSpoSet  = new Set<String>();
			if(jobApp.Spoken_Language__c != null){
				score = 0;
				List<String> jobAppSpoList = jobApp.Spoken_Language__c != null ? jobApp.Spoken_Language__c.split(';'):new List<String>() ;
				jobAppSpoSet.addAll(jobAppSpoList);
				
				for(String spok : jobSpoknList)
				{
					if(jobAppSpoSet.contains(spok))
					{
						jApp.spokenLang.add(new ColorClass(spok,'green'));
						score++;
					}
					else
						jApp.spokenLang.add(new ColorClass(spok,'red'));
				}
				for(String spok : jobAppSpoList)
					if(!jobSpoknSet.contains(spok))
						jApp.spokenLang.add(new ColorClass(spok,'orange'));
			}
			else{
				for(String spok : jobSpoknList)
				{
					jApp.spokenLang.add(new ColorClass(spok,'red'));
				}
			}
			if(jobSpoknList.size() > 0){
				jobAppScore += score/jobSpoknList.size();
			}
			
			
			
			/*TechnicalLang*/
			Set<String> jobAppTechSet = new Set<String>();
			if(jobApp.Technical_Language__c != null){
				score = 0;
				List<String> jobAppTechList = jobApp.Technical_Language__c != null ? jobApp.Technical_Language__c.split(';'): new List<String>();
				jobAppTechSet.addAll(jobAppTechList);
				for(String tech : jobTechList)
				{
					if(jobAppTechSet.contains(tech))
					{
						jApp.techanicalLang.add(new ColorClass(tech,'green'));
						score++;
					}
					else
						jApp.techanicalLang.add(new ColorClass(tech,'red'));
				}
				for(String tech : jobAppTechList)
					if(!jobTechSet.contains(tech))
						jApp.techanicalLang.add(new ColorClass(tech,'orange'));
				System.debug('jobAppScore '+jobAppScore );
			}
			else{
				for(String tech : jobTechList)
				{
					jApp.techanicalLang.add(new ColorClass(tech,'red'));
				}
			} 
			if(jobTechList.size() >0){
				jobAppScore += score/jobTechList.size(); 
			}
			
			
			/*Experience*/
			//t<String> jobAppExpSet = new Set<String>();
			//ring jobAppExpList = jobApp.Experience__c;
			//bAppExpSet.addAll(jobAppExpList);
			if(jobApp.Experience__c != null){
				score = 0;
				 expNum = 0; 
				 expNum= jobApp.Experience__c!= null?Integer.valueof(jobApp.Experience__c):0;
				 
				 
					Integer num = Integer.valueof(job.Experience__c);
					if(num == expNum)
					{   
						jApp.experience.add(new ColorClass(''+num,'green'));
						score = num;
						System.debug('jobAppScore1'+score );
						//jobAppScore += score;
									
					}
					else if(expNum > num)
					{
						jApp.experience.add(new ColorClass(''+num,'green'));
						score = num ;
						System.debug('jobAppScore '+score );
						jApp.experience.add(new ColorClass(''+(expNum-num),'orange'));
						//jobAppScore += score/num;	
					}
					
					else if(expNum < num)
					{
						jApp.experience.add(new ColorClass(''+expNum,'green'));
						score = expNum;
						System.debug('jobAppScore2'+score );
						jApp.experience.add(new ColorClass(''+(expNum-num),'red'));
							//jobAppScore += score/num;
				}
				if(num > 0){
				jobAppScore += score/num;
			System.debug('jobAppScore '+jobAppScore );
				}
			}
			else{
				Integer num = 0;
					jApp.experience.add(new ColorClass(''+num,'red'));
				}
			System.debug('jobAppScore '+jobAppScore );
			jApp.score = new ColorClass(''+(jobAppScore / 4 *100).setScale(2)+ '%','green');
			jobApplicationList.add(jApp);
		}
		

			
	}
	
	public class JobApplication
	{
		public String name{get;set;}
		public List<ColorClass> qualification{get;set;}
		public List<ColorClass> spokenLang{get;set;}
		public List<ColorClass> techanicalLang{get;set;}
		public List<ColorClass> experience{get;set;}
		public ColorClass score{get;set;}
	}
	
	public class ColorClass
	{
		public String value{get;set;}
		public String color{get;set;}
		public ColorClass(String v,String C)
		{
			value=v;
			color=c;
		}
	}
}