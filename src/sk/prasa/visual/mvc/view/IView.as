/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.control.IController;

interface sk.prasa.visual.mvc.view.IView 
{
	public function setModel(m : AbstractModel) : Void;
	public function getModel() : AbstractModel;

	public function setController(c : IController) : Void;
	public function getController() : IController;
	public function defaultController(m : AbstractModel) : IController;
}
