/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.mvc.control.IController;
import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.view.IView;

class sk.prasa.visual.mvc.control.AbstractController implements IController
{
	private var model : AbstractModel;	
	private var view : IView;

	public function AbstractController(m : AbstractModel)
	{
		setModel(m);
	}
	
	public function setModel(m : AbstractModel) : Void
	{
		model = m;
	}
	 
	public function getModel() : AbstractModel
	{
		return model;
	}

	public function setView(v : IView) : Void
	{
		view = v;
	}

	public function getView() : IView
	{
		return view;
	}
}