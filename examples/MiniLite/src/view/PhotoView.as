import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.control.IController;
import sk.prasa.visual.mvc.view.AbstractView;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class view.PhotoView extends AbstractView 
{
	public function PhotoView(m : AbstractModel, c : IController, t : MovieClip)
	{
		super(m, c);
	}
}
