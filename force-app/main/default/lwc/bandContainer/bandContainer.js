import { LightningElement, track } from 'lwc';

import init from '@salesforce/apex/BandController.init';
import AlbumCovers from '@salesforce/resourceUrl/AlbumCovers';
//import AugustAndEverythingAfter from '@salesforce/resourceUrl/AugustAndEverythingAfter';
//import RecoveringTheSatellites from '@salesforce/resourceUrl/RecoveringTheSatellites';
//import ThisDesertLife from '@salesforce/resourceUrl/ThisDesertLife';
//import HardCandy from '@salesforce/resourceUrl/HardCandy';
//import SaturdayNightsSundayMornings from '@salesforce/resourceUrl/SaturdayNightsSundayMornings';
//import SomewhereUnderWonderland from '@salesforce/resourceUrl/SomewhereUnderWonderland';




export default class BandController extends LightningElement {

	AugustAndEverythingAfter = AlbumCovers + '/AlbumCovers/AugustAndEverythingAfter.jpeg';
	/* RecoveringTheSatellites = AlbumCovers +  '/resource/1594934602000/AlbumCovers' ;
	ThisDesertLife = AlbumCovers +  '/resource/1594934602000/AlbumCovers';
	HardCandy = AlbumCovers +  '/resource/1594934602000/AlbumCovers';
	SaturdayNightsSundayMornings = AlbumCovers +  '/resource/1594934602000/AlbumCovers';
	SomewhereUnderWonderland = AlbumCovers +  '/resource/1594934602000/AlbumCovers'; */
	
	@track albums;
	@track error;
	
	connectedCallback() {
		console.log(AlbumCovers);
		this.initialize();
		
		
	}
	initialize() {
		init()
		
			.then(result => {
				
				this.albums = result;
				
				for (var j=0; j<this.albums.length; j++){

					this.albums[j].albumCover = AlbumCovers + '/AlbumCovers/'+this.albums[j].albumCover+'.jpeg';

					console.log('album name: ' + this.albums[j].albumName );
					console.log('album release date: ' + this.albums[j].albumReleaseDate );
					console.log('album cover: ' + this.albums[j].albumCover );


	
					for (var i=0; i<this.albums[j].albumSongList.length; i++){
	
						console.log('album songs: ' + this.albums[j].albumSongList[i].Name);
						
					}
				}
			})
			.catch(error => {
				this.error = error;
			});
		}

	 	Sz(event){
			var position = event.target.value;
			


			if (this.albums[position].showSongs == true){

				

				this.albums[position].showSongs = false;
			}
			else {
				this.albums[position].showSongs = true;
				
			}
			
		}

}

	

