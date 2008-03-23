package business 
{
	import mx.collections.ArrayCollection;	
	
	import flash.events.Event;	
	
	import command.IDelegateReceiver;
	import model.ModelList;
	import model.ModelApplication;
	
	import sk.prasa.webapis.picasa.events.PicasaEvent;
	import sk.prasa.webapis.picasa.PicasaService;
	
	import com.bourre.model.ModelLocator;
		
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PhotosDelegate 
	{
		private var service : PicasaService; 
		private var receiver : IDelegateReceiver;

		public function PhotosDelegate(r : IDelegateReceiver)
		{
			receiver = r;
			service = ModelApplication(ModelLocator.getInstance().getModel(ModelList.MODEL_APPLICATION)).service;
		}
		public function list(aUserid : String, aAlbumid : String) : void
		{ 
			service.addEventListener(PicasaEvent.PHOTOS_GET_LIST, list_complete);
			service.photos.list(aUserid, aAlbumid);
		}
		
		public function list_complete(evt : Event) : void
		{			
			try
			{
				var tEvt : PicasaEvent = evt as PicasaEvent;
				
				if(tEvt.success)
				{
					receiver.result(tEvt.data);
				} else 
				{
					receiver.fault(tEvt.error);
				}
			} catch(e : Error)
			{
				trace("list_complete failed: "+e.message);
			} finally
			{
				service.removeEventListener(PicasaEvent.PHOTOS_GET_LIST, list_complete);
			}
		}
	}
}
