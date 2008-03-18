import sk.prasa.webapis.generic.IPicasaService;
import sk.prasa.webapis.picasa.core.Auth;
import sk.prasa.webapis.generic.DynamicXMLService;
import sk.prasa.webapis.generic.IXMLService;
import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.events.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.core.MethodGroupHelper
{
	private static var __instance : MethodGroupHelper;

	private function MethodGroupHelper()
	{
	}
	
	public static function getInstance() : MethodGroupHelper
	{
		if(!__instance) __instance = new MethodGroupHelper();
		
		return __instance;
	}

	public function invokeMethod(service : IPicasaService, callBack : Function, signed : Boolean, suffix : String, params : UrlParams) : Void
	{
		var s : String = (suffix != "" && suffix != "") ? suffix : "";		
		var q : String = "" + s + "" + params.toString();
		
		trace("loading: " + Auth.FEEDS_POINT + q);
		
		var l : IXMLService = service.getXMLService();
			l.addEventListener(DynamicXMLService.onLoadInitEVENT, callBack);
			l.load(Auth.FEEDS_POINT + q);
	}
	
	public function processAndDispatch(service : IPicasaService, response : Object, result : PicasaResultEvent, parseFunction : Function) : Void 
	{
		var tRsp : Object = processResponse(response, parseFunction);

		result.success = tRsp.success;
		result.data = tRsp.data;
		result.error = tRsp.error;

		service.broadcastEvent(result);
	}
	
	public function processResponse(picasaResponse : Object, parseFunction : Function):Object
	{
		var tResult : Object = {};
			tResult.data = {};
			tResult.error = {};
		
		if (picasaResponse.error == null)
		{
			tResult.success = true;
			tResult.data = (parseFunction == null) ? picasaResponse : parseFunction(picasaResponse);			
		} else
		{
			tResult.success = false;
			tResult.error = new PicasaError(picasaResponse.error.message);
		}
		
		return tResult;			
	}
	
	
	public function parsePhotoList(o : Object) : Array
	{
		var tRes : Array = [];
		
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
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
	
	public function parseAlbumList(o : Object) : Array
	{
		var tRes : Array = [];
		
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
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
	
	public function parseCommentList(o : Object) : Array
	{
		var tRes : Array = [];
		
		// there is more than one entry
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
			{
				var tComment : Comment = new Comment(o.entry[a]);
				
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
	
	public function parseTagList(o : Object):Array
	{
		var tRes : Array = [];
		
		// there is more than one tag
		if(o.entry instanceof Array)
		{
			for(var a : Number = 0; a < o.entry.length; a++)
			{
				var tTag : Tag = new Tag(o.entry[a]);
				
				tRes.push(tTag);
			}
		} else
		{
			// there are no tags?
			if(o.entry != undefined)
			{
				var tSingleTag : Tag = new Tag(o.entry);
				
				tRes.push(tSingleTag);
			}
		}
		
		return tRes;
	}

	public function parseCommunityPhotoList(o : Object) : Array
	{
		return parsePhotoList(o);
	}
}