import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibStack;
import com.bourre.visual.MovieClipHelper;

import sk.prasa.webapis.picasa.Photo;

import control.thumb.LoadThumbsEvent;
import model.*;
import view.*;
import view.thumb.Thumb;
import view.thumb.ThumbsHolder;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.thumb.LoadThumbsCommand implements Command
{
	private var model : ModelApplication; 
	private var stack : LibStack;
	private var gl : Array = [];
	
	public function execute(evt : LoadThumbsEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		model.notifyChanged(evt);
		
		var tGrid : ThumbsHolder = ThumbsHolder(MovieClipHelper.getMovieClipHelper(ViewList.GRID));
				
		if(!stack) {
			stack = new LibStack();
			stack.addListener(tGrid);
		}
		
		stack.clear();
		clearGraphicLibs();
		
		for(var a : Number = 0; a < model.photos.length; a++)
		{
			var tItem : Photo = model.photos[a];
			var tThumb : Thumb = tGrid.addChild(tItem.gphoto.id, tItem.author.name, tItem.summary, tItem.links.getByRel("alternate").href);
			var tGL : GraphicLib = new GraphicLib(tThumb.view, 5);
				gl.push(tGL);
			
			stack.enqueue(tGL, "gl_" + tItem.gphoto.id, tItem.media.thumbnail[0].url);
		}

		stack.execute();
	}
	
	private function clearGraphicLibs() : Void
	{
		for(var a : Number = 0; a < gl.length; a++)
		{
			var tGL : GraphicLib = GraphicLib(gl[a]);
				tGL.release();
		}
		
		gl = [];
	}
}