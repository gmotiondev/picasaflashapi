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

		var tPhotoHolder = MovieClipHelper.getMovieClipHelper(ViewList.PHOTO_HOLDER);
		var tThumbHolder = MovieClipHelper.getMovieClipHelper(ViewList.THUMB_HOLDER);
		
		var tTLibStack:LibStack = new LibStack();
		
			tThumbHolder.grid = new view.layout.GridLayout(6, 6);
			tThumbHolder.grid.addListener(tThumbHolder);
			
		for(var a:Number = 0; a < model.photos.length; a++)
		{
			var tItem:Photo = model.photos[a];
			
			var tPC:MovieClip = tPhotoHolder.view.createEmptyMovieClip("p_"+tItem.gphoto.id, tPhotoHolder.view.getNextHighestDepth());
			var tTC:MovieClip = tThumbHolder.view.createEmptyMovieClip("p_"+tItem.gphoto.id, tThumbHolder.view.getNextHighestDepth());
			
			var tPhotoContainer:PhotoContainer = new PhotoContainer(tItem.gphoto.id, tPC, true, tItem.media.content.url, (tItem.summary != undefined ? tItem.summary : ""));
			var tThumbContainer:ThumbContainer = new ThumbContainer(tItem.gphoto.id, tTC);
				
			// TODO.. read photos album object, get album title and photos count	
				tThumbContainer.title = tItem.summary;
				
			tThumbHolder.grid.addChild(tThumbContainer.view);
			tThumbHolder.setTitle("")
			model.addListener(tPhotoContainer);
			model.addListener(tThumbContainer);

			tTLibStack.enqueue(new GraphicLib(tThumbContainer.view, 5), tItem.gphoto.id, tItem.media.thumbnail[0].url);
			tTLibStack.addListener(tThumbHolder);
		}
		
		tTLibStack.execute();
	}
}