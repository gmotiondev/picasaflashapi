/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

import sk.prasa.webapis.picasa.PicasaError;

interface plugins.picasa.command.IResponder
{
	public function progress(percents:Number):Void
	public function result(data:Object):Void
	public function fault(error:PicasaError):Void
}