import sk.prasa.visual.mvc.view.IObserver;
import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.control.IController;
import sk.prasa.visual.mvc.view.AbstractView;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.ThumbView extends AbstractView implements IObserver
{
	public function ThumbView(m : AbstractModel, c : IController, t : MovieClip)
	{
		super(m, c);
	}
	
	public function update(o : AbstractModel, infoObj : Object) : Void
	{
		trace("ThumbView.update(o, infoObj)");
	}
}
