/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.view.IView;

interface sk.prasa.visual.mvc.control.IController 
{
	public function setModel(m : AbstractModel) : Void;
	public function getModel() : AbstractModel;

	public function setView(v : IView) : Void;
	public function getView() : IView;
}
