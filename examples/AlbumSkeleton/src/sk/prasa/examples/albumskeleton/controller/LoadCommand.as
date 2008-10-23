package sk.prasa.examples.albumskeleton.controller 
{
	import sk.prasa.examples.albumskeleton.model.vo.RequestVO;
	import sk.prasa.examples.albumskeleton.model.ServiceProxy;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class LoadCommand extends SimpleCommand implements ICommand 
	{	
		override public function execute(notification : INotification) : void
		{
			var tAlbumVO : RequestVO = notification.getBody() as RequestVO;
			var tServiceProxy : ServiceProxy = facade.retrieveProxy(ServiceProxy.NAME) as ServiceProxy;
				tServiceProxy.getPhotosList(tAlbumVO.userid, tAlbumVO.albumid);
		}
	}
}
