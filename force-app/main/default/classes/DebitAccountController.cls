public class DebitAccountController{
    public List<WrapperDebitAccount> wrapperDebitAccounts{get;set;}
    
    public DebitAccountController(){
        wrapperDebitAccounts = new List<WrapperDebitAccount>();
        wrapperDebitAccounts = LoadDebitAccounts();
    }
    
    public List<WrapperDebitAccount> LoadDebitAccounts(){
        List<Debt_Account__c> debitAccountList = new List<Debt_Account__c>();
        List<WrapperDebitAccount> tempWrapperccounts= new List<WrapperDebitAccount>();
         
        debitAccountList = [select id, name,Status__c,Client__r.name,Client__r.Status__c from Debt_Account__c limit 1000];
    
        for(Debt_Account__c account:  debitAccountList){
            tempWrapperccounts.add(new WrapperDebitAccount(account,false));
        }
        return tempWrapperccounts;
    }

    public class WrapperDebitAccount{
        public Boolean isReviewed{get;set;}
        public Debt_Account__c debitAccount{get;set;}

        public WrapperDebitAccount(Debt_Account__c objDebitAccount, boolean bReviewed){
            this.debitAccount = objDebitAccount;
            this.isReviewed = bReviewed;
        }
    }
    
    public pagereference updateReviewed(){
        try{
            List<Debt_Account__c> debitAccountList = new List<Debt_Account__c>();
            
            for(WrapperDebitAccount wp :wrapperDebitAccounts){
                if(wp.isReviewed){
                    Debt_Account__c debt_Account = wp.debitAccount;
                    debt_Account.Reviewed__c=true;
                    debitAccountList.add(debt_Account);  
                }
            }
            
            if(debitAccountList.size()>0){
                update debitAccountList;
                return new pagereference('/apex/DebitAccounts');    
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.warning,'Please select at least one record to updates');
                ApexPages.addMessage(myMsg);
                return null;
            }
        }
        catch(exception ex){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
            ApexPages.addMessage(myMsg);
            return null;
        }
    }
}