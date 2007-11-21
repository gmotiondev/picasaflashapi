/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.Album;
import sk.prasa.webapis.picasa.Comment;
import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.Tag;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.webapis.picasa.UrlParams;
import sk.prasa.webapis.picasa.User;
import sk.prasa.webapis.picasa.core.*;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import com.bourre.data.libs.XMLToObject;

class sk.prasa.webapis.picasa.core.MethodGroupHelper
{
	public static function invokeMethod(service:PicasaService, 
										callBack:Function, 
										signed:Boolean,
										suffix:String,
										url_params:UrlParams):Void
	{
			
		// Create an array to store our name/value pairs
		// for the query because during signing we need to sort
		// these alphabetically
		var args:Array = new Array();
		var tSuffix:String = (suffix != "" && suffix != "") ? suffix : "";
		//args.push(new NameValuePair("api_key", service.api_key));
		//args.push(new NameValuePair("method", method));
		
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
		

		var query:String = ""+tSuffix+""+url_params.toString();
		
		trace("loading: "+PicasaService.END_POINT + query);
		
		var tLoader:XMLToObject = service.xmlLoader;
			tLoader.addEventListener(XMLToObject.onLoadInitEVENT, callBack);
			
			tLoader.load(PicasaService.END_POINT + query);			
	}
	
	public static function processAndDispatch(service:PicasaService, response:Object, result:PicasaResultEvent, parseFunction:Function):Void 
	{
		// Process the response to create an object for return values
		var rsp:Object = processResponse(response, parseFunction);

		// Copy some properties from the response to the result event
		result.success = rsp.success;
		result.data = rsp.data;
		result.error = rsp.error;

		service.broadcastEvent(result);
	}
	
	public static function processResponse(picasaResponse:Object, parseFunction:Function):Object
	{
		//trace(picasaResponse.error.code+":"+picasaResponse.error.message);
		
		var result:Object = {};
			result.data = {};
			result.error = {};
		
		if (picasaResponse.error == null)
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
				error.code = picasaResponse.error.code;
				error.message = picasaResponse.error.message;
				
				result.error = error;
		}
		
		return result;			
	}
	
	
	public static function parsePhotoList(o:Object):Array
	{
		var tRes:Array = [];
		
		if(o.entry instanceof Array)
		{
			for(var a:Number = 0; a < o.entry.length; a++)
			{
				var tPhoto:Photo = new Photo(o.entry[a]);
					tPhoto.album = new Album(o); 
				tRes.push(tPhoto);
			}
		} else
		{
			// there are no photos?
			if(o.entry != undefined)
			{
				var tSinglePhoto:Photo = new Photo(o.entry);
					tSinglePhoto.album = new Album(o); 
				tRes.push(tSinglePhoto);
			}
		}
		
		// o should be a parsed xml to object
		return tRes;
	}
	
	public static function parseAlbumList(o:Object):Array
	{
		var tRes:Array = [];
		
		if(o.entry instanceof Array)
		{
			for(var a:Number = 0; a < o.entry.length; a++)
			{
				var tAlbum:Album = new Album(o.entry[a]);
					tAlbum.user = new User(o);
				tRes.push(tAlbum);
			}
		} else
		{
			// there are no albums?
			if(o.entry != undefined)
			{
				var tSingleAlbum:Album = new Album(o.entry);
					tSingleAlbum.user = new User(o);
				tRes.push(tSingleAlbum);
			}
		}
		
		// o should be a parsed xml to object
		return tRes;
	}
	
	public static function parseCommentList(o:Object):Array
	{
		var tRes:Array = [];
		// there is more than one entry
		if(o.entry instanceof Array)
		{
			for(var a:Number = 0; a < o.entry.length; a++)
			{
				var tComment:Comment = new Comment(o.entry[a]);
				
				tRes.push(tComment);
			}
		} else
		{
			// there are no comments?
			if(o.entry != undefined)
			{
				var tSingleComment:Comment = new Comment(o.entry);
				tRes.push(tSingleComment);
			}
		}
		
		return tRes;
	}
	
	public static function parseTagList(o:Object):Array
	{
		var tRes:Array = [];
		
		// there is more than one tag
		if(o.entry instanceof Array)
		{
			for(var a:Number = 0; a < o.entry.length; a++)
			{
				var tTag:Tag = new Tag(o.entry[a]);
				tRes.push(tTag);
			}
		} else
		{
			// there are no tags?
			if(o.entry != undefined)
			{
				var tSingleTag:Tag = new Tag(o.entry);
				tRes.push(tSingleTag);
			}
		}
		
		return tRes;
	}

	public static function parseCommunityPhotoList(o:Object):Array
	{
		return MethodGroupHelper.parsePhotoList(o);
	}
	
	public static function mergeUrlParams(service:PicasaService,request:UrlParams):UrlParams
	{
		// request params have priority before service params
		
		var tRes:UrlParams = new UrlParams(
			 service.access
			,service.thumbsize
			,service.imgmax
			,service.max_results
			,service.start_index);
			
		if(request.access) tRes.access = request.access;
		
		if(request.thumbsize) tRes.thumbsize = request.thumbsize;
		if(request.imgmax) tRes.imgmax = request.imgmax;
		if(request.max_results) tRes.max_results = request.max_results;
		if(request.start_index) tRes.start_index = request.start_index;
		
		return tRes;
	}
}