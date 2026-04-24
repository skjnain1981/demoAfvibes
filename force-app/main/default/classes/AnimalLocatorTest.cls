@isTest
private class AnimalLocatorTest {
    
    @isTest static void testgetAnimalNameById() {
        
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());     
        String result = '';
        result = AnimalLocator.getAnimalNameById(1);
         
        System.assertEquals('chicken',result, 'The animals are same.');
    }
}