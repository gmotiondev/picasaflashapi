package sk.prasa.examples.albumskeleton.model 
{
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import sk.prasa.examples.albumskeleton.model.vo.AlbumVO;
	import sk.prasa.examples.albumskeleton.model.vo.PhotoVO;
	import sk.prasa.webapis.picasa.objects.feed.AlbumFeed;
	import sk.prasa.webapis.picasa.objects.feed.AlbumMeta;
	import sk.prasa.webapis.picasa.objects.feed.PhotoEntry;		
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ContentProxy extends Proxy implements IProxy 
	{
		public static const NAME : String = "ContentProxy";
		
		public function ContentProxy(data : Object = null)
		{
			super(NAME, data);
		}
		
		public function getMeta() : AlbumVO
		{
			var tMeta : AlbumVO = new AlbumVO();
				tMeta.id = meta.id;
				
			return tMeta;
		}

		public function getEntries() : Array
		{
			var tEntries : Array = new Array();
			
			for each(var photo : PhotoEntry in feed.entries)
			{
				var tPhotoVO : PhotoVO = new PhotoVO();
					tPhotoVO.id = photo.gphoto.id;
					tPhotoVO.url = photo.media.content.url;
					tPhotoVO.thumb = photo.media.thumbnails[0].url;
				
				tEntries.push(tPhotoVO);
			}
			
			return tEntries;
		}
		
		public function getEntry(aID : String) : PhotoVO
		{
			for each(var photo : PhotoEntry in feed.entries)
			{
				if(aID == photo.gphoto.id)
				{
					var tPhotoVO : PhotoVO = new PhotoVO();
						tPhotoVO.id = photo.gphoto.id;
						tPhotoVO.url = photo.media.content.url;
						tPhotoVO.thumb = photo.media.thumbnails[0].url;
						
					return tPhotoVO;
				}
			}
			
			return null;
		}
		
		private function get feed() : AlbumFeed
		{
			return data as AlbumFeed;
		}
		
		private function get meta() : AlbumMeta
		{
			return feed.meta as AlbumMeta;
		} 
	}
}
