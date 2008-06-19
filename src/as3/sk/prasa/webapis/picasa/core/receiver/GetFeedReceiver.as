package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;
	import sk.prasa.webapis.picasa.objects.feed.Atom;
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 * @private
	 */
	public class GetFeedReceiver implements IReceiver
	{
		private var __responder : PicasaResponder;

		public function GetFeedReceiver()
		{
			__responder = new PicasaResponder();
		}

		public function process(response : XML) : void 
		{
			try
			{
				var tEvt : PicasaDataEvent = new PicasaDataEvent(PicasaDataEvent.DATA);
					tEvt.data = parse(response);
					
				responder.dispatchEvent(tEvt);
			} catch(e : Error)
			{
				throw new Error(e);
			}
		}

		protected function parse(aFeed : XML) : IAtom
		{
			var tFeed : IAtom = new Atom(aFeed);
			return tFeed;
		}

		public function get responder() : PicasaResponder
		{
			return __responder;
		}

		public function result(evt : Event) : void
		{
			var loader : URLLoader = URLLoader(evt.target); 
			process(new XML(loader.data));
		}

		public function fault(evt : ErrorEvent) : void
		{
			responder.dispatchEvent(evt);
		}

		public function progress(evt : ProgressEvent) : void
		{
			responder.dispatchEvent(evt);
		}

		public function open(evt : Event) : void
		{
			responder.dispatchEvent(evt);
		}

		public function status(evt : HTTPStatusEvent) : void
		{
			responder.dispatchEvent(evt);
		}
	}
}