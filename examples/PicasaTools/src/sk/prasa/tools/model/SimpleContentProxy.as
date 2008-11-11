package sk.prasa.tools.model 
{
	import sk.prasa.tools.model.vo.AlbumVO;
	import sk.prasa.tools.model.vo.PhotoVO;
	import sk.prasa.webapis.picasa.objects.GPhoto;
	import sk.prasa.webapis.picasa.objects.Link;
	import sk.prasa.webapis.picasa.objects.Links;
	import sk.prasa.webapis.picasa.objects.feed.AlbumMeta;
	import sk.prasa.webapis.picasa.objects.feed.AtomFeed;
	import sk.prasa.webapis.picasa.objects.feed.PhotoEntry;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class SimpleContentProxy extends Proxy implements IProxy
	{
		private var __current : int = 0;
		
		public function SimpleContentProxy(name : String = "SimpleModelProxy", data : Object = null)
		{
			super(name, data);
		}
		
		/**
		 * 
		 */
		public function getMeta() : AlbumVO
		{
			var tMeta : AlbumVO = new AlbumVO();
				tMeta.id = meta.id;
				
			return tMeta;
		}
		
		/**
		 * 
		 */
		public function getEntries() : Array
		{
			var tEntries : Array = new Array();
			
			for each(var photo : PhotoEntry in feed.entries)
			{
				tEntries.push(createVO(photo));
			}
			
			return tEntries;
		}
		
		/**
		 * 
		 */
		public function getEntry(aID : String = null) : PhotoVO
		{
			var tID : String = aID != null ? aID : getCurrent();
			 
			for each(var photo : PhotoEntry in feed.entries)
			{
				if(tID == photo.gphoto.id)
				{
					setCurrent(tID);
					return createVO(photo);
				}
			}
			
			return null;
		}
		
		public function get totalEntries() : int
		{
			return (feed != null && feed.entries != null) ? feed.entries.length : 0;
		}
		
		public function get currentEntry() : int
		{
			return (totalEntries > 0) ? __current + 1 : 0;
		}

		/**
		 * 
		 */
		public function getNextPhoto() : String
		{
			if(++__current >= feed.entries.length || isNaN(__current)) __current = 0;
			
			return getCurrent();
		}
		
		/**
		 * 
		 */
		public function getPrevPhoto() : String
		{
			if(--__current < 0 || isNaN(__current)) __current = feed.entries.length - 1;
			
			return getCurrent();
		}
		
		/**
		 * 
		 */
		public function getPrevPageURL() : String
		{
			return Links(meta.links).getByRel(Link.REL_PREV).href;
		}
		
		/**
		 * 
		 */
		public function getNextPageURL() : String
		{
			return Links(meta.links).getByRel(Link.REL_NEXT).href;
		}
		
		/**
		 * get current id
		 */
		private function getCurrent() : String
		{
			return PhotoEntry(feed.entries[__current]).gphoto.id;			
		}
		
		/**
		 * set id as current
		 */
		private function setCurrent(aID : String) : void
		{
			var tPos : int = 0;
		
			for each(var photo : PhotoEntry in feed.entries)
			{
				if(aID == photo.gphoto.id)
				{
					__current = tPos;
				}
				
				tPos++;
			}
		}
		
		/**
		 * 
		 */
		private function createVO(aEntry : PhotoEntry) : PhotoVO
		{
			var tPhotoVO : PhotoVO = new PhotoVO();
				tPhotoVO.id = aEntry.gphoto.id;
				tPhotoVO.url = aEntry.media.content.url;
				tPhotoVO.thumb = aEntry.media.thumbnails[0].url;
				tPhotoVO.title = aEntry.summary;
						
				return tPhotoVO;
		}
		
		/**
		 * 
		 */
		private function get feed() : AtomFeed
		{
			return data as AtomFeed;
		}
		
		/**
		 * 
		 */
		private function get meta() : AlbumMeta
		{
			return feed.meta as AlbumMeta;
		} 
	}
}
