import control.LoadThumbsEvent;

import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import control.GetAlbumEvent;
import control.LoadPhotoEvent;

import vo.Photos;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.visual.mvc.model.AbstractModel;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class model.MiniLiteModel extends AbstractModel 
{
	public var service : PicasaService;
	public var photos : Photos;

	public static var USERID : String = "thisispinkfu";
	public static var ALBUMID : String = "5135051345581734225";
	
	public function MiniLiteModel()
	{
		super();
	}
	
	public function initialize() : Void
	{
		photos = Photos.getInstance();
		
		service = new PicasaService();
		service.start_index = 1;
		service.max_results = 9;
		service.thumbsize = 48;
		service.imgmax = 144;
		
		service.addEventListener(PicasaService.ERROR, this);
		
		getAlbumCommand(new GetAlbumEvent(USERID, ALBUMID));
	}
	
	private function getAlbumCommand(evt : GetAlbumEvent) : Void
	{
		service.addEventListener(PicasaService.PROGRESS, this); 
		service.addEventListener(PicasaResultEvent.PHOTOS_GET_LIST, this);
		service.photos.list(evt.userid, evt.albumid);
	}
	
	private function photosGetList(evt : PicasaResultEvent)
	{
		try
		{
			if(evt.success)
			{
				for(var a : Number = 0; a < evt.data.length; a++)
				{
					var tPhoto : Photo = evt.data[a];
					photos.push(tPhoto);
				}
				
				trace("got: "+photos.length+" photos!");
				loadThumbsCommand();
				
			} else
			{
				trace(evt.error);
			}
		} catch(error:Error)
		{
			trace("photosGetList failed: "+error.message);
		} finally
		{
			service.removeEventListener(PicasaResultEvent.PHOTOS_GET_LIST, this);
		}
	}
	
	private function loadThumbsCommand() : Void
	{
		trace("MiniLiteModel.loadThumbsCommand()");
		var tRes : Array = [];
		for(var a : Number = 0; a < photos.length; a++)
		{
			tRes.push({id:photos[a].gphoto.id, url:photos[a].media.thumbnail[0].url});
		}
		setChanged();
		notifyChanged(new LoadThumbsEvent(tRes));
	}

	public function next() : Void
	{
		var tId:String = photos.getNext();
		var tUrl : String = photos.getCurrentUrl();
//		var tTitle:String = photos.getCurrentTitle();
		
//		notifyChanged(new PhotoChangedEvent(tId, tTitle));
		notifyChanged(new LoadPhotoEvent(tId, tUrl));
	}
	
	public function prev() : Void
	{
		var tId:String = photos.getPrevious();
		var tUrl : String = photos.getCurrentUrl();
//		var tTitle:String = photos.getCurrentTitle();

//		notifyChanged(new PhotoChangedEvent(tId, tTitle));
		notifyChanged(new LoadPhotoEvent(tId, tUrl));
	}
	
	public function click(aId : String) : Void
	{
		photos.setClicked(aId);

		var tId:String = photos.getCurrentId();
		var tUrl : String = photos.getCurrentUrl();
//		var tTitle : String = photos.getCurrentTitle();
		
		notifyChanged(new LoadPhotoEvent(tId, tUrl));
//		notifyChanged(new PhotoChangedEvent(tId, tTitle));
	}
	
	public function progress(evt) : Void
	{
		trace("progress");
	}
	
	public function error(evt) : Void
	{
		trace("error");
	}
}
