import sk.prasa.visual.mvc.view.IObserver;
import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.control.IController;
import sk.prasa.visual.mvc.view.AbstractView;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoView extends AbstractView implements IObserver
{
	public function PhotoView(m : AbstractModel, c : IController, t : MovieClip)
	{
		super(m, c);
	}
	
	public function update(o : AbstractModel, infoObj : Object) : Void
	{
		trace("PhotoView.update(o, infoObj)");
	}
}
