@istest
public class CalculateResolvedAccountTest{  
    public testMethod static void positivetestmethod(){
        Client__c client = createClient();
        insert client;
        
        List<Debt_Account__c> debitAccountList = new list<Debt_Account__c>();
        debitAccountList = createDebtAccount(3,client);
        insert debitAccountList; 
        
        Client__c objClient = [select Resolved_Accounts__c from Client__c where id =: client.Id];
        System.assertEquals(String.valueOf(objClient.Resolved_Accounts__c),'3');
       
        for(Debt_Account__c objDebitAccount : debitAccountList){
            if(objDebitAccount.Status__c == 'Resolved'){
                objDebitAccount.Status__c ='Active';
            }
        }
        update debitAccountList;
        
        objClient = [select Resolved_Accounts__c from Client__c where id =:client.Id];
        System.assertEquals(String.valueOf(objClient.Resolved_Accounts__c),'0');
    }
    
    private static Client__c createClient(){
        Client__c client1 = new Client__c();
        client1.Name='Client 1';
        client1.Status__c = 'Client';
        return client1;
    }
    
    private static  List<Debt_Account__c> createDebtAccount(Integer numberofAccounts, Client__c client){
        List<Debt_Account__c> debitAccountList = new list<Debt_Account__c>();
        for(Integer i=1;i<=numberofAccounts;i++){
            Debt_Account__c debitAccount= new Debt_Account__c();
            debitAccount.Name = 'TEST ' + i ;
            debitAccount.Status__c ='Resolved';
            debitAccount.client__c = client.ID;
            debitAccountList.add(debitAccount);
        }
        return debitAccountList; 
    }    
}