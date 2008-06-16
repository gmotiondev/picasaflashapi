package sk.prasa.webapis.picasa.objects.feed 
{
	import sk.prasa.webapis.picasa.objects.Utils;	
	import sk.prasa.webapis.picasa.objects.Kind;
	import sk.prasa.webapis.picasa.objects.Namespaces;
	import sk.prasa.webapis.picasa.objects.feed.AlbumEntry;
	import sk.prasa.webapis.picasa.objects.feed.AlbumMeta;
	import sk.prasa.webapis.picasa.objects.feed.Parser;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Atom extends Parser implements IAtom 
	{
		private var __meta : IMeta;
		private var __entries : Array;
		
		private var atom_ns : Namespace = Namespaces.ATOM_NS;
		
		/**
		 * 
		 */
		public function Atom(xml : XML)
		{
			super(xml);
		}
		
		/**
		 * 
		 */
		public function get meta() : IMeta
		{
			if (__meta == null)
			{
				switch(Utils.parseString(this.data.atom_ns::category.@term))
				{
					case Kind.USER: 	__meta = new UserMeta(XMLList(this.data)); break;
					case Kind.ALBUM:	__meta = new AlbumMeta(XMLList(this.data)); break;
					case Kind.PHOTO:	__meta = new PhotoMeta(XMLList(this.data)); break;
					// any default here?
				}
			}
			
			return __meta;
		}
		
		/**
		 * 
		 */
		public function set meta(aMeta : IMeta) : void
		{
			// TODO: ...
		}
		
		/**
		 * 
		 */
		public function get entries() : Array
		{
			if (this.data.atom_ns::entry == null)
			{
				return null;
			}

			if (__entries == null)
			{
				__entries = new Array();
				
				for each (var node : XML in this.data.atom_ns::entry)
				{
					switch(Utils.parseString(node.atom_ns::category.@term))
					{
						case Kind.USER: 	__entries.push(new UserEntry(XMLList(node))); break;
						case Kind.ALBUM:	__entries.push(new AlbumEntry(XMLList(node))); break;
						case Kind.PHOTO:	__entries.push(new PhotoEntry(XMLList(node))); break;
						case Kind.TAG: 		__entries.push(new TagEntry(XMLList(node))); break;
						case Kind.COMMENT: 	__entries.push(new CommentEntry(XMLList(node))); break;
						// any default here?
					}
				}
				
			}
			
			return __entries;
		}
		
		/**
		 * 
		 */
		public function set entries(aEntries : Array) : void
		{
			// TODO: ...
		}
	}
}
