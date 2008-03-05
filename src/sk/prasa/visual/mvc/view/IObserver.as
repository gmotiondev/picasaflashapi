/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.mvc.model.AbstractModel;

interface sk.prasa.visual.mvc.view.IObserver 
{
	public function update(o : AbstractModel, infoObj : Object) : Void;
}
