/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.visual.mvc.view.IObserver;

class sk.prasa.visual.mvc.model.AbstractModel 
{
	private var changed : Boolean = false;
	private var observers : Array;

	public function AbstractModel()
	{
		observers = [];
	}

	public function addObserver(o : IObserver) : Boolean
	{
		if (o == null)
		{
			return false;
		}
		
		for (var a : Number = 0; a < observers.length; a++)
		{
			if (observers[a] == o)
			{
				return false;
			}	
		}

		observers.push(o);
		return true;
	}

	public function removeObserver(o : IObserver) : Boolean
	{
		for (var a : Number = 0; a < observers.length; a++)
		{
			if(observers[a] == o)
			{
				observers.splice(a, 1);
				return true;
			}
		}
		
		return false;
	}

	public function notifyChanged(infoObj : Object) : Void
	{	
		if(infoObj == undefined)
		{
			infoObj = null;
		}

		if(!changed)
		{
			return;
		}

		var observersSnapshot : Array = observers.slice(0);

		clearChanged();

		for (var a : Number = observersSnapshot.length - 1; a >= 0; a--)
		{
			observersSnapshot[a].update(this, infoObj);
		}
	}

	public function clearObservers() : Void
	{
		observers = [];
	}

	private function setChanged() : Void
	{
		changed = true;
	}

	private function clearChanged() : Void
	{
		changed = false;
	}

	public function hasChanged() : Boolean
	{
		return changed;
	}

	public function countObservers() : Number
	{
		return observers.length;
	}
}