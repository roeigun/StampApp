Global with sharing class ApexActionRegionDemoController {
    
    public Account account {get; set;}
    public static Account acc {get; set;}
    public List<Account> accounts {get; set;}
    public String url {get;set;}
    public Boolean isDisplay{get;set;}
    
    public ApexActionRegionDemoController() {
        this.account = new Account();
        this.accounts = getAccounts();
        isDisplay = false;
        url = ApexPages.currentPage().getHeaders().get('X-Salesforce-SIP');
    }
    
    public void doSave() {
        insert this.account;
        this.account = new Account();
        this.accounts = getAccounts();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, 'Create Account!!'));
    }
    
    public void doDelete() {
        String accountId = System.currentPageReference().getParameters().get('deleteId');
        delete [SELECT Id FROM Account WHERE Id =: accountId];
        this.account = new Account();
        this.accounts = getAccounts();
        ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.CONFIRM, 'Delete Account!!'));
    }
    
    private List<Account> getAccounts() {
        return [SELECT Name,AccountNumber FROM Account ORDER BY Name ASC LIMIT 200];
    }


    @RemoteAction
    global static Account getAccount(String accountName) {
        acc = [SELECT Id, Name, Phone, Type, NumberOfEmployees 
                   FROM Account WHERE Name = :accountName];
        return acc;
    }
  
}