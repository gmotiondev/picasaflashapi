package sk.prasa.tools.model 
{
	import flash.events.IOErrorEvent;	
	import flash.events.ProgressEvent;	
	
	import sk.prasa.tools.model.vo.RequestVO;	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	import flash.events.ErrorEvent;	

	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class SimpleServiceProxy extends Proxy implements IProxy 
	{
		private var service : PicasaService;
		private var lastCommand : LastCommand;
		private var lastCount : int;
		private var START_INDEX : int;
		private var MAX_RESULTS : int;
		
		//public static const DATA_EVENT : String = "data_Event";
		//public static const ERROR_EVENT : String = "error_Event";
		
		public function SimpleServiceProxy(	name : String = "SimpleServiceProxy", 
											data : Object = null)
		{
			super(name, data);
			
			service = new PicasaService();
			service.thumbsize = request.thumbsize;
			service.imgmax = request.imgmax;
			service.start_index = request.start_index;
			service.max_results = request.max_results;
			
			START_INDEX = request.start_index;
			MAX_RESULTS = request.max_results;
		}

		public function getPhotosList(aUserID : String, aAlbumID : String) : void
		{
			lastCommand = new LastCommand(getPhotosList, aUserID, aAlbumID);
			
			var tResponder : PicasaResponder = service.photos.list(aUserID, aAlbumID);
				tResponder.addEventListener(PicasaDataEvent.DATA, result);
				tResponder.addEventListener(IOErrorEvent.IO_ERROR, fault);
				tResponder.addEventListener(ProgressEvent.PROGRESS, progress);
		}

		public function getPhotosListByTag(aUserID : String, aAlbumID : String, aTag : String) : void
		{
			lastCommand = new LastCommand(getPhotosListByTag, aUserID, aAlbumID, aTag);
			
			var tResponder : PicasaResponder = service.photos.list_by_tag(aUserID, aAlbumID, aTag);
				tResponder.addEventListener(PicasaDataEvent.DATA, result);
				tResponder.addEventListener(IOErrorEvent.IO_ERROR, fault);
				tResponder.addEventListener(ProgressEvent.PROGRESS, progress);
		}
		
		public function getListByTag(aUserID : String, aTag : String) : void
		{
			lastCommand = new LastCommand(getListByTag, aUserID, aTag);
			
			var tResponder : PicasaResponder = service.albums.list_by_tag(aUserID, aTag);
				tResponder.addEventListener(PicasaDataEvent.DATA, result);
				tResponder.addEventListener(IOErrorEvent.IO_ERROR, fault);
				tResponder.addEventListener(ProgressEvent.PROGRESS, progress);
		}
			
		public function getNextPage() : void
		{
			if(lastCommand != null && lastCount >= MAX_RESULTS)
			{
				service.start_index += service.max_results;
				lastCommand.execute();
			}
		}
		
		public function getPrevPage() : void
		{ 
			if(lastCommand != null && service.start_index > START_INDEX)
			{
				service.start_index = (service.start_index - service.max_results) >= 1 ? (service.start_index - service.max_results) : 1;
				lastCommand.execute();
			}
		}
		
		// if we have indexed navigation (1 2 3 4 5 ...)
		public function getCustomPage(aPageNumber : Number) : void
		{ 
			if(lastCommand != null)
			{
				service.start_index = service.max_results * aPageNumber - (service.max_results - 1);
				lastCommand.execute();
			}
		}
		
		protected function result(evt : PicasaDataEvent) : void
		{
			PicasaResponder(evt.target).removeEventListener(PicasaDataEvent.DATA, result);
			PicasaResponder(evt.target).removeEventListener(ErrorEvent.ERROR, fault);

			lastCount = evt.data.entries.length;
	
			//this.sendNotification(DATA_EVENT, evt.data);
		}

		protected function fault(evt : ErrorEvent) : void
		{
			PicasaResponder(evt.target).removeEventListener(PicasaDataEvent.DATA, result);
			PicasaResponder(evt.target).removeEventListener(ErrorEvent.ERROR, fault);
			
			//this.sendNotification(ERROR_EVENT, evt.text);
		}
		
		protected function progress(evt : ProgressEvent) : void
		{
		}

		public function get request() : RequestVO
		{
			return data as RequestVO;
		}
	}
}

class LastCommand
{
	public var func : Function;
	public var args : Array;
	
	public function LastCommand(fn : Function, ...rest : Array)
	{
		func = fn;
		args = rest;
	}
	
	public function execute() : void
	{
		func.apply(null, args);
	}
}
