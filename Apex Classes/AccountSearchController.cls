/******************************************************************************************
Class Name:  AddressSearchController
Description: This class is used t0 call google location API for auto complete functionality
******************************************************************************************/
public class AccountSearchController {
    
    //Method to get address details in the initial load
    @AuraEnabled
    public static Account getAddressDetailsbyId(String id){
        Account ac = new Account();
        ac = [select Id, Name from Account where Id=: id];
        return ac;
    }
    
    //Method to save address details on click on Save button
    @AuraEnabled
    public static String saveAddressDetailsbyId(String id, Account accDetails){
        system.debug('saveAddressDetailsbyId method');
        Account obj = [select Id from Account where Id=: id];
        obj.Name = accDetails.Name;
        obj.Phone = accDetails.Phone;
        update obj;
        return 'Success';
    }
    
    //Method to call google API and fetch the address recommendations 
    @AuraEnabled
    public static String getAddressSet(String SearchText){
        String APIKey = '';
        String result = null;
        system.debug('SearchText is ' + SearchText);
        try{
            if(SearchText != null){
                String APIUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + SearchText.replace(' ', '%20') + '&key=' + APIKey; 
                system.debug('APIUrl is ' + APIUrl);
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(APIURL);
                Http http = new Http();
                HttpResponse res = http.send(req);
                Integer statusCode = res.getStatusCode();
                system.debug('statusCode is ' + statusCode);
                if(statusCode == 200){
                    system.debug('API invoked successfully');
                    result = res.getBody();
                }
            }
        }
        catch(exception e){
            //Handling exception
            system.debug(e.getMessage());
        }
        return result;
    }
    
    //Method to call google API and fetch the address details by addressID 
    @AuraEnabled
    public static String getAddressDetailsByPlaceId(String PlaceID){
        String APIKey = '';
        String result = null;
        system.debug('SearchText is ' + PlaceID);
        try{
            if(PlaceID != null){
                String APIUrl = 'https://maps.googleapis.com/maps/api/place/details/json?placeid=' + PlaceId.replace(' ', '%20') + '&key=' + APIKey; 
                system.debug('APIUrl is ' + APIUrl);
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setEndpoint(APIURL);
                Http http = new Http();
                HttpResponse res = http.send(req);
                Integer statusCode = res.getStatusCode();
                system.debug('statusCode is ' + statusCode);
                if(statusCode == 200){
                    system.debug('API invoked successfully');
                    result = res.getBody();
                }
            }
        }
        catch(exception e){
            //Handling exception
            system.debug(e.getMessage());
        }
        return result;
    }
}