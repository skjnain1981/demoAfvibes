/*
Created By        :  Jacob Hancock
Revision History  :  5/22/2014 Kai Ruan (class created)
                     5/22/2014 Kai Ruan (#59560 S2S sharing helper class)      
                     5/27/2014 Sidharth Agarwal (#59560 added sendToPartnerOrg and stopsendToPartnerOrg methods)        
Test Class        :  none
Class Nature      :  Helper class for S2S sharing
Summary           :  Helper methods for querying the PartnerNetworkConnection standard object, start/stop sharing fdr records with partner sf instances

*/ 
public class ConnectionHelper {

    public static Id getConnectionId( String connectionName ) {                                                         // Method return Id of current connection
        String realConnectionName = 'HCL Technologies';//S2S_Connections__c.getValues(connectionName).Connection_Name__c;                    // get from custom settings
        return [SELECT Id FROM PartnerNetworkConnection WHERE connectionStatus = 'Accepted' AND connectionName = : realConnectionName LIMIT 1].Id; 
    }
     
    /* 
    @param: objectList          - list of objects you want to forward; 
    @param: parentRecordIdMap   - Map<Record Id; Parent Id> map of Parent records;
    @param: relatedRecordsMap   - Map<Record Id; String with related records String> map with objects API names for whom forwarding record is parent and you want to forward them too; 
    @param: connectionName      - name of connection you want to use; 
    */
    public static void sendToPartnerOrg( List<sObject> objectList, Map<Id,Id> parentRecordIdMap, Map<Id,String> relatedRecordsMap, String connectionName ){ 
        if ( objectList != null && !objectList.isEmpty() ){             
            Id connectionId = getConnectionId(connectionName);                                  // (to:do:put dynamic handling)First thing we need to have connection name
            List<PartnerNetworkRecordConnection> objectConnections =  new  List<PartnerNetworkRecordConnection>();      // Creating list of PartnerNetworkRecordConnection that will be inserted            
            for ( sObject obj: objectList )                                                                             // Going throught list of recordth we want to share
            objectConnections.add(                                                                                      // Adding new PartnerNetworkRecordConnection to list
                new PartnerNetworkRecordConnection( 
                    ConnectionId = connectionId,                                                                        // ConnectionId - setting our PartnerNetworkConnection Id
                    LocalRecordId = obj.Id,                                                                             // LocalRecordId - Id of record we want to forward
                    SendClosedTasks = false,                                                                            
                    SendOpenTasks = false,
                    SendEmails = false, 
                    ParentRecordId = parentRecordIdMap != null ? parentRecordIdMap.get( obj.Id ): null,                 // ParentRecordId - parent of forwarding record                                                                                                     
                    RelatedRecords = relatedRecordsMap != null ? relatedRecordsMap.get( obj.Id ): null                  // RelatedRecords - child objects you what to forward too
                )
            ); 
            
            System.debug(objectConnections);
            
            // insert of PartnerNetworkRecordConnection list with linking error to the object
            // we are forwarding 
            if ( !objectConnections.isEmpty() ) {
                try{ 
                    database.insert( objectConnections ); 
                }catch( DMLException dmlEx ){ 
                    for ( Integer i = 0; i < dmlEx.getNumDml(); i++ )
                        if( dmlEx.getDmlStatusCode( i ) == 'INVALID_PARTNER_NETWORK_STATUS' ) 
                            for( PartnerNetworkRecordConnection connectionItem: objectConnections ) 
                                if( dmlEx.getDmlId( i ) == connectionItem.Id ) 
                                    for( sObject obj : objectList ) 
                                        if( connectionItem.LocalRecordId == obj.Id ) 
                                            obj.addError( 'Incorrect partner network status.' );
                    } 
            } 
        }  
    }
    

    public static void stopsendToPartnerOrg( List<Id> objectListIds, String connectionName ){ 
        if ( objectListIds != null && !objectListIds.isEmpty() ){           
            Id connectionId = getConnectionId(connectionName);                                                      // First thing we need to have connection name          
            List<PartnerNetworkRecordConnection> recordConns = new List<PartnerNetworkRecordConnection>([select Id, Status, ConnectionId, LocalRecordId from PartnerNetworkRecordConnection where LocalRecordId in :objectListIds]);            
            for(PartnerNetworkRecordConnection recordConn : recordConns) {                                              // cant delete records with pending stage, status = Invite
                if(recordConn.Status.equalsignorecase('Sent')){                                                         // record is connected - outbound
                    delete recordConn;
                } 
            }
        }  
    }
    
}