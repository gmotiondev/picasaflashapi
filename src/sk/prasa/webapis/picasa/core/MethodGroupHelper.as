/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.webapis.picasa.core.*;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import com.bourre.data.libs.XMLToObject;

class sk.prasa.webapis.picasa.core.MethodGroupHelper
{
	public static function invokeMethod(service:PicasaService, 
										callBack:Function, 
										signed:Boolean,
										params:Array):Void
	{
			
		// Create an array to store our name/value pairs
		// for the query because during signing we need to sort
		// these alphabetically
		var args:Array = new Array();
		
		//args.push(new NameValuePair("api_key", service.api_key));
		//args.push(new NameValuePair("method", method));
		
		
		// Loop over the params and add them as arguments
		for(var i:Number = 0; i < params.length; i++)
		{
			// Do we have an argument name, or do we create one
			if (params[i] instanceof NameValuePair)
			{
				args.push(params[i]);
			} else
			{
				// Create a unique argument name using our loop counter
				args.push(new NameValuePair("param"+i, params[i].toString()));
			}
		}
		
		/*
		// If a user is authenticated, automatically add their token
		if (service.permission != AuthPerm.NONE && service.token)
		{
			args.push(new NameValuePair( "auth_token", service.token));
			// auto-sign the call because the user is authenticated
			signed = true;
		}
		*/
		/*
		// Sign the call if we have to, or if the user is logged in
		if (signed)
		{	
			// sign the call according to the documentation point #8
			// here: http://www.flickr.com/services/api/auth.spec.html
			args.sortOn( "name" );
			var sig:String = service.secret;
			for ( var j:int = 0; j < args.length; j++ ) {
				sig += args[j].name.toString() + args[j].value.toString();	
			}	
			args.push( new NameValuePair( "api_sig", MD5.hash( sig ) ) );
		}
		*/
		
		// Construct the query string to send to the Flickr service
		var query:String = "";
		for (var k:Number = 0; k < args.length; k++ )
		{
			// This puts 1 too many "&" on the end, but that doesn't
			// affect the flickr call, so it doesn't matter
			query += args[k].name + "=" + args[k].value + "&";	
		}
		
		// Use the "internal" flickrservice namespace to be able to
		// access the urlLoader so we can make the request.
		var loader:XMLToObject = service.xmlLoader;
		
		// Construct a url request with our query string and invoke
		// the Flickr method
		loader.addEventListener(XMLToObject.onLoadInitEVENT, callBack);
		loader.addEventListener(XMLToObject.onErrorEVENT, onError);
		loader.load(PicasaService.END_POINT + query);
		
		trace("loading: "+PicasaService.END_POINT + query);
	}
	
	private static function onError(e:Object)
	{
		trace("e: "+e);
	}
	
	public static function processAndDispatch(service:PicasaService, response:Object, result:PicasaResultEvent, parseFunction:Function):Void 
	{
		// Process the response to create an object for return values
		var rsp:Object = processResponse(response, parseFunction);

		// Copy some properties from the response to the result event
		result.success = rsp.success;
		result.data = rsp.data;

		// Notify everyone listening
		service.dispatchEvent( result );
	}
	
	public static function processResponse(picasaResponse:Object, parseFunction:Function):Object
	{
		var result:Object = {};
			result.data = {};
			result.error = {};
			
		if (picasaResponse.id != null)
		{
			result.success = true;
			
			if(parseFunction == null)
			{
				result.data = picasaResponse;
			} else
			{
				result.data = parseFunction(picasaResponse);	
			}			
		} else
		{
			result.success = false;
			
			var error:PicasaError = new PicasaError();
				error.code = -1;
				error.message = picasaResponse.toString();
				
				result.error = error;
		}
		
		return result;			
	}
	
	
	public static function parsePhotoList(o:Object):Void
	{
		// o should be a parsed xml to object
		trace("parsePhotoList: "+o);
	}
}