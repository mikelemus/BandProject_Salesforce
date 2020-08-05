public with sharing class BandController {
   
    @AuraEnabled(Cacheable=true)
    public static Band__c[]  getAllBands() {
        
        Band__c[] bandsArray = [SELECT Name, Genre__c FROM Band__c ORDER BY Name];   
        return bandsArray;
          

    }
    @AuraEnabled
    public static Album__c[] getAllAlbums(){

        Album__c[] albumsArray = [SELECT Name, Cover_Album__c, Release_Date__c FROM Album__c ORDER BY Release_Date__c];
        return albumsArray;
    }

    @AuraEnabled
    public static Song__c[] getAllSongs(){

        Song__c[] songsArray = [SELECT Name, Album__r.Name FROM Song__c];
        return songsArray;
    }

    @AuraEnabled 
    public static List<AlbumWrapper> init(){
       
        List<AlbumWrapper> albumWrapperList = new List<AlbumWrapper>();

        Band__c[] bandsArray = [SELECT Id, Name, Genre__c FROM Band__c WHERE Name = 'Counting Crows'];
        
        if (!bandsArray.isEmpty()) {

            Band__c band = bandsArray[0]; 

            Album__c[] albumsArray = [SELECT Id, Name, Cover_Album__c, Release_Date__c FROM Album__c WHERE Band__c = :band.Id ORDER BY Release_Date__c];
           
            Set<Id> albumsIds = new Set<Id>();
            for (Album__c album : albumsArray) {

                albumsIds.add(album.Id);
            }
           
            Song__c[] songsArray = [SELECT Name, Album__c, Album__r.Name FROM Song__c WHERE Album__c IN :albumsIds];
           
            for (Album__c album : albumsArray){ 

                List<Song__c> songsPerAlbumsList = new List<Song__c>();
                
                for(Song__c song : songsArray){

                    if(song.Album__c == album.Id){ 

                        songsPerAlbumsList.add(song);
                    }

                }
               
                AlbumWrapper wrapper = new AlbumWrapper();
                wrapper.albumName = album.Name;
                wrapper.albumReleaseDate = album.Release_Date__c;
                wrapper.albumCover = album.Cover_Album__c;
                wrapper.albumSongList = songsPerAlbumsList;
                albumWrapperList.add(wrapper);
            }
        }

        return albumWrapperList;

    }
 
    public class AlbumWrapper {

        
        @AuraEnabled
        public String albumName;
        
        @AuraEnabled
        public Date albumReleaseDate;

        @AuraEnabled
        public String albumCover;

        @AuraEnabled
        public List<Song__c> albumSongList;

        @AuraEnabled
        public Boolean showSongs = false;
    }

}
