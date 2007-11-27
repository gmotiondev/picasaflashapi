/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.events.IEvent;
import com.bourre.core.Model;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.visual.MovieClipHelper;
import sk.prasa.webapis.picasa.Photo;

import model.*;
import view.*;
import control.InitializeEvent;

class command.InitializeCommand implements Command
{
	private var model:ModelApplication; 
	private var __libstack:LibStack;
	
	public function execute(event:InitializeEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tMainView = MovieClipHelper.getMovieClipHelper(ViewList.MAIN_VIEW);
			tMainView.setSearchResult("Found "+event.totalResults+" photos ("+event.startIndex+" to "+(event.startIndex+(event.totalResults < event.itemsPerPage ? event.totalResults : event.itemsPerPage) - (event.totalResults == 0 ? 0 : 1))+").");
			
		var tThumbHolder = MovieClipHelper.getMovieClipHelper(ViewList.THUMB_HOLDER);
			tThumbHolder.removeAllChildren();
		
		__libstack.clear();
		__libstack.release();
		__libstack.removeListener(tThumbHolder);
		
		__libstack = new LibStack();
		__libstack.addListener(tThumbHolder);
		
		for(var a:Number = 0; a < model.photos.length; a++)
		{
			var tItem:Photo = model.photos[a];			
			var tThumbContainer:ThumbContainer = tThumbHolder.addChild(tItem.gphoto.id);
			
			__libstack.enqueue(new GraphicLib(tThumbContainer.view, 5), tItem.gphoto.id, tItem.media.thumbnail[0].url);
		}

		__libstack.execute();
	}
}