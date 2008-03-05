/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.mvc.model.AbstractModel;
import sk.prasa.visual.mvc.view.IObserver;
import sk.prasa.visual.mvc.view.IView;
import sk.prasa.visual.mvc.control.IController;

class sk.prasa.visual.mvc.view.AbstractView implements IView
{
	private var model : AbstractModel;
	private var controller : IController;

	public function AbstractView(m : AbstractModel, c : IController)
	{
		setModel(m);
		
		if(c !== undefined)
		{
			setController(c);
		}
	}
		
	public function defaultController(m : AbstractModel) : IController
	{
		return null;
	}
	
	public function setModel(m : AbstractModel) : Void
	{
		model = m;
	}
	
	public function getModel() : AbstractModel
	{
		return model;
	}
	
	public function setController(c : IController) : Void
	{
	 	controller = c;
	 	
	 	getController().setView( this );
	}
	 
	public function getController() : IController
	{
		if(controller === undefined)
		{
			setController( defaultController( getModel() ) );
		}

		return controller;
	}

//	public function update(o : AbstractModel, infoObj : Object) : Void
//	{
//	}
}