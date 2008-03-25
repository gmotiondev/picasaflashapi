/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import sk.prasa.webapis.picasa.PicasaError;

interface command.IResponder
{
	public function result(data:Object):Void
	public function fault(error:PicasaError):Void
}