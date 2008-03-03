import control.*;
import model.*;

import com.bourre.commands.Command;
import com.bourre.core.Model;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.LoadThumbsCommand implements Command
{
	private var model : ModelApplication;

	public function execute(evt : LoadThumbsEvent) : Void 
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
//		var tThumbs : Thumbs = Thumbs(MovieClipHelper.getMovieClipHelper(ViewList.THUMBS));
//		var tStack : LibStack = new LibStack();
	}
}