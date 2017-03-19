# mv
mind valley

-architecture diagram is attahced as architecture.png  

-minimum supported iOS version is 8.0. Built with Xcode8.1 Swift3. Static library built in Objective-C.  
-resource download library is present in ResourceManager folder within the app project. ResourceManager.xcodeproj.
-pinterest app - mv.xcodeproj.

-ListViewController - demands resource from Resource Manager.   
1.Resource Manager fetches the resource from CacheService or APIService depending on situation.  
2.Resource Manager takes care of cancelling a resource fetch if demanded by a sender.  
3.Resource Manager ensures only 1 api call is made for multiple requests of same resource.  

-Cache capacity  
1.cache count can be changed in configuration.h file in the library.  
2.LRU policy is maintainted. Whenever resource is fetched from cache, the resource is added to start of list.   
Upon capacity breach, the elements at the end of the list are evicted.

-Animation:  
1.long press gesture for animation is done on cells. Long press a cell to hide other cells. Similar to pinterest pin board.  
2.Pull to refresh makes same api call and appends new data at the top of list and refreshes tableview.  
3.Autolayout is used for cells.

-Pagination:  
1.Paginated API not available,hence pagination not implemented. But placeholders exists for this functionality.  

-UI Tests and Unit tests  
1.unit tests and UI tests implemented for both app and the library. Pressing command+U will execute these test cases.  

-Resource Manager contains Receiverdictionary.  
1.This dictionary contains the receivers to be notified when api call fetches data for a resource from API.  
receiver dictionary is made an atomic resource as simultaneous read/write/delete operations take place and  
it’s important to synchronize setters and getters. The add operation to receiver dictionary is synchronized  
block to ensure only 1 thread is adding value at a single time..  
2.CacheService maintains resource list which is atomic - to ensure setters and getters are synchronized.   
Lot of operations happen simultaneously on these 2 variables - Receiver dictionary and Cache Resource List.  

-Resource fetch cancellation  
1.while 2 senders request for same resource (and the resource is not present in cache),  
only 1 api call is made and both sender are updated with data.   
if present in cache, both senders are returned data from cache directly.  
2.while 2 senders request for same resource, and api call is made, then one sender cancels the request,  
the other sender is updated with data once api call returns with Data. If both of them cancel, resource is downloaded  
 and cached.  

-Network Manager  
1.data(contents url ) used for image download, because calling simple image download is light weight that way.   
2.api call is made with nsurlsession however.  

-Scalability  
1.Resource manager can handle any resource as long as it's identified by a url, be it png, or pdf or txt etc.  
2.New tableViewcells can be inherited from BaseTableViewCell and cellModel can inhert from BaseModel, and by doing so,   
the cellForRowAtIndexPath method size remains the same with increasing types of cells.  

Static library  
1.made for both simulator and device. The folder for Library is ResourceManager within the main project folder:mv.  
Resource Manager contains xcodeproj for building static library.  
