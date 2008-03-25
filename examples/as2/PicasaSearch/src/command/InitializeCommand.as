/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.visual.MovieClipHelper;
import sk.prasa.webapis.picasa.Photo;

import model.*;
import view.*;
import control.*;

class command.InitializeCommand implements Command
{
	private var model:ModelApplication; 
	private var __libstack:LibStack;
	
	public function execute(evt:InitializeEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
		
		var tGrid = MovieClipHelper.getMovieClipHelper(ViewList.GRID);
			tGrid.removeAllChildren();
		
		__libstack.clear();
		__libstack.release();
		__libstack.removeListener(tGrid);
		
		__libstack = new LibStack();
		__libstack.addListener(tGrid);
		
		for(var a:Number = 0; a < model.photos.length; a++)
		{
			var tItem:Photo = model.photos[a];			
			var tThumb:Thumb = tGrid.addChild(tItem.gphoto.id);
			
			__libstack.enqueue(new GraphicLib(tThumb.view, 5), tItem.gphoto.id, tItem.media.thumbnail[0].url);
		}

		__libstack.execute();
	}
}