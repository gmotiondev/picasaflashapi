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

package sk.prasa.webapis.picasa
{
	import flash.net.URLRequest;	
	import flash.net.URLLoader;	
	//import flash.events.EventDispatcher;
	//import flash.events.IEventDispatcher;
	
	//[Event(name="open", type="flash.events.Event")]
	//[Event(name="data", type="sk.prasa.webapis.picasa.events.PicasaDataEvent")]
	//[Event(name="progress", type="flash.events.ProgressEvent")]
	//[Event(name="error", type="flash.events.ErrorEvent")]
	//[Event(name="status", type="flash.events.HTTPStatusEvent")]
	/**
	 * Picasa responder. Dispatches basic Picasa events.
	 * 
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	//public class PicasaResponder extends EventDispatcher
	public class PicasaResponder extends URLLoader
	{
		/**
		 * PicasaResponder Constructor.
		 * 
		 * Responder is created by main Picasa methods. Each Picasa method returns a PicasaResponder
		 * to listen for basic Picasa events. 
		 * 
		 * @param target IEventDispatcher
		 */
		//public function PicasaResponder(target : IEventDispatcher = null)
		public function PicasaResponder(request : URLRequest = null)
		{
			super(request);
		}
	}
}