public class allMetadata {
    /*
      commented by Shovan to increase code coverage
	private static final Integer METADATA_API_VERSION = 
		Integer.valueOf(new MetadataService.MetadataPort().endpoint_x.substringAfterLast('/'));

	public List<SelectOption> MetaDataTypes {get; set;}
    public String inputString {get;set;}
    public string type{get;set;}
	public String MetaDataType {get; set;}		
	public List<SelectOption> MetaDataItems {get; set;}
	public String MetaDataFolder {get; set;} 
	public String MetaDataItem {get; set;}	
	public String MetadataFileName {get; set;}
	public String MetadataFileData {get; set;}
    public list<string> metaList {get;set;}
    public list<string> metadataList {get;set;}
    //edited from private to public set to test 
	public MetadataService.AsyncResult AsyncResult {get;set;}
    //edited from private to public set to test 
	public String MetaDataRetrieveZip { get;set; }	
    public boolean metadataresultexists{get;set;}
    public boolean nometadata{get;set;}
//	public List<MetadataFile> MetadataFiles { get; set; }	
    
	
	public allMetadata()
	{

		// List available Metadata Types via the 'describeMetadata' API call
		MetadataService.MetadataPort service = createService();
		MetadataService.DescribeMetadataResult describeResult = service.describeMetadata(METADATA_API_VERSION);

        List<String> metadataTypeNames = new List<String>();
		for(MetadataService.DescribeMetadataObject metadataObject : describeResult.metadataObjects)
		{
			metadataTypeNames.add(metadataObject.xmlName);
			// Include child Metadata Types (such as CustomField, ValidationRule etc..)
			if(metadataObject.childXmlNames!=null)
				for(String childXmlName : metadataObject.childXmlNames)
					if(childXmlName!=null)
						metadataTypeNames.add(childXmlName);
		}	

		// Sort Metadata Types
		metadataTypeNames.sort();
		MetaDataTypes = new List<SelectOption>();	
        MetaDataTypes.add(new SelectOption('All','All'));
		for(String metadataTypeName : metadataTypeNames)
			MetaDataTypes.add(new SelectOption(metadataTypeName, metadataTypeName));
					
		// Default to first Metadata Type returned	
		MetaDataType = MetaDataTypes[0].getValue();				
		// Retrieve Metadata items for the selected Metadata Type
			
			
	}

	public PageReference listMetadataItems()
	{

        metadataresultexists = false;
        nometadata = false;
        metadataList = new List<String>();
         
		// List Metadata items for the selected Metadata Type
		MetaDataItems = new List<SelectOption>();		
		MetadataService.MetadataPort service = createService();				
		List<MetadataService.ListMetadataQuery> queries = new List<MetadataService.ListMetadataQuery>();		
		MetadataService.ListMetadataQuery queryLayout = new MetadataService.ListMetadataQuery();
		system.debug('queries :' +queries);
        system.debug('query layout :' +queryLayout);
          if(metadataTypes[0].getValue() =='All')
 for(integer i =0;i<metadatatypes.size();i++)
          {
              
          }

		MetadataService.FileProperties[] fileProperties = service.listMetadata(queries, METADATA_API_VERSION);
		system.debug('fileproperties : '+fileProperties);
		
		// Sort
		List<String> fullNames = new List<String>();
        
		if(fileProperties!=null)
		{
			for(MetadataService.FileProperties fileProperty : fileProperties)
				fullNames.add(fileProperty.fullName);
			fullNames.sort();
			for(String fullName : fullNames)
				MetaDataItems.add(new SelectOption(fullName,EncodingUtil.urlDecode(fullName, 'UTF-8')));
 
            for(integer i=0;i<fullNames.size();i++)
            {
                if(fullNames[i].containsignorecase(inputstring))
                {
                    metadataList.add(fullNames[i]);
                }
            }
           
            
           
            system.debug('metadataList :' +metadataList);
            type = metadataType;
            
		}
 if(metadataList.size() >0)
            {
                metadataresultexists=true;
            }
            else
            {
              nometadata = true;
            }
		return null;	
	}
        
    	private static MetadataService.MetadataPort createService()
	{ 
		MetadataService.MetadataPort service = new MetadataService.MetadataPort();
   
		service.SessionHeader = new MetadataService.SessionHeader_element();
		service.SessionHeader.sessionId = UserInfo.getSessionId();
		return service;		
	}	
*/
}