trigger CalculateResolvedAccount on Debt_Account__c(after insert, after update) {
    SET<ID> ClientIDs = new SET<ID>();
    String strResolved = 'Resolved';
    String strClient = 'Client';
    
    for(Debt_Account__c debitAccount : Trigger.new){
        if((Trigger.isInsert && debitAccount.Status__c == strResolved) 
            || (Trigger.isUpdate && Trigger.oldMap.get(debitAccount.id).Status__c <> debitAccount.status__c)){
            
            ClientIDs.add(debitAccount.client__c);
        }
    }
    
    if(ClientIDs.size() > 0){
        MAP<ID, Integer> mapDebitAccount = new Map <ID, Integer>();
        List<Client__c> clientList = new List<Client__c>();
        
        List<Debt_Account__c> debitAccountList = [select id,Status__c,client__c  from Debt_Account__c
                                                     where client__c in:ClientIDs and Client__r.Status__c =:strClient limit 50000];
    
        for(Debt_Account__c objDebitAccount: debitAccountList){
            Integer resolvedCount = 0;
       
            if(mapDebitAccount.containskey(objDebitAccount.client__c)){
               resolvedCount = mapDebitAccount.get(objDebitAccount.client__c);
            } 
            
            if(objDebitAccount.Status__c == strResolved){
                resolvedCount++;
            }
            mapDebitAccount.put(objDebitAccount.client__c,resolvedCount);
        }
    
        for(ID clientid : mapDebitAccount.keyset()){
            Client__c client= new Client__c();
            client.id = clientid ;
            client.Resolved_Accounts__c  = mapDebitAccount.get(clientid);
            clientList.add(client);
        }
 
        if(clientList.size()>0){
            update clientList;
        }
    }
}