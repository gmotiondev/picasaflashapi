package sk.prasa.webapis.picasa.core 
{
	import sk.prasa.webapis.picasa.core.command.GetFeedCommand;	
	import sk.prasa.webapis.picasa.core.receiver.contacts.ContactsListReceiver;	
	import sk.prasa.webapis.picasa.core.command.Invoker;	
	import sk.prasa.webapis.picasa.core.command.ICommand;	
	import sk.prasa.webapis.picasa.core.receiver.IReceiver;	
	import sk.prasa.webapis.picasa.UrlParams;	
	import sk.prasa.webapis.picasa.PicasaService;	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class Contacts 
	{
		private var service : PicasaService;

		public function Contacts(srv : PicasaService)
		{
			service = srv;
		}
		
		/**
		 * List contacts from user
		 * Loads e.g. http://picasaweb.google.com/data/feed/api/user/userID?kind=album
		 * 
		 * @param userid String Picasaweb user id
		 * @param params UrlParams Parameters to alter the feed url
		 */ 
		public function list(userid : String, params : UrlParams = null) : void
		{
			var s : String = "user/" + userid;
			var p : UrlParams = service.mergeUrlParams(params);
				p.kind = "contacts";	// override!
				p.tag = null;
				p.q = null;
	
			var tReceiver : IReceiver = new ContactsListReceiver(service);
			var tCommand : ICommand = new GetFeedCommand(tReceiver, service, s, p.toString());
			var tInvoker : Invoker = new Invoker();
			
			tInvoker.setCommand(tCommand);
			tInvoker.executeCommand();
		}
	}
}

/*
<entry>
  <id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/contacts/davidtravnicek</id>
  <published>2008-05-23T11:01:24.667Z</published>
  <updated>2008-05-23T11:01:24.667Z</updated>
  <category scheme='http://schemas.google.com/g/2005#kind' term='http://schemas.google.com/photos/2007#user'/>
  <title type='text'>davidtravnicek</title>
  <summary type='text'></summary>
  <link rel='alternate' type='text/html' href='http://picasaweb.google.com/davidtravnicek'/>
  <link rel='self' type='application/atom+xml' href='http://picasaweb.google.com/data/entry/api/user/thisispinkfu/contacts/davidtravnicek'/>
  <link rel='edit' type='application/atom+xml' href='http://picasaweb.google.com/data/entry/api/user/thisispinkfu/contacts/davidtravnicek'/>
  <author>
  	<name>Fuji_ita</name>
  	<uri>http://picasaweb.google.com/davidtravnicek</uri>
  </author>
  <gphoto:user>davidtravnicek</gphoto:user>
  <gphoto:nickname>Fuji_ita</gphoto:nickname>
  <gphoto:thumbnail>http://lh6.ggpht.com/davidtravnicek/AAAAls5kcJE/AAAAAAAAAAA/ua29FHNrScM/s64-c/davidtravnicek.jpg</gphoto:thumbnail>
</entry>*/ 

