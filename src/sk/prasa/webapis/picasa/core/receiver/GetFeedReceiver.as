/*
 * The MIT License
 * 
 * Copyright (c) 2008 Michal Gron (michal.gron@gmail.com)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;
	import sk.prasa.webapis.picasa.objects.feed.AtomFeed;
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	
	/**
	 * Receives and XML instance from GetFeedCommand.
	 * TODO: ... ERROR handling is here poor! what if passed wrong argument or wrong argument value?
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public class GetFeedReceiver implements IReceiver
	{
		private var __responder : PicasaResponder;

		public function GetFeedReceiver()
		{
			__responder = new PicasaResponder();
		}
		
		/**
		 * Called when XML loading is complete. 
		 * 
		 * @param response XML Loaded XML document.
		 */
		public function process(response : XML) : void 
		{
			try
			{
				var tEvt : PicasaDataEvent = new PicasaDataEvent(PicasaDataEvent.DATA);
					tEvt.data = parse(response);
					
				responder.dispatchEvent(tEvt);
			} catch(e : Error)
			{
				trace("gooooing to throw!");
				throw new Error(e);
			}
		}

		/**
		 * Parse received XML document. 
		 * 
		 * TODO: ... RSS projection?.. make this factory method?
		 */
		protected function parse(aFeed : XML) : IAtom
		{
			var tFeed : IAtom = new AtomFeed(aFeed);
			return tFeed;
		}

		public function get responder() : PicasaResponder
		{
			return __responder;
		}
		
		/** 
		 * When the result event from the URLLoader is received.
		 */
		public function result(evt : Event) : void
		{
			var loader : URLLoader = URLLoader(evt.target); 
			process(new XML(loader.data));
		}

		/**
		 * When the fault event from the URLLoader is received. 
		 */
//		public function fault(evt : ErrorEvent) : void
//		{
//			responder.dispatchEvent(evt);
//		}

		/**
		 * When the URLLoader dispatches ProgressEvent, redispatch it.
		 */
//		public function progress(evt : ProgressEvent) : void
//		{
//			responder.dispatchEvent(evt);
//		}

		/** 
		 * The URLLoader has dispatched on Event.OPEN event.
		 */
//		public function open(evt : Event) : void
//		{
//			responder.dispatchEvent(evt);
//		}

		/**
		 * We have received an HTTPStatusEvent.STATUS from URLLoader.
		 * Usefull for determining errors.
		 */
//		public function status(evt : HTTPStatusEvent) : void
//		{
//			responder.dispatchEvent(evt);
//		}
	}
}