package business 
{
	import flash.events.IOErrorEvent;	
	import flash.errors.IOError;	
	import flash.events.ErrorEvent;
	
	import com.bourre.model.ModelLocator;
	
	import command.IDelegateReceiver;
	
	import model.ModelApplication;
	import model.ModelList;
	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;		
	
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
				tResp.addEventListener(PicasaDataEvent.DATA, list_complete);
				tResp.addEventListener(ErrorEvent.ERROR, list_failed);
				tResp.addEventListener(IOErrorEvent.IO_ERROR, list_failed);
		}

		private function list_failed(evt : ErrorEvent) : void
		{
			receiver.fault(new Error(evt.text));
		}

		private function list_complete(evt : PicasaDataEvent) : void
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
