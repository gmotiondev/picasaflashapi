import sk.prasa.webapis.picasa.PicasaError;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

interface sk.prasa.mvc.command.IResponder
{
	public function result(data : Object) : Void
	public function fault(error : PicasaError) : Void
}