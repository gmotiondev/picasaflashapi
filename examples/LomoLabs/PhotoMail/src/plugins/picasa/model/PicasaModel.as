/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.ioc.model.AbstractModel;
import com.bourre.ioc.plugin.IPlugin;

class plugins.picasa.model.PicasaModel extends AbstractModel
{
	public function PicasaModel(owner:IPlugin, name:String)
	{
		super(owner, name);
	}
	
	public function echo(a:String):Void
	{
		trace(a);
	}
}