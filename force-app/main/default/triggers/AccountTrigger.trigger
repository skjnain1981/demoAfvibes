trigger AccountTrigger on Account (after insert, after update) {

    List<Account> accountsToStartShare = new List<Account>();
    List<ID> accountsToStopShare = new List<ID>();
    for(Account acc : Trigger.new){
        
        if(Trigger.IsInsert){
            if(acc.Share__c){
                accountsToStartShare.add(acc);
            }
        }
        
        if(Trigger.IsUpdate){
            Account oldaccount = trigger.oldMap.get(acc.Id);
            
            if(acc.Share__c != oldaccount.Share__c && acc.Share__c){
                accountsToStartShare.add(acc);
            }
            
            if(acc.Share__c != oldaccount.Share__c && !acc.Share__c){
                accountsToStopShare.add(acc.id);
            }
            
        }
        
        /*if(acc.Match_Billing_Address__c && acc.BillingPostalCode != ''){
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }*/
    }
    
    if(!accountsToStartShare.IsEmpty()){
        // share the clients
        if(!test.isRunningTest())ConnectionHelper.sendToPartnerOrg(accountsToStartShare, null, null, 'HCL Technologies');
    }
    
    if(!accountsToStopShare.IsEmpty()){
        // stop sharing the clients
        if(!test.isRunningTest())ConnectionHelper.stopsendToPartnerOrg(accountsToStopShare, 'HCL Technologies');
    }
    
}