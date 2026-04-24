trigger ClosedOpportunityTrigger on Opportunity (before insert) {
    
    SET<ID> accountIDs = new SET<ID>();
    Map<ID, ID> MapaccountOwner = new Map<ID, ID>();
    
    
    for(Opportunity opp : Trigger.New){
        if(opp.StageName != 'Closed'){
            accountIDs.add(opp.accountid);
        }
    }
    
    if(accountIDs.size()>0){
        List<Account> accountlist =[select id,owneriD from account where id in:accountIDs];
        for(Account acc : accountlist){
            MapaccountOwner.put(acc.id, acc.owneriD);
        }
    }
    
    for(Opportunity opp : Trigger.New){
        if(opp.StageName != 'Closed'){
            if(MapaccountOwner.get(opp.accountID) != Null){
                opp.Working_Account_Owner__c = MapaccountOwner.get(opp.accountID);
            }
        }
    }
}