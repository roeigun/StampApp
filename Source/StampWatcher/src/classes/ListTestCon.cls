public class ListTestCon{

	public ListInfo__c li {get;set;}

	public ListTestCon(){

		List<ListInfo__c> liList = [select id ,companyDiv__c, subDiv__c from ListInfo__c order by Name DESC];

		if(liList.size() == 0){
			li = new ListInfo__c();
		}else{
			li = liList.get(0);
		}

	}

	public void doSave(){
		upsert li;
	}

	public void doDelete(){
		delete li;
		li = new ListInfo__c();
	}

	public void doChange(){
		if(String.isBlank(li.companyDiv__c)){
			li.companyDiv__c = 'BX';
		}
		else if(li.companyDiv__c == 'BX'){
			li.companyDiv__c = 'SS';
		}

		else if(li.companyDiv__c == 'SS'){
			li.companyDiv__c = 'BX';
		}
	}
}