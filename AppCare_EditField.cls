public with sharing class AppCare_EditField{
    private static final Integer METADATA_API_VERSION = 
    Integer.valueOf(new MetadataService.MetadataPort().endpoint_x.substringAfterLast('/'));
    public String MetaDataFolder {get; set;} 
    public String selectedLabel {get; set;} 
    public String MetaDataType {get; set;}  
    public String MetaDataItem1 {get; set;}     
    public List<SelectOption> MetaDataItems {get; set;}
    public String MetaDataItem {get; set;}  
     public Integer startingNumberInfo{get;set;}
     public String displayFormatInfo{get;set;}
       public String picklistValue {get; set;}
    public String child{get;set;}
    public String related{get;set;} 
    public Boolean displayFormat{get;set;}
    public Boolean childRelationship{get;set;}
    public Boolean relatedList{get;set;}
   public String label{get;set;}
    public String newlabel{get;set;}
    public Integer lengthNumber{get;set;}
    public Integer decimalPlaces{get;set;}
    public String labelType{get;set;}
    public Integer length{get;set;}
    public Integer complete{get;set;}
    public Boolean lengthtype{get;set;}
    public Boolean startingNumber{get;set;} 
    public Boolean lengthNumberType{get;set;}
    public Boolean decimalPlacesType{get;set;}
    public boolean picklistValueSet{get;set;}  
    public boolean relatedTo{get;set;}
    public String ACHID{get;set;}
    public AppCare_EditField(){
        listMetadataItems();
             lengthtype=false;
        lengthNumberType=false;
        decimalPlacesType=false;
        picklistValueSet=false;
        relatedTo=false;
        relatedList =false;
        childRelationship=false;
        displayformat = false;
        startingNumber=false;
    }
    public PageReference listMetadataItems()
    {
        // List Metadata items for the selected Metadata Type
        MetaDataType='CustomField';
        MetaDataItems = new List<SelectOption>();       
        MetadataService.MetadataPort service = createService();             
        List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();        
        MetadataService.ListMetadataQuery queryLayout = new MetadataService.ListMetadataQuery();
        if(MetaDataFolder!=null && MetaDataFolder.length()>0)
            queryLayout.folder = MetaDataFolder;
        queryLayout.type_x = MetaDataType;
        queries.add(queryLayout);       
       
        MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, METADATA_API_VERSION);
        
        List<String> fullNames = new List<String>();
        if(fileProperties!=null)
        {
            for(MetadataService.FileProperties fileProperty : fileProperties)
                fullNames.add(fileProperty.fullName);
            fullNames.sort();
            Integer count=0;
            for(String fullName : fullNames){
                if(count<1000){
                    MetaDataItems.add(new SelectOption(fullName,EncodingUtil.urlDecode(fullName, 'UTF-8')));
                    count++;
                }
            }
        }
       
        return null;    
    }
    public List<SelectOption> getLabelTypes() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('--None--','--None--'));
        options.add(new SelectOption('Text','Text'));
        options.add(new SelectOption('AutoNumber','AutoNumber'));
       // options.add(new SelectOption('Lookup','Lookup'));
     
        options.add(new SelectOption('Checkbox','Checkbox'));
        options.add(new SelectOption('Currency','Currency'));
        options.add(new SelectOption('Date','Date'));
        options.add(new SelectOption('DateTime','DateTime'));
        options.add(new SelectOption('Email','Email'));
       // options.add(new SelectOption('ExternalLookup','ExternalLookup'));
       // options.add(new SelectOption('IndirectLookup','IndirectLookup'));
        options.add(new SelectOption('Number','Number'));
        options.add(new SelectOption('Percent','Percent'));
        options.add(new SelectOption('Phone','Phone'));
        options.add(new SelectOption('Picklist','Picklist'));
        options.add(new SelectOption('MultiselectPicklist','MultiselectPicklist'));
        options.add(new SelectOption('TextArea','TextArea'));
        options.add(new SelectOption('LongTextArea','LongTextArea'));
        options.add(new SelectOption('Url','Url'));
     
        return options;
    }
    public void selectLength(){
        
        if(selectedLabel=='Text' || selectedLabel=='LongTextArea'){
                    lengthtype=true;
        	lengthNumberType=false;
        	decimalPlacesType=false;
        	picklistValueSet=false;
        	relatedTo=false;
            relatedList =false;
        	childRelationship=false;
        	displayformat = false;
        	startingNumber=false;
        }else if(selectedLabel=='Number' || selectedLabel == 'Percent' || selectedLabel == 'Currency')
        {
             lengthNumberType=true;
            decimalPlacesType=true;
            lengthtype=false;
			picklistValueSet=false;
        	relatedTo=false;
            relatedList =false;
        	childRelationship=false;
        	displayformat = false;
        	startingNumber=false;
        }
        else if(selectedLabel=='AutoNumber')
        {           
            displayformat = true;
            startingNumber=true;
                       relatedTo=false;
            childRelationship=false;
            relatedList=false;
                      picklistValueSet=false;
                        lengthtype=false;
        lengthNumberType=false;
        decimalPlacesType=false;
        } else if(selectedLabel=='Picklist' || selectedLabel == 'MultiselectPicklist')
        {
                        picklistValueSet=true;
                        lengthtype=false;
        lengthNumberType=false;
        decimalPlacesType=false;
        relatedTo=false;
            relatedList =false;
        childRelationship=false;
        displayformat = false;
        startingNumber=false; 
        }
        else if(selectedLabel=='Lookup' || selectedLabel=='MasterDetail')
        {
                     relatedTo=true;
            childRelationship=true;
            relatedList=true;
                      picklistValueSet=false;
                        lengthtype=false;
        lengthNumberType=false;
        decimalPlacesType=false;
        displayformat = false;
        startingNumber=false;
        }
       else if(selectedLabel=='Checkbox' || selectedLabel=='Date' || selectedLabel=='DateTime' || selectedLabel=='Email' || selectedLabel=='Phone' || selectedLabel=='Url' || selectedLabel=='TextArea')
        {
          displayformat = false;
            startingNumber=false;
            relatedTo=false;
            childRelationship=false;
            relatedList=false;
            picklistValueSet=false;
            lengthtype=false;
            lengthNumberType=false;
        	decimalPlacesType=false;  
        }
        
    }
    public PageReference save(){
    
                MetadataService.MetadataPort service = createService();
        MetadataService.CustomField custObj = new MetadataService.CustomField();
        if(selectedLabel == 'Text')
        {
               custObj.fullName = MetaDataItem;
  
          
        custObj.label=newlabel;
            custObj.type_x = selectedLabel;
             if(length < 1 || length > 255)
            {
               
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter length in the range 1-255'));
				return null;
            }
            else
            {
                  custObj.length = length;
            }
        }
        if(selectedLabel == 'LongTextArea')
        {
              custObj.fullName = MetaDataItem;
        
           
        custObj.label=newlabel;
            custObj.type_x = selectedLabel;
             if(length < 255 || length > 131072)
            {
              
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter length in the range 255-131072'));
				return null;
            }
            else
            {
                  custObj.length = length;
            }
            custObj.visibleLines = 3;
        }
        if(selectedLabel == 'TextArea' || selectedLabel == 'Date' || selectedLabel == 'DateTime' || selectedLabel == 'Email' || selectedLabel == 'Phone' || selectedLabel == 'Url')
        {
            
             custObj.fullName = MetaDataItem;
        
           
        custObj.label=newlabel;
            custObj.type_x = selectedLabel;
  
        }
        
        if(selectedLabel == 'Checkbox')
        {
            
            custObj.fullName = MetaDataItem;
        
           
        custObj.label=newlabel;
            custObj.type_x = selectedLabel;
            custObj.defaultValue = 'True';
        }
        
        if(selectedLabel== 'AutoNumber')
        {
            custObj.fullName = MetaDataItem;
        
           
        custObj.label=newlabel;
        custObj.type_x = selectedLabel;
        custObj.length = length;
            custObj.displayFormat = displayFormatInfo;
            custObj.startingNumber = startingNumberInfo;

        }
          if(selectedLabel == 'Number' || selectedLabel == 'Percent' || selectedLabel == 'Currency')
        {
            
            custObj.fullName = MetaDataItem;
            custObj.type_x = selectedLabel;
            custObj.label = newlabel;
            if(lengthNumber < 1 || decimalPlaces < 1)
           
            {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter value for both length and decimal place'));
                return null;
                }
            custObj.precision = lengthNumber;
            custObj.scale = decimalPlaces;
        }
         if(selectedLabel == 'Picklist')
        {
            custObj.fullName = MetaDataItem;
            custObj.label = newlabel;
              if(picklistValue == '')
            {
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter picklist values'));
                return null;
            }
            custObj.type_x = selectedLabel;
          
            metadataservice.Picklist pt = new metadataservice.Picklist();
            pt.sorted= false;
            List<String> FullNameItems = picklistValue.split(',');
                  List<metadataservice.PicklistValue> ListValue = new List<metadataservice.PicklistValue>();
         
            For(String a: FullNameItems)     
            {
                metadataservice.PicklistValue one = new metadataservice.PicklistValue();
                
                one.fullName = a;    
                one.default_x=false ;
                ListValue.add(one);
               
            }    

            pt.picklistValues = new list<metadataservice.PicklistValue>(ListValue);
            custObj.picklist = pt ;
          
        }
        if(selectedLabel == 'MultiSelectPicklist')
        {
            custObj.fullName = MetaDataItem;
            custObj.label = newlabel;
            
            if(picklistValue == '')
            {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter picklist values'));
                return null;
                }
            custObj.type_x = selectedLabel;
            metadataservice.Picklist pt = new metadataservice.Picklist();
            pt.sorted= false;
            List<String> FullNameItems = picklistValue.split(',');
                  List<metadataservice.PicklistValue> ListValue = new List<metadataservice.PicklistValue>();
         
            For(String a: FullNameItems)     
            {
                metadataservice.PicklistValue one = new metadataservice.PicklistValue();
                
                one.fullName = a;    
                one.default_x=false ;
                ListValue.add(one);
               
            }    

            pt.picklistValues = new list<metadataservice.PicklistValue>(ListValue);
            custObj.picklist = pt ;
            custObj.visibleLines =3;
        }
        
        List<MetadataService.SaveResult> results =
            service.updateMetadata(
                new MetadataService.Metadata[] { custObj });
       

        complete=1;
       if(ApexPages.currentPage().getUrl()!=null){
            return new pagereference(ApexPages.currentPage().getUrl());
        }
        else return null;
      
    }
    public static MetadataService.MetadataPort createService()
    { 
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;     
    }
    public PageReference exportData() {
        PageReference pf = new PageReference('/apex/ExportToExcelConfigBook');
        pf.setRedirect(true);
        return pf;
    }
    public PageReference exportCustData() {
        PageReference pf = new PageReference('/apex/AGP__CustomizationData');
        pf.setRedirect(true);
        return pf;
    }
    public PageReference exportSPData() {
        PageReference pf = new PageReference('/apex/ExportSystemPermissionsInExcel');
        pf.setRedirect(true);
        return pf;
    }
    public PageReference upsertACHData() {
        List<Organization> lOrg= [SELECT ID, NamespacePrefix FROM Organization LIMIT 1];
        String nm;
        String orgID;
        if(!lOrg.isEmpty()){
        nm = lOrg[0].NamespacePrefix;
        orgID = lOrg[0].ID;
        }
        Integer classLines = 0;
        Integer triggerLines = 0;
        Integer TotalApexLines = 0;
        Integer totalClasses = 0;
        Integer totalTriggers = 0;
        for(ApexClass a : [Select Body From ApexClass ]){
                            String[] lines = safeSplit(a.Body, '\n');
                            classLines += lines.size();
            				totalClasses++;
        }
    
        for(ApexTrigger a : [Select Body From ApexTrigger ]){
                            String[] lines = safeSplit(a.Body, '\n');
                            triggerLines += lines.size();
            				totalTriggers++;
        }
    
        TotalApexLines = classLines + triggerLines;
    
        Integer totalPages = [SELECT count() FROM ApexPage ];
        Integer totalCustomObjects = 0;
        Integer totalStandardObjects = 0;
        Map<String, Schema.SObjectType> GlobalMap = Schema.getGlobalDescribe(); 
        for (Schema.SObjectType Obj : GlobalMap.values()) {
            Schema.DescribeSObjectResult ObjDesc = Obj.getDescribe();
            if(ObjDesc.iscustom()){
                 totalCustomObjects++;
              
            }
            else{
                if(!ObjDesc.getName().containsignorecase('history') && !ObjDesc.getName().containsignorecase('tag')&&
               !ObjDesc.getName().containsignorecase('share') && !ObjDesc.getName().containsignorecase('feed')){
                    totalStandardObjects++;
                }
            }
        }
        try{
            AGP__AGP_AppCare_Health__c ach = new AGP__AGP_AppCare_Health__c();
            ach.AGP__Apex_Classes__c = totalClasses;
            ach.AGP__Apex_Triggers__c = totalTriggers;
            ach.AGP__Custom_VF_Pages__c = totalPages;
            ach.AGP__Lines_of_Code__c = TotalApexLines;
            ach.AGP__Custom_Objects__c = totalCustomObjects;
            ach.AGP__Standard_Objects__c = totalStandardObjects;
            ach.AGP__Last_Updated__c = System.now();
            ach.AGP__Namespace__c = nm;
            ach.AGP__Organization_ID__c = orgID;
            upsert ach AGP__Organization_ID__c;
            if(ach.ID != NULL){
                ACHID = ach.ID;
            } 
        }catch(Exception e){
            System.debug('Failed to upsert the record '+ e.getMessage());
        }
        return null;
    }
    
    public List<String> safeSplit(String inStr, String delim)
	{
    Integer regexFindLimit = 100;
    Integer regexFindCount = 0;
    
    List<String> output = new List<String>();
    
    Matcher m = Pattern.compile(delim).matcher(inStr);
    
    Integer lastEnd = 0;

    while(!m.hitEnd())
    {
        while(regexFindCount < regexFindLimit && !m.hitEnd())
        {
            if(m.find())
            {
                output.add(inStr.substring(lastEnd, m.start()));  
                lastEnd = m.end();
            }
            else
            {
                output.add(inStr.substring(lastEnd));
                lastEnd = inStr.length();
            }
            
            regexFindCount++;
        }

        
        m.reset(inStr);        
        m.region(lastEnd, m.regionEnd());
        
        regexFindCount = 0;
    }
    
    return output;
	}
}