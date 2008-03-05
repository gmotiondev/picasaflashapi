import control.LoadThumbsEvent;

import sk.prasa.visual.mvc.view.IObserver;
import sk.prasa.visual.mvc.view.IView;
import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.control.IController;
import sk.prasa.visual.mvc.view.AbstractView;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.ThumbsView extends AbstractView implements IObserver
{
	private var target : MovieClip;

	public function ThumbsView(m : AbstractModel, c : IController, t : MovieClip)
	{
		super(m, c);
		
		target = t;
	}
	
	public function update(m : AbstractModel, o : Object) : Void
	{
		switch(o.type)
		{
			case "load_thumbs_event":
			{
				var tRes : Array = LoadThumbsEvent(o).thumbs;
				for(var a : Number = 0; a < tRes.length; a++)
				{
					trace("load_thumbs_event: "+tRes[a].id+" > "+tRes[a].url);
					var tT : MovieClip = target.createEmptyMovieClip(tRes[a].id, target.getNextHighestDepth());
						tT.loadMovie(tRes[a].url);
				}
				
				break;
			}
		}
	}
}