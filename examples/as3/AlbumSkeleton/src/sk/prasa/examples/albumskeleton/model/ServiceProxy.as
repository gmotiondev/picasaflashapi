package sk.prasa.examples.albumskeleton.model 
{
	import flash.events.ErrorEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.observer.Notifier;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import sk.prasa.examples.albumskeleton.ApplicationFacade;
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class ServiceProxy extends Proxy implements IProxy 
	{
		private var service : PicasaService;

		public static const NAME : String = "ServiceProxy";
		
		public static var THUMBSIZE : String = "64c";
		public static var IMGMAX : String = "320";
		public static var MAX_RESULTS : int = 20;
		public static var START_INDEX : int = 1;
		
		public function ServiceProxy(data : Object = null)
		{
			super(NAME, data);
			
			service = new PicasaService();
			service.thumbsize = THUMBSIZE;
			service.imgmax = IMGMAX;
			service.max_results = MAX_RESULTS;
			service.start_index = 1;
		}

		// if we have indexed navigation (1 2 3 4 5 ...)
//		public function setPage(aPageNumber : Number) : void
//		{
//			service.start_index = service.max_results * aPageNumber - (service.max_results - 1);
//		}
	
		// next page button clicked
//		public function setNextPage() : void
//		{
//			service.start_index += service.max_results;
//		}
	
		// prev page button clicked
//		public function setPrevPage() : void
//		{
//			//service.start_index = (service.start_index - service.max_results) >= 1 ? (service.start_index - service.max_results) : 1;
//		}
			
		public function getPhotosList(aUserID : String, aAlbumID : String) : void
		{
			var tResponder : PicasaResponder = service.photos.list(aUserID, aAlbumID);
				tResponder.addEventListener(PicasaDataEvent.DATA, result);
				tResponder.addEventListener(ErrorEvent.ERROR, fault);
		}

		public function getPhotosListByTag(aUserID : String, aAlbumID : String, aTag : String) : void
		{
			var tResponder : PicasaResponder = service.photos.list_by_tag(aUserID, aAlbumID, aTag);
				tResponder.addEventListener(PicasaDataEvent.DATA, result);
				tResponder.addEventListener(ErrorEvent.ERROR, fault);
		}
			
		public function getNextPage() : void
		{
			// TODO: ... manualy create the feed url?
		}
		
		public function getPrevPage() : void
		{
			// TODO: ... manualy create the  feed url?
		}
		
		public function getCustomQuery(aURL : String) : void
		{
			/*var tResponder : PicasaResponder = service.photos.custom(aURL);
				tResponder.addEventListener(PicasaDataEvent.DATA, result);
				tResponder.addEventListener(ErrorEvent.ERROR, fault);
			 */
		}
		
		private function result(evt : PicasaDataEvent) : void
		{
			PicasaResponder(evt.target).removeEventListener(PicasaDataEvent.DATA, result);
			PicasaResponder(evt.target).removeEventListener(ErrorEvent.ERROR, fault);

			if(facade.hasProxy(ContentProxy.NAME))
			{
				facade.removeProxy(ContentProxy.NAME);
			}
			
			facade.registerProxy(new ContentProxy(evt.data));
	
			this.sendNotification(ApplicationFacade.DATA_EVENT);
		}

		private function fault(evt : ErrorEvent) : void
		{
			PicasaResponder(evt.target).removeEventListener(PicasaDataEvent.DATA, result);
			PicasaResponder(evt.target).removeEventListener(ErrorEvent.ERROR, fault);
			
			this.sendNotification(ApplicationFacade.ERROR_EVENT, evt.text);
		}
	}
}
