﻿import com.bourre.commands.Command;
import com.bourre.commands.Delegate;
import com.bourre.core.Model;
import com.bourre.events.BasicEvent;
import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;

import events.EventList;
import uis.uilist;
import uis.Thumb;
import uis.Photo;
import models.*;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class controllers.ServiceLoaded implements Command
{
	public function execute(e:BasicEvent):Void 
	{
		var tModel = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		var tPPS:Picasa.AlbumService = tModel.getAlbumService();
		var tCurrentOnFinished:String = "";
		var tContainer = MovieClipHelper.getMovieClipHelper(uilist.THUMBS).view;
		var tPhotoContainer = MovieClipHelper.getMovieClipHelper(uilist.PHOTO).view;
		
		for(var a = 0; a < tPPS.getPhotosCount(); a++)
		{
			var tPP:Picasa.Photo = tPPS.getNextPhoto();
			var tID:String = tPP.getIdString();
			
			if(!Thumb.exists(tID))
			{
				if(a == 0) tCurrentOnFinished = tID;
				
				var tThumb:Thumb = new Thumb(tID, tContainer, false);

					tModel.addEventListener(EventList.PHOTO_THUMB_CLICK,tThumb);

					tThumb.move(0,(a*70));
					tThumb.setTitle(tPP.getTitle()+"<br/>"+tPP.getSummary());
					tThumb.getButton().onRelease = Delegate.create(this, notify, tPP);
					tThumb.load(tPP.getThumbnailLink());
				
				//preload photos
				var tPhoto:Photo = new Photo(tID,tPhotoContainer,(a != 0));
					tPhoto.setTitle(tPP.getSummary()+"("+tPP.getTitle()+")")
					tModel.addListener(tPhoto);
					tPhoto.load(tPP.getLink());
			} else {
				trace("Thumb "+tID+" already exists. Skipping!",Log.WARNING);
			}
		}
		tModel.setCurrentPhoto(tCurrentOnFinished);
	}
	
	public function notify(aPP:Picasa.Photo):Void
	{
		ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).PhotoThumbClick(aPP);
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}