import com.bourre.data.collections.IndexedArray;
import com.bourre.data.iterator.Iterator;

import sk.prasa.webapis.picasa.Photo;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class vo.Photos extends IndexedArray
{
	private var __current:Number;
	
	// 
	public function Photos()
	{
	}
	
	// 
	public function getNext():String
	{
		if(++__current >= this.length || __current == null) __current = 0;
		return this[__current].gphoto.id;
	}
	
	// 
	public function getPrevious():String
	{
		if(--__current < 0) __current = this.length - 1;
		return this[__current].gphoto.id;
	}
	
	// 
	public function getCurrentUrl():String
	{
		return this[__current].media.content.url;
	}
	
	public function getPhotoById(aPhotoId : String) : Photo
	{
		var tIt : Iterator = getIterator();
		
		while(tIt.hasNext())
		{
			var tPhoto : Photo = tIt.next();
			
			if(tPhoto.gphoto.id == aPhotoId) return tPhoto;
		}
		
		return null;
	}

	public function getPhotosByAlbumId(aAlbumId : String) : IndexedArray
	{
		var tRes : IndexedArray = new IndexedArray();
		var tIt : Iterator = getIterator();
		
		while(tIt.hasNext())
		{
			var tPhoto : Photo = tIt.next();
			
			if(tPhoto.album.gphoto.id == aAlbumId) tRes.push(tPhoto);
		}
		
		return tRes;
	}
	
	public function containsAlbum(aAlbumId : String) : Boolean
	{
		return getPhotosByAlbumId(aAlbumId).length > 0;
	}
}