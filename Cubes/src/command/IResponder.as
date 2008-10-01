import sk.prasa.webapis.picasa.PicasaError;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
interface command.IResponder
{
	public function result(data:Object):Void
	public function fault(error:PicasaError):Void
}