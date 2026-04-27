@RestResource(urlMapping='/mcpCreateCase/')
global with sharing class mcpCreateCase {
    global class Responsewrapper {
        String caseId;
        String errorMessage;
        

        public Responsewrapper(String caseId, String errorMessage) {
            this.caseId = caseId;
            this.errorMessage = errorMessage;
        }
    }

    @HttpPost
    global static Responsewrapper createcase(String caseSubject, String caseDescription, String Priority) {
        Case c = new Case();
        c.Subject = caseSubject;
        c.Description = caseDescription;
        c.Priority = Priority;
        c.Origin = 'Web';
        insert c;

        // Return the caseNumber of the newly created Case
        Case newCase = [SELECT Id, CaseNumber FROM Case WHERE Id = :c.Id];
        return new Responsewrapper(newCase.CaseNumber, 'Successfully case created');
    }
}