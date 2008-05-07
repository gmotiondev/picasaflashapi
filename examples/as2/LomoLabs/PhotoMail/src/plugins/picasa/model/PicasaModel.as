/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.model.AbstractModel;
import com.bourre.ioc.plugin.IPlugin;
import com.bourre.commands.Delegate;
import com.bourre.events.IEvent;

import sk.prasa.webapis.picasa.PicasaService;

class plugins.picasa.model.PicasaModel extends AbstractModel
{
	public var service:PicasaService;

	public function PicasaModel(owner:IPlugin, name:String)
	{
		super(owner, name);
	}

	public function initialize(aImgmax:Number, aThumbsize:Number, aMax_results:Number):Void
	{
		service = new PicasaService();
		service.imgmax = aImgmax;
		service.thumbsize = aThumbsize;
		service.max_results = aMax_results;
		service.addEventListener(PicasaService.ERROR, Delegate.create(this, onServiceError));
	}

	private function onServiceError(e:IEvent):Void
	{
		trace("error: "+e.getType());
	}
}