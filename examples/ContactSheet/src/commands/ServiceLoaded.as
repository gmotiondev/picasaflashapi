import com.bourre.commands.Command;
import com.bourre.commands.Delegate;
import com.bourre.core.Model;
import com.bourre.events.BasicEvent;
import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;

import events.EventList;
import view.ViewList;
import view.Thumb;
import view.Photo;
import model.*;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class commands.ServiceLoaded implements Command
{
	public function execute(e:BasicEvent):Void 
	{
		var tModel = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		var tPPS:Picasa.AlbumService = tModel.getAlbumService();
		var tContainer = MovieClipHelper.getMovieClipHelper(ViewList.THUMBS).view;
		var tPhotoContainer = MovieClipHelper.getMovieClipHelper(ViewList.PHOTO).view;
		var tLibStack:LibStack = new LibStack();
		
		var tLM:Picasa.tools.layout.GridLayout = new Picasa.tools.layout.GridLayout(6, 6);
			tLM.addListener(MovieClipHelper.getMovieClipHelper(ViewList.THUMBS));
			
		for(var a = 0; a < tPPS.getPhotosCount(); a++)
		{
			var tPP:Picasa.Photo = tPPS.getNextPhoto();
			var tID:String = tPP.getIdString();
			
			if(!Thumb.exists(tID))
			{	
				var tThumb:Thumb = new Thumb(tID, tContainer, false);
					//tThumb.setSize(tPP.getThumbWidth(),tPP.getThumbHeight());	//BECAUSE OF PICASA WIDTH/HEIGHT BUG
					tThumb.setSize(tModel.__thumbsize,tModel.__thumbsize);
					tModel.addEventListener(EventList.PHOTO_THUMB_CLICK,tThumb);
				
					tLM.addChild(tThumb.view);
					//tThumb.setTitle(tPP.getTitle()+"<br/>"+tPP.getSummary());
					tThumb.getButton().onRelease = Delegate.create(this, notify, tPP);
										
					tLibStack.enqueue(new GraphicLib(tThumb.view, 20), tID, tPP.getThumbnailLink());
					tLibStack.addListener(tThumb);
				
				//preload photos
				var tPhoto:Photo = new Photo(tID, tPP.getLink(), tPhotoContainer, false);
					tPhoto.setSize(tPP.getWidth(),tPP.getHeight());
					tModel.addListener(tPhoto);

			} else {
				trace("Thumb "+tID+" already exists. Skipping!",Log.WARNING);
			}
		}
		tLibStack.execute();
		tLM.draw();	
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
