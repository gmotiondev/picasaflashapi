package business 
{
	import com.bourre.model.ModelLocator;
	
	import command.IDelegateReceiver;
	
	import model.ModelApplication;
	import model.ModelList;
	
	import sk.prasa.webapis.picasa.PicasaError;
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.events.PicasaErrorEvent;
	import sk.prasa.webapis.picasa.events.PicasaResultEvent;	
	
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
			var tResp : PicasaResponder = service.photos.list(aUserid, aAlbumid);
				tResp.addEventListener(PicasaResultEvent.COMPLETE, list_complete);
				tResp.addEventListener(PicasaErrorEvent.ERROR, list_failed);
		}

		private function list_failed(evt : PicasaErrorEvent) : void
		{
			receiver.fault(new PicasaError(evt.text));
		}

		private function list_complete(evt : PicasaResultEvent) : void
		{			
			try
			{
				receiver.result(evt.data);
			} catch(e : Error)
			{
				trace("list_complete failed: " + e.message);
			} 
		}
	}
}
