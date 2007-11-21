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

class command.InitializeCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(e:IEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		var tThumbHolder = MovieClipHelper.getMovieClipHelper(ViewList.THUMB_HOLDER);
			tThumbHolder.grid = new view.layout.GridLayout(12, 16);
			tThumbHolder.grid.addListener(tThumbHolder);
		
		var tTLibStack:LibStack = new LibStack();
		
			
		for(var a:Number = 0; a < model.photos.length; a++)
		{
			var tItem:Photo = model.photos[a];			
			var tTC:MovieClip = tThumbHolder.view.createEmptyMovieClip("p_"+tItem.gphoto.id, tThumbHolder.view.getNextHighestDepth());
			var tThumbContainer:ThumbContainer = new ThumbContainer(tItem.gphoto.id, tTC, tItem.summary);
				
			tThumbHolder.grid.addChild(tThumbContainer.view);
			tThumbHolder.setTitle(tItem.album.title+" ("+tItem.album.gphoto.numphotos+")");

			model.addListener(tThumbContainer);

			tTLibStack.enqueue(new GraphicLib(tThumbContainer.view, 5), tItem.gphoto.id, tItem.media.thumbnail[0].url);
			tTLibStack.addListener(tThumbHolder);
		}
		
		tTLibStack.execute();
	}
}